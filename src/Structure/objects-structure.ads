with Objects;           use Objects;
with Objects.Statement; use Objects.Statement;
with Types.Prefix;      use Types.Prefix;

package Objects.Structure is

    type StructureObject is tagged private;

    function Prefix     (SO : StructureObject) return PrefixNames;
    function Statement  (SO : StructureObject) return VarObject;
    function BodyStmt   (SO : StructureObject) return ObjectList;

    function New_Structure (Prefix    : PrefixNames;
                            Stmt      : VarObject'Class;
                            Body_Stmt : ObjectList)
    return StructureObject;

private

    type StructureObject is new RootObject with record

        Prefix    : PrefixNames;
        Statement : VarObject;
        BodyStmt  : RootObject;

    end record;

end Objects.Structure;