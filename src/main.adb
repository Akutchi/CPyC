with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with objects; use objects;
with operations; use operations;
with Types.Prefix; use Types.Prefix;
with Types.Naturals; use Types.Naturals;

procedure main is

    obj : StructureObject'Class := New_Structure
                                    (Prefix => IF_PREFIX,
                                     Stmt => New_Assignment
                                                (Left => New_Variable (Name => "x"),
                                                Right => New_Integer (Value => 10),
                                                Op    => ASSIGN),

                                     Body_stmt => New_Variable (Name => "y"));
begin

    Put_Line ("This is the main program");

end main;