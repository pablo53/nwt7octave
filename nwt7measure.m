function sig = nwt7measure(nwt7, freq, channel, bits)

  if (nargin != 3) && (nargin != 4)
    printf("\nnwt7measure(nwt7, freq, channel, bits): set the output frequency and measure an input channel signal\n");
    printf("  nwt7: NWT7 config object as created by nwtconfig()\n");
    printf("  freq: the frequency [in Hz] to set the NWT output to, and subsequently take the measure from a given input channel\n");
    printf("  channel: input channel (signals and detector assignments depend on a particular NWT7 build) [0-3]\n");
    printf("  bits: measurement resolution in bits accepted values are 8 or 10\n");
    return;
  endif;
  if ((channel < 0) || (channel > 3))
    printf("incorrect channel");
    return;
  endif;
  if ((bits != 8) && (bits != 10))
    printf("incorrect no. of bits");
    return;
  endif;
  
  freqcmdvalue = round(freq * 2 ^ 32 / nwt7.ddsfreq);
  freqcmd = char([0, 0, 0, 0]);
  for i = 1:4
    freqcmd(i) = bitand(freqcmdvalue, 0xff);
    freqcmdvalue = bitshift(freqcmdvalue, -8);
  endfor;

  measurecmd = 0x50 + channel;
  switch (bits)
    case 8
      explen = 1;
    case 10
      explen = 2;
      measurecmd += 4;
  endswitch;
  measurecmd = char([measurecmd]);

  srl_write(nwt7.serialport, freqcmd);
  srl_write(nwt7.serialport, measurecmd);

  [rs232data, rs232cnt] = srl_read(nwt7.serialport, explen);

  if (rs232cnt < explen)
    printf("%s\n", "Couldn't read enough data from NWT7");
    return;
  elseif (explen == 1)
    sig = int64(rs232data(1));
  elseif (explen == 2)
    hi = int64(rs232data(1));
    lo = int64(rs232data(2));
    sig = lo + 256 * hi;
  endif;

endfunction
