/**
 * Aritm Cloud - Backend (Google Apps Script)
 * Copyright (C) 2026 Mikael O. Bonnier, Lund, Sweden. 
 * * Detta program är fri programvara. Du kan distribuera det och/eller modifiera 
 * det under villkoren i GNU General Public License, version 3 eller senare, 
 * enligt vad som publicerats av Free Software Foundation.
 * * Se: https://www.gnu.org/licenses/gpl-3.0.html
 * * @OnlyCurrentDoc
 */

// URL till din källkod på GitHub
var GITHUB_URL = "https://raw.githubusercontent.com/mobluse/aritmjs/refs/heads/master/docs/index.html";

// 1. Denna funktion körs när du öppnar Kalkylarket
function onOpen() {
  SpreadsheetApp.getUi().createMenu('Aritm Cloud').addItem('Öppna Aritm', 'showSidebar').addToUi();
}

// 2. Denna funktion körs när du öppnar WEBBAPPEN (Länken)
function doGet(e) {
  return createHtmlOutput();
}

// 3. Denna funktion körs när du öppnar SIDOPANELEN i Kalkylarket
function showSidebar() {
  var html = createHtmlOutput();
  SpreadsheetApp.getUi().showSidebar(html);
}

// Hjälpfunktion för att hämta koden (så vi slipper skriva det två gånger)
function createHtmlOutput() {
  var response = UrlFetchApp.fetch(GITHUB_URL);
  var htmlContent = response.getContentText();
  
  return HtmlService.createTemplate(htmlContent).evaluate()
    .setTitle('Aritm Cloud')
    .setXFrameOptionsMode(HtmlService.XFrameOptionsMode.ALLOWALL)
    .addMetaTag('viewport', 'width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0');
}

// --- LAGRINGSFUNKTIONER (Anropas från index.html) ---
function saveCloudSettings(s) { PropertiesService.getUserProperties().setProperty('settings', s); }
function loadCloudSettings() { return PropertiesService.getUserProperties().getProperty('settings'); }
function saveCloudProgress(p) { PropertiesService.getUserProperties().setProperty('progress', p); }
function loadCloudProgress() { return PropertiesService.getUserProperties().getProperty('progress'); }
function clearCloudProgress() { PropertiesService.getUserProperties().deleteProperty('progress'); }
