with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Operations;        use Operations;
with Types.Prefix;      use Types.Prefix;

package Objects.VarObject is

    type VariableObject is tagged private;

    function New_Variable (Var_Name : String) return VariableObject;

    function Var_Name  (VO : VariableObject) return String;


    type HardValue is tagged private;

    type IntegerValue is tagged private;

    function Value (IV : IntegerValue) return Integer;

    function New_IntegerValue (Value : Integer) return IntegerValue;


private

    type VariableObject is tagged record
        Var_Name : Unbounded_String;

    end record;

    type HardValue is tagged null record;

    type IntegerValue is new HardValue with record
        Value : Integer;

    end record;

end Objects.VarObject;