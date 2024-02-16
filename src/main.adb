with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Tags; use Ada.Tags;

with Objects;           use Objects;
with Objects.Statement; use Objects.Statement;
with Operations;        use Operations;
with Types.Prefix;      use Types.Prefix;
with Types.Naturals;    use Types.Naturals;

with FileHandler;       use FileHandler;
with Parser;            use Parser;

procedure main is

    Source_File : String := "./project/source/main.c";
    Dest_File   : String := "./project/dest/main.py";

    Source_Object : File_Type;
    Dest_Object   : File_Type;
begin

    Open_File (Source_Object, Source_File, In_File);
    Open_File (Dest_Object, Dest_File, Out_File);

    while not End_Of_File (Source_Object) loop

        declare
            Row : constant String := Get_Line (Source_Object);
            Stmt : VariableObject := Parse_Variable (Row);

            Var : IntAssignment'Class :=
                        New_IntAssignment
                            (Axiom        => INT,
                            Left_Member   => New_Variable (Var_Name => Stmt.Var_Name),
                            Right_Member  => New_IntegerValue (Value => 0));
        begin

            Put_Line (Dest_Object, Var.Left.Var_Name & " =" & Integer'Image(Var.Right.Value));


        end;

    end loop;

    Close (Source_Object);
    Close (Dest_Object);



end main;