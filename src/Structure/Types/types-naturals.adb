package body Types.Naturals is

    -----------
    -- Value --
    -----------

    function Value (IV : IntegerValue) return Integer
    is
    begin
        return IV.Value;
    end Value;

    -----------------
    -- New_Integer --
    -----------------

    function New_IntegerValue (Value : Integer) return IntegerValue
    is
        New_Type : IntegerValue := (Value => Value);
    begin

        return New_Type;

    end New_IntegerValue;

end Types.Naturals;