with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Objects.Statement; use Objects.Statement;

package body Objects.Statement is

    function VarName  (VO : VariableObject) return String
    is
    begin
        return To_String (VO.VarName);
    end VarName;

    function New_Variable (VarName : String) return VariableObject
    is
        New_Var : VariableObject := (VarName => To_Unbounded_String (VarName));
    begin

        return New_Var;

    end New_Variable;

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

    function New_Expression (Left   : VarObject;
                             Right  : VarObject;
                             Op     : BinaryOp)
    return ExpressionObject
    is
        New_Expr : ExpressionObject := (Left  => Left,
                                        Right => Right,
                                        Op    => Op);
    begin

        return  New_Expr;

    end New_Expression;

end Objects.Statement;