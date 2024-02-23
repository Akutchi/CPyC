with Ada.Strings;           use Ada.Strings;
with Ada.Text_IO;           use Ada.Text_IO;

with Operations;        use Operations;

with Parser.BooleanHelper;  use Parser.BooleanHelper;
with Parser.StringHelper;   use Parser.StringHelper;
with Parser.Expressions;    use Parser.Expressions;

package body Parser is

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
            Parse_Int_Expression
                (Remove_Semi_Colon (To_Unbounded_String (Row)));

        New_Assign : IntAssignment.Any_ConcreteAssignment :=
            IntAssignment.New_Assignment
                (Axiom => INT,
                 Left_Member => New_Variable (Var_Name => Var_Name),
                 Right_Member => Var_Expr);

    begin

        return IntImplAssignment.Any_Assignment (New_Assign);

    end Create_Int_Expression;

    ----------------
    -- Parse_Line --
    ----------------

    function Parse_Line (Row : String) return RowInformation
    is
        Splited_Line : String_Array := Split_Line (Row, " ");

        Is_Typped : Boolean :=
            New_GType
                (CHAR, New_GType
                        (INT, Splited_Line (Splited_Line'First))).Get_State;

        Current_Row : RowInformation := (Splited_Line'Last, Splited_Line,
                                        NULL_PREFIX);

    begin

        if Splited_Line'Length > 1 then

            if Is_Typped then

                if Has_Affectation (Splited_Line) then

                    Current_Row.Prefix := VAR_ASSIGNED_PREFIX;
                else

                    if Is_Not_Structure (Splited_Line) then

                        Current_Row.Prefix := VAR_DECLARATION_PREFIX;

                    else
                        Current_Row.Prefix := FUNCTION_PREFIX;

                    end if;
                end if;
            end if;

        elsif To_String (Splited_Line (Splited_Line'First)) = "}" then

            Current_Row.Prefix := CLOSE_BRACKET_PREFIX;

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

                else
                    return Create_Assigned_Variable
                        (Current_Row.Prefix, Splited_Row);
                end if;

            when others =>
                return IntImplAssignment.Any_Assignment (Null_Var);
        end case;

    end Generate_Int_Variable;

end Parser;