with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Fixed;     use Ada.Strings.Fixed;

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

        Count_Pattern : Natural := Count (Source  => To_String (Row),
                                          Pattern => Pattern);
    begin

        return Count_Pattern > 0;

    end Has_Pattern;

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

        Row : Unbounded_String;

    begin

        for I in 1 .. Splited_Row'Length loop
            Append (Row, Splited_Row (I));
        end loop;

        return Has_Pattern (Row, Parenthesis) or
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

    function Is_Variable (Row : String) return Boolean
    is
    begin
        return not Is_Expression (To_Unbounded_String (Row));
    end Is_Variable;

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