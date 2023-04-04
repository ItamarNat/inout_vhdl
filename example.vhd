library ieee;
use ieee.std_logic_1164.all;

entity example is
    port (
        clk: in std_logic;
        data_in: in std_logic;
        data_out: out std_logic := '0';
        data_inout: inout std_logic := '0';
		  data_rd	: out std_logic;
		  cs 			: in std_logic
    );
end example;

architecture rtl of example is
begin
    process (clk, cs)
    begin
        if rising_edge(clk) then
            -- Read from data_in and write to data_out
            data_out <= data_in;
            
            -- Modify data_inout
            -- data_inout <= not data_inout;
				-- Tri-State Buffer control
				if cs = '1' then
					data_inout <= data_in; 
				else
					data_inout <= 'Z';
				end if;
        end if;
    end process;
end rtl;
