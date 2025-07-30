% Integrity constraints
invalid_price("V1_Clean_MissingOrInvalidPrice", ID) :-
    menuItem(ID, _, PRICE, _, _, _, _, _),
    PRICE = "nan".

zero_price("V2_Clean_ZeroPrice", ID) :-
    menuItem(ID, _, PRICE, _, _, _, _, _),
    PRICE = "0".

invalid_dishid("V3_Clean_MissingOrInvalidDishID", ID) :-
    menuItem(ID, _, PRICE, DISH_ID, _, _, _, _),
    DISH_ID = "nan",
    not PRICE = "nan",
    not PRICE = "0.0".