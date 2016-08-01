module MainTest exposing (..)

import ElmTest exposing (..)
import Array exposing (..)
import List exposing (all)
import Main exposing (..)
import BoardView

emptyBoard : Array (Array String)
emptyBoard =
  ((repeat sideLength << repeat sideLength) "")

modelTests : Test
modelTests =
  suite "Model"
    [
      test "sideLength initializes to 3 (i.e. a 3x3 board)"
        <| assertEqual model.sideLength 3

    , test "boardState initialized with number of 'rows' (arrays) equal to the sideLength"
        <| assertEqual (length model.boardState) sideLength

    , test "boardState initialized with number of columns (in each row) equal to the sideLength)"
        <| assert (all (\n -> (length n) == sideLength) (toList model.boardState))

    , test "playerOneMarker initialize to X"
        <| assertEqual model.playerOneMarker "X"

    , test "playerTwoMarker initialize to O"
        <| assertEqual model.playerTwoMarker "O"

    , test "flattenArray turns a two dimensional array into a one-dimensional array"
        <| assertEqual
          (flattenArray (fromList (List.map fromList [["", "", model.playerOneMarker], ["", "", ""], [model.playerOneMarker, "", ""]])))
          (fromList ["", "", model.playerOneMarker, "", "", "", model.playerOneMarker, "", ""])

    , test "activePlayer returns player one marker if board is empty"
        <| assertEqual
          (activePlayer model.boardState model.playerOneMarker model.playerTwoMarker)
          model.playerOneMarker

    , test "activePlayer returns player two marker if there are more player one markers on the board"
        <| assertEqual
          (activePlayer ((update (BoardView.Mark 0 0) model).boardState) model.playerOneMarker model.playerTwoMarker)
          model.playerTwoMarker

    -- test fillSpace returns original board if given an invalid space
    , test "fillSpace fills proper space with given string"
        <| assertEqual
          (fromList (List.map fromList [["", model.playerOneMarker, ""], ["", "" , ""], ["", "", ""]]))
          (fillSpace 1 0 model.playerOneMarker emptyBoard)

    , test "fillSpace fills proper second space with given string"
        <| assertEqual
          (fromList (List.map fromList [[model.playerTwoMarker, model.playerOneMarker, ""], ["", "" , ""], ["", "", ""]]))
          (fillSpace 0 0 model.playerTwoMarker (fromList (List.map fromList [["", model.playerOneMarker, ""], ["", "" , ""], ["", "", ""]])))

    , test "Mark message changes the given spot in an empty board to player one"
        <| assertEqual
          (fromList (List.map fromList [["", "", model.playerOneMarker], ["", "", ""], ["", "", ""]]))
          (update (BoardView.Mark 2 0) model).boardState
    ]
