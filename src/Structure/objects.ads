with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with operations; use operations;
with Types.Prefix; use Types.Prefix;

package objects is

    type RootObject is tagged null record;

    type VarObject is new RootObject with null record;

    type StructureObject is new RootObject with record

        Prefix : PrefixNames;
        Statement : VarObject;
        Body_stmt : RootObject;

    end record;

    type VariableObject is new VarObject with record
        Name : Unbounded_String;

    end record;

    type AssignmentObject is new VarObject with record
        Left  : VariableObject;
        Right : VarObject;
        Op    : BinaryOp;

    end record;

    type VarDecoratorObject is new VarObject with record
        Left    : AssignmentObject;
        Right   : VarObject;

    end record;

    function New_Structure (Prefix : PrefixNames; Stmt : VarObject'Class;
                            Body_Stmt : RootObject'Class)
    return StructureObject'Class;

    function New_Variable (Name : String) return VariableObject'Class;

    function New_Assignment (Left   : VariableObject'Class;
                             Right  : VarObject'Class;
                             Op     : BinaryOp)
    return AssignmentObject'Class;

    function New_VarDecorator (Left  : AssignmentObject'Class;
                               Right : VarObject'Class)
    return VarDecoratorObject'Class;

end objects;