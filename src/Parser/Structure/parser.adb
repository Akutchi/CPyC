with Ada.Strings;           use Ada.Strings;
with Ada.Strings.Fixed;     use Ada.Strings.Fixed;
with Ada.Strings.Maps;      use Ada.Strings.Maps;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO;           use Ada.Text_IO;

with GNAT.Regpat; use GNAT.Regpat;

with Types.Prefix; use Types.Prefix;

package body Parser is

    ----------------
    -- Split_Line --
    ----------------

    function Split_Line (Row : String) return String_Array
    is

        P : String := " ";
        Cnt : Integer := Ada.Strings.Fixed.Count (Source  => Row, Pattern => P);

        Array_Index : Natural := 1;
        Splited_Line : String_Array (1 .. Cnt+1);

        whitespace : constant Character_Set := To_Set (' ');
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

    ----------------------------
    -- Is_Undeclared_Variable --
    ----------------------------

    function Is_Undeclared_Variable (Is_Typped : Boolean ; Row : String)
    return Boolean
    is
    begin
        return Is_Typped and Row(Row'Last) = ';';
    end;

    ----------------
    -- Parse_Line --
    ----------------

    function Parse_Line (Row : String) return PrefixStructure
    is
        Splited_Line : String_Array := Split_Line (Row);

        Is_Typped : Boolean :=
            New_GType (CHAR, New_GType (INT, Splited_Line(1))).Get_State;

    begin

        if Is_Undeclared_Variable (Is_Typped, Row) then
            return VAR_PREFIX;
        end if;

        return NULL_PREFIX;

    end Parse_Line;

end Parser;