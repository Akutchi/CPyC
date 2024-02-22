with Ada.Strings.Fixed; use Ada.Strings.Fixed;

package Parser.StringHelper is

    function Split_Line (Row : String; Pattern : String) return String_Array;

    function Remove_Semi_Colon (Variable : Unbounded_String) return String;

    function Get_Expression_Array (Start : Integer; Splited_Row : String_Array)
    return String_Array;

    function Concatenate_Array (Sub_Splited_Row : String_Array) return String;

    function Get_Real_Row_Length (Row : String) return Integer;

end Parser.StringHelper;