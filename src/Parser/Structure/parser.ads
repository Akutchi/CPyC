with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Types.Prefix; use Types.Prefix;

package Parser is

    type String_Array is array (Positive range <>) of Unbounded_String;

    function Split_Line (Row : String) return String_Array;

    function Parse_Line (Row : String) return PrefixStructure;

end Parser;