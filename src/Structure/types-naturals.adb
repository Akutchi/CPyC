package body Types.Naturals is

        -- See to become a generic function for all types
        function New_Integer (Value : Integer) return IntegerValue
        is
        begin

            return IntegerValue (Value => Value);

        end New_Integer;

end Types.Naturals;