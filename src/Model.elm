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
  , loading : Bool
  , turnWarning : Bool
  }

sideLength : Int
sideLength = 3

emptyBoard : Array (Array String)
emptyBoard =
  ((repeat sideLength << repeat sideLength) "")

init : (Model, Cmd Msg)
init =
  (model, Cmd.none)

model : Model
model =
  {
    sideLength = sideLength
  , boardState = emptyBoard
  , playerOneMarker = "X"
  , playerTwoMarker = "O"
  , gameType = playerAIType
  , activeGame = False
  , loading = False
  , turnWarning = False
  }

type Msg
  = StartNewGame
  | BeginPlayerPlayer
  | BeginPlayerAI
  | SingleMove Int Int
  | PlayerMoveVsAI Int Int
  | AIMove
  | OutOfTurnWarning

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
