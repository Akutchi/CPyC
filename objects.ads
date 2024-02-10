with operations; use operations;

package objects is

    type Object is tagged null record;

    type VarObject is new Object with record
    end record;

    type AssignmentObject is new VarObject with record
        Left  : String;
        Right : VarObject;
        Op    : operations;

    end record;

    type VarObjectDecorator is new VarObject with record
        Left    : AssignmentObject;
        Right   : VarObject;

    end record;

    type StructureObject is new Object with record
        prefix      : String;
        statement   : String;
        body_stmt   : Object;

    end record;

    type ConditionObject is new StructureObject with null record;

    type LoopObject is new StructureObject with null record;


end objects;