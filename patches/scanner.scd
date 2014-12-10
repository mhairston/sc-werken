/**/
SynthDef(\scanner,{
  arg freq=3000, amp=0.5, gate = 1,
  amrate=6, fmrate=880, panrate = 1/4,
  attack=2,release=2,cutoff=12000;
  var mod,fm;
  mod =     SinOsc.kr(amrate).range(0.2,1);
  fm =      SinOsc.ar(fmrate).range(0.001,1);
  a =       SinOsc.ar(freq*fm,mul:amp) * mod;
  p =       SinOsc.ar(panrate).range(-0.99,0.99);
  e =       EnvGen.kr(Env.asr(attack,0.8,release,'sine'),gate:gate,doneAction:2);
  a =       Pan2.ar(a,p) * e;
  a =       a * LFNoise0.kr(32).range(0.3,1);
  a =       LPF.ar(a,cutoff);
  Out.ar(0,a);
}).add;

Pbind(
  \instrument,\scanner,
  \freq,  Pfunc({rrand(50,12500)}),
  \dur,   Pfunc({rrand(60,100)},inf),
  \delta, 20,
  \amp,   Pfunc({rrand(0.04,0.3)}),
  \panrate, Pfunc({rrand(1/150,1/30)}),
  \amrate, Pfunc({rrand(2,24)}),
  \fmrate, Pfunc({rrand(20,1000)}),
  \attack,30,\release,30,\cutoff,2000
).play;
Synth.tail(s,\dubecho,[\delay,0.28,\fb,0.91]);

Pbind(
    \instrument,\scanner,
    \freq,  Pfunc({rrand(50,2500)}),
    \dur,   Pfunc({[0.125,0.25,8].wchoose([0.3,0.6,0.1])/2},inf),
    \amp,   Pfunc({rrand(0.02,0.8)}),
    \panrate, Pfunc({rrand(1/32,1)}),
    \amrate, Pfunc({rrand(2,24)}),
    \fmrate, Pfunc({rrand(20,1000)}),
    \attack,0,\release,0,\cutoff,8000
).play;
