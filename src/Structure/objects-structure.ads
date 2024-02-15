with Objects;               use Objects;
with Objects.ObjectList;    use Objects.ObjectList;
with Objects.Statement;     use Objects.Statement;
with Types.Prefix;          use Types.Prefix;

package Objects.Structure is

    type StructureObject is tagged private;

    function Prefix     (SO : StructureObject) return PrefixStructure;
    function Stmt       (SO : StructureObject) return VarObject;
    function BodyStmt   (SO : StructureObject) return ObjectList.Vector;

    function New_Structure (StructPrefix   : PrefixStructure;
                            Statement      : VarObject;
                            BodyStatement  : ObjectList.Vector)
    return StructureObject;

private

    type StructureObject is new RootObject with record

        Prefix    : PrefixStructure;
        Stmt      : VarObject;
        BodyStmt  : ObjectList.Vector;

    end record;

end Objects.Structure;