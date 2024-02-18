with Ada.Text_IO;       use Ada.Text_IO;
with Ada.Exceptions;    use Ada.Exceptions;

package body FileHandler is

    ---------------
    -- Open_File --
    ---------------

    procedure Open_File (F : in out File_Type; Name : String; Mode : File_Mode)
    is
    begin

        begin

            Open (F, Mode, Name);

        exception
            when E : Name_Error =>
                Create (F, Out_File, Name);
        end;

    end Open_File;

end FileHandler;