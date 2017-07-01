library verilog;
use verilog.vl_types.all;
entity key_out is
    port(
        IN_clk          : in     vl_logic;
        IN_value        : in     vl_logic_vector(3 downto 0);
        IN_key          : in     vl_logic;
        IN_reset        : in     vl_logic;
        IN_shank_hand   : in     vl_logic;
        OUT_value       : out    vl_logic_vector(63 downto 0);
        OUT_number      : out    vl_logic_vector(4 downto 0);
        OUT_finish      : out    vl_logic;
        OUT_off_number  : out    vl_logic_vector(2 downto 0);
        OUT_show_value  : out    vl_logic_vector(15 downto 0)
    );
end key_out;
