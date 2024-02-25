with Objects.VarObject; use Objects.VarObject;
with Types.Prefix;      use Types.Prefix;
with Operations;        use Operations;

generic
    type T is private;

package Assignment is

    type AssignmentObject is interface;
    type Any_Assignment is access all AssignmentObject'Class;

    type Expression;
    type Any_Expression is access Expression;

    type Expression (Form : ExpressionPrefix) is record

        case Form is
            when VARIABLE_FORM   => Var : VariableObject := New_Variable
                                                            (Var_Name => "");
            when VALUE_FORM      => ValueRep : T;
            when EXPRESSION_FORM =>
                Left    : Any_Expression;
                Right   : Any_Expression;
                Op      : BinaryOp;

            when others => null;
        end case;

    end record;

    function Axiomatic_Type (AO : AssignmentObject) return NaturalType
    is abstract;
    function Left           (AO : AssignmentObject) return VariableObject'Class
    is abstract;
    function Right          (AO : AssignmentObject) return Any_Expression
    is abstract;

end Assignment;