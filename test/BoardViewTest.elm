module BoardViewTest exposing (..)

import ElmTest exposing (..)
import Array exposing (..)
import BoardView exposing (..)

type alias MockModel =
  {
    sideLength : Int
  , boardState : BoardState
  , playerOneMarker : String
  , playerTwoMarker : String
  }

mockModel : MockModel
mockModel =
  {
    sideLength = 3
  , boardState = ((repeat 3 << repeat 3) "")
  , playerOneMarker = "R"
  , playerTwoMarker = "Q"
  }

viewTests : Test
viewTests =
  suite "Board View"
    [
      test "getRowElements returns array of Html elements (table rows) where the length is equal to the length of the given rowNums"
        <| assertEqual 3 (List.length (getRowElements [] 0 mockModel))

    , test "getSpaces returns an array of Html elements where the length is equal to the length of the given rowNums"
        <| assertEqual 3 (List.length (getSpaces [] 2 0 mockModel))
    ]
