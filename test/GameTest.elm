module GameTest exposing (..)

import ElmTest exposing (..)
import BoardHelper exposing (..)
import Array exposing (..)
import Game exposing (..)

gameIsOver : Test
gameIsOver =
  suite "gameOver"
    [
      test "returns false if there is no winner"
        <| assert (not (gameOver (emptyBoard 3) ))

    , test "returns true if player one is the winner on the first row"
        <| assert (gameOver (winnerRowOne p1))

    , test "returns true if player one is the winner on the second row"
        <| assert (gameOver (winnerRowTwo p1))

    , test "returns true if player one is the winner on the third row"
        <| assert (gameOver (winnerRowThree p1))

    , test "returns true if player two is the winner on the first row"
        <| assert (gameOver (winnerRowOne p2))

    , test "returns true if player two is the winner on the second row"
        <| assert (gameOver (winnerRowTwo p2))

    , test "returns true if player two is the winner on the third row"
        <| assert (gameOver (winnerRowThree p2))

    , test "transpose transposes an array"
        <| assertEqual (map fromList (fromList [["1","4","7"],["2","5","8"],["3","6","9"]]))
                       (transpose (orderedNumberStrings))

    , test "returns true if player one is the winner on the first column"
        <| assert (gameOver (winnerColOne p1))

    , test "returns true if player one is the winner on the second column"
        <| assert (gameOver (winnerColTwo p1))

    , test "returns true if player one is the winner on the third column"
        <| assert (gameOver (winnerColThree p1))

    , test "returns true if player two is the winner on the first column"
        <| assert (gameOver (winnerColOne p2))

    , test "returns true if player two is the winner on the second column"
        <| assert (gameOver (winnerColTwo p2))

    , test "returns true if player two is the winner on the third column"
        <| assert (gameOver (winnerColThree p2))

    , test "getDiagonalOne returns diagonal of matrix starting at 0,0"
        <| assertEqual (getDiagonalOne orderedNumberStrings 0 (fromList []))
                       (fromList ["1", "5", "9"])

    , test "returns true if player one is the winner on the diagonal starting at 0,0"
        <| assert (gameOver (winnerDiagonalOne p1))

    , test "returns true if player two is the winner on the diagonal starting at 0,0"
        <| assert (gameOver (winnerDiagonalOne p2))

    , test "getDiagonalTwo returns diagonal of matrix starting at the top right corner"
        <| assertEqual (getDiagonalTwo orderedNumberStrings 0 (fromList []))
                       (fromList ["3", "5", "7"])

    , test "returns true if player one is the winner on the diagonal starting at the top right corner"
        <| assert (gameOver (winnerDiagonalTwo p1))

    , test "returns true if player two is the winner on the diagonal starting at the top right corner"
        <| assert (gameOver (winnerDiagonalTwo p2))

    , test "returns false if vertical column is filled but not won"
        <| assertEqual False (gameOver (makeBoard [[p1, "", ""], [p2, "", ""], [p2, "", ""]]))

    , test "returns false if horizontal row is filled but not won"
        <| assertEqual False (gameOver (makeBoard [[p1, p1, p2], ["", "", ""], [p2, "", ""]]))

    , test "returns false if diagonal row is filled but not won"
        <| assertEqual False (gameOver (makeBoard [[p1, "", p1], ["", p2, ""], [p2, "", p2]]))

    , test "returns true if no winner but board is full (cat's game)"
        <| assert (gameOver (catsGameBoard p1 p2))
    ]

boardWinner : Test
boardWinner =
  suite "winner"
    [
      test "returns nothing if there is no winner"
        <| assertEqual Nothing (winner (emptyBoard 3))

    , test "returns (maybe) marker of player who has won on a horizontal row"
        <| assertEqual (Just p1) (winner (winnerRowTwo p1))

    , test "returns (maybe) marker of player who has won on a vertical row"
        <| assertEqual (Just p2) (winner (winnerColThree p2))

    , test "returns (maybe) marker of player who has won on a diagonal row"
        <| assertEqual (Just p1) (winner (winnerDiagonalTwo p1))
    ]
