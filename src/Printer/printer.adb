with Ada.strings.Fixed; use Ada.strings.Fixed;
with Ada.strings.Maps; use Ada.strings.Maps;

with Exceptions; use Exceptions;

package body Printer is

    -----------------------------
    -- Decide_Inverse_Operator --
    -----------------------------

    function Decide_Inverse_Operator (Op : BinaryOp) return String
    is
    begin
        case Op is

            when PLUS_OP    => return "+";
            when MINUS_OP   => return "-";
            when MULT_OP    => return "*";
            when DIV_OP     => return "/";
            when others     => return "&";

        end case;

    end Decide_Inverse_Operator;

    -----------
    -- Print --
    -----------

    procedure Print (F : File_Type; Exp : IntImplAssignment.Any_Assignment)
    is

        Right_Assign : String := Print (Exp.Right);

    begin

        Put_Line (F, Exp.Left.Var_Name & " = " & Right_Assign);

    end Print;

    function Print (Exp : IntImplAssignment.Any_Expression)
    return String
    is
        whitespace : Character_Set := To_Set (' ');
    begin

        case Exp.Form is

            when VARIABLE_FORM => return Exp.Var.Var_Name;

            when VALUE_FORM    => return Integer'Image(Exp.ValueRep.Value);

            when others =>

                declare

                    Left  : String := Trim (Print (Exp.Left), whitespace, whitespace);
                    Right : String := Trim (Print (Exp.Right), whitespace, whitespace);
                    Op    : String := Decide_Inverse_Operator (Exp.Op);

                begin

                    return "(" & Left & ")" & Op & "(" & Right & ")";
                end;
        end case;

    end Print;

    procedure Print (F : File_Type; Object : Any_Object)
    is
    begin

        case Object.Form is

            when ASSIGNMENT_PREFIX => Print (F, Object.Assign);

            when others => raise ImplementationError with "structure printing";

        end case;

    end Print;

end Printer;