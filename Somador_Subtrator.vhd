library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Somador_Subtrator is
    Port (
        A      : in  STD_LOGIC_VECTOR (3 downto 0);
        B      : in  STD_LOGIC_VECTOR (3 downto 0);
        SEL    : in  STD_LOGIC;  -- 0 = soma, 1 = subtração
        S      : out STD_LOGIC_VECTOR (3 downto 0);
        Overflow : out STD_LOGIC
    );
end Somador_Subtrator;

architecture Behavioral of Somador_Subtrator is
    signal A_signed, B_signed, B_mux, Result : SIGNED(3 downto 0);
    signal Carry_out : STD_LOGIC;
begin
    -- Conversão de entrada para signed
    A_signed <= SIGNED(A);
    B_signed <= SIGNED(B);

    -- Subtração: invertemos B e somamos 1 (complemento de dois)
    B_mux <= B_signed when SEL = '0' else (-B_signed);

    -- Soma ou subtração
    Result <= A_signed + B_mux;

    -- Atribuição do resultado
    S <= STD_LOGIC_VECTOR(Result);

    -- Detecção de overflow (para números com sinal)
    Overflow <= '1' when 
        (A_signed(3) = B_mux(3)) and (Result(3) /= A_signed(3))
        else '0';

end Behavioral;
