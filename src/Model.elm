module Model exposing (..)

import Array exposing (..)

type alias BoardState
  = Array (Array String)

type alias Model =
  {
    sideLength : Int
  , boardState : BoardState
  , gameOver : Bool
  , playerOneMarker : String
  , playerTwoMarker : String
  }

sideLength : Int
sideLength = 3

model : Model
model =
  {
    sideLength = sideLength
  , boardState = ((repeat sideLength << repeat sideLength) "")
  , gameOver = False
  , playerOneMarker = "X"
  , playerTwoMarker = "O"
  }
