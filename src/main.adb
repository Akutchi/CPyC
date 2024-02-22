with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Root;              use Root;

with FileHandler;       use FileHandler;
with Printer;           use Printer;

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

            Root_Object : Any_Object := Decide_On_Parsing (Source_Object);

        begin
            Print (Dest_Object, Root_Object);
        end;
    end loop;

    Close (Source_Object);
    Close (Dest_Object);

end main;