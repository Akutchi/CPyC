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

    function Is_Not_Structure (Split_Row : String_Array)
    return Boolean
    is
    begin

        declare
            Last_EI  : Integer   := Split_Row'Last;
            Last_EL  : Integer   := Length (Split_Row (Last_EI));
            Last_EC  : Character := To_String (Split_Row (Last_EI)) (Last_EL-1);
        begin
            return Last_EC /= '{';
        end;

    exception
        when Constraint_Error => return false;
    end;

    ---------------------
    -- Has_Affectation --
    ---------------------

    function Has_Affectation (Split_Row : String_Array) return Boolean
    is
    begin

        declare
            Second_Position : constant Character := To_String
                                                        (Split_Row (2)) (1);
            Third_Position  : constant Character := To_String
                                                        (Split_Row (3)) (1);
        begin
            return Third_Position = '=' or Second_Position = '=';
        end;

        exception
            when Constraint_Error => return false;

    end Has_Affectation;

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

        if Is_Typped then

            if Has_Affectation (Splited_Line)
            and Is_Not_Structure (Splited_Line) then

                Current_Row.Prefix := VAR_ASSIGNED_PREFIX;
            else

                Current_Row.Prefix := VAR_DECLARATION_PREFIX;
            end if;

        else
                Current_Row.Prefix := VAR_USAGE_PREFIX;
        end if;

        return Current_Row;

    end Parse_Line;

    -----------------------
    -- Remove_Semi_Colon --
    -----------------------

    function Remove_Semi_Colon (Variable : Unbounded_String) return String
    is
        L : Integer := Length (Variable);
    begin

        return To_String (Variable) (1 .. L-1);
    end Remove_Semi_Colon;

    ---------------------------
    -- Generate_Int_Variable --
    ---------------------------

    function Generate_Int_Variable (Current_Row : RowInformation)
    return IntImplAssignment.Any_Assignment
    is

        Splited_Row : String_Array := Current_Row.Splited_Line;

        Var_Expr : IntImplAssignment.Any_Expression :=
            new IntImplAssignment.Expression (VALUE_FORM);

        Null_Var : IntAssignment.Any_ConcreteAssignment :=
                    IntAssignment.New_Assignment
                        (Axiom          => INT,
                         Left_Member    => New_Variable (Var_Name => ""),
                         Right_Member   => Var_Expr);
    begin

        Var_Expr.ValueRep := New_IntegerValue (Value => 0);
        case Current_Row.Prefix is

            when VAR_DECLARATION_PREFIX =>

                declare
                    Currated_Var : String := Remove_Semi_Colon
                                                (Splited_Row (2));

                    New_Var : IntAssignment.Any_ConcreteAssignment :=
                                IntAssignment.New_Assignment
                                    (Axiom          => INT,
                                     Left_Member    => New_Variable
                                                        (Var_Name =>
                                                            Currated_Var),
                                     Right_Member   => Var_Expr);
                begin

                    return IntImplAssignment.Any_Assignment(New_Var);
                end;

            when VAR_ASSIGNED_PREFIX | VAR_USAGE_PREFIX =>

                declare
                    Name_Position : Integer := (if Current_Row.Prefix =
                                                VAR_ASSIGNED_PREFIX then 2
                                                else 1);

                    Name      : String  := To_String (Splited_Row
                                                        (Name_Position));
                    Var_Value : Integer := Integer'Value
                                                (Remove_Semi_Colon
                                                    (Splited_Row
                                                        (Splited_Row'Last)));

                    New_Var : IntAssignment.Any_ConcreteAssignment :=
                            IntAssignment.New_Assignment
                                (Axiom          => INT,
                                    Left_Member    => New_Variable
                                                        (Var_Name => Name),
                                    Right_Member   => Var_Expr);

                begin

                    Var_Expr.ValueRep := New_IntegerValue (Value => Var_Value);

                    return IntImplAssignment.Any_Assignment(New_Var);
                end;

            when others => return IntImplAssignment.Any_Assignment (Null_Var);
        end case;

    end Generate_Int_Variable;

end Parser;