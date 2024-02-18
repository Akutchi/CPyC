with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package body Objects.VarObject is

    ------------------
    -- New_Variable --
    ------------------

    function New_Variable (Var_Name : String) return VariableObject
    is
        New_Var : VariableObject := (Var_Name => To_Unbounded_String (Var_Name));
    begin

        return New_Var;

    end New_Variable;

    -------------
    -- VarName --
    -------------

    function Var_Name  (VO : VariableObject) return String
    is
    begin
        return To_String (VO.Var_Name);
    end Var_Name;

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


end Objects.VarObject;