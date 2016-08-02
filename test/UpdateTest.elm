module UpdateTest exposing (..)

import ElmTest exposing (..)
import Update exposing (..)
import Actions exposing (..)
import Array exposing (fromList)
import Model exposing (model)

updateTests : Test
updateTests =
  suite "Update"
    [
      test "flattenArray turns a two dimensional array into a one-dimensional array"
        <| assertEqual
          (flattenArray (fromList (List.map fromList [["", "", model.playerOneMarker], ["", "", ""], [model.playerOneMarker, "", ""]])))
          (fromList ["", "", model.playerOneMarker, "", "", "", model.playerOneMarker, "", ""])

    , test "activePlayer returns player one marker if board is empty"
        <| assertEqual
          (activePlayer model.boardState model.playerOneMarker model.playerTwoMarker)
          model.playerOneMarker

    , test "activePlayer returns player two marker if there are more player one markers on the board"
        <| assertEqual
          (activePlayer ((update (Mark 0 0) model).boardState) model.playerOneMarker model.playerTwoMarker)
          model.playerTwoMarker

  -- test fillSpace returns original board if given an invalid space
  , test "fillSpace fills proper space with given string"
      <| assertEqual
        (fromList (List.map fromList [["", model.playerOneMarker, ""], ["", "" , ""], ["", "", ""]]))
        (fillSpace 1 0 model.playerOneMarker model.boardState)

  , test "fillSpace fills proper second space with given string"
      <| assertEqual
        (fromList (List.map fromList [[model.playerTwoMarker, model.playerOneMarker, ""], ["", "" , ""], ["", "", ""]]))
        (fillSpace 0 0 model.playerTwoMarker (fromList (List.map fromList [["", model.playerOneMarker, ""], ["", "" , ""], ["", "", ""]])))

  , test "Mark message changes the given spot in an empty board to player one"
      <| assertEqual
        (fromList (List.map fromList [["", "", model.playerOneMarker], ["", "", ""], ["", "", ""]]))
        (update (Mark 2 0) model).boardState
  ]
