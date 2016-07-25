module Board exposing (..)

import ElmTest exposing (..)

tests : Test
tests =
    suite "Board"
        [ test "has nine spaces"
            <| assertEqual List.length board
        ]
