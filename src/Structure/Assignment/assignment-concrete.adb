with Ada.Text_IO; use Ada.Text_IO;

package body Assignment.Concrete is

    --------------------
    -- Axiomatic_Type --
    --------------------

    function Axiomatic_Type (CA : ConcreteAssignment) return NaturalType
    is
    begin
        return CA.Axiomatic_Type;
    end Axiomatic_Type;

    ----------
    -- Left --
    ----------

    function Left (CA : ConcreteAssignment) return VariableObject'Class
    is
    begin
        return CA.Left;
    end Left;

    -----------
    -- Right --
    -----------

    function Right (CA : ConcreteAssignment) return Any_Expression
    is
    begin
        return CA.Right;
    end Right;

    --------------------
    -- New_Assignment --
    --------------------

    function New_Assignment (Axiom          : NaturalType;
                             Left_Member    : VariableObject;
                             Right_Member   : Any_Expression)
    return Any_ConcreteAssignment
    is
        CA : Any_ConcreteAssignment := new ConcreteAssignment;
    begin

        CA.Axiomatic_Type := Axiom;
        CA.Left := Left_Member;
        CA.Right := Right_Member;

        return CA;
    end New_Assignment;

end Assignment.Concrete;