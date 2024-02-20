with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Objects;                       use Objects;
with Objects.VarObject;             use Objects.VarObject;
with Operations;                    use Operations;
with Types.Prefix;                  use Types.Prefix;

with FileHandler;       use FileHandler;
with Parser;            use Parser;
with Printer;           use Printer;

with Assignment;
with Assignment.Concrete;

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
            Raw_Data : RowInformation := Parse_Line (Row);
            Representation : IntImplAssignment.Any_Assignment :=
                Generate_Int_Variable (Raw_Data);
        begin

            Print (Dest_Object, Representation);
        end;

    end loop;

    Close (Source_Object);
    Close (Dest_Object);



end main;