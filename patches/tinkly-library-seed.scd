
// to be separated into
// an amplitude mod Instr ("mask" or "texture")
// and a tone generator Instr
// So they can be Patched and recombined with others




Instr(\tinkly,{
  arg freq=440;
  freq = freq * (LFNoise0.kr(0.1).range(0.5,2.0));
  Saw.ar([freq,freq*1.5])*LFNoise0.kr([8,8]);
}).test;