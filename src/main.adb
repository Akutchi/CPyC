with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

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

    Open_File (Source_Object, Source_File);
    Open_File (Dest_Object, Dest_File);

    while not End_Of_File (Source_Object) loop

        declare
            Row : constant String := Get_Line (Source_Object);
            Stmt_Type : PrefixStructure := Parse_Line (Row);

        begin
            Put_Line (Row & " is " &
                (if Stmt_Type = VAR_PREFIX then "Var" else "Other"));
        end;

    end loop;

    Close (Source_Object);
    Close (Dest_Object);



end main;