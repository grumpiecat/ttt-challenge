module AITest exposing (..)

import ElmTest exposing (..)
import AI exposing (..)
import Array exposing (..)
import BoardHelper exposing (..)
import Board

p1 : String
p1 = "X"

ai : String
ai = "O"

aiTests : Test
aiTests =
  suite "AI"
    [
      test "hypotheticalBoards returns a list of boards equal to the length of the open spaces"
        <| assertEqual
          (length (hypotheticalBoards (emptyBoard 3)))
          (length allOpenSpaces)

    , test "gameOutcome returns 0 if there is no winner"
        <| assertEqual 0
            (gameOutcome ai (emptyBoard 3) 5)

    , test "gameOutcome returns higher score for game won by player than cats game"
        <| assert ((gameOutcome ai (catsGameBoard p1 ai) 9)
                < (gameOutcome ai (winnerRowOne ai) 9))

    , test "gameOutcome returns higher score for game won by player than game lost by player"
        <| assert ((gameOutcome ai (winnerColOne p1) 5)
                < (gameOutcome ai (winnerRowOne ai) 5))

    , test "gameOutcome returns higher score for game won by player with lower depth"
        <| assert ((gameOutcome ai (winnerColOne ai) 6)
                < (gameOutcome ai (winnerRowOne ai) 5))

    , test "minimax returns higher score for won board than lost board"
        <| assert ((minimax ai (winnerRowOne ai) 0) > (minimax ai (winnerRowOne p1) 0))

    , test "minimax returns higher score for game won that cats game"
        <| assert ((minimax ai (winnerColTwo ai) 0) > (minimax ai (catsGameBoard p1 ai) 0))

    , test "minimax returns lower score for game lost that cats game"
        <| assert ((minimax ai (winnerColTwo p1) 0) < (minimax ai (catsGameBoard p1 ai) 0))

    , test "scoredSpaces returns list of length equal to number of open spaces"
        <| assertEqual
            (length (Board.availableSpaces (threeMovesLeftBoard p1 p2) 0 0 []))
            (length (fromList (scoredSpaces ai (threeMovesLeftBoard p1 p2))))

    , test "chooseMove returns the row, col where board can immediately win"
        <| assertEqual (2,0) (AI.chooseMove ai (makeBoard [[p1,"",ai],
                                                           ["",ai,p1],
                                                           ["","",p1]]))

    , test "chooseMove returns the row, col where board can block an opponent win"
        <| assertEqual (0,1) (AI.chooseMove ai (makeBoard [[p1,"",p1],
                                                           [p1,"",ai],
                                                           [ai,p1,ai]]))

    , test "choice does not fall into the corner trap"
        <| let choice = (AI.chooseMove ai (makeBoard [[p1, "", ""],
                                                      ["", ai, ""],
                                                      ["", "", p1]])) in
        assert (not (choice == (0,2)) && (not (choice == (2,0))))

    , test "choice does not fall into the two-way winner trap"
        <| let choice = (AI.chooseMove ai (makeBoard [["", "", ""],
                                                      [p1, ai, ""],
                                                      ["", p1, ""]])) in
        assert (not (choice == (0,1)) && (not (choice == (0,2))) && (not (choice == (2,2))))

    , test "choice avoids the edge trap"
        <| let choice = (AI.chooseMove ai (makeBoard [[p1, "", ""],
                                                      ["", ai, p1],
                                                      ["", "", ""]])) in
        assert (not (choice == (1,0)) && (not (choice == (2,0))))

    , test "choice is quickest path to victory when two winning choices exist"
      <| let choice = (AI.chooseMove ai (makeBoard [[p1, ai, ""],
                                                    [p1, ai, ""],
                                                    ["", "", p1]])) in
        assertEqual choice (2,1)
    ]
