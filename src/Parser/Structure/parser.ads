with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Objects.VarObject; use Objects.VarObject;
with Types.Prefix;      use Types.Prefix;
with Types.Constructed; use Types.Constructed;

with Assignment;
with Assignment.Concrete;

package Parser is

    package IntImplAssignment is new Assignment (T => IntegerValue);
    package IntAssignment     is new IntImplAssignment.Concrete;

    function Parse_Line (Row : String) return RowInformation;

    function Generate_Int_Variable (Current_Row : RowInformation)
    return IntImplAssignment.Any_Assignment;

private

    function Create_Assigned_Variable
    (Current_Case : StructurePrefix; Splited_Row : String_Array)
    return IntImplAssignment.Any_Assignment;

    function Create_Variable (Splited_Row : String_Array)
    return IntImplAssignment.Any_Assignment;

    function Create_Int_Expression (Var_Name : String; Row : String)
    return IntImplAssignment.Any_Assignment;

end Parser;