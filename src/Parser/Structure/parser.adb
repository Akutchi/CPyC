with Ada.Strings;           use Ada.Strings;
with Ada.Strings.Fixed;     use Ada.Strings.Fixed;
with Ada.Strings.Maps;      use Ada.Strings.Maps;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO;           use Ada.Text_IO;

with Objects.Statement; use Objects.Statement;
with Types.Prefix;      use Types.Prefix;

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

    function Cure_Variable (Variable : Unbounded_String) return String
    is
        L : Integer := Length (Variable);
    begin

        return To_String (Variable) (1 .. L-1);
    end Cure_Variable;

    ----------------
    -- Parse_Line --
    ----------------

    function Parse_Variable (Row : String) return VariableObject
    is
        Splited_Line : String_Array := Split_Line (Row);

        Is_Typped : Boolean :=
            New_GType (CHAR, New_GType (INT, Splited_Line (1))).Get_State;

    begin

        if Is_Undeclared_Variable (Is_Typped, Row) then

            declare
                Currated_Var : String := Cure_Variable (Splited_Line (2));
            begin
                return New_Variable (Var_Name => Currated_Var);
            end;
        end if;

        return New_Variable (Var_Name => "");

    end Parse_Variable;

end Parser;