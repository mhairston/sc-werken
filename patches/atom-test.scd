


{
  a = Saw.ar([200,201,199,202]);
  a = Mix.ar(a);
  c = Lag2.kr(Impulse.kr(1), 1.0);
  Pan2.ar(a * c,0);
}.play;


{SinOsc.kr(200)}.play;

s.gui
