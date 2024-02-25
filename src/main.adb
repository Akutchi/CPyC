with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Root;              use Root;
with Types.Prefix;      use Types.Prefix;

with FileHandler;       use FileHandler;
with Printer;           use Printer;

procedure main is

    Source_File : String := "./project/source/main.c";
    Dest_File   : String := "./project/dest/main.py";

    Source_Object : File_Type;
    Dest_Object   : File_Type;

    MAIN_INDENT : Natural := 0;
    Main_Level : ObjectList.Vector;

    Prepare_To_Print_Main : Boolean := False;

begin

    Open_File (Source_Object, Source_File, In_File);
    Open_File (Dest_Object, Dest_File, Out_File);

    while not End_Of_File (Source_Object) loop

        declare

            Root_Object : Any_Object := Decide_On_Parsing (Source_Object);

        begin

            if Root_Object.Form /= NULL_PREFIX then
                Main_Level.Append (Root_Object);
            end if;
        end;
    end loop;

    for I in 1 .. Main_Level.Last_Index loop

        declare

            Element : Any_Object := Main_Level.Element (I);

        begin

            if Element.Form = FUNCTION_PREFIX and Element.Func_Name = "main" then
                Prepare_To_Print_Main := True;
            end if;

            Print (Dest_Object, Element, MAIN_INDENT);
        end;
    end loop;

    if Prepare_To_Print_Main then
        Put_Line (Dest_Object, " ");
        Put_Line (Dest_Object, "main()");
    end if;

    Close (Source_Object);
    Close (Dest_Object);

end main;