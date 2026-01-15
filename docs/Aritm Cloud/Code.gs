/**
 * Aritm Cloud
 * Copyright (C) 2026 Mikael O. Bonnier, Lund, Sweden. 
 * * Detta program är fri programvara. Du kan distribuera det och/eller modifiera 
 * det under villkoren i GNU General Public License, version 3 eller senare, 
 * enligt vad som publicerats av Free Software Foundation.
 * * Se: https://www.gnu.org/licenses/gpl-3.0.html
 * * @OnlyCurrentDoc
 */
// --- INIT & MENU ---

function doGet() {
  return HtmlService.createHtmlOutputFromFile('Sidebar')
      .setTitle('Aritm Cloud')
      // Vi behåller enbart viewport här för att tvinga Google att rendera sidan mobilvänligt
      .addMetaTag('viewport', 'width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, viewport-fit=cover')
      .setXFrameOptionsMode(HtmlService.XFrameOptionsMode.ALLOWALL);
}

function onOpen() {
  SpreadsheetApp.getUi()
      .createMenu('Aritm Träning')
      .addItem('Starta Träning', 'showSidebar')
      .addToUi();
}

function showSidebar() {
  var html = HtmlService.createHtmlOutputFromFile('Sidebar')
      .setTitle('Aritm Huvudräkning')
      .setWidth(350);
  SpreadsheetApp.getUi().showSidebar(html);
}

// --- STATE MANAGEMENT ---

function getUserState() {
  var userProperties = PropertiesService.getUserProperties();
  var savedState = userProperties.getProperty('aritmSession');
  return savedState ? JSON.parse(savedState) : null;
}

function saveUserState(state) {
  var props = PropertiesService.getUserProperties();
  if (!state || state.status === 'finished') {
    props.deleteProperty('aritmSession');
  } else {
    props.setProperty('aritmSession', JSON.stringify(state));
  }
}

function quitSession() {
  var state = getUserState();
  var finalData = {
    problemsLeft: state ? state.problemsLeft : 0
  };
  
  // Radera sessionen
  saveUserState(null);
  
  // Skicka tillbaka info om hur det gick till Sidebar
  return finalData;
}

// --- SESSION LOGIC ---

function startNewSession(settings) {
  var problemQueue = [];
  settings.types.forEach(function(type) {
    var fullSet = generateFullSet(type);
    // Varje element i kön: [a, b, typ, hits_needed]
    var preparedSet = fullSet.map(function(p) { return [p[0], p[1], p[2], 1]; });
    problemQueue = problemQueue.concat(preparedSet);
  });
  
  shuffleArray(problemQueue);
  
  var requestedTotal = parseInt(settings.total);
  if (requestedTotal > 0 && requestedTotal < problemQueue.length) {
    problemQueue = problemQueue.slice(0, requestedTotal);
  }
  
  var state = {
    status: 'active',
    queue: problemQueue,
    initialTotal: problemQueue.length,
    score: 0,
    currentProblem: null
  };
  
  state = pickNextProblem(state);
  saveUserState(state);
  return state;
}

function processAnswer(userAnswer, clientState) {
  // Vi hämtar färskt state från servern för att undvika osynk med klienten
  var state = getUserState();
  if (!state) return { error: "Session saknas" };

  var isCorrect = parseInt(userAnswer) === state.currentProblem.answer;
  
  if (isCorrect) {
    state.currentProblem.remainingHits--;
    
    // Om vi har "skuld" kvar (remainingHits > 0), lägg tillbaka talet i kön
    if (state.currentProblem.remainingHits > 0) {
      // unshift lägger den sist (eftersom vi använder pop() för att dra tal)
      state.queue.unshift([
        state.currentProblem.rawA, 
        state.currentProblem.rawB, 
        state.currentProblem.rawType, 
        state.currentProblem.remainingHits
      ]);
    } else {
      // Talet är helt klart
      state.score++; 
    }

    // Dra nästa tal om det finns något i kön
    if (state.queue.length === 0) {
      state.status = 'finished';
      saveUserState(state);
      return { correct: true, finished: true, finalScore: state.score, total: state.initialTotal };
    }
    
    state = pickNextProblem(state);
    
  } else {
    // FEL SVAR: Öka skulden.
    state.currentProblem.remainingHits++;
    
    // Uppdatera verkligt antal kvar direkt vid fel
    var totalHitsInQueue = state.queue.reduce(function(sum, prob) {
      return sum + prob[3];
    }, 0);
    state.problemsLeft = totalHitsInQueue + state.currentProblem.remainingHits;
  }
  
  saveUserState(state);
  return { 
    correct: isCorrect, 
    finished: false, 
    newState: state 
  };
}

function pickNextProblem(state) {
  var nextRaw = state.queue.pop(); 
  
  var a = nextRaw[0];
  var b = nextRaw[1];
  var type = nextRaw[2];
  var hits = nextRaw[3]; 
  
  var symbol, answer;
  if (type === 'a') { symbol = "+"; answer = a + b; }
  else if (type === 's') { symbol = "-"; answer = a - b; }
  else if (type === 'm') { symbol = "·"; answer = a * b; }
  else if (type === 'd') { symbol = "/"; answer = Math.floor(a / b); }
  
  state.currentProblem = {
    str: a + " " + symbol + " " + b,
    answer: answer,
    remainingHits: hits,
    rawA: a,
    rawB: b,
    rawType: type
  };
  
  // BERÄKNA VERKLIGT KVAR:
  // Summera alla hits i kön + den nuvarande uppgiftens hits
  var totalHitsInQueue = state.queue.reduce(function(sum, prob) {
    return sum + prob[3];
  }, 0);
  
  state.problemsLeft = totalHitsInQueue + state.currentProblem.remainingHits;
  
  return state;
}

// --- GENERATORER ---

function generateFullSet(type) {
  var set = [];
  var i, j, t;
  
  switch (type) {
    case 'add1': 
      for (i = 0; i <= 9; i++) for (j = 0; j <= 9; j++) set.push([i, j, 'a']);
      break;
    case 'add2': 
      for (i = 0; i <= 9; i++) for (j = 0; j <= 9; j++) {
        t = 10 * (Math.floor(Math.random() * 8) + 1); 
        set.push([t + i, j, 'a']);
      }
      break;
    case 'sub1': 
      for (i = 0; i <= 9; i++) for (j = 0; j <= 9; j++) set.push([i + j, j, 's']);
      break;
    case 'sub2': 
      for (i = 0; i <= 9; i++) for (j = 0; j <= 9; j++) {
        t = 10 * (Math.floor(Math.random() * 9) + 1);
        set.push([t + i + j, j, 's']);
      }
      break;
    case 'mult': 
      for (i = 0; i <= 9; i++) for (j = 0; j <= 9; j++) set.push([i, j, 'm']);
      break;
    case 'div': 
      for (i = 0; i <= 9; i++) for (j = 1; j <= 9; j++) {
        set.push([i * j + Math.floor(j * Math.random()), j, 'd']);
      }
      break;
  }
  return set;
}

function shuffleArray(array) {
  for (var i = array.length - 1; i > 0; i--) {
    var j = Math.floor(Math.random() * (i + 1));
    var temp = array[i];
    array[i] = array[j];
    array[j] = temp;
  }
}
