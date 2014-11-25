

// to preload all Instr, avoiding delay when played:
Instr.loadAll;

// define an Instr:
Instr(\yup,{
  a = Line.kr(10,1,0.2);
  SinOsc.ar([400,403],mul:a).clip(-1,1);
}).play;
