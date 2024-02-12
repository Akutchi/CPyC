with Objects;               use Objects;
with Objects.ObjectList;    use Objects.ObjectList;
with Objects.Statement;     use Objects.Statement;
with Types.Prefix;          use Types.Prefix;

package Objects.Structure is

    type StructureObject is tagged private;

    function Prefix     (SO : StructureObject) return PrefixNames;
    function Stmt       (SO : StructureObject) return VarObject;
    function BodyStmt   (SO : StructureObject) return ObjectList.Vector;

    function New_Structure (StructPrefix   : PrefixNames;
                            Statement      : VarObject;
                            BodyStatement  : ObjectList.Vector)
    return StructureObject;

private

    type StructureObject is new RootObject with record

        Prefix    : PrefixNames;
        Stmt      : VarObject;
        BodyStmt  : ObjectList.Vector;

    end record;

end Objects.Structure;