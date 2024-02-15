with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Objects.Statement; use Objects.Statement;

package body Objects.Statement is

    ------------------
    -- New_Variable --
    ------------------

    function New_Variable (VarName : String) return VariableObject
    is
        New_Var : VariableObject := (VarName => To_Unbounded_String (VarName));
    begin

        return New_Var;

    end New_Variable;

    -------------
    -- VarName --
    -------------

    function VarName  (VO : VariableObject) return String
    is
    begin
        return To_String (VO.VarName);
    end VarName;


    function Left   (AO : ExpressionObject'Class) return VarObject
    is
    begin
        return AO.Left;
    end Left;

    function Right   (AO : ExpressionObject'Class) return VarObject
    is
    begin
        return AO.Right;
    end Right;

    function Op  (AO : ExpressionObject'Class) return BinaryOp
    is
    begin
        return AO.Op;
    end Op;

    function New_Expression (LeftMember   : VarObject'Class;
                             RightMember  : VarObject'Class;
                             Operator     : BinaryOp)
    return ExpressionObject
    is
        New_Expr : ExpressionObject := (Left  => VarObject (LeftMember),
                                        Right => VarObject (RightMember),
                                        Op    => Operator);
    begin

        return  New_Expr;

    end New_Expression;

end Objects.Statement;