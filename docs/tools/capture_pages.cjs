const http = require('http');
const fs = require('fs');
const path = require('path');
const {spawn} = require('child_process');
const root = path.resolve('build/web');
const wait = ms => new Promise(r => setTimeout(r, ms));
const server = http.createServer((req,res) => {
  const file = path.join(root, decodeURIComponent(req.url.split('?')[0] === '/' ? '/index.html' : req.url.split('?')[0]));
  if (!file.startsWith(root) || !fs.existsSync(file) || fs.statSync(file).isDirectory()) { res.writeHead(404); return res.end(); }
  const types = {'.html':'text/html','.js':'application/javascript','.wasm':'application/wasm','.json':'application/json','.png':'image/png','.ttf':'font/ttf'};
  res.setHeader('Content-Type',types[path.extname(file)] || 'application/octet-stream');
  fs.createReadStream(file).pipe(res);
});
(async () => {
  await new Promise(r => server.listen(8765,'127.0.0.1',r));
  const browser = spawn('C:/Program Files (x86)/Microsoft/Edge/Application/msedge.exe', [
    '--headless=new','--disable-gpu','--no-first-run','--no-default-browser-check',
    '--remote-debugging-port=9226','--remote-allow-origins=*',
    '--user-data-dir='+path.resolve('build/edge-capture-profile'),'about:blank'
  ], {windowsHide:true,stdio:'ignore'});
  let ws;
  try {
    let targets;
    for(let i=0;i<80;i++) {try {targets=await (await fetch('http://127.0.0.1:9226/json')).json();break;} catch {await wait(250);}}
    if(!targets) throw Error('Edge debugging endpoint did not start');
    ws = new WebSocket(targets.find(t=>t.type==='page').webSocketDebuggerUrl);
    await new Promise(r=>ws.addEventListener('open',r,{once:true}));
    let id=0; const pending=new Map();
    ws.addEventListener('message', e=> {const m=JSON.parse(e.data); if(pending.has(m.id)) {const {resolve,reject}=pending.get(m.id);pending.delete(m.id);m.error?reject(Error(JSON.stringify(m.error))):resolve(m.result);}});
    const send=(method,params={})=>new Promise((resolve,reject)=> {const key=++id;pending.set(key,{resolve,reject});ws.send(JSON.stringify({id:key,method,params}));});
    const evaluate=async expression=>(await send('Runtime.evaluate',{expression,returnByValue:true,awaitPromise:true})).result.value;
    await send('Page.enable');
    await send('Emulation.setDeviceMetricsOverride',{width:430,height:850,deviceScaleFactor:1,mobile:false});
    await send('Page.navigate',{url:'http://127.0.0.1:8765'});
    await wait(12000);
    await evaluate(`document.querySelector('flt-semantics-placeholder')?.click()`);
    await wait(2000);
    const clickSelector = async selector => {
      const rect = await evaluate(`(() => {const e=document.querySelector(${JSON.stringify(selector)}); if(!e) return null; const r=e.getBoundingClientRect(); return {x:r.x+r.width/2,y:r.y+r.height/2};})()`);
      if(!rect) throw Error('Missing element: '+selector);
      await send('Input.dispatchMouseEvent',{type:'mousePressed',button:'left',clickCount:1,...rect});
      await send('Input.dispatchMouseEvent',{type:'mouseReleased',button:'left',clickCount:1,...rect});
      await wait(150);
    };
    const clickText = async label => {
      const selector = await evaluate(`(() => {const e=[...document.querySelectorAll('[role="button"],[role="tab"]')].find(e=>e.textContent.trim()===${JSON.stringify(label)} || e.getAttribute('aria-label')===${JSON.stringify(label)});return e?'#'+e.id:null;})()`);
      if(!selector) { console.log(await evaluate('document.body.innerHTML')); throw Error('Missing action: '+label); }
      await clickSelector(selector);
      await wait(500);
    };
    const fill = async (label,text) => {
      await clickSelector('input[aria-label="'+label+'"]');
      await send('Input.insertText',{text});
      await wait(200);
    };
    const assertText = async text => {
      if(!(await evaluate('document.body.textContent')).includes(text)) throw Error('Missing text: '+text);
    };
    const screenshot = async name => {
      await wait(400);
      const shot=await send('Page.captureScreenshot',{format:'png'});
      fs.writeFileSync('docs/screenshots/'+name+'.png',Buffer.from(shot.data,'base64'));
      console.log('Captured '+name);
    };
    await fill('Username','admin');
    await fill('Password','admin123');
    await clickText('Login');
    await assertText('Welcome, Student!');
    await screenshot('01-home');
    await clickText('Calculator');
    await fill('First number','12');
    await fill('Second number','4');
    await clickText('+ Add');
    await assertText('12 + 4 = 16');
    await screenshot('02-calculator');
    await clickText('Profile');
    await assertText('557989');
    await assertText('Jolex129@gmail.com');
    await screenshot('03-profile');
    await clickText('Social Media');
    await assertText('Connect With Me');
    await screenshot('04-social-media');
    await clickText('Facebook\nstudent.sample');
    await assertText('Selected account: Facebook: student.sample');
    await clickText('Calculator');
    await assertText('12 + 4 = 16');
    await clickSelector('input[aria-label="First number"]');
    const first=await evaluate(`document.querySelector('input[aria-label="First number"]').value`);
    if(first!=='12') throw Error('Calculator input was not preserved');
    console.log('Browser login, four destinations, arithmetic, profile, social feedback and state preservation passed.');
  } finally {
    if(ws) ws.close();
    browser.kill();server.close();
  }
})().catch(e=> {console.error(e);process.exitCode=1;});
