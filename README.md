# nwt7octave
NWT7 controll via Octave


#### Before You start using this library, install ```instrument-control package``` for Octave:
in Ubuntu, type the following command from shell:

```$ sudo apt install octave-instrument-control```

The, after You start Yuor session in Octave, load the above library:

```octave:1> pkg load instrument-control```

#### Example:
For an NWT7 with a PIC16F876A driven by 10MHz cristal oscillator and an AD9851 driven by 32MHz cristall oscillator, set for high speed RS232, we want to generate 1.8 MHz sin wave and check the the response with 10-bit resolution in the channel 0 (whether this is an input of a linear detector or a log detector, depends on how the particular NWT7 was assembled; it can be even other type of an head in Your NWT7 - e.g. some spectrum analyzer or an antenna analyzer).

```octave:2> nwt7 = nwt7config(1, 32, 10, "/dev/ttyUSB0", true)```

```octave:3> nwt7measure(nwt7, 1800000, 0, 10)```
