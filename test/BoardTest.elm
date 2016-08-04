module BoardTest exposing (..)

import ElmTest exposing (..)
import Board exposing (..)
import Array exposing (..)
import Model exposing (model)
import BoardHelper exposing (..)

makeBoard : List (List String) -> Array (Array String)
makeBoard list =
  (map fromList (fromList list))

p1 : String
p1 = "X"

p2 : String
p2 = "O"

boardTests : Test
boardTests =
  suite "Board Tests"
  [
    test "availableSpaces returns list of indices of all open spaces on board"
        <| assertEqual (fromList [(0,0)])
                       (availableSpaces ([["", p1, p2],[p2, p2, p1],[p1,p1,p2]] |> makeBoard) 0 0 [])

  , test "availableSpaces returns list of indices of all open spaces on board"
      <| assertEqual (fromList ([(0,0),(0,1),(0,2),(1,0),(1,1),(1,2),(2,0),(2,1),(2,2)]))
                     (availableSpaces ([["","",""],["","",""],["","",""]] |> makeBoard) 0 0 [])

  , test "flattenArray turns a two dimensional array into a one-dimensional array"
        <| assertEqual
          (flattenArray (makeBoard [["", "", model.playerOneMarker], ["", "", ""], [model.playerOneMarker, "", ""]]))
          (fromList ["", "", model.playerOneMarker, "", "", "", model.playerOneMarker, "", ""])

  , test "activePlayer returns player one marker if board is empty"
      <| assertEqual
        (activePlayer model.boardState model.playerOneMarker model.playerTwoMarker)
        model.playerOneMarker

  , test "activePlayer returns player two marker if there are more player one markers on the board"
      <| assertEqual
        (activePlayer (makeBoard [["", "", ""], ["", "", ""], [p1, "", ""]]) p1 p2)
        p2

  , test "activePlayer returns player one marker if there are more player two markers on the board"
      <| assertEqual
        (activePlayer (makeBoard [[p2, p2, ""], ["", "", ""], [p1, "", ""]]) p1 p2)
        p1

  , test "fillSpace returns old board if given space is full"
      <| let board = (threeMovesLeftBoard p1 p2) in
          assertEqual board (fillSpace 1 0 p1 board)

  , test "fillSpace fills proper space with given string"
      <| assertEqual
        (makeBoard [["", p1, ""], ["", "" , ""], ["", "", ""]])
        (fillSpace 0 1 p1 model.boardState)

  , test "fillSpace fills proper second space with given string"
      <| assertEqual
        (makeBoard [["",p1,""], ["","",""], [p2,"",""]])
        (fillSpace 2 0 p2 (makeBoard [["",p1,""], ["","",""], ["","",""]]))

  ]
