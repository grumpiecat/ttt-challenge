module BoardViewTest exposing (..)

import ElmTest exposing (..)
import Array exposing (..)
import BoardView exposing (..)

mockEmptyBoard : Array String
mockEmptyBoard = (initialize 9 (\n -> (toString n)))

viewTests : Test
viewTests =
  suite "Board View"
    [
      test "getRows returns array of Html elements (table rows) where the length is equal to the length of the given rowNums"
        <| assertEqual 5 (List.length (getRows [] 0 5 mockEmptyBoard))

    , test "getSpaces returns an array of Html elements where the length is equal to the length of the given rowNums"
        <| assertEqual 3 (List.length (getSpaces [] 2 0 3 mockEmptyBoard))
    ]
