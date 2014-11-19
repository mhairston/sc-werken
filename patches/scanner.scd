
SynthDef(\scanner,{
  arg freq=3000, amp=0.5, dur=1,
  amrate=6, fmrate=880, panrate = 1/4;
  var mod,fm;
  mod =     SinOsc.kr(amrate).range(0.2,1);
  fm =     SinOsc.ar(fmrate).range(0.001,1);
  a =       SinOsc.ar(freq*fm,mul:amp) * m;
  p =       SinOsc.ar(panrate).range(-0.99,0.99);
  e =       Line.kr(1,0,dur,doneAction:2);
  a =       Pan2.ar(a,p) * e;
  Out.ar(0,a);
}).add;

// Not working!!
t=Task({
  var freq,amp,dur,panrate,amrate,fmrate;
  8.do({
    freq = rrand(900,9000);
    amp = rrand(0.3,0.7);
    dur = rrand(1,4);
    panrate = rrand(1/32,10);
    amrate = rrand(2,24);
    fmrate = rrand(20,900);
    Synth.tail(s,\scanner,[
      \freq, freq, \amp, amp, \dur, dur,
      \panrate, panrate,
      \amrate, amrate,
      \fmrate, fmrate,
    ]);
    rrand(1,8).wait;
  });
});

t.play;
