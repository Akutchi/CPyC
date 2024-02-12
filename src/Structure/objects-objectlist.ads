with Ada.Containers.Indefinite_Vectors;

package Objects.ObjectList is new Ada.Containers.Indefinite_Vectors (

    Index_Type   => Positive,
    Element_Type => RootObject'Class
);