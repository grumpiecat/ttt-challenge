module UpdateTest exposing (..)

import ElmTest exposing (..)
import Update exposing (..)
import Model exposing (..)
import BoardHelper exposing (..)
import Array exposing (toList)

p1 : String
p1 = "X"

p2 : String
p2 = "O"

updateTests : Test
updateTests =
  suite "Update"
    [
      test "Mark action places player one on the board"
        <| assert (List.member p1
          ((fst (update (Mark 0 2) model)).boardState |> flattenBoard |> toList))
    ]
