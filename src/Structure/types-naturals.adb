package body Types.Naturals is

        -- See to become a generic function for all types
        function New_Integer (Value : Integer) return IntegerValue
        is

            New_Int : IntegerValue;

        begin

            New_Int.Value := Value;

            return New_Int;

        end New_Integer;

end Types.Naturals;