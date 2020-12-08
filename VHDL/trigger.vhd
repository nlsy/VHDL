
Process fsm
WHEN S0 =>  IF    (ls_i="001") THEN nxt_st <= S1;
            ELSIF (ls_i="100") THEN nxt_st <= S1;
            ELSE  nxt_st <= S0;
            END IF ;

WHEN S1 =>  IF    (ls_i= "010") THEN nxt_st <= S2;
						ELSE  nxt_st <= S1;
					  END IF;

WHEN S2 =>  IF    (ls_i="001") THEN nxt_st <= S3;
            ELSIF (ls_i="100") THEN nxt_st <= S4;
						ELSE  nxt_st <= S2;
					  END IF;

WHEN S3 =>  nxt_st <= S0;
WHEN S4 =>  nxt_st <= S0;

Process result
WHEN S3     => inc_s <= '1'; dec_s <= '0';
WHEN S4     => inc_s <= '0'; dec_s <= '1';
WHEN OTHERS => inc_s <= '0'; dec_s <= '0';
