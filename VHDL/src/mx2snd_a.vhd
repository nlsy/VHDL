
ARCHITECTURE a1 OF mx2snd IS
BEGIN
  WITH s_i SELECT
  txd_o <=  d_i( 0) WHEN "0000",
            d_i( 1) WHEN "0001",
            d_i( 2) WHEN "0010",
            d_i( 3) WHEN "0011",
            d_i( 4) WHEN "0100",
            d_i( 5) WHEN "0101",
            d_i( 6) WHEN "0110",
            d_i( 7) WHEN "0111",
            d_i( 8) WHEN "1000",
            d_i( 9) WHEN "1001",
            d_i(10) WHEN "1010",
            d_i(11) WHEN "1011",
            d_i(12) WHEN "1100",
            d_i(13) WHEN "1101",
            d_i(14) WHEN "1110",
            d_i(15) WHEN "1111",
                '0' WHEN OTHERS;
END a1;
