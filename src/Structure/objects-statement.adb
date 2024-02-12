with Objects.Statement; use Objects.Statement;

package body Objects.Statement is

    function New_Variable (VarName : String) return VariableObject
    is
    begin

        return VariableObject (VarName => VarName);

    end New_Variable;

    function New_Expression (Left   : VarObject'Class;
                             Right  : VarObject'Class;
                             Op     : BinaryOp)
    return ExpressionObject
    is
    begin

        return  ExpressionObject (Left  => Left,
                                  Right => Right,
                                  Op    => Op);

    end New_Expression;

end Objects.Statement;