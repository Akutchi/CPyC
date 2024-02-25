with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Types.Prefix is

    type StructurePrefix is (

        -- VAR_DECLARATION_PREFIX   <T> [Name];
        -- VAR_ASSIGNED_PREFIX      <T> [Name] = {Value};
        -- VAR_USAGE_PREFIX         [Name] = {Value};

        NULL_PREFIX,
        ASSIGNMENT_PREFIX,
        EXPRESSION_PREFIX,
        VAR_DECLARATION_PREFIX,
        VAR_ASSIGNED_PREFIX,
        VAR_USAGE_PREFIX,
        FUNCTION_PREFIX,
        RETURN_PREFIX,
        CLOSE_BRACKET_PREFIX,
        IF_PREFIX,
        ELIF_PREFIX,
        ELSE_PREFIX,
        FOR_PREFIX,
        WHILE_PREFIX
    );

    type ExpressionPrefix is (

        VARIABLE_FORM,
        VALUE_FORM,
        EXPRESSION_FORM
    );

    type NaturalType is (

        INT,
        FLOAT,
        DOUBLE,
        CHAR,
        VOID
    );

    type GType is tagged private;

    function New_GType (Pattern : NaturalType; T : GType) return GType;
    function New_GType (Pattern : NaturalType; S : Unbounded_String) return GType;

    function Get_State   (Self : GType) return Boolean;

private

    type GType is tagged record
        Base    : Unbounded_String;
        State   : Boolean;
    end record;

end Types.Prefix;