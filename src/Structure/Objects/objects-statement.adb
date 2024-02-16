with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

with Objects.Statement; use Objects.Statement;

package body Objects.Statement is

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

    function New_IntAssignment (Axiom           : NaturalType;
                                Left_Member     : VariableObject;
                                Right_Member    : IntegerValue)
    return IntAssignment'Class
    is
        New_Assign : IntAssignment := (Axiomatic_Type    => Axiom,
                                       Left              => Left_Member,
                                       Right             => Right_Member);
    begin

        return New_Assign;

    end New_IntAssignment;

    function Axiomatic_Type (IO : IntAssignment) return NaturalType
    is
    begin
        return IO.Axiomatic_Type;
    end Axiomatic_Type;

    function Left (IO : IntAssignment) return VariableObject'Class
    is
    begin
        return IO.Left;
    end Left;

    function Right (IO : IntAssignment) return IntegerValue'Class
    is
    begin
        return IO.Right;
    end Right;

    --  function Left   (EO : ExpressionObject'Class) return VarObject
    --  is
    --  begin
    --      return EO.Left;
    --  end Left;

    --  function Right   (EO : ExpressionObject'Class) return VarObject
    --  is
    --  begin
    --      return EO.Right;
    --  end Right;

    --  function Op  (EO : ExpressionObject'Class) return BinaryOp
    --  is
    --  begin
    --      return EO.Op;
    --  end Op;

    --  function New_Expression (LeftMember   : VarObject'Class;
    --                           RightMember  : VarObject'Class;
    --                           Operator     : BinaryOp)
    --  return ExpressionObject
    --  is
    --      New_Expr : ExpressionObject := (Left  => VarObject (LeftMember),
    --                                      Right => VarObject (RightMember),
    --                                      Op    => Operator);
    --  begin

    --      return  New_Expr;

    --  end New_Expression;

end Objects.Statement;