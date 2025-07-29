% CS 513 Datat Cleaning Project - Summer 2025
% Benjamin Fridkis, Samarth Patel, Kesavar Kabilar - Team 15
%% Clingo datalog integrity constraint logic validations

%% Example data entry (Not all entries show - see Dish.lp_wFullDataEntry-Dirty for all entries)
dish(1,'Consomme_printaniere_royal','none',8,8,1897,1927,0.2,0.4).
dish(2,'Chicken_gumbo','none',111,117,1895,1960,0.1,0.8).
dish(3,'Tomato_aux_croutons','none',13,13,1893,1917,0.25,0.4).
dish(4,'Onion_au_gratin','none',41,41,1900,1971,0.25,1.0).
dish(5,'St_Emilion','none',66,68,1881,1981,0.0,18.0).
dish(7,'Radishes','none',3262,3346,1854,2928,0.0,25.0).
dish(8,'Chicken_soup_with_rice','none',48,49,1897,1961,0.1,0.6).
dish(9,'Clam_broth_cup','none',14,16,1899,1962,0.15,0.4).
dish(10,'Cream_of_new_asparagus_croutons','none',2,2,1900,1900,0.0,0.0).
dish(11,'Clear_green_turtle','none',157,157,1893,1937,0.25,60.0).

% Integrity constraints
% 1. Missing or empty mandatory fields
:- dish(Id,Name,Description,MenusAppeared,TimesAppeared,FirstAppeared,LastAppeared,LowestPrice,HighestPrice), Name = "none".
:- dish(Id,Name,Description,MenusAppeared,TimesAppeared,FirstAppeared,LastAppeared,LowestPrice,HighestPrice), MenusAppeared = -1.
:- dish(Id,Name,Description,MenusAppeared,TimesAppeared,FirstAppeared,LastAppeared,LowestPrice,HighestPrice), TimesAppeared = -1.
:- dish(Id,Name,Description,MenusAppeared,TimesAppeared,FirstAppeared,LastAppeared,LowestPrice,HighestPrice), FirstAppeared = -1.
:- dish(Id,Name,Description,MenusAppeared,TimesAppeared,FirstAppeared,LastAppeared,LowestPrice,HighestPrice), LastAppeared = -1.

% 2. Non-negative counts
:- dish(Id,_,_,MenusAppeared,TimesAppeared,_,_,_,_), MenusAppeared < 0.
:- dish(Id,_,_,MenusAppeared,TimesAppeared,_,_,_,_), TimesAppeared < 0.

% 3. Valid year range (1800-2025)
:- dish(Id,_,_,_,_,FirstAppeared,_,_,_), FirstAppeared != -1, FirstAppeared < 1800.
:- dish(Id,_,_,_,_,FirstAppeared,_,_,_), FirstAppeared != -1, FirstAppeared > 2025.
:- dish(Id,_,_,_,_,_,LastAppeared,_,_), LastAppeared != -1, LastAppeared < 1800.
:- dish(Id,_,_,_,_,_,LastAppeared,_,_), LastAppeared != -1, LastAppeared > 2025.

% 4. Year consistency
:- dish(Id,_,_,_,_,FirstAppeared,LastAppeared,_,_), FirstAppeared != -1, LastAppeared != -1, FirstAppeared > LastAppeared.

% 5. Price consistency
:- dish(Id,_,_,_,_,_,_,LowestPrice,HighestPrice), LowestPrice != -1, HighestPrice != -1, LowestPrice > HighestPrice.
:- dish(Id,_,_,_,_,_,_,LowestPrice,_), LowestPrice < 0.
:- dish(Id,_,_,_,_,_,_,_,HighestPrice), HighestPrice < 0.

% 6. Duplicate IDs
:- dish(Id,Name1,_,_,_,_,_,_,_), dish(Id,Name2,_,_,_,_,_,_,_), Name1 != Name2.

% Output violations
violation(Id,missing_name) :- dish(Id,Name,_,_,_,_,_,_,_), Name = "none".
violation(Id,missing_menus_appeared) :- dish(Id,_,_,MenusAppeared,_,_,_,_,_), MenusAppeared = -1.
violation(Id,missing_times_appeared) :- dish(Id,_,_,_,TimesAppeared,_,_,_,_), TimesAppeared = -1.
violation(Id,missing_first_appeared) :- dish(Id,_,_,_,_,FirstAppeared,_,_,_), FirstAppeared = -1.
violation(Id,missing_last_appeared) :- dish(Id,_,_,_,_,_,LastAppeared,_,_), LastAppeared = -1.
violation(Id,negative_menus_appeared) :- dish(Id,_,_,MenusAppeared,_,_,_,_,_), MenusAppeared < 0.
violation(Id,negative_times_appeared) :- dish(Id,_,_,_,TimesAppeared,_,_,_,_), TimesAppeared < 0.
violation(Id,invalid_first_appeared) :- dish(Id,_,_,_,_,FirstAppeared,_,_,_), FirstAppeared != -1, (FirstAppeared < 1800; FirstAppeared > 2025).
violation(Id,invalid_last_appeared) :- dish(Id,_,_,_,_,_,LastAppeared,_,_), LastAppeared != -1, (LastAppeared < 1800; LastAppeared > 2025).
violation(Id,year_inconsistency) :- dish(Id,_,_,_,_,FirstAppeared,LastAppeared,_,_), FirstAppeared != -1, LastAppeared != -1, FirstAppeared > LastAppeared.
violation(Id,invalid_price_range) :- dish(Id,_,_,_,_,_,_,LowestPrice,HighestPrice), LowestPrice != -1, HighestPrice != -1, LowestPrice > HighestPrice.
violation(Id,negative_lowest_price) :- dish(Id,_,_,_,_,_,_,LowestPrice,_), LowestPrice < 0.
violation(Id,negative_highest_price) :- dish(Id,_,_,_,_,_,_,_,HighestPrice), HighestPrice < 0.
violation(Id,duplicate_id) :- dish(Id,Name1,_,_,_,_,_,_,_), dish(Id,Name2,_,_,_,_,_,_,_), Name1 != Name2.
