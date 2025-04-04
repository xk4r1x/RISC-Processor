module Hazard_Detection (
   input logic ID_EX_MemRead,
   input logic [4:0] ID_EX_Rt, IF_ID_Rs, IF_ID_Rt,
   output logic Stall
);
   always_comb begin
      if (ID_EX_MemRead && ((ID_EX_Rt == IF_ID_Rs)||(ID_EX_Rt == IF_ID_Rt)))
         Stall = 1;
      else
         Stall = 0;
   end
endmodule