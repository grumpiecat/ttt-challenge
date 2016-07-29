module MainTest exposing (..)

import ElmTest exposing (..)
import Array exposing (..)
import Main exposing (..)
import BoardView

mockEmptyBoard : Array String
mockEmptyBoard = (repeat 9 "")

modelTests : Test
modelTests =
  suite "Model"
    [
      test "contents initialized as empty array with length of 9"
        <| assertEqual model.boardState mockEmptyBoard

    , test "boardSize initialize to 3 (i.e. a 3x3 board)"
        <| assertEqual model.boardSize 3

    , test "playerOneMarker initialize to X"
        <| assertEqual model.playerOneMarker "X"

    , test "playerTwoMarker initialize to O"
        <| assertEqual model.playerTwoMarker "O"
    ]

updateTests : Test
updateTests =
  suite "Update"
    [
      test "Mark message changes the given spot in the model to active player marker"
        <| assertEqual
          (mockEmptyBoard |> set 0 model.playerOneMarker |> set 1 model.playerTwoMarker)
          (update (BoardView.Mark 1) (update (BoardView.Mark 0) model)).boardState

      , test "clicking on non-first space changes that space's marker to the player one marker"
        <| assertEqual
          (Just model.playerOneMarker)
          (Array.get 3 (update (BoardView.Mark 3) model).boardState)

      , test "activePlayer returns player one marker if board is empty"
        <| assertEqual
          (activePlayer mockEmptyBoard model.playerOneMarker model.playerTwoMarker)
          model.playerOneMarker

      , test "activePlayer returns player two marker if there are more player one markers on the board"
        <| assertEqual
          (activePlayer (set 0 model.playerOneMarker mockEmptyBoard) model.playerOneMarker model.playerTwoMarker)
          model.playerTwoMarker
    ]
