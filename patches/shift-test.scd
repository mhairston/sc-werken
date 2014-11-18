





{
  a = RLPF.ar(WhiteNoise.ar,[440,660,880],0.005);

  c = Mix.ar(PitchShift.ar(a,pitchRatio:[MouseX.kr(0.1,4)]));


c = Pan2.ar(c,0);

}.play
