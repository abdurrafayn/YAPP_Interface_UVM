
// Define your enumerated type(s) here

typedef enum { GOOD_PARITY, BAD_PARITY } parity_type_e;



class yapp_packet extends uvm_sequence_item;

// Follow the lab instructions to create the packet.
// Place the packet declarations in the following order:

  rand bit [1:0] addr;
  rand bit [5:0]length;
  rand bit [7:0] payload[];
  rand bit [7:0] parity;
  rand parity_type_e parity_type;  //control knob, for cehcking if its bad parity or good parity
  
  rand bit packet_delay;
  
  //Utility and Field macros,
  
  `uvm_object_utils_begin(yapp_packet)
    `uvm_field_int(addr,UVM_ALL_ON)
    `uvm_field_int(length,UVM_ALL_ON)
    `uvm_field_array_int(payload,UVM_ALL_ON)
    `uvm_field_int(parity,UVM_ALL_ON)
    `uvm_field_enum(parity_type_e, parity_type, UVM_ALL_ON)
    `uvm_field_int(packet_delay,UVM_ALL_ON)
  `uvm_object_utils_end

  // Constructor

  function new(string name = "yapp_packet");
    super.new(name);
  endfunction

  // parity checker
  function bit [7:0] calc_parity();
  bit [7:0] result = 0;
  foreach(payload[i]) begin
    result ^= payload[i];
  end
  return result;
  endfunction


  function void set_parity();
    if(parity_type == GOOD_PARITY)
      parity = calc_parity();
    else 
      parity = ~(calc_parity());
  endfunction

  function void post_randomize();
    set_parity();
  endfunction


  // constraints

  constraint cons_addr {
    addr inside {[0:2]};  //3 is discouraged  
  }

  constraint c_length {
    length inside {[1:63]}; 
  }

  constraint c_payload_size {
    payload.size() == length;
  }

  constraint c_parity_distribution {
    parity_type dist {GOOD_PARITY := 5, BAD_PARITY := 1};
  }

  constraint c_packet_delay {
    packet_delay inside {[1:20]};
  }


endclass: yapp_packet
