module UpdateTest exposing (..)

import ElmTest exposing (..)
import Update exposing (..)
import Model exposing (..)
import BoardHelper exposing (..)
import Array exposing (toList)

p1 : String
p1 = model.playerOneMarker

p2 : String
p2 = model.playerTwoMarker

updateTests : Test
updateTests =
  suite "Update"
    [
      test "PlayRound action places player one and two on the board"
        <| let updatedBoard = ((fst (update (PlayRound 0 2) model)).boardState |> flattenBoard |> toList) in
          assert ((List.member p1 updatedBoard) && (List.member p2 updatedBoard))

    , test "Mark action places only the active player on the board"
        <| let updatedBoard = ((fst (update (Mark 2 2) model)).boardState |> flattenBoard |> toList) in
          assert ((List.member p1 updatedBoard) && (not (List.member p2 updatedBoard)))
    ]
