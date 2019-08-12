library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity GLU65C02 is

    port 
    (
        PHI2   : in std_logic;
        RESETn : in std_logic;
        ADDR   : in unsigned(15 downto 0);
        RWn    : in std_logic;
        WSn    : in std_logic;
        IOSEL0 : out std_logic;
        IOSEL1 : out std_logic;
        IOSEL2 : out std_logic;
        IOSEL3 : out std_logic;
        RDYn   : out std_logic;
        MRDn   : out std_logic;
        MWRn   : out std_logic;
        RAMCS1 : out std_logic;
        RAMCS2 : out std_logic;
        ROMCS  : buffer std_logic  
    );

end entity;

architecture behavioral of GLU65C02 is
signal FF1: std_logic := '0';

begin

-- MRDn/MWRn gated by PHI2 OR FF1 so they are mantained through waitstate cycles
-- Don't allow writes to ROM space

MRDn <= RWn NAND (PHI2 OR FF1);
MWRn <= (NOT RWn) NAND (PHI2 OR FF1);
        
--   $0000-$7FFF decode as RAM1
--   $8000-$BFFF decode as RAM2 (Bottom 16K)
--   $D000-$DFFF decode as IO
--   $E000-$FFFF decode as ROM


RAMCS1 <= '0' when (to_integer(addr (15 downto 12)) < 16#8#) else '1';

RAMCS2 <= '0' when ((to_integer(addr (15 downto 12)) >= 16#8#) AND (to_integer(addr (15 downto 12)) < 16#D#)) else '1';

ROMCS  <= '0' when (to_integer(addr (15 downto 12)) >= 16#E#) else '1';

IOSEL0 <= '0' when (to_integer(addr (15 downto 8)) = 16#D0#) else '1';
IOSEL1 <= '0' when (to_integer(addr (15 downto 8)) = 16#D1#) else '1';
IOSEL2 <= '0' when (to_integer(addr (15 downto 8)) = 16#D2#) else '1';
IOSEL3 <= '0' when (to_integer(addr (15 downto 8)) = 16#D3#) else '1';

--- Insert 1-Cycle waitstate when the ROM is selected or when /WS is brought low.
RDYn <= '0' WHEN (FF1 = '1') ELSE 'Z';

Waitstate:
process (PHI2, RESETn)
begin
  if (RESETn = '0') then
    FF1 <= '0';
  elsif rising_edge(PHI2) then
    FF1 <= ((ROMCS AND WSn) NOR FF1);
  end if;
end process;

end behavioral;
