module BoardTest exposing (..)

import ElmTest exposing (..)
import Array exposing (..)
import Board exposing (..)

mockEmptyBoard : Array String
mockEmptyBoard = (initialize 9 (\n -> (toString n)))

modelTests : Test
modelTests =
    suite "Board"
        [ test "is a String array with numbers 0-8"
          <| assertEqual newBoard (Array.map toString (Array.fromList [0,1,2,3,4,5,6,7,8]))
        ]

viewTests : Test
viewTests =
  suite "Board View"
    [ test "getRows returns array of Html elements (table rows) where the length is equal to the length of the given rowNums"
        <| assertEqual 5 (List.length (getRows [] 0 5 mockEmptyBoard))
      , test "getSpaces returns an array of Html elements where the length is equal to the length of the given rowNums"
        <| assertEqual 3 (List.length (getSpaces [] 2 0 3 mockEmptyBoard))
    ]
