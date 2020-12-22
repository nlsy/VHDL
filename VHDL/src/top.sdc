#create input clock which is 12MHz
create_clock -name cp_i -period 83.333 [get_ports {CLK12M}]

#derive PLL clocks
derive_pll_clocks

#derive clock uncertainty
derive_clock_uncertainty

#set false path
set_false_path -from [get_ports {s1_i}]
set_false_path -from [get_ports {s2_i}]
set_false_path -from [get_ports {s3_i}]
#set_false_path -from * -to [get_ports {}]
