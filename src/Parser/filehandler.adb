with Ada.Text_IO;       use Ada.Text_IO;
with Ada.Exceptions;    use Ada.Exceptions;

package body FileHandler is

    procedure Open_File (F : in out File_Type; File_Name : String)
    is
    begin

        begin

            Open (F, In_File, File_Name);

        exception
            when E : Name_Error =>
                Create (F, Out_File, File_Name);
        end;

    end Open_File;

end FileHandler;