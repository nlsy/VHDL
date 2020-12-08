Process 1
WHEN init_st     => IF    (enter_i='1' AND leave_i='0' AND max_i='0') THEN nxt_st <= inc_clac_st;
                    ELSIF (enter_i='0' AND leave_i='1' AND min_i='0') THEN nxt_st <= dec_calc_st;
                    ELSE nxt_st <= init_st;
                    END IF;

WHEN inc_clac_st => nxt_st <= inc_conf_st;
WHEN dec_calc_st => nxt_st <= dec_conf_st;
WHEN inc_conf_st => IF (max_i='1') THEN nxt_st <= max_send_st;
                    ELSE  nxt_st <= inc_send_st;
                    END IF;
WHEN dec_conf_st => nxt_st <= dec_send_st;
WHEN inc_send_st => nxt_st <= init_st;
WHEN dec_send_st => nxt_st <= init_st;
WHEN max_send_st => nxt_st <= init_st;


Process 2
WHEN S3     => inc_s <= '1'; dec_s <= '0';
WHEN S4     => inc_s <= '0'; dec_s <= '1';
WHEN inc_send_st => inc_s <= '0'; dec_s <= '0'; sub_o <= '1'; grn_o <= '1'; red_o <= '0'; evt_o <= "00101011"; -- ascii '+'
WHEN dec_send_st => inc_s <= '0'; dec_s <= '0'; sub_o <= '1'; grn_o <= '1'; red_o <= '0'; evt_o <= "00101101"; -- ascii '-'
WHEN max_send_st => inc_s <= '0'; dec_s <= '0'; sub_o <= '1'; grn_o <= '0'; red_o <= '1'; evt_o <= "00100001"; -- ascii '!'
WHEN OTHERS => inc_s <= '0'; dec_s <= '0'; sub_o <= '0'; grn_o <= '0'; red_o <= '0'; evt_o <= "00000000";

