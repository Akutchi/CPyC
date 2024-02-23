with Ada.Text_IO; use Ada.Text_IO;

with Root;              use Root;
with Objects.VarObject; use Objects.VarObject;
with Operations;        use Operations;
with Types.Prefix;      use Types.Prefix;

with Parser; use Parser;

with Assignment;
with Assignment.Concrete;

package Printer is

    function Print (Exp : IntImplAssignment.Any_Expression) return String;

    procedure Print (F : File_Type; Exp : IntImplAssignment.Any_Assignment;
                     Level : Integer);

    procedure Print (F : File_Type; Object : ObjectList.Vector; Level : Integer);

    procedure Print (F : File_Type; Object : Any_Object; Level : Integer);

private

    function Decide_Inverse_Operator (Op : BinaryOp) return String;

    function Build_Function_Arg (Args : ObjectList.Vector) return String;

    function Get_Function_Def (Object : in Any_Object; Indent : String)
    return String;

end Printer;