library verilog;
use verilog.vl_types.all;
entity serial_output is
    port(
        IN_clk          : in     vl_logic;
        IN_finish       : in     vl_logic;
        IN_value        : in     vl_logic_vector(63 downto 0);
        IN_number       : in     vl_logic_vector(4 downto 0);
        OUT_ser         : out    vl_logic;
        OUT_shanke_hand : out    vl_logic
    );
end serial_output;
