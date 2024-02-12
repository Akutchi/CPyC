with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Objects;           use Objects;
with Objects.ObjectList;use Objects.ObjectList;
with Objects.Structure; use Objects.Structure;
with Objects.Statement; use Objects.Statement;
with Operations;        use Operations;
with Types.Prefix;      use Types.Prefix;
with Types.Naturals;    use Types.Naturals;

procedure main is

    V : ObjectList.Vector;
    obj : StructureObject;

begin

    V.Append (New_Variable (VarName => "y"));

    obj := New_Structure (Prefix     => IF_PREFIX,
                          Stmt       => New_Expression
                                            (Left   => VarObject (New_Variable
                                                            (VarName => "x")),
                                             Right  => VarObject (New_Integer
                                                            (Value => 10)),
                                             Op     => ASSIGN),

                          Body_stmt  => V);

    Put_Line ("This is the main program");

end main;