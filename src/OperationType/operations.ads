package Operations is

    type NullOp is (
        NOP
    );

    type BinaryOp is (

        NULL_OP,
        GREATER_THAN,
        GREATER_EQUAL,
        LESS_THAN,
        LESS_EQUAL,
        EQUAL,
        ASSIGN,
        DIFFERENT,
        PLUS_OP,
        MINUS_OP,
        MULT_OP,
        DIV_OP
    );

    type UnaryOp is (

        NULL_UNARY,
        INVERSE,
        MINUS_UNARY
    );


end Operations;