module BoardTest exposing (..)

import ElmTest exposing (..)
import Board exposing (..)

boardTests : Test
boardTests =
    suite "Board"
        [ test "is a list with 9 spaces" <| assertEqual (List.length newBoard) 9
        ]
