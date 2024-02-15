with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Objects;           use Objects;
with Objects.Statement; use Objects.Statement;
with Operations;        use Operations;
with Types.Prefix;      use Types.Prefix;
with Types.Naturals;    use Types.Naturals;

with FileHandler;       use FileHandler;

procedure main is

    -- to automatize
    Source_File : File_Type;
    Dest_File   : File_Type;

    Source_Name : constant String := "./project/source/main.c";
    Dest_Name   : constant String := "./project/dest/main.py";


begin

    Open_File (Dest_File, Dest_Name);
    Open (Source_File, In_File, Source_Name);

    while not End_Of_File (Source_File) loop

        Put_Line (Get_Line (Source_File));

    end loop;

    Close (Source_File);
    Close (Dest_File);



end main;