module Model exposing (..)

import Array exposing (..)

type alias BoardState
  = Array (Array String)

type alias GameType = Int

playerPlayerType : GameType
playerPlayerType = 1

playerAIType : GameType
playerAIType = 2

type alias Model =
  {
    sideLength : Int
  , boardState : BoardState
  , playerOneMarker : String
  , playerTwoMarker : String
  , gameType : GameType
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
  , gameType = playerPlayerType
  }

type Msg
  = PlayRound Int Int
  | Mark Int Int

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
