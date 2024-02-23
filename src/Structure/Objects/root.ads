with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Strings;           use Ada.Strings;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Fixed;     use Ada.Strings.Fixed;
with Ada.Strings.Maps;      use Ada.Strings.Maps;

with Objects.VarObject; use Objects.VarObject;
with Types.Prefix;      use Types.Prefix;

with Parser; use Parser;
with Parser.StringHelper; use Parser.StringHelper;

with Exceptions; use Exceptions;

with Ada.Containers.Indefinite_Vectors;
with Assignment;
with Assignment.Concrete;

package Root is

    type RootObject;
    type Any_Object is access all RootObject;

    package ObjectList is new Ada.Containers.Indefinite_Vectors (

    Index_Type   => Positive,
    Element_Type => Any_Object
    );
    use ObjectList;

    type RootObject (Form : StructurePrefix) is record

        Body_Stmt   : ObjectList.Vector;

        case Form is

            when EXPRESSION_PREFIX =>
                Exp : IntImplAssignment.Any_Expression;

            when ASSIGNMENT_PREFIX =>
                Assign : IntImplAssignment.Any_Assignment;

             when FUNCTION_PREFIX =>
                Axiomatic_Type  : NaturalType;
                Func_Name       : Unbounded_String;
                Args            : ObjectList.Vector;
                Has_Return      : Boolean := False;
                Return_Stmt     : Any_Object;

            when IF_PREFIX | ELIF_PREFIX | FOR_PREFIX =>
                Stmt : Any_Object;

            when others => null;

        end case;
    end record;

    function Decide_On_Parsing (Source_Object : File_Type) return Any_Object;

private

    function Decide_Type (Type_Str : Unbounded_String) return NaturalType;

    function Generate_Function  (Source : in File_Type;
                                 Raw_Data : RowInformation)
    return Any_Object;

    function Get_Function_Name (Raw_Data : RowInformation)
    return Unbounded_String;

    function Get_Arguments (F_Str : String)
    return ObjectList.Vector;

    function Get_Body (Source : in File_Type) return ObjectList.Vector;

end Root;