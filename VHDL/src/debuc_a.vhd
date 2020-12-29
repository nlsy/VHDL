-- ----------------------------------------------------------------------------

ARCHITECTURE ar1 OF debnc IS

BEGIN

  -- Modules -----------------------------------------
  -- Debouncing the input
  db1 : dbpul
    GENERIC MAP (debounce_const)
    PORT    MAP (rst_n_i,clk_i,ub1_i,db1_o);
  db2 : dbpul
    GENERIC MAP (debounce_const)
    PORT    MAP (rst_n_i,clk_i,ub2_i,db2_o);
  db3 : dbpul
    GENERIC MAP (debounce_const)
    PORT    MAP (rst_n_i,clk_i,ub3_i,db3_o);

END ar1;

-- ----------------------------------------------------------------------------