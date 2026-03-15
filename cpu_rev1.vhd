library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cpu_rev1 is
port (
	clk : in std_logic;
	inp : in std_logic_vector(3 downto 0); 
   flg : in std_logic_vector(3 downto 0);
	HEX0: out std_logic_vector(6 downto 0);
   HEX1: out std_logic_vector(6 downto 0);
   HEX2: out std_logic_vector(6 downto 0);
   HEX3: out std_logic_vector(6 downto 0);
   HEX4: out std_logic_vector(6 downto 0);
   HEX5: out std_logic_vector(6 downto 0);
	C,Z,S : out std_logic
);
end entity;
 
-- 0 - inc eax (eax++)
-- 1 - dec eax (eax--)
-- 2 - neg eax (-eax) 
-- 3 - mov eax, ebx (ebx = eax)
-- 4 - int eax (id operation = eax) / syscall = 80
-- 5 
 
architecture rtl of cpu_rev1 is
	signal outp : integer range 0 to 15 := 0; -- inp
	signal outf : integer range 0 to 15 := 0; -- flag
	
	signal outh1 : integer range 0 to 15 := 0;
	signal outh2 : integer range 0 to 15 := 0;
	signal outh3 : integer range 0 to 15 := 0;
	signal outh4 : integer range 0 to 15 := 0;
	
	type int_array is array (0 to 3) of integer; 
	signal dat : int_array; -- eax, ebx, ecx, edx
	
	function seg7(x : integer range 0 to 15) return std_logic_vector is
	begin
		case x is
			when 0  => return "1000000"; -- 0
			when 1  => return "1111001"; -- 1
			when 2  => return "0100100"; -- 2
         when 3  => return "0110000"; -- 3
         when 4  => return "0011001"; -- 4
         when 5  => return "0010010"; -- 5
         when 6  => return "0000010"; -- 6
         when 7  => return "1111000"; -- 7
         when 8  => return "0000000"; -- 8
         when 9  => return "0010000"; -- 9
         when 10 => return "0001000"; -- A
         when 11 => return "0000011"; -- b
         when 12 => return "1000110"; -- C
         when 13 => return "0100001"; -- d
         when 14 => return "0000110"; -- E
         when 15 => return "0001110"; -- F
         when others => return "1111111";
		end case;
	end;
	
	function callsys() 
	begin
		case outf is
			when 0 =>
				
				null;
			when 1 =>
				
				null;
			when 2 =>
				
				null;
			when 3 =>
				
				null;
			when 4 =>
				
				null;
			when 5 =>
				
				null;			
			-- 15
			when others =>
				
				null;
		end case;
	end;
	
begin
	process (clk)		
	begin
		if rising_edge(clk) then
			outp <= to_integer(unsigned(inp));
			outf <= to_integer(unsigned(flg));
					
			callsys();
	
			HEX0 <= seg7(outp);
			HEX1 <= seg7(outf);
			
			outh1 <= dat(0);
			outh2 <= dat(1);
			outh3 <= dat(2);
			outh4 <= dat(3);
			
			HEX2 <= seg7(outh1);
			HEX3 <= seg7(outh2);
			HEX4 <= seg7(outh3);
			HEX5 <= seg7(outh4);
			
		end if;		
	end process;
end rtl;
