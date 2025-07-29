% CS 513 Datat Cleaning Project - Summer 2025
% Benjamin Fridkis, Samarth Patel, Kesavar Kabilar - Team 15
%% Clingo datalog integrity constraint logic validations

%% Example data entry (Not all entries show - see Menu.lp_wFullDataEntry-Dirty for all entries)
menu(12463,'HOTEL_EASTMAN','BREAKFAST','1900-04-15',67,'COMPLETE','none','none').
menu(12464,'REPUBLICAN_HOUSE','DINNER','1900-04-15',34,'UNDER_REVIEW','none','none').
menu(12465,'NORDDEUTSCHER_LLOYD_BREMEN','BREAKFAST','1900-04-16',84,'COMPLETE','none','none').
menu(12466,'NORDDEUTSCHER_LLOYD_BREMEN','LUNCH','1900-04-16',63,'COMPLETE','none','none').
menu(12467,'NORDDEUTSCHER_LLOYD_BREMEN','DINNER','1900-04-16',33,'COMPLETE','none','none').
menu(12468,'CANADIAN_PACIFIC_RAILWAY_COMPANY','DINNER','1900-04-16',37,'COMPLETE','none','none').
menu(12469,'HOTEL_NETHERLAND','SUPPER','1900-04-16',144,'COMPLETE','Dollars','none').
menu(12470,'NORDDEUTSCHER_LLOYD_BREMEN','BREAKFAST','1900-04-17',80,'COMPLETE','none','none').
menu(12471,'NORDDEUTSCHER_LLOYD_BREMEN','LUNCH','1900-04-17',67,'UNDER_REVIEW','none','none').
menu(12472,'NORDDEUTSCHER_LLOYD_BREMEN','DINNER','1900-04-17',29,'COMPLETE','none','none').

% Define valid statuses
valid_status("COMPLETE").
valid_status("UNDER_REVIEW").

% Integrity constraints
% 1. Missing or empty mandatory fields
:- menu(Id,Sponsor,Event,Date,DishCount,Status,Currency,CurrencySymbol), Sponsor = "none".
:- menu(Id,Sponsor,Event,Date,DishCount,Status,Currency,CurrencySymbol), Event = "none".
:- menu(Id,Sponsor,Event,Date,DishCount,Status,Currency,CurrencySymbol), Date = "none".
:- menu(Id,Sponsor,Event,Date,DishCount,Status,Currency,CurrencySymbol), Status = "none".

% 2. Negative or zero dish count
:- menu(Id,_,_,_,DishCount,_,_,_), DishCount <= 0.

% 3. Inconsistent currency and symbol
:- menu(Id,_,_,_,_,_,Currency,CurrencySymbol), Currency != "none", not currency_symbol(Currency,CurrencySymbol).

% 4. Invalid status
:- menu(Id,_,_,_,_,Status,_,_), Status != "none", not valid_status(Status).

% 5. Duplicate IDs
:- menu(Id,S1,E1,D1,DC1,ST1,C1,CS1), menu(Id,S2,E2,D2,DC2,ST2,C2,CS2), S1 != S2.

% Output violations
violation(Id,missing_sponsor) :- menu(Id,Sponsor,_,_,_,_,_,_), Sponsor = "none".
violation(Id,missing_event) :- menu(Id,_,Event,_,_,_,_,_), Event = "none".
violation(Id,missing_date) :- menu(Id,_,_,Date,_,_,_,_), Date = "none".
violation(Id,missing_status) :- menu(Id,_,_,_,_,Status,_,_), Status = "none".
violation(Id,invalid_dish_count) :- menu(Id,_,_,_,DishCount,_,_,_), DishCount <= 0.
violation(Id,invalid_currency) :- menu(Id,_,_,_,_,_,Currency,CurrencySymbol), Currency != "none", not currency_symbol(Currency,CurrencySymbol).
violation(Id,invalid_status) :- menu(Id,_,_,_,_,Status,_,_), Status != "none", not valid_status(Status).
violation(Id,duplicate_id) :- menu(Id,S1,E1,D1,DC1,ST1,C1,CS1), menu(Id,S2,E2,D2,DC2,ST2,C2,CS2), S1 != S2.
