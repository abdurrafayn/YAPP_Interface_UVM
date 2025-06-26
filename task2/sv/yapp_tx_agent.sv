class yapp_tx_agent extends uvm_agent;

`uvm_component_utils_begin(yapp_tx_agent)
    `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ACTIVE)
`uvm_component_utils_end


yapp_tx_monitor monitor;
yapp_driver driver;
yapp_tx_sequencer sequencer;


// uvm_active_passive_enum is_active = UVM_ACTIVE;



function new(string name = "yapp_tx_agent", uvm_component parent);
    super.new(name,parent);
    
endfunction

    function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(is_active == UVM_ACTIVE) begin
        
        driver = yapp_driver::type_id::create("driver", this);
        sequencer = yapp_tx_sequencer::type_id::create("sequencer", this);

    end
        monitor = yapp_tx_monitor::type_id::create("monitor", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        if(is_active == UVM_ACTIVE) begin
            driver.seq_item_port.connect(sequencer.seq_item_export);
        end
        
    endfunction

    function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Running Simulation in Agent class", UVM_HIGH);
        
    endfunction
endclass