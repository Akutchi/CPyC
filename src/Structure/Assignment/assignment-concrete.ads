with Objects.VarObject; use Objects.VarObject;

generic
package Assignment.Concrete is

    type ConcreteAssignment is new AssignmentObject with private;
    type ConcreteAssignment_Access is access all ConcreteAssignment;

    overriding
    function Axiomatic_Type (CA : ConcreteAssignment) return NaturalType;
    overriding
    function Left           (CA : ConcreteAssignment) return VariableObject'Class;
    overriding
    function Right          (CA : ConcreteAssignment) return T;

    function New_Assignment (Axiom          : NaturalType;
                             Left_Member    : VariableObject;
                             Right_Member   : T)
    return ConcreteAssignment_Access;

private

    type ConcreteAssignment is new AssignmentObject with record
        Axiomatic_Type : NaturalType;
        Left           : VariableObject;
        Right          : T;

    end record;

end Assignment.Concrete;