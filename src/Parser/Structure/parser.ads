with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Objects.VarObject; use Objects.VarObject;
with Types.Prefix;      use Types.Prefix;

with Assignment;
with Assignment.Concrete;

package Parser is

    package IntImplAssignment is new Assignment (T => IntegerValue);
    package IntAssignment     is new IntImplAssignment.Concrete;


    type String_Array is array (Positive range <>) of Unbounded_String;

    type RowInformation (Length : Integer) is record

        Splited_Line : String_Array (1 .. Length);
        Prefix : PrefixStructure;
    end record;

    function Split_Line (Row : String) return String_Array;

    function Parse_Line (Row : String) return RowInformation;

    function Generate_Int_Variable (Current_Row : RowInformation)
    return IntImplAssignment.Any_Assignment;

end Parser;