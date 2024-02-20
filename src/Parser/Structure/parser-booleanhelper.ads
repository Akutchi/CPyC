package Parser.BooleanHelper is

    function Is_Not_Structure (Split_Row : String_Array) return Boolean;

    function Has_Affectation (Split_Row : String_Array) return Boolean;

    function Has_Pattern (Row : Unbounded_String; Pattern : String)
    return Boolean;

    function Is_Expression (Splited_Row : String_Array) return Boolean;

    function Is_Expression (Row : Unbounded_String) return Boolean;

    function Is_Variable (Row : String) return Boolean;

    function Is_Numeric (Row : String) return Boolean;

end Parser.BooleanHelper;