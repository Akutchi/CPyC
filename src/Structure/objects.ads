package Objects is

    type RootObject is tagged null record;

    type ObjectList is array (Positive range <>) of RootObject;

    type VarObject is new RootObject with null record;

end Objects;