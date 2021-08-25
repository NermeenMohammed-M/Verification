interface counter_vif;

 logic sig_clk_in;
 logic sig_rst_in;
 logic sig_en_ctrl_in;
 logic sig_set_ctrl_in;
 logic sig_up_ctrl_in;
 logic[7:0] sig_counter_in;
 logic [7:0]sig_counter_out;
 logic sig_ovf_out;

endinterface: counter_vif