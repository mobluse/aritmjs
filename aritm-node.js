#!/usr/bin/env node
// Aritm v0.3.4 for Node.js v18.20.4 is FOSS.
// (c) 1992-2025 by Mikael O. Bonnier, Lund, Sweden.
// E-mail: <mikael.bonnier@gmail.com>.
// Absolutely no warranty.
// License GPLv3+, see
// <http://www.gnu.org/licenses/gpl.html>.
// More programs at
// <http://www.df.lth.se.orbin.se/~mikaelb/basic/>. ~ is tilde.
// Documentation:
// 76543210, 7:type, 6-4:op1, 3-2:op2, 1-0:#todo.

const readline = require('readline');

// Global variables
let md = 0.0;
let dv = 0.0;
let x = 0.0;
let y = 0.0;
let r = 0.0;
let l = 0;
let m = 0;
let aa = [];
let a = 0;
let u = 0;
let k = 0;
let t = 0;
let c = 0;
let i = 0;
let j = 0;
let ans = "";
let n = 0;
let d = 0;

// Create readline interface
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function question(prompt) {
  return new Promise((resolve) => {
    rl.question(prompt, resolve);
  });
}

function delay() {
  return new Promise(resolve => setTimeout(resolve, d));
}

function mod() {
  md = Math.floor(0.5 + (x / y - Math.floor(x / y)) * y);
}

function idiv() {
  dv = Math.floor(0.5 + x / y);
}

function rnd() {
  return Math.random();
}

function cls() {
  // Clear screen and print Aritm header
  process.stdout.write('\x1Bc');
  console.log("Aritm");
}

function sound() {
  process.stdout.write('\x07');
  return new Promise(resolve => setTimeout(resolve, 100));
}

function sign() {
  switch (c) {
    case 1:
    case 2:
      process.stdout.write('+');
      break;
    case 3:
    case 4:
      process.stdout.write('-');
      break;
    case 5:
      process.stdout.write('*');
      break;
    case 6:
      process.stdout.write('/');
      break;
  }
}

function pow10() {
  r = 1;
  for (i = 1; i <= a; i++) {
    r *= 10;
  }
}

async function help() {
  cls();
  console.log("Help");
  console.log("You can mix problems anyway you like.");
  console.log("More help on <http://aritm.orbin.se/>.");
  d = 5000;
  await delay();
}

async function about() {
  cls();
  console.log("About");
  console.log("Aritm 0.3 (c) 1992-2025 by");
  console.log("Mikael O. Bonnier, Lund, Sweden.");
  console.log("Absolutely no warranty.");
  console.log("FOSS, see license GPLv3+.");
  d = 5000;
  await delay();
}

function menuitem() {
  a++;
  process.stdout.write(a + ' ');
}

function generateProblems() {
  cls();
  console.log("Generating\nProblems...");
  u = 1;

  // Addition 1
  x = m;
  y = 10;
  idiv();
  x = dv;
  mod();
  if (md != 0) {
    for (i = 0; i <= 9; i++) {
      for (j = 0; j <= 9; j++) {
        aa[u] = 10000000 + i * 10000 + j * 100 + 1;
        u++;
      }
    }
  }

  // Addition 2
  x = m;
  y = 100;
  idiv();
  x = dv;
  y = 10;
  mod();
  if (md != 0) {
    for (i = 0; i <= 9; i++) {
      for (j = 0; j <= 9; j++) {
        t = 10 * (Math.floor(8 * rnd()) + 1);
        aa[u] = 20000000 + (t + i) * 10000 + j * 100 + 1;
        u++;
      }
    }
  }

  // Subtraction 1
  x = m;
  y = 1000;
  idiv();
  x = dv;
  y = 10;
  mod();
  if (md != 0) {
    for (i = 0; i <= 9; i++) {
      for (j = i; j <= 9 + i; j++) {
        aa[u] = 30000000 + j * 10000 + i * 100 + 1;
        u++;
      }
    }
  }

  // Subtraction 2
  x = m;
  y = 10000;
  idiv();
  x = dv;
  y = 10;
  mod();
  if (md != 0) {
    for (i = 0; i <= 9; i++) {
      for (j = i; j <= 9 + i; j++) {
        t = 10 * (Math.floor(9 * rnd()) + 1);
        aa[u] = 40000000 + (t + j) * 10000 + i * 100 + 1;
        u++;
      }
    }
  }

  // Multiplication
  x = m;
  y = 100000;
  idiv();
  x = dv;
  y = 10;
  mod();
  if (md != 0) {
    for (i = 0; i <= 9; i++) {
      for (j = 0; j <= 9; j++) {
        aa[u] = 50000000 + i * 10000 + j * 100 + 1;
        u++;
      }
    }
  }

  // Division
  x = m;
  y = 1000000;
  idiv();
  x = dv;
  y = 10;
  mod();
  if (md != 0) {
    for (i = 0; i <= 9; i++) {
      for (j = 1; j <= 9; j++) {
        t = i * j + Math.floor(j * rnd());
        aa[u] = 60000000 + t * 10000 + j * 100 + 1;
        u++;
      }
    }
  }

  u--;
  l = u;
}

function shuffleProblems() {
  console.log("Shuffling...");
  for (i = u; i >= 2; i--) {
    j = Math.floor(i * rnd()) + 1;
    t = aa[i];
    aa[i] = aa[j];
    aa[j] = t;
  }
}

async function practiceSession() {
  while (l > 0) {
    // Practice loop
    while (k <= u && l > 0) {
      cls();
      console.log(l + " problems left. -1 Esc");

      t = aa[k];
      x = t;
      y = 10000000;
      idiv();
      c = dv;

      if (c == 6) {
        process.stdout.write('Integer part of ');
      }

      x = t;
      y = 10000;
      idiv();
      x = dv;
      y = 1000;
      mod();
      i = md;
      process.stdout.write(i.toString());

      sign();

      x = t;
      y = 100;
      idiv();
      x = dv;
      y = 100;
      mod();
      j = md;
      process.stdout.write(j.toString());
      process.stdout.write(' = ');

      ans = await question('');
      a = parseFloat(ans);

      if (-1 == a || '.1' === ans || ',1' === ans || '01' === ans) {
        return;
      }

      switch (c) {
        case 1:
        case 2:
          r = i + j;
          break;
        case 3:
        case 4:
          r = i - j;
          break;
        case 5:
          r = i * j;
          break;
        case 6:
          r = Math.floor(i / j);
          break;
      }

      if (r != a) {
        process.stdout.write('Wrong. ');
        process.stdout.write(i.toString());
        sign();
        process.stdout.write(j.toString());
        process.stdout.write(' is ');
        process.stdout.write(r.toString());
        console.log(".");

        x = t;
        y = 100;
        mod();
        if (md < 99) {
          l++;
          aa[k] = t + 1;
        }

        k++;
        await sound();
        d = 1000;
        await delay();
      } else {
        console.log("Right!");
        x = t;
        y = 100;
        mod();
        if (md > 0) {
          l--;
          aa[k] = t - 1;
        }
        k++;
        if (l > 0) {
          d = 500;
          await delay();
        }
      }
    }

    if (l <= 0) {
      console.log("Good!!! Well done!");
      d = 5000;
      await delay();
      return;
    } else {
      console.log("Checking...");
      n = 1;
      for (k = 1; k <= u; k++) {
        t = aa[k];
        x = t;
        y = 100;
        mod();
        if (md != 0) {
          aa[n] = t;
          n++;
        }
      }
      u = n - 1;
      shuffleProblems();
      k = 1;
    }
  }
}

function nr() {
  a++;
  x = m;
  pow10();
  y = r;
  idiv();
  x = dv;
  y = 10;
  mod();
  process.stdout.write(a + (md != 0 ? '*' : ' '));
}

async function setupMenu() {
  while (true) {
    cls();
    n = 0;

    // Calculate the number of selected exercises
    for (a = 1; a <= 6; a++) {
      pow10();
      x = m;
      y = r;
      idiv();
      x = dv;
      y = 10;
      mod();
      if (md != 0) {
        n += (a == 6) ? 90 : 100;
      }
    }

    // Display menu items
    a = 0;
    nr();
    console.log("Addition 1");

    nr();
    console.log("Addition 2");

    nr();
    console.log("Subtraction 1");

    nr();
    console.log("Subtraction 2");

    nr();
    console.log("Multiplication");

    nr();
    console.log("Division|-1 Esc");

    console.log('0 OK and go ' + n);

    while (true) {
      ans = await question('Toggle item 1-6, or choose 0 or -1: ');
      a = parseInt(ans);

      if (-1 == a || '.1' === ans || ',1' === ans || '01' === ans) {
        return;
      }

      if (ans === "" || a < -1 || a > 6 || (a == 0 && n == 0)) {
        continue;
      }

      if (a == 0) {
        if (n > 0) {
          generateProblems();
          shuffleProblems();
          k = 1;
          await practiceSession();
          return;
        } else {
          continue;
        }
      }
      break;
    }

    // Toggle the selected exercise type
    pow10();
    x = m;
    y = r;
    idiv();
    x = dv;
    y = 10;
    mod();

    if (md == 0) {
      m += r;
    } else {
      m -= r;
    }
  }
}

async function mainMenu() {
  cls();
  a = 0;

  if (l > 0) {
    menuitem();
    console.log("Continue");
  }

  menuitem();
  console.log("Setup and go");
  menuitem();
  console.log("Help");
  menuitem();
  console.log("About");
  menuitem();
  console.log("Exit");

  const maxOption = a;
  let s = 0;

  while (s < 1 || s > maxOption) {
    ans = await question('Choose 1-' + maxOption + ': ');
    s = parseInt(ans);
  }

  const optionIndex = l > 0 ? s : s + 1;

  switch (optionIndex) {
    case 1:
      await practiceSession();
      break;
    case 2:
      await setupMenu();
      break;
    case 3:
      await help();
      break;
    case 4:
      await about();
      break;
    case 5:
      quit();
      break;
  }
}

function quit() {
  cls();
  rl.close();
  process.exit(0);
}

async function mainLoop() {
  while (true) {
    await mainMenu();
  }
}

// Initialize and start the program
aa = new Array(591).fill(0.0);
mainLoop().catch(err => {
  console.error(err);
  rl.close();
});
