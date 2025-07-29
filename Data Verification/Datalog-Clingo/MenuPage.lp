% CS 513 Datat Cleaning Project - Summer 2025
% Benjamin Fridkis, Samarth Patel, Kesavar Kabilar - Team 15
%% Clingo datalog integrity constraint logic validations

%% Example data entry (Not all entries show - see MenuPage.lp_wFullDataEntry-Dirty for all entries)
menu_page(119, 12460, 1, 1603595, 7230, 5428, 510d47e4_2955_a3d9_e040_e00a18064a99).
menu_page(120, 12460, 2, 1603596, 5428, 7230, 510d47e4_2956_a3d9_e040_e00a18064a99).
menu_page(121, 12460, 3, 1603597, 7230, 5428, 510d47e4_2957_a3d9_e040_e00a18064a99).
menu_page(122, 12460, 4, 1603598, 7230, 5428, 510d47e4_2958_a3d9_e040_e00a18064a99).
menu_page(123, 12461, 1, 1603591, 7230, 5428, 510d47e4_2959_a3d9_e040_e00a18064a99).
menu_page(124, 12461, 2, 1603592, 7230, 5428, 510d47e4_295a_a3d9_e040_e00a18064a99).
menu_page(125, 12461, 3, 1603593, 7230, 5428, 510d47e4_295b_a3d9_e040_e00a18064a99).
menu_page(126, 12461, 4, 1603594, 7230, 5428, 510d47e4_295c_a3d9_e040_e00a18064a99).
menu_page(127, 12462, 2, 4000001128, 0, 0, 510d47db_1ef8_a3d9_e040_e00a18064a99).
menu_page(128, 12462, 1, 474450, 0, 0, 510d47db_1ef9_a3d9_e040_e00a18064a99).

% --- Combined Integrity Violation Rules ---
duplicate_id(ID) :-
    ID_ = ID,
    { menupage(ID_, _, _, _, _, _, _) } > 1.

null_menu_id(ID) :-
    menupage(ID, MenuID, _, _, _, _, _),
    MenuID <= 0.

non_positive_page_number(ID, PageNumber) :-
    menupage(ID, _, PageNumber, _, _, _, _),
    PageNumber <= 0.

 null_image_id(ID) :-
    menupage(ID, _, _, ImageID, _, _, _),
    ImageID <= 0.           

invalid_height(ID, Height) :-
    menupage(ID, _, _, _, Height, _, _),
    Height <= 0.

invalid_width(ID, Width) :-
    menupage(ID, _, _, _, _, Width, _),
    Width <= 0.