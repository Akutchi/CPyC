with Types.Prefix; use Types.Prefix;
with Objects.Statement; use Objects.Statement;

package body Objects.Structure is

    function New_Structure (Prefix   : PrefixNames;
                            Stmt     : VarObject'Class;
                            BodyStmt : ObjectList)
    return StructureObject
    is
    begin

        return StructureObject (Prefix => Prefix,
                                Statement => Stmt,
                                BodyStmt => BodyStmt);

    end New_Structure;

end Objects.Structure;