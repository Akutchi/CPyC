with Ada.Strings;           use Ada.Strings;
with Ada.Strings.Fixed;     use Ada.Strings.Fixed;
with Ada.Strings.Maps;      use Ada.Strings.Maps;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO;           use Ada.Text_IO;

with Objects.VarObject; use Objects.VarObject;
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

    function Is_Undeclared_Variable (Is_Typped : Boolean ; Split_Row : String_Array)
    return Boolean
    is
    begin

        declare
            Last_EI  : Integer   := Split_Row'Last;
            Last_EL  : Integer   := Length (Split_Row (Last_EI));
            Last_EC  : Character := To_String (Split_Row (Last_EI)) (Last_EL-1);
        begin
            return Is_Typped and Last_EC /= '{';
        end;

    exception
        when Constraint_Error => return false;
    end;

    --------------------------
    -- Is_Declared_Variable --
    --------------------------

    function Is_Declared_Variable (Is_Typped : Boolean ; Split_Row : String_Array)
    return Boolean
    is
    begin

        declare
            Char_Rep : constant Character := To_String (Split_Row (3)) (1);
        begin
            return Is_Typped and Char_Rep = '=';
        end;

    exception
        when Constraint_Error => return false;
    end;

    -----------------------
    -- Remove_Semi_Colon --
    -----------------------

    function Remove_Semi_Colon (Variable : Unbounded_String) return String
    is
        L : Integer := Length (Variable);
    begin

        return To_String (Variable) (1 .. L-1);
    end Remove_Semi_Colon;

    ----------------
    -- Parse_Line --
    ----------------

    function Parse_Line (Row : String) return RowInformation
    is
        Splited_Line : String_Array := Split_Line (Row);

        Is_Typped : Boolean :=
            New_GType (CHAR, New_GType (INT, Splited_Line (1))).Get_State;

        Current_Row : RowInformation := (Splited_Line'Last, Splited_Line,
                                        NULL_PREFIX);

    begin

        if Is_Declared_Variable (Is_Typped, Splited_Line) then
            Current_Row.Prefix := VAR_ASSIGNED_PREFIX;

        elsif Is_Undeclared_Variable (Is_Typped, Splited_Line) then
            Current_Row.Prefix := VAR_PREFIX;

        end if;

        return Current_Row;

    end Parse_Line;

    function Generate_Int_Variable (Current_Row : RowInformation)
    return IntImplAssignment.Any_Assignment
    is

        Splited_Row : String_Array := Current_Row.Splited_Line;

        Null_Var : IntAssignment.ConcreteAssignment_Access :=
                    IntAssignment.New_Assignment
                        (Axiom          => INT,
                         Left_Member    => New_Variable (Var_Name => ""),
                         Right_Member   => New_IntegerValue (Value => 0));
    begin

        case Current_Row.Prefix is

            when VAR_PREFIX =>

                declare
                    Currated_Var : String := Remove_Semi_Colon
                                                (Splited_Row (2));

                    New_Var : IntAssignment.ConcreteAssignment_Access :=
                                IntAssignment.New_Assignment
                                    (Axiom          => INT,
                                     Left_Member    => New_Variable
                                                        (Var_Name =>
                                                            Currated_Var),
                                     Right_Member   => New_IntegerValue
                                                        (Value => 0));
                begin

                return IntImplAssignment.Any_Assignment(New_Var);
                end;

            when VAR_ASSIGNED_PREFIX =>

                declare
                    Name      : String  := To_String (Splited_Row (2));
                    Var_Value : Integer := Integer'Value
                                                (Remove_Semi_Colon
                                                    (Splited_Row
                                                        (Splited_Row'Last)));

                    New_Var : IntAssignment.ConcreteAssignment_Access :=
                            IntAssignment.New_Assignment
                                (Axiom          => INT,
                                    Left_Member    => New_Variable
                                                        (Var_Name => Name),
                                    Right_Member   => New_IntegerValue
                                                        (Value => Var_Value));

                begin

                    return IntImplAssignment.Any_Assignment(New_Var);
                end;

            when others => return IntImplAssignment.Any_Assignment (Null_Var);
        end case;

    end Generate_Int_Variable;

end Parser;