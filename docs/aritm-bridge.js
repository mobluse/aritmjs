const puppeteer = require('puppeteer');
const readline = require('readline');

// Standardvärde 0 (Alla) om inget anges
const requestedCount = process.argv[2] || "0";

(async () => {
  const browser = await puppeteer.launch({ 
    headless: "new",
    executablePath: '/usr/bin/chromium', 
    userDataDir: './puppeteer_data',
    args: ['--no-sandbox', '--disable-setuid-sandbox'] 
  });
  const page = await browser.newPage();

  await page.goto(`file://${process.cwd()}/index.html`);

  // Konfigurera appen via localStorage
  await page.evaluate((countStr) => {
    const settings = {
      total: parseInt(countStr),
      types: [
        {val: "add1", checked: true}, {val: "add2", checked: true},
        {val: "sub1", checked: true}, {val: "sub2", checked: true},
        {val: "mul", checked: true},  {val: "div", checked: true}
      ]
    };
    localStorage.setItem('aritm_settings', JSON.stringify(settings));
    localStorage.removeItem('aritm_save'); // Tvinga till setup-vyn
    location.reload();
  }, requestedCount);

  await page.waitForSelector('.btn-start');
  await page.click('.btn-start');

  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
    terminal: false
  });

  async function getTxt(sel) {
    try { return await page.$eval(sel, el => el.innerText.trim()); } catch(e) { return null; }
  }

  // Första uppgiften
  let prob = await getTxt('#problem-text');
  if (prob) process.stdout.write(prob + " = ");

  rl.on('line', async (line) => {
    const answer = line.trim();
    if (!answer) return;

    for (let c of answer) {
      await page.evaluate((k) => pressKey(k), c);
    }
    await page.evaluate(() => submitAnswer());

    // Feedback-väntan
    await new Promise(r => setTimeout(r, 150));
    const fb = await getTxt('#feedback');
    if (fb) process.stdout.write(`\n${fb}\n`);

    // Animations-väntan
    await new Promise(r => setTimeout(r, 300));

    const finished = await page.evaluate(() => 
      document.body.getAttribute('data-current-view') === 'finish-view'
    );

    if (finished) {
      const stats = await getTxt('#speed-stats');
      console.log(`Övning klar! ${stats || ''}`);
      process.exit(0);
    } else {
      prob = await getTxt('#problem-text');
      if (prob) process.stdout.write(prob + " = ");
    }
  });
})();
