package body Parser.StringHelper is

    -----------------------
    -- Remove_Semi_Colon --
    -----------------------

    function Remove_Semi_Colon (Variable : Unbounded_String) return String
    is
        L : Integer := Length (Variable);
    begin

        return To_String (Variable) (1 .. L-1);
    end Remove_Semi_Colon;

     function Get_Expression_Array (Start : Integer; Splited_Row : String_Array)
    return String_Array
    is
    begin

        return Splited_Row (Start .. Splited_Row'Length-1);

    end Get_Expression_Array;

    function Concatenate_Array (Sub_Splited_Row : String_Array) return String
    is
        Row : Unbounded_String;
    begin

        if Sub_Splited_Row'Length = 1 then
            return To_String (Sub_Splited_Row (1));
        end if;

        for I in 1 .. Sub_Splited_Row'Length-1 loop
            Append (Row, Sub_Splited_Row (I));
        end loop;

        return To_String (Row);

    end Concatenate_Array;
end Parser.StringHelper;