with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Objects;           use Objects;
with Objects.Structure; use Objects.Structure;
with Objects.Statement; use Objects.Statement;
with Operations;        use Operations;
with Types.Prefix;      use Types.Prefix;
with Types.Naturals;    use Types.Naturals;

procedure main is

    var : ObjectList := (New_Variable (VarName => "y"));

    obj : StructureObject'Class := New_Structure
                                    (Prefix => IF_PREFIX,
                                     Stmt => New_Expression
                                                (Left  => New_Variable (VarName => "x"),
                                                 Right => New_Integer (Value => 10),
                                                 Op    => ASSIGN),

                                     Body_stmt => var);
begin

    Put_Line ("This is the main program");

end main;