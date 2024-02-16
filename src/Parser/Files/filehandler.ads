with Ada.Text_IO;           use Ada.Text_IO;

package FileHandler is

    procedure Open_File (F : in out File_Type; Name : String; Mode : File_Mode);

end FileHandler;