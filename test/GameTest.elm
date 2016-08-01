module GameTest exposing (..)

import ElmTest exposing (..)
import Array exposing (..)
import Game exposing (..)
-- import Debug exposing (..)

p1 : String
p1 = "X"

p2 : String
p2 = "O"

mockModel : Model
mockModel =
  {
    sideLength = 3
  , boardState = ((repeat 3 << repeat 3) "")
  , playerOneMarker = p1
  , playerTwoMarker = p2
  }

replaceRow : Int -> Array String -> Model
replaceRow row newRow =
  { mockModel | boardState = (set row newRow mockModel.boardState) }

gameTests : Test
gameTests =
  suite "gameOver"
    [
     test "returns false if there is no winner"
        <| assert (not (gameOver mockModel))

    , test "returns true if player one is the winner on the first row"
        <| assert (gameOver (replaceRow 0 (fromList [p1, p1, p1])))

    , test "returns true if player one is the winner on the second row"
        <| assert (gameOver (replaceRow 1 (fromList [p1, p1, p1])))

    , test "returns true if player one is the winner on the third row"
        <| assert (gameOver (replaceRow 2 (fromList [p1, p1, p1])))

    , test "returns true if player two is the winner on the first row"
        <| assert (gameOver (replaceRow 0 (fromList [p2, p2, p2])))

    , test "returns true if player two is the winner on the second row"
        <| assert (gameOver (replaceRow 1 (fromList [p2, p2, p2])))

    , test "returns true if player two is the winner on the third row"
        <| assert (gameOver (replaceRow 2 (fromList [p2, p2, p2])))

    , test "transpose transposes an array"
        <| assertEqual (map fromList (fromList [[1,4,7], [2,5,8], [3,6,9]]))
                       (transpose (map fromList (fromList [[1,2,3],[4,5,6],[7,8,9]])))

    , test "returns true if player one is the winner on the first column"
        <| assert (gameOver { mockModel | boardState = (map fromList (fromList [[p1, "", ""], [p1, "", ""], [p1, "", ""]]))})

    , test "returns true if player one is the winner on the second column"
        <| assert (gameOver { mockModel | boardState = (map fromList (fromList [["", p1, ""], ["", p1, ""], ["", p1, ""]]))})

    , test "returns true if player one is the winner on the third column"
        <| assert (gameOver { mockModel | boardState = (map fromList (fromList [["", "", p1], ["", "", p1], ["", "", p1]]))})

    , test "returns true if player two is the winner on the first column"
        <| assert (gameOver { mockModel | boardState = (map fromList (fromList [[p2, "", ""], [p2, "", ""], [p2, "", ""]]))})

    , test "returns true if player two is the winner on the second column"
        <| assert (gameOver { mockModel | boardState = (map fromList (fromList [["", p2, ""], ["", p2, ""], ["", p2, ""]]))})

    , test "returns true if player two is the winner on the third column"
        <| assert (gameOver { mockModel | boardState = (map fromList (fromList [["", "", p2], ["", "", p2], ["", "", p2]]))})

    , test "getDiagonalOne returns diagonal of matrix starting at 0,0"
        <| assertEqual (getDiagonalOne (map fromList (fromList [["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"]])) 0 (fromList []))
                       (fromList ["1", "5", "9"])

    , test "returns true if player one is the winner on the diagonal starting at 0,0"
        <| assert (gameOver { mockModel | boardState = (map fromList (fromList [[p1, "", ""], ["", p1, ""], ["", "", p1]]))})

    , test "returns true if player two is the winner on the diagonal starting at 0,0"
        <| assert (gameOver { mockModel | boardState = (map fromList (fromList [[p2, "", ""], ["", p2, ""], ["", "", p2]]))})

    , test "getDiagonalTwo returns diagonal of matrix starting at the top right corner"
        <| assertEqual (getDiagonalTwo (map fromList (fromList [["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"]])) 0 (fromList []))
                       (fromList ["3", "5", "7"])

    , test "returns true if player one is the winner on the diagonal starting at the top right corner"
        <| assert (gameOver { mockModel | boardState = (map fromList (fromList [["", "", p1], ["", p1, ""], [p1, "", ""]]))})

    , test "returns true if player two is the winner on the diagonal starting at the top right corner"
        <| assert (gameOver { mockModel | boardState = (map fromList (fromList [["", "", p2], ["", p2, ""], [p2, "", ""]]))})
    ]
