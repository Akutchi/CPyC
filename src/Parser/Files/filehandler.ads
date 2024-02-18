with Ada.Text_IO;           use Ada.Text_IO;

package FileHandler is

    -- A wrapper to avoid having to check wether the file exist or not
    procedure Open_File (F : in out File_Type; Name : String; Mode : File_Mode);

end FileHandler;