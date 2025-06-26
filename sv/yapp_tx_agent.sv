class yapp_tx_agent extends uvm_agent;

`uvm_component_utils_begin(yapp_tx_agent)
    `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ACTIVE)
`uvm_component_utils_end


yapp_tx_monitor monitor;
yapp_driver driver;
yapp_tx_sequencer sequencer;


// uvm_active_passive_enum is_active = UVM_ACTIVE;



function new(string name = "yapp_tx_agent", uvm_component parent = null);
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
endclass

//agent encapsulates sequencer,driver,monitor in a single agent, so environment doesnt have to manage them individually
// class agent extends uvm_agent;

//     `uvm_component_utils(agent)
    
//     // a container that encapsulates all protocol related components
//     driver drv;
//     seqcr seqr;
//     monitor mon;

//     function new(string name = "agent", uvm_component parent = NULL);
//         super.new(name,parent);
//     endfunction

//     function void build_phase(uvm_phase phase);
//         super.build_phase(phase);

//         if(get_is_Active == UVM_ACTIVE) begin //built-in method from uvm_agent (active means driver+sequencer+monitor, passive means -> monitor)
//             //why not drv = new()? becase UVM uses a factory pattern to make testbenches configurable and reuseable, with create we can override the type at runtime
//             drv = driver::type_id::create("drv", this); // necessary to drive DUT input via virtual interface  |||| this is parent i.e. agent ||| drv is necessary for config DB path matching. 
//             seqr = sequencer::type_id::create("seqr", this); // necessary to control which sequence runs and sends data to driver
//         end

//         mon = monitor::type_id::create("mon", this); // neccesay to sample DUT signals and sent them to scoreboard
//     endfunction

//     function void connect_phase(); // buld 
//         if(get_is_Active == UVM_ACTIVE) begin
//             drv.seq_item_port.connect(seqr.seq_item_export); // seq_item_port , a port in driver to recevie sequence items, seq_item_export, an export in sequencer that connects to sequence.
//         end
//     endfunction

// endclass