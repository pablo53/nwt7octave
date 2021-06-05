function nwt7resp = nwt7freqanalyze(nwt7, frequencies, channel)

  if (nargin != 3)
    printf("\nnwt7freqanalyze(nwt7, frequencies, channel): analyze the spectrum via a given channel\n");
    printf("  nwt7: NWT7 config object as created by nwtconfig()\n");
    printf("  frequencies: frequencies [in Hz] vector to analyze\n");
    printf("  channel: input channel (signals and detector assignments depend on a particular NWT7 build) [0-3]\n");
    return;
  endif;
  if ((channel < 0) || (channel > 3))
    printf("incorrect channel");
    return;
  endif;
  
  nooff = columns(frequencies);
  nwt7resp = zeros(1, nooff);
  for i = 1:nooff
    freq = frequencies(i);
    nwt7resp(i) = nwt7measure(nwt7, freq, channel, 10);  # always 10-bit measurement
  endfor;

endfunction
