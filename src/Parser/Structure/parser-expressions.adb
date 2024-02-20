with Ada.Text_IO; use Ada.Text_IO;

package body Parser.Expressions is

    ---------------------
    -- Decide_Operator --
    ---------------------

    function Decide_Operator (Op_Str : Character) return BinaryOp
    is
    begin
        case Op_Str is

            when '+' => return PLUS_OP;
            when '-' => return MINUS_OP;
            when '*' => return MULT_OP;
            when '/' => return DIV_OP;
            when others => return NULL_OP;

        end case;

    end Decide_Operator;

    -----------------
    -- Get_SubExpr --
    -----------------

    function Get_SubExpr (Row : String) return SubExpression_Information
    is

        Expr : SubExpression_Information;
        Parenthesis_Number : Natural := 0;
        Index : Positive := 1;
    begin

        loop

            if Row (Index) = '(' then
                Parenthesis_Number := Parenthesis_Number + 1;
            elsif Row (Index) = ')' then
                Parenthesis_Number := Parenthesis_Number - 1;
                exit when Parenthesis_Number = 0;

            end if;

            Index := Index + 1;

        end loop;

        Expr.Str := To_Unbounded_String (Row (Row'First+1 .. Index-1));
        Expr.End_Pos := Index;

        return Expr;

    end Get_SubExpr;

    function Get_All_Before_Next_Op (SubRow : String)
    return SubExpression_Information
    is
        Expr : SubExpression_Information;
        I : Positive := 1;
    begin

        loop

            exit when I = SubRow'Length or
            Is_Expression (To_Unbounded_String (SubRow (I)'Image));
            I := I + 1;

        end loop;

        if I /= SubRow'Length then
            I := I - 1;
        end if;

        Expr.Str := To_Unbounded_String (SubRow (SubRow'First .. I));
        Expr.End_Pos := I;

        return Expr;

    end;
    ----------------------
    -- Parse_Expression --
    ----------------------

    function Parse_Int_Expression (SubRow : String)
    return IntImplAssignment.Any_Expression
    is

        Left_Expr  : SubExpression_Information;
        Remainder : Unbounded_String;
        End_Str : Integer := SubRow'Length;

        Op_Str : Character;

        Var_Expr : IntImplAssignment.Any_Expression;

    begin

        Put_Line (SubRow);

        if Is_Numeric (SubRow) then
            Var_Expr := new IntImplAssignment.Expression (VALUE_FORM);
            Var_Expr.ValueRep := New_IntegerValue (Value => Integer'Value (SubRow));
            return Var_Expr;

        elsif Is_Variable (SubRow) then
            Var_Expr := new IntImplAssignment.Expression (VARIABLE_FORM);
            Var_Expr.Var := New_Variable (Var_Name => SubRow);
            return Var_Expr;
        end if;

        Var_Expr := new IntImplAssignment.Expression (EXPRESSION_FORM);

        if SubRow (SubRow'First) = '(' then
            Left_Expr := Get_SubExpr (SubRow);

        else
            Left_Expr := Get_All_Before_Next_Op (SubRow);
        end if;

        Op_Str := SubRow (Left_Expr.End_Pos+1);
        Remainder := To_Unbounded_String (SubRow (Left_Expr.End_Pos+2 .. End_Str));

        Var_Expr.Op := Decide_Operator (Op_Str);
        Var_Expr.Left := Parse_Int_Expression (To_String (Left_Expr.Str));
        Var_Expr.Right := Parse_Int_Expression (To_String (Remainder));

        return Var_Expr;

    end Parse_Int_Expression;

end Parser.Expressions;