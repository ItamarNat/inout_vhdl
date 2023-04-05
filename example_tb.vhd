library ieee;
use ieee.std_logic_1164.all;

entity example_tb is
end example_tb;

architecture tb_arch of example_tb is
   signal clk: std_logic := '0';
   signal data_in: std_logic := '0';
   signal data_out: std_logic;
   signal data_inout: std_logic := '0';
	signal cs			: std_logic := '0';
	signal data_rd		: std_logic;
   
   component example
      port (
         clk: in std_logic;
         data_in: in std_logic;
         data_out: out std_logic;
         data_inout: inout std_logic;
			cs			: in std_logic;
			data_rd	: out std_logic
      );
   end component;
begin
   DUT: example
      port map (
         clk => clk,
         data_in => data_in,
         data_out => data_out,
         data_inout => data_inout,
			cs => cs,
			data_rd => data_rd
      );
		
	clk <= not clk after 10 ns;
		
--	clk_process: process
--	begin
--		clk <= '0';
--		wait for 5 ns;
--		clk <= '1';
--		wait for 5 ns;
--	end process;

	stimulus_process: process
	begin
		-- Set data_in to '1'
		
		data_in <= '1';
		wait for 20 ns;
		
		cs <= '1';
		-- Set data_inout to '1'
		data_inout <= '1';
		wait for 20 ns;
		
		cs <= '0';
		-- Set data_in to '0'
		data_in <= '0';
		wait for 20 ns;
		
		-- Set data_inout to '0'
		data_inout <= '0';
		wait for 20 ns;
		
		-- End the simulation
		wait;
	end process;
	
	monitor_process: process
	begin
		wait for 5 ns;
		
		-- Check that data_out is initially '0'
		assert data_out = '0' report "Error: data_out is not '0'" severity error;
		
		wait for 5 ns;
		
		-- Check that data_out is now '1'
		assert data_out = '1' report "Error: data_out is not '1'" severity error;
		
		wait for 5 ns;
		
		-- Check that data_out is still '1'
		assert data_out = '1' report "Error: data_out is not '1'" severity error;
		
		wait for 5 ns;
		
		-- Check that data_out is now '0'
		assert data_out = '0' report "Error: data_out is not '0'" severity error;
		
		wait for 5 ns;
		
		-- Check that data_out is still '0'
		assert data_out = '0' report "Error: data_out is not '0'" severity error;
		
		wait;
	end process;



end tb_arch;
