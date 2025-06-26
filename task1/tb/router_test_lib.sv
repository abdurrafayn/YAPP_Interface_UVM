class base_test extends uvm_test;

    `uvm_component_utils(base_test)

    function new(string name="base_test", uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    router_tb inst_tb;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
         uvm_config_wrapper::set(this, "inst_tb.environment.agent.sequencer.run_phase",
                                "default_sequence",
                                yapp_5_packets::get_type());

        inst_tb = new("inst_tb", this);
        uvm_config_int::set( this, "*", "recording_detail", 1);
        `uvm_info("test_phase","Build phase of test is executing", UVM_HIGH);
    endfunction: build_phase

    function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction

        function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "Running Simulation in Test class", UVM_HIGH);
        
    endfunction

    function void check_phase(uvm_phase phase);
        check_config_usage(phase);
    endfunction
endclass //className extends superClass


//base_test p1;
class test2 extends base_test;
    `uvm_component_utils(test2)

   function new(string name="test2", uvm_component parent);
        super.new(name, parent);
    endfunction //new()

endclass //className extends superClass

class short_packet_test extends base_test;

    function new(string name="short_packet_test", uvm_component parent);
        super.new(name, parent);
    endfunction 

       `uvm_component_utils(short_packet_test)

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        set_type_override_by_type(yapp_packet::get_type(), short_packet_test::get_type());
    endfunction

endclass
