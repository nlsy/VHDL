#create input clock which is 12MHz
create_clock -name cp_i -period 83.333 [get_ports {CLK12M}]