with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Operations;        use Operations;
with Types.Prefix;      use Types.Prefix;
with Types.Naturals;    use Types.Naturals;

package Objects.Statement is

    type VariableObject is tagged private;

    function New_Variable (Var_Name : String) return VariableObject;

    function Var_Name  (VO : VariableObject) return String;


    type AssignmentObject is tagged private;

    type IntAssignment is tagged private;

    function New_IntAssignment (Axiom           : NaturalType;
                                Left_Member     : VariableObject;
                                Right_Member    : IntegerValue)
    return IntAssignment'Class;

    function Axiomatic_Type (IO : IntAssignment) return NaturalType;
    function Left           (IO : IntAssignment) return VariableObject'Class;
    function Right          (IO : IntAssignment) return IntegerValue'Class;

    --  type ExpressionObject is tagged private;

    --  function New_Expression (LeftMember   : VarObject'Class;
    --                           RightMember  : VarObject'Class;
    --                           Operator     : BinaryOp)
    --  return ExpressionObject;

    --  function Left   (EO : ExpressionObject'Class) return VarObject;
    --  function Right  (EO : ExpressionObject'Class) return VarObject;
    --  function Op     (EO : ExpressionObject'Class) return BinaryOp;

private

    type VariableObject is new VarObject with record
        Var_Name : Unbounded_String;

    end record;

    type AssignmentObject is new VarObject with null record;

    type IntAssignment is new AssignmentObject with record
        Axiomatic_Type  : NaturalType;
        Left            : VariableObject;
        Right           : IntegerValue;

    end record;

    --  type ExpressionObject is new VarObject with record
    --      Left  : VarObject;
    --      Right : VarObject;
    --      Op    : BinaryOp;

    --  end record;

end Objects.Statement;