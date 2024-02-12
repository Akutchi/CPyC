package body Types.Naturals is

        function Value (IV : IntegerValue) return Integer
        is
        begin
            return IV.Value;
        end Value;

        -- See to become a generic function for all types
        function New_Integer (Value : Integer) return IntegerValue
        is
            New_Int : IntegerValue := (Value => Value);
        begin

            return New_Int;

        end New_Integer;

end Types.Naturals;