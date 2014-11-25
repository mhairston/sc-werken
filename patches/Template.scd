



(
Instr(\foop,{
  arg freq=440,amp=0.3,dur=1,cutoffRatio=1.5;
  var audio;
  audio = LPF.ar(Saw.ar(freq),freq*cutoffRatio) * XLine.kr(0.001,amp,dur,doneAction:2);
  audio!2;
},[
    \freq,
    \amp,
    [0.01,10,0,0.01,1,"sec"],
    [0.25,8.0,0,0.01,4]
]);


~sc=[0,2,4,7,9];
~base = 60;

Synth.tail(s, \gverb);

InstrSpawner(\foop,[
  Prand((~base+~sc).midicps,8),
  0.4,
  Prand([1,2],8),
  Prand([0.7,0.8,1,1,1.5,2,3,4,5],8)
],rrand(0.5,1)).gui;
)


(
v=View(bounds:300@300);
5.do { |i|
    Slider(v).moveTo(i * 25 + 10, 10);
};
v.front;
)