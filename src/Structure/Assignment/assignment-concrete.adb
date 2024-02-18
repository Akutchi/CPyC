with Ada.Text_IO; use Ada.Text_IO;

package body Assignment.Concrete is

    function Axiomatic_Type (CA : ConcreteAssignment) return NaturalType
    is
    begin
        return CA.Axiomatic_Type;
    end Axiomatic_Type;

    function Left (CA : ConcreteAssignment) return VariableObject'Class
    is
    begin
        return CA.Left;
    end Left;

    function Right (CA : ConcreteAssignment) return T
    is
    begin
        return CA.Right;
    end Right;

    function New_Assignment (Axiom          : NaturalType;
                             Left_Member    : VariableObject;
                             Right_Member   : T)
    return ConcreteAssignment_Access
    is
        CA : ConcreteAssignment_Access := new ConcreteAssignment;
    begin

        CA.Axiomatic_Type := Axiom;
        CA.Left := Left_Member;
        CA.Right := Right_Member;

        return CA;
    end New_Assignment;

end Assignment.Concrete;