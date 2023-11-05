module metroid2.bank06;


// Given an input and a collision state, this produces a rotational direction for the spider ball
// - Note that this only considers cardinal directions. Perhaps, by adding
//  data for diagonal directions, the controls of the spider ball could be improved
//
// Values
//  0: Don't move
//  1: Move counter-clockwise
//  2: Move clockwise
//   ______________________________________________ 0: No input
//  |   ___________________________________________ 1: Right
//  |  |   ________________________________________ 2: Left
//  |  |  |   _____________________________________ 3: X: R+L
//  |  |  |  |   __________________________________ 4: Up
//  |  |  |  |  |   _______________________________ 5: R+U
//  |  |  |  |  |  |   ____________________________ 6: L+U
//  |  |  |  |  |  |  |   _________________________ 7: X: R+L+U
//  |  |  |  |  |  |  |  |   ______________________ 8: Down
//  |  |  |  |  |  |  |  |  |   ___________________ 9: D+R
//  |  |  |  |  |  |  |  |  |  |   ________________ A: D+L
//  |  |  |  |  |  |  |  |  |  |  |   _____________ B: X: R+L+U
//  |  |  |  |  |  |  |  |  |  |  |  |   __________ C: X: U+D
//  |  |  |  |  |  |  |  |  |  |  |  |  |   _______ D: X: R+U+D
//  |  |  |  |  |  |  |  |  |  |  |  |  |  |   ____ E: X: L+U+D
//  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |   _ F: X: R+L+U+D
//  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
immutable ubyte[] spiderBallOrientationTable = [
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, //    0: In air
    0, 2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, //    1: Outside corner: Of left-facing wall and ceiling
    0, 1, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, //    2: Outside corner: Of left-facing wall and floor
    0, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, //    3: Flat surface:   Left-facing wall
    0, 0, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, //    4: Outside corner: Of right-facing wall and ceiling
    0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, //    5: Flat surface:   Ceiling
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, //    6: Unused:         Top-left and bottom-right corners of ball in contact
    0, 0, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, //    7: Inside corner:  Of left-facing wall and ceiling
    0, 0, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, //    8: Outside corner: Of right-facing wall and floor
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, //    9: Unused:         Bottom-left and top-right corners of ball in contact
    0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, //    A: Flat surface:   Floor
    0, 0, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, //    B: Inside corner:  Of left-facing wall and floor
    0, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, //    C: Flat surface:   Right-facing wall
    0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, //    D: Inside corner:  Of right-facing wall and ceiling
    0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, //    E: Inside corner:  Of right-facing wall and floor
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, //    F: Unused:         Embedded in solid
];