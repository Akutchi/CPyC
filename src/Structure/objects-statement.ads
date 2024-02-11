with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Objects;       use Objects;
with Operations;    use Operations;

package Objects.Statement is

    type VariableObject is tagged private;

    function VarName  (VO : VariableObject) return String;

    function New_Variable (VarName : String) return VariableObject;


    type ExpressionObject is tagged private;

    function Left   (AO : ExpressionObject'Class) return VarObject;
    function Right  (AO : ExpressionObject'Class) return VarObject;
    function Op     (AO : ExpressionObject'Class) return BinaryOp;

    function New_Expression (Left   : VarObject'Class;
                             Right  : VarObject'Class;
                             Op     : BinaryOp)
    return ExpressionObject;

private

    type VariableObject is new VarObject with record
        Name : Unbounded_String;

    end record;

    type ExpressionObject is new VarObject with record
        Left  : VarObject;
        Right : VarObject;
        Op    : BinaryOp;

    end record;

end Objects.Statement;