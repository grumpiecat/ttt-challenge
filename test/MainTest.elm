module MainTest exposing (..)

import ElmTest exposing (..)
import Main exposing (..)

mainTests : Test
mainTests =
    suite "Model"
        [ test "model initializes as empty board" <| assertEqual model [1..9]
        ]
