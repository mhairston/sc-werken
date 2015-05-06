

// Various distortion effects:


srcFM = SinOsc.ar(freq + (modindex * modfreq * SinOsc.ar(modfreq)), 0, dist).tanh * amp;



Batuhan Bozkurt:
Not much like Boss MZ distortion but I had a decent guitar amp type distortion here:

/*
Waveshaper

References : Posted by Partice Tarrabia and Bram de Jong

Notes :
amount should be in [-1..1[ Plot it and stand back in astonishment! ;)

Code :
x = input in [-1..1]
y = output
k = 2*amount/(1-amount);

f(x) = (1+k)*x/(1+k*abs(x))
http://www.musicdsp.org/archive.php?classid=4#203
*/

(
{
  var x = SinOsc.ar(220, 0, 0.8);
  var amount = MouseX.kr(-1, 1);
  var k = 2 * amount / (1 - amount);
  (1 + k) * x / (1 + (k * x.abs));
}.scope

)

// a bit of filtering and tweaking, you get a decent guitar amp...

(
{
  var in, amount, amCoef;
  in = HPF.ar(SoundIn.ar(0), 400)*5;
  amount = 0.99;
  amCoef= 2*amount/(1-amount);
  MidEQ.ar(LPF.ar((1+amCoef)*in/(1+(amCoef*in.abs)), [3800, 3900])*0.5, 120, 0.7, 8);
}.play;
)

Maybe you can tweak / add / remove filters to suit your needs. The algorithm is in the comments. It sounds very raw as is because of the low freq content. So before distorting I HPF the input, apply the algorithm, and add LPF and MidEQ for some primitive cabinet simulation. Getting rid of/tweaking the LPF and MidEQ might help for harsher distortion. You can premultiply the HPF'ed input by bigger numbers (it is 5 in here). Hope this helps.

Best,
Batuhan Bozkurt
/* http://www.earslap.com */

http://new-supercollider-mailing-lists-forums-use-these.2681727.n2.nabble.com/Distortion-effect-td5173262.html
