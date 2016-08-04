module BoardHelper exposing (..)

import Array exposing (..)

type alias Board
  = Array (Array String)

makeBoard : List (List String) -> Array (Array String)
makeBoard list =
  list |> fromList |> map fromList

flattenBoard : Array (Array String) -> Array String
flattenBoard board =
  (map toList board) |> toList |> List.concat |> fromList

emptyBoard : Int -> Board
emptyBoard sideLength =
  ((repeat sideLength << repeat sideLength) "")

allOpenSpaces : Array (Int, Int)
allOpenSpaces =
  [(0,0),(0,1),(0,2),(1,0),(1,1),(1,2),(2,0),(2,1),(2,2)] |> fromList

orderedNumberStrings : Board
orderedNumberStrings =
  (makeBoard [["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"]])

winnerRowOne : String -> Board
winnerRowOne marker =
  (makeBoard [[marker, marker, marker], ["", "", ""], ["", "", ""]])

winnerRowTwo : String -> Board
winnerRowTwo marker =
  (makeBoard [["", "", ""], [marker, marker, marker], ["", "", ""]])

winnerRowThree : String -> Board
winnerRowThree marker =
  (makeBoard [["", "", ""], ["", "", ""], [marker, marker, marker]])

winnerColOne : String -> Board
winnerColOne marker =
  (makeBoard [[marker, "", ""], [marker, "", ""], [marker, "", ""]])

winnerColTwo : String -> Board
winnerColTwo marker =
  (makeBoard [["", marker, ""], ["", marker, ""], ["", marker, ""]])

winnerColThree : String -> Board
winnerColThree marker =
  (makeBoard [["", "", marker], ["", "", marker], ["", "", marker]])

winnerDiagonalOne : String -> Board
winnerDiagonalOne marker =
  (makeBoard [[marker, "", ""], ["", marker, ""], ["", "", marker]])

winnerDiagonalTwo : String -> Board
winnerDiagonalTwo marker =
  (makeBoard [["", "", marker], ["", marker, ""], [marker, "", ""]])

catsGameBoard : String -> String -> Board
catsGameBoard p1 p2 =
  (makeBoard [[p1,p1,p2], [p2,p2,p1], [p1,p1,p2]])

threeMovesLeftBoard : String -> String -> Board
threeMovesLeftBoard p1 p2 =
  (makeBoard [[p1,"",""],[p2,p2,p1],[p1,p2,""]])
