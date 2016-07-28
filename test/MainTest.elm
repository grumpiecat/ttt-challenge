module MainTest exposing (..)

import ElmTest exposing (..)
import Array exposing (..)
import Main exposing (..)
import Board

mockEmptyBoard : Array String
mockEmptyBoard = (initialize 9 (\n -> (toString n)))

modelTests : Test
modelTests =
  suite "Model"
    [ test "initialized as empty board"
      <| assertEqual model mockEmptyBoard
    ]

updateTests : Test
updateTests =
  suite "Update"
    [ test "clicking on first button changes the element's text to 'X'"
       <| assertEqual
         (update (Board.Mark 0) mockEmptyBoard)
         (Array.set 0 "X" mockEmptyBoard)
     ,test "clicking on non-first space changes that space's marker to 'X'"
       <| assertEqual
         (Array.get 3 (update (Board.Mark 3) mockEmptyBoard))
         (Just "X")
    ]
