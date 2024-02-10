with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with objects; use objects;
with Types.Prefix; use Types.Prefix;

package body objects is

    function New_Structure (Prefix : PrefixNames; Stmt : VarObject'Class;
                            Body_Stmt : RootObject'Class)
    return StructureObject'Class is

        New_Object : StructureObject;

    begin

        New_Object.Prefix := Prefix;
        New_Object.Statement := Stmt;
        New_Object.Body_Stmt := Body_Stmt;

        return New_Object;

    end New_Structure;

    function New_Variable (Name : String) return VariableObject'Class
    is

        New_Var : VariableObject;

    begin

        New_Var.Name := To_Unbounded_String (Name);

        return New_Var;

    end New_Variable;

    function New_Assignment (Left   : VariableObject'Class;
                             Right  : VarObject'Class;
                             Op     : BinaryOp)
    return AssignmentObject'Class
    is

        New_Object : AssignmentObject;

    begin

        New_Object.Left := Left;
        New_Object.Right := Right;
        New_Object.Op := Op;

        return New_Object;

    end New_Assignment;

    function New_VarDecorator (Left  : AssignmentObject'Class;
                               Right : VarObject'Class)
    return VarDecoratorObject'Class
    is

        New_Object : VarDecoratorObject;

    begin

        New_Object.Left := Left;
        New_Object.Right := Right;

        return New_Object;

    end New_VarDecorator;


end objects;