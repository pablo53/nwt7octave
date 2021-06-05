function nwt7 = nwt7config(ad985x_sel, ad985x_freq, pic16_freq, rs232_port, rs232_highspeed)

  if (nargin != 5)
    printf("\nnwt7config(ad985x_sel, ad985x_freq, pic16_freq, rs232_port, rs232_highspeed): create and configure a communicator for NWT7\n");
    printf("  ad985x_sel: DDS chipset selecor: 0 = AD9850, 1 = AD9851\n");
    printf("  ad985x_freq: frequency [in MHz] of the oscillator feeding AD9850/1 DDS chip\n");
    printf("  pic16_freq: PIC16F876A chip crystal oscillator frequency [in MHz]; accepted are 4 or 10\n");
    printf("  rs232_port: tty port to which NWT7 is connected to, e.g. /dev/ttyUSB0, /dev/ttyS0, etc.\n");
    printf("  rs232_highspeed: True - for higher speed of RS232, False - for normal speed\n");
    return;
  endif;
  if ((ad985x_sel != 0) && (ad985x_sel != 1))
    printf("incorrect value for parameter ad985x_sel\n");
    return;
  endif;
  if ((pic16_freq != 4) && (pic16_freq != 10))
    printf("incorrect value for parameter pic16_freq\n");
    return;
  endif;

  nwt7ddsfreq = ad985x_freq * 1000000;
  if (ad985x_sel == 1)
    nwt7ddsfreq *= 6;  # AD9851 has an internal frequency multiplier x6
  endif;
  switch (pic16_freq)
    case 4
      if (rs232_highspeed)
        baudrate = 19200;
      else
        baudrate = 9600;
      endif;
    case 10
      if (rs232_highspeed)
        baudrate = 57600;
      else
        baudrate = 38400;
      endif;
  endswitch;

  nwt7serialport = serial(rs232_port, baudrate, 10);
  set(nwt7serialport, 'baudrate', baudrate, 'bytesize', 8, 'parity', 'None', 'stopbits', 1, 'timeout', 10);
  
  nwt7.serialport = nwt7serialport;
  nwt7.ddsfreq = nwt7ddsfreq;

endfunction
