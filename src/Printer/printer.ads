with Ada.Text_IO; use Ada.Text_IO;

with Objects.VarObject; use Objects.VarObject;
with Operations;        use Operations;
with Types.Prefix;      use Types.Prefix;

with Parser; use Parser;

with Assignment;
with Assignment.Concrete;

package Printer is

    function Decide_Inverse_Operator (Op : BinaryOp) return String;

    procedure Print (F : File_Type; Exp : IntImplAssignment.Any_Assignment);

    function Print (Exp : IntImplAssignment.Any_Expression) return String;
end Printer;