with Objects; use Objects;

package Types.Naturals is

    type IntegerValue is tagged private;

    function Value (IV : IntegerValue) return Integer;

    function New_Integer (Value : Integer) return IntegerValue;

private

    type IntegerValue is new VarObject with record
        Value : Integer;

    end record;

end Types.Naturals;