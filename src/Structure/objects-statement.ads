with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Objects;       use Objects;
with Operations;    use Operations;

package Objects.Statement is

    type VariableObject is tagged private;

    function New_Variable (VarName : String) return VariableObject;

    function VarName  (VO : VariableObject) return String;


    type ExpressionObject is tagged private;

    function New_Expression (Left   : VarObject;
                             Right  : VarObject;
                             Op     : BinaryOp)
    return ExpressionObject;

    function Left   (AO : ExpressionObject'Class) return VarObject;
    function Right  (AO : ExpressionObject'Class) return VarObject;
    function Op     (AO : ExpressionObject'Class) return BinaryOp;

private

    type VariableObject is new VarObject with record
        VarName : Unbounded_String;

    end record;

    type ExpressionObject is new VarObject with record
        Left  : VarObject;
        Right : VarObject;
        Op    : BinaryOp;

    end record;

end Objects.Statement;