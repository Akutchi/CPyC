with Ada.Strings;           use Ada.Strings;
with Ada.Strings.Fixed;     use Ada.Strings.Fixed;
with Ada.Strings.Maps;      use Ada.Strings.Maps;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO;           use Ada.Text_IO;

with Objects.VarObject; use Objects.VarObject;
with Types.Prefix;      use Types.Prefix;
with Operations;        use Operations;

with Parser.BooleanHelper;  use Parser.BooleanHelper;
with Parser.StringHelper;   use Parser.StringHelper;
with Parser.Expressions;    use Parser.Expressions;

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

    ---------------------
    -- Create_Variable --
    ---------------------

    function Create_Variable (Splited_Row : String_Array)
    return IntImplAssignment.Any_Assignment
    is

        Currated_Var : String := Remove_Semi_Colon
                                    (Splited_Row (2));

        Var_Expr : IntImplAssignment.Any_Expression :=
            new IntImplAssignment.Expression (VALUE_FORM);

        New_Var : IntAssignment.Any_ConcreteAssignment :=
                    IntAssignment.New_Assignment
                        (Axiom          => INT,
                            Left_Member    => New_Variable
                                            (Var_Name =>
                                                Currated_Var),
                            Right_Member   => Var_Expr);

    begin
        Var_Expr.ValueRep := New_IntegerValue (Value => 0);
        return IntImplAssignment.Any_Assignment(New_Var);

    end;

    ------------------------------
    -- Create_Assigned_Variable --
    ------------------------------

    function Create_Assigned_Variable
    (Current_Case : StructurePrefix; Splited_Row : String_Array)
    return IntImplAssignment.Any_Assignment
    is

    Name_Position : Integer :=
        (if Current_Case = VAR_ASSIGNED_PREFIX then 2 else 1);

    Name : String  := To_String (Splited_Row (Name_Position));

    Var_Value : Integer :=
        Integer'Value (Remove_Semi_Colon (Splited_Row (Splited_Row'Last)));

    Var_Expr : IntImplAssignment.Any_Expression :=
            new IntImplAssignment.Expression (VALUE_FORM);

    New_Var : IntAssignment.Any_ConcreteAssignment :=
        IntAssignment.New_Assignment (Axiom => INT,
                                      Left_Member => New_Variable
                                        (Var_Name => Name),
                                      Right_Member   => Var_Expr);

    begin
        Var_Expr.ValueRep := New_IntegerValue (Value => Var_Value);
        return IntImplAssignment.Any_Assignment(New_Var);

    end;

    ---------------------------
    -- Create_Int_Expression --
    ---------------------------

    function Create_Int_Expression (Var_Name : String; Row : String)
    return IntImplAssignment.Any_Assignment
    is
        Var_Expr : IntImplAssignment.Any_Expression :=
            new IntImplAssignment.Expression (EXPRESSION_FORM);

        New_Assign : IntAssignment.Any_ConcreteAssignment :=
            IntAssignment.New_Assignment
                (Axiom => INT,
                 Left_Member => New_Variable (Var_Name => Var_Name),
                 Right_Member => Var_Expr);

    begin
        Var_Expr :=
            Parse_Int_Expression
                (Remove_Semi_Colon (To_Unbounded_String (Row)));

        return IntImplAssignment.Any_Assignment (New_Assign);

    end Create_Int_Expression;

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

        case Current_Row.Prefix is

            when VAR_DECLARATION_PREFIX =>
                return Create_Variable (Splited_Row);

            when VAR_ASSIGNED_PREFIX | VAR_USAGE_PREFIX =>

                if Is_Expression (Splited_Row) then

                    declare

                        Var_Name : constant String := To_String (Splited_Row (2));
                        Equal_Position : Integer :=
                            (if Current_Row.Prefix = VAR_ASSIGNED_PREFIX then 3
                             else 2);

                        Expr_Array: String_Array :=
                            Get_Expression_Array (Equal_Position, Splited_Row);

                        SubRow : constant String :=
                            Concatenate_Array (Expr_Array);

                    begin

                        return Create_Int_Expression (Var_Name, SubRow);
                    end;
                end if;

                return Create_Assigned_Variable (Current_Row.Prefix, Splited_Row);

            when others =>
                return IntImplAssignment.Any_Assignment (Null_Var);
        end case;

    end Generate_Int_Variable;

end Parser;