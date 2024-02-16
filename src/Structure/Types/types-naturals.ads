package Types.Naturals is

    type HardValue is tagged private;

    type IntegerValue is tagged private;

    function Value (IV : IntegerValue) return Integer;

    function New_IntegerValue (Value : Integer) return IntegerValue;

private

    type HardValue is tagged null record;

    type IntegerValue is new HardValue with record
        Value : Integer;

    end record;

end Types.Naturals;