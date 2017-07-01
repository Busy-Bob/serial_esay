library verilog;
use verilog.vl_types.all;
entity test1 is
    port(
        clk250          : in     vl_logic;
        key             : in     vl_logic;
        reset           : in     vl_logic;
        clk9600         : in     vl_logic;
        value           : in     vl_logic_vector(3 downto 0);
        ser             : out    vl_logic;
        off_number      : out    vl_logic_vector(2 downto 0);
        show_value      : out    vl_logic_vector(15 downto 0)
    );
end test1;
