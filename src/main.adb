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

    LeftVar : VariableObject := New_Variable (VarName => "x");
    RightValue : IntegerValue := New_Integer (Value => 10);

    --  Stmt : ExpressionObject := New_Expression (
    --                              Left   => LeftVar,
    --                              Right  => RightValue,
    --                              Op     => ASSIGN
    --                          );

    --  V : ObjectList.Vector;

    --  obj : StructureObject := New_Structure (
    --                              Prefix     => IF_PREFIX,
    --                              Stmt       => Stmt,
    --                              Body_stmt  => V
    --                          );


begin

    -- V.Append (New_Variable (VarName => "y"));

    Put_Line ("This is the main program");
    Put_Line ("Var name is " & LeftVar.VarName);
    Put_Line ("Var value is " & Integer'Image (RightValue.Value));


end main;