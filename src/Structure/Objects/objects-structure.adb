with Types.Prefix; use Types.Prefix;
with Objects.Statement; use Objects.Statement;

package body Objects.Structure is

    function Prefix     (SO : StructureObject) return PrefixStructure
    is
    begin
        return SO.Prefix;
    end Prefix;

    function Stmt  (SO : StructureObject) return VarObject
    is
    begin
        return SO.Stmt;
    end Stmt;

    function BodyStmt   (SO : StructureObject) return ObjectList.Vector
    is
    begin
        return SO.BodyStmt;
    end BodyStmt;

    function New_Structure (StructPrefix  : PrefixStructure;
                            Statement     : VarObject;
                            BodyStatement : ObjectList.Vector)
    return StructureObject
    is
        New_Object : StructureObject := (Prefix      => StructPrefix,
                                         Stmt        => Statement,
                                         BodyStmt    => BodyStatement);
    begin

        return New_Object;

    end New_Structure;

end Objects.Structure;