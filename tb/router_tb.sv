class router_tb extends uvm_env;
    
`uvm_component_utils(router_tb)

    function new(string name ="router_tb", uvm_component parent);
        super.new(name, parent);
    endfunction: new
    
    yapp_env environment;



    function void build_phase(uvm_phase phase);
    
        environment = new("environment", this);
        
        super.build_phase(phase);
        `uvm_info("build_phase","Build base of base test is executing", UVM_HIGH);
    endfunction: build_phase

endclass: router_tb