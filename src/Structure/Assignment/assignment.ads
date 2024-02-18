with Objects.VarObject; use Objects.VarObject;
with Types.Prefix;      use Types.Prefix;

generic
    type T is private;

package Assignment is

    type AssignmentObject is interface;
    type Any_Assignment is access all AssignmentObject'Class;

    function Axiomatic_Type (AO : AssignmentObject) return NaturalType is abstract;
    function Left           (AO : AssignmentObject) return VariableObject'Class is abstract;
    function Right          (AO : AssignmentObject) return T is abstract;

end Assignment;