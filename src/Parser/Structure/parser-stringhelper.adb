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

    --------------------------
    -- Get_Expression_Array --
    --------------------------

    function Get_Expression_Array (Start : Integer; Splited_Row : String_Array)
    return String_Array
    is
    begin

        return Splited_Row (Start+1 .. Splited_Row'Length);

    end Get_Expression_Array;

    -----------------------
    -- Concatenate_Array --
    -----------------------

    function Concatenate_Array (Sub_Splited_Row : String_Array) return String
    is
        Row : Unbounded_String;
    begin

        if Sub_Splited_Row'Length = 1 then
            return To_String (Sub_Splited_Row (Sub_Splited_Row'First));
        end if;

        for I in Sub_Splited_Row'Range loop
            Append (Row, Sub_Splited_Row (I));
        end loop;

        return To_String (Row);

    end Concatenate_Array;
end Parser.StringHelper;