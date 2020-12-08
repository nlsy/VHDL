
ARCHITECTURE a1 OF mx2snd IS
BEGIN
  WITH s_i SELECT
  txd_o <=      '0' WHEN "00000",
            d_i( 0) WHEN "00001",
            d_i( 1) WHEN "00010",
            d_i( 2) WHEN "00011",
            d_i( 3) WHEN "00100",
            d_i( 4) WHEN "00101",
            d_i( 5) WHEN "00110",
            d_i( 6) WHEN "00111",
            d_i( 7) WHEN "01000",
            d_i( 8) WHEN "01001",
            d_i( 9) WHEN "01010",
            d_i(10) WHEN "01011",
            d_i(11) WHEN "01100",
            d_i(12) WHEN "01101",
            d_i(13) WHEN "01110",
            d_i(14) WHEN "01111",
            d_i(15) WHEN "10000",
                '0' WHEN OTHERS;
END a1;