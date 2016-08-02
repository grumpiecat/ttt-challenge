module ViewTest exposing (..)

import ElmTest exposing (..)
import View exposing (..)
import Model exposing (model)

viewTests : Test
viewTests =
  suite "Board View"
    [
      test "getRowElements returns array of Html elements (table rows) where the length is equal to the length of the given rowNums"
        <| assertEqual 3 (List.length (getRowElements [] 0 model))

    , test "getSpaces returns an array of Html elements where the length is equal to the length of the given rowNums"
        <| assertEqual 3 (List.length (getSpaces [] 2 0 model))
    ]
