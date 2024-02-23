with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Fixed;     use Ada.Strings.Fixed;

with Parser.StringHelper; use Parser.StringHelper;

package body Parser.BooleanHelper is

    ----------------------
    -- Is_Not_Structure --
    ----------------------

    function Is_Not_Structure (Split_Row : String_Array)
    return Boolean
    is
    begin

        declare
            Last_EI  : Integer   := Split_Row'Last;
            Last_EL  : Integer   := Length (Split_Row (Last_EI));
            Last_EC  : Character := To_String (Split_Row (Last_EI)) (Last_EL-1);
        begin
            return Last_EC /= '{';
        end;

    exception
        when Constraint_Error => return false;
    end;

    ---------------------
    -- Has_Affectation --
    ---------------------

    function Has_Affectation (Split_Row : String_Array) return Boolean
    is
    begin

        declare
            Second_Position : constant Character := To_String
                                                        (Split_Row (2)) (1);
            Third_Position  : constant Character := To_String
                                                        (Split_Row (3)) (1);
        begin
            return Third_Position = '=' or Second_Position = '=';
        end;

        exception
            when Constraint_Error => return false;

    end Has_Affectation;

    -----------------
    -- Has_Pattern --
    -----------------

    function Has_Pattern (Row : Unbounded_String; Pattern : String)
    return Boolean
    is

        Count_Pattern : Natural := Ada.Strings.Fixed.Count
            (Source  => To_String (Row), Pattern => Pattern);
    begin

        return Count_Pattern > 0;

    end Has_Pattern;

    -----------------
    -- Is_Function --
    -----------------

    function Is_Function (Splited_Row : String_Array) return Boolean
    is
        Cnt : Natural;
        Idx : Natural := 0;

        Row : Unbounded_String :=
            To_Unbounded_String (Concatenate_Array (Splited_Row));

        Row_Check : Unbounded_String;
        Is_Function_Result : Boolean := True;
    begin

        Cnt := Ada.Strings.Fixed.Count
            (Source  => To_String (Row), Pattern => "(");

        for I in 1 .. Cnt loop
            Idx := Index (Source => Row, Pattern => "(", From => Idx + 1);

            Row_Check := To_Unbounded_String (To_String (Row) (Idx-1)'Image);
            Is_Function_Result := Is_Function_Result and
            (not Is_Expression (Row_Check));
        end loop;

        return Is_Function_Result;
    end;

    -------------------
    -- Is_Expression --
    -------------------

    function Is_Expression (Splited_Row : String_Array)
    return Boolean
    is

        Parenthesis : constant String := "(";
        Plus_Op     : constant String := "+";
        Minus_Op    : constant String := "-";
        Mult_Op     : constant String := "*";
        Div_Op      : constant String := "/";

        Row : Unbounded_String :=
            To_Unbounded_String (Concatenate_Array (Splited_Row));

    begin

        return  Has_Pattern (Row, Parenthesis) or
                Has_Pattern (Row, Plus_Op) or
                Has_Pattern (Row, Minus_Op) or
                Has_Pattern (Row, Mult_Op) or
                Has_Pattern (Row, Div_Op);

    end Is_Expression;

    function Is_Expression (Row : Unbounded_String)
    return Boolean
    is

        Parenthesis : constant String := "(";
        Plus_Op     : constant String := "+";
        Minus_Op    : constant String := "-";
        Mult_Op     : constant String := "*";
        Div_Op      : constant String := "/";

    begin

        return Has_Pattern (Row, Parenthesis) or
               Has_Pattern (Row, Plus_Op) or
               Has_Pattern (Row, Minus_Op) or
               Has_Pattern (Row, Mult_Op) or
               Has_Pattern (Row, Div_Op);

    end Is_Expression;

    -----------------
    -- Is_Variable --
    -----------------

    function Is_Variable (Row : String) return Boolean
    is
    begin
        return not Is_Expression (To_Unbounded_String (Row));
    end Is_Variable;

    ----------------
    -- Is_Numeric --
    ----------------

    function Is_Numeric (Row : String) return Boolean
    is
        Placeholder : Integer;
    begin
        Placeholder := Integer'Value (Row);
        return True;

    exception
        when others => return False;

    end Is_Numeric;

end Parser.BooleanHelper;