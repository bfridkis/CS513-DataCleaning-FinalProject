% Integrity constraints
invalid_price("V1_Dirty_MissingOrInvalidPrice", ID) :-
    menuItem(ID, _, PRICE, _, _, _, _, _, _),
    PRICE = "nan".

zero_price("V2_Dirty_ZeroPrice", ID) :-
    menuItem(ID, _, PRICE, _, _, _, _, _, _),
    PRICE = "0.0".

invalid_dishid("V3_Dirty_MissingOrInvalidDishID", ID) :-
    menuItem(ID, _, PRICE, _, DISH_ID, _, _, _, _),
    DISH_ID = "nan",
    not PRICE = "nan",
    not PRICE = "0.0".