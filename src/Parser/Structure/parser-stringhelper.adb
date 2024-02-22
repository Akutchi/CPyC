with Ada.Strings;           use Ada.Strings;
with Ada.Strings.Fixed;     use Ada.Strings.Fixed;
with Ada.Strings.Maps;      use Ada.Strings.Maps;
with Ada.Text_IO;           use Ada.Text_IO;

package body Parser.StringHelper is

    ----------------
    -- Split_Line --
    ----------------

    function Split_Line (Row : String; Pattern : String) return String_Array
    is

        Cnt : Integer := Ada.Strings.Fixed.Count (Source  => Row, Pattern => Pattern);

        Array_Index : Natural := 1;
        Splited_Line : String_Array (1 .. Cnt+1);

        whitespace : constant Character_Set := To_Set (Pattern (Pattern'First));
        F : Positive;
        L : Natural;
        I : Natural := 1;

    begin

        while I in Row'Range loop

            Find_Token
            (Source => Row,
            Set    => whitespace,
            From => I,
            Test   => Outside,
            First  => F,
            Last   => L);

            Splited_Line (Array_Index) := To_Unbounded_String (Row (F .. L));

            exit when L = 0;

            I := L + 1;
            Array_Index := Array_Index + 1;

        end loop;

        return Splited_Line;

    end Split_Line;

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
            Append (Row, Sub_Splited_Row (I) & " ");
        end loop;

        return To_String (Row);

    end Concatenate_Array;

    -------------------------
    -- Get_Real_Row_Length --
    -------------------------

    function Get_Real_Row_Length (Row : String) return Integer
    is
        I : Positive := 1;
    begin

        if Row'Length = 0 then
            return 1;
        end if;

        loop

            exit when I = Row'Length or Row (I) = ';' or Row (I) = '}';
            I := I + 1;
        end loop;

        return I;

    end Get_Real_Row_Length;

end Parser.StringHelper;