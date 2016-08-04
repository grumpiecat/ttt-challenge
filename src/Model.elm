module Model exposing (..)

import Array exposing (..)

type alias BoardState
  = Array (Array String)

type alias Model =
  {
    sideLength : Int
  , boardState : BoardState
  , playerOneMarker : String
  , playerTwoMarker : String
  }

sideLength : Int
sideLength = 3

init : (Model, Cmd Msg)
init =
  (model, Cmd.none)

model : Model
model =
  {
    sideLength = sideLength
  , boardState = ((repeat sideLength << repeat sideLength) "")
  , playerOneMarker = "X"
  , playerTwoMarker = "O"
  }

type Msg
  = Mark Int Int

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
