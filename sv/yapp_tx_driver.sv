class yapp_driver extends uvm_driver#(yapp_packet);

    `uvm_component_utils(yapp_driver)

    function new(string name = "yapp_driver", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    task run_phase(uvm_phase phase);
    forever begin
        seq_item_port.get_next_item(req); 

        send_to_dut(req);

        seq_item_port.item_done();
    end
    endtask
    
    task send_to_dut(yapp_packet req);
    #10ns;
        `uvm_info(get_type_name(), $sformatf("Packet is \n%s", req.sprint()), UVM_LOW);
    endtask
endclass
