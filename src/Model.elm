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
  , activeGame : Bool
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
  , gameType = playerAIType
  , activeGame = False
  }

type Msg
  = Mark Int Int
  | PlayRound Int Int
  | BeginPlayerPlayer
  | BeginPlayerAI

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
