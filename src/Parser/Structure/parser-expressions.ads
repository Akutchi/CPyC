with Ada.Containers.Vectors;

with Operations; use Operations;

with Parser.BooleanHelper; use Parser.BooleanHelper;

with Exceptions; use Exceptions;

package Parser.Expressions is

    function Parse_Int_Expression (SubRow : String)
    return IntImplAssignment.Any_Expression;

private

    function Decide_Operator (Op_Str : Character) return BinaryOp;

    function Get_SubExpr (Row : String) return SubExpression_Information;

end Parser.Expressions;