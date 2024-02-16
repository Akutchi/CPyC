with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package body Types.Prefix is

    function Update (T : GType; implementation : String) return Boolean
    is
    begin

        return T.State or T.Base = implementation;
    end Update;

    ---------------
    -- New_Gtype --
    ---------------

    function New_GType (Pattern : NaturalType; T : GType)
    return GType
    is
        New_GType : GType := (Base => T.Base, State => T.State);

    begin

        case Pattern is
            when INT        => New_GType.State := Update (New_GType, "int");
            when FLOAT      => New_GType.State := Update (New_GType, "float");
            when DOUBLE     => New_GType.State := Update (New_GType, "double");
            when CHAR       => New_GType.State := Update (New_GType, "char");
            when others     => New_GType.State := false;
        end case;

        return New_GType;

    end New_GType;

    function New_GType (Pattern : NaturalType; S : Unbounded_String)
    return GType
    is

        New_GType : GType := (Base => S, State => false);
    begin

        case Pattern is
            when INT        => New_GType.State := New_GType.Base = "int";
            when FLOAT      => New_GType.State := New_GType.Base = "float";
            when DOUBLE     => New_GType.State := New_GType.Base = "double";
            when CHAR       => New_GType.State := New_GType.Base = "char";
            when others     => New_GType.State := false;
        end case;

        return New_GType;

    end New_GType;

    ---------------
    -- Get_State --
    ---------------

    function Get_State (Self : GType) return Boolean
    is
    begin
        return Self.State;
    end Get_State;


end Types.Prefix;