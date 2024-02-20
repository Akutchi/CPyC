with Ada.Strings.Fixed; use Ada.Strings.Fixed;

package Parser.StringHelper is

    function Remove_Semi_Colon (Variable : Unbounded_String) return String;

    function Get_Expression_Array (Start : Integer; Splited_Row : String_Array)
    return String_Array;

    function Concatenate_Array (Sub_Splited_Row : String_Array) return String;

end Parser.StringHelper;