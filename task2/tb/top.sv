module top;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import yapp_pkg::*;
      `include "router_tb.sv"  
      `include "router_test_lib.sv"  

//     yapp_packet p1,p2,p3;
//     bit ok;

    initial begin

        run_test("short_packet_test");
    end
    
//         p1 = new("p1");
//         p2 = new("p2");

//         repeat (5) begin
//             ok = p1.randomize();
//             if (!ok)
//                 $display("Randomization Failed");
//             else
//                 p1.print();

//         p2.copy(p1);
//         p2.print();


//         $cast(p3,p2.clone());
//         p3.print();
//         //p.print();
//         p1.randomize();
//         if(p1.compare(p2))
//         $display("P1 matching with P2");
//         else
//         $display("P1 is not matching with P2");
//         end
//     end
    
endmodule