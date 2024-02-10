with objects; use objects;

package Types.Naturals is

    type IntegerValue is new VarObject with record
        Value : Integer;

    end record;

    function New_Integer (Value : Integer) return IntegerValue;

end Types.Naturals;