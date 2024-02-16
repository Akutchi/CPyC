with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Types.Prefix;      use Types.Prefix;
with Objects.Statement; use Objects.Statement;

package Parser is

    type String_Array is array (Positive range <>) of Unbounded_String;

    type RowInformation (Length : Integer) is record

        Splited_Line : String_Array (1 .. Length);
        Prefix : PrefixStructure;
    end record;

    function Split_Line (Row : String) return String_Array;

    function Parse_Line (Row : String) return RowInformation;

    function Generate_Int_Variable (Current_Row : RowInformation)
    return IntAssignment'Class;

end Parser;