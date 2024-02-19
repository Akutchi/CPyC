with Objects.VarObject; use Objects.VarObject;
with Operations;        use Operations;

generic
package Assignment.Concrete is

    type ConcreteAssignment is new AssignmentObject with private;
    type Any_ConcreteAssignment is access all ConcreteAssignment;

    overriding
    function Axiomatic_Type (CA : ConcreteAssignment) return NaturalType;
    overriding
    function Left           (CA : ConcreteAssignment) return VariableObject'Class;
    overriding
    function Right          (CA : ConcreteAssignment) return Any_Expression;

    function New_Assignment (Axiom          : NaturalType;
                             Left_Member    : VariableObject;
                             Right_Member   : Any_Expression)
    return Any_ConcreteAssignment;

private

    type ConcreteAssignment is new AssignmentObject with record
        Axiomatic_Type : NaturalType;
        Left           : VariableObject;
        Right          : Any_Expression;

    end record;

end Assignment.Concrete;