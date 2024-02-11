package Operations is

    type NullOp is (
        NOP
    );

    type BinaryOp is (

        GREATER_THAN,
        GREATER_EQUAL,
        LESS_THAN,
        LESS_EQUAL,
        EQUAL,
        ASSIGN,
        DIFFERENT
    );

    type UnaryOp is (

        INVERSE,
        MINUS
    );


end Operations;