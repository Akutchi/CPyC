with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.strings.Fixed;     use Ada.strings.Fixed;
with Ada.strings.Maps;      use Ada.strings.Maps;

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

    ------------------------
    -- Build_Function_Arg --
    ------------------------

    function Build_Function_Arg (Args : ObjectList.Vector) return String
    is
        Arg_Str : Unbounded_String;
        LAST_ARG : Integer := Args.Last_Index;
        Suffix : String (1 .. 2);
    begin

        if LAST_ARG = 0 then

            return "():";
        end if;

        Append (Arg_Str, "(");
        for I in 1 .. LAST_ARG loop

            declare
                Arg_I : String := Args (I).Exp.Var.Var_Name;
            begin

                if I /= LAST_ARG then
                    Suffix := ", ";
                else
                    Suffix := "):";
                end if;
                Append (Arg_Str, Arg_I & Suffix);
            end;

        end loop;

        return To_String (Arg_Str);

    end Build_Function_Arg;

    ----------------------
    -- Get_Function_Def --
    ----------------------

    function Get_Function_Def (Object : in Any_Object; Indent : String)
    return String
    is
        Function_Def : Unbounded_String;

        Name_Part : String := Indent & "def " & To_String (Object.Func_Name);
        Arg_Part  : String := Build_Function_Arg (Object.Args);
    begin

        Append (Function_Def, Name_Part & Arg_Part);

        return To_String (Function_Def);

    end Get_Function_Def;

    -----------
    -- Print --
    -----------

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

                    Left  : String := Trim (Print (Exp.Left), whitespace,
                                        whitespace);
                    Right : String := Trim (Print (Exp.Right), whitespace,
                                        whitespace);
                    Op    : String := Decide_Inverse_Operator (Exp.Op);

                begin

                    return "(" & Left & ")" & Op & "(" & Right & ")";
                end;
        end case;

    end Print;


    procedure Print (F : File_Type; Exp : IntImplAssignment.Any_Assignment;
                     Level : Integer)
    is

        INDENT : String := Level * " ";
        Right_Assign : String := Print (Exp.Right);

    begin

        Put_Line (F, INDENT & Exp.Left.Var_Name & " = " & Right_Assign);

    end Print;

    procedure Print (F : File_Type; Object : ObjectList.Vector; Level : Integer)
    is
    begin

        if Object.Last_Index /= 0 then

            for I in 1 .. Object.Last_Index loop

                Print (F, Object.Element (I), Level+1);
            end loop;

        end if;

    end Print;


    procedure Print (F : File_Type; Object : Any_Object; Level : Integer)
    is
        INDENT : String := Level * " ";
    begin

        case Object.Form is

            when ASSIGNMENT_PREFIX => Print (F, Object.Assign, Level);

            when FUNCTION_PREFIX =>

                declare
                    Function_Str : String := Get_Function_Def (Object, INDENT);
                begin

                    Put_Line (F, Function_Str);
                    Put_Line (F, " ");
                    Print (F, Object.Body_Stmt, Level+1);
                    Put_Line (F, " ");

                end;

            when others => raise ImplementationError with "structure printing";

        end case;

    end Print;

end Printer;