with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Types.Prefix; use Types.Prefix;

package Types.Constructed is

    type String_Array is array (Positive range <>) of Unbounded_String;

    type RowInformation (Length : Integer) is record

        Splited_Line : String_Array (1 .. Length);
        Prefix       : StructurePrefix;
    end record;

    type SubExpression_Information is record

        Str     : Unbounded_String;
        End_Pos : Integer;
    end record;

end Types.Constructed;