/**/
SynthDef(\scanner,{
  arg freq=3000, amp=0.5, dur=1,
  amrate=6, fmrate=880, panrate = 1/4;
  var mod,fm;
  mod =     SinOsc.kr(amrate).range(0.2,1);
  fm =     SinOsc.ar(fmrate).range(0.001,1);
  a =       SinOsc.ar(freq*fm,mul:amp) * mod;
  p =       SinOsc.ar(panrate).range(-0.99,0.99);
  e =       EnvGen.kr(Env.new([0,1,0],[4,dur,4]),doneAction:2);
  a =       Pan2.ar(a,p) * e;
  a = a * LFNoise0.kr(32).range(0.3,1);
  Out.ar(0,a);
}).add;

t=Task({
  var freq,amp,dur,panrate,amrate,fmrate;
  freq = rrand(900,9000);
  amp = rrand(0.3,0.7);
  dur = rrand(4,8);
  panrate = rrand(1/32,1);
  amrate = rrand(2,24);
  fmrate = rrand(20,900);
  Synth.tail(s,\scanner,[
    \freq, freq, \amp, amp, \dur, dur,
    \panrate, panrate,
    \amrate, amrate,
    \fmrate, fmrate,
  ]);
});

t.reset;t.play;
