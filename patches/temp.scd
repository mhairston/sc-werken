(
Instr(\kick, {arg freq = 50, rate = 1, decay = 0.7;
  var x,t;
  x = SinOsc.ar(freq);
  t = Dust.kr(rate);
  RLPF.ar(x,EnvGen.kr(Env.perc(0,decay,level:200),gate:t),rq:1);
});
)


Patch(\kick).gui;
x.set(\freq,200);
x.set(\decay,0.6);
x.set(\rate,0.40);


x = Instr(\kick).play

s = Server.local.boot;


{VarSaw.ar}.plot
