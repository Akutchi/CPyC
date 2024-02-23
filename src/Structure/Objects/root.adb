package body Root is

    -----------------
    -- Decide_Type --
    -----------------

    function Decide_Type (Type_Str : Unbounded_String) return NaturalType
    is
        Type_Str_Fixed : constant String := To_String (Type_Str);
    begin

        if (Type_Str_Fixed = "int") then
            return INT;
        else
            Put_Line ("Beware : Others function types were not implemented and return VOID");
            return VOID;
        end if;

    end Decide_Type;

    -----------------------
    -- Get_Function_Name --
    -----------------------

    function Get_Function_Name (Raw_Data : RowInformation)
    return Unbounded_String
    is
        Name_Part : constant String := To_String (Raw_Data.Splited_Line (2));
        Name : Unbounded_String;
        I : Positive := 1;
    begin

        loop
            exit when Name_Part (I) = '(';
            Append (Name, Name_Part (I));
            I := I + 1;

        end loop;

        return Name;

    end Get_Function_Name;

    -------------------
    -- Get_Arguments --
    -------------------

    function Get_Arguments (F_Str : String)
    return ObjectList.Vector
    is
        Has_Entered_Args : Boolean := False;

        Arg_Str : Unbounded_String;

        Args : ObjectList.Vector;
        I : Positive := 1;
    begin

        loop

            exit when F_Str (I) = ')';

            if Has_Entered_Args then
                Append (Arg_Str, F_Str (I));

            elsif F_Str (I) = '(' then
                Has_Entered_Args := True;
            end if;

            I := I + 1;

        end loop;

        declare

            Arg_Split : String_Array := Split_Line (To_String (Arg_Str), ",");

        begin
            for I in Arg_Split'Range loop

                declare
                    Arg_Single_List : String_Array := Split_Line (To_String (Arg_Split (I)), " ");
                    Arg_Name : String := To_String (Arg_Single_List (2));
                    Exp : IntImplAssignment.Any_Expression :=
                        new IntImplAssignment.Expression (VARIABLE_FORM);
                    Obj : Any_Object := new RootObject (EXPRESSION_PREFIX);

                begin
                    Exp.Var := New_Variable (Var_Name => Arg_Name);
                    Obj.Exp := Exp;
                    Args.Append (Obj);
                end;

            end loop;
        end;

        return Args;

    end Get_Arguments;

    --------------
    -- Get_Body --
    --------------

    function Get_Body (Source : in File_Type) return ObjectList.Vector
    is

        New_Inner_Structure : Any_Object;
        Funct_Body : ObjectList.Vector;
    begin

        loop

            New_Inner_Structure := Decide_On_Parsing (Source);
            exit when New_Inner_Structure.Form = CLOSE_BRACKET_PREFIX;

            if New_Inner_Structure.Form /= NULL_PREFIX then

                Funct_Body.Append (New_Inner_Structure);
            end if;

        end loop;


        return Funct_Body;

    end Get_Body;

    -----------------------
    -- Generate_Function --
    -----------------------

    function Generate_Function  (Source : in File_Type;
                                 Raw_Data : RowInformation) return Any_Object
    is
        New_Function : Any_Object := new RootObject (FUNCTION_PREFIX);
        Row : String := Concatenate_Array (Raw_Data.Splited_Line);
    begin

        New_Function.Axiomatic_Type := Decide_Type (Raw_Data.Splited_Line (1));
        New_Function.Func_Name := Get_Function_Name (Raw_Data);
        New_Function.Args := Get_Arguments (Row);
        New_Function.Body_Stmt := Get_Body (Source);

        return New_Function;

    end Generate_Function;

    -----------------------
    -- Decide_On_Parsing --
    -----------------------

    function Decide_On_Parsing (Source_Object : File_Type)
    return Any_Object
    is
        Row : String := Get_Line (Source_Object);
        whitespace : constant Character_Set := To_Set (' ');
        Representation : Any_Object;

    begin

        Put_Line (Row);

        Trim (Row, whitespace, whitespace);

        declare
            -- because trim only goes from "    int i = 0;" to "int i = 0;    "
            -- thus we need to shorten the string so that the semi-colon is
            -- effectively the last character
            Real_Length : Integer := Get_Real_Row_Length (Row);
            Real_Row : String (1 .. Real_Length) :=
                (if Row /= "" then Row (1 .. Real_Length) else " ");

            Raw_Data : RowInformation := Parse_Line (Real_Row);

        begin

            case Raw_Data.Prefix is

                when VAR_ASSIGNED_PREFIX | VAR_DECLARATION_PREFIX |
                VAR_USAGE_PREFIX =>

                    Representation := new RootObject (ASSIGNMENT_PREFIX);
                    Representation.Assign := Generate_Int_Variable (Raw_Data);
                    return Representation;

                when FUNCTION_PREFIX =>
                    return Generate_Function (Source_Object, Raw_Data);

                when CLOSE_BRACKET_PREFIX =>
                    return new RootObject (CLOSE_BRACKET_PREFIX);

                when others =>
                    return new RootObject (NULL_PREFIX);

            end case;
        end;

    end Decide_On_Parsing;

end Root;