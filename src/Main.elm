module Main exposing (..)

import Html exposing (..)
import Html.App
import Array exposing (..)

import BoardView

main : Program Never
main = Html.App.beginnerProgram
  { model = model
  , update = update
  , view = view
  }

-- Model

type alias Model =
  {
    boardSize : Int
  , boardState : Array String
  , playerOneMarker : String
  , playerTwoMarker : String
  }

model : Model
model =
  {
    boardSize = 3
  , boardState = (repeat (3 * 3) "")
  , playerOneMarker = "X"
  , playerTwoMarker = "O"
  }

-- Update

type alias Msg =
  BoardView.Msg

update : Msg -> Model -> Model
update message model =
  case message of
    BoardView.Mark space ->
      let activePlayerMarker = activePlayer model.boardState model.playerOneMarker model.playerTwoMarker
      in { model | boardState = (set space activePlayerMarker model.boardState) }

activePlayer : Array String -> String -> String -> String
activePlayer board playerOneMarker playerTwoMarker =
  let oneCount : Int
      oneCount = board |> filter (\n -> (n == playerOneMarker)) |> length

      twoCount : Int
      twoCount = board |> filter (\n -> (n == playerTwoMarker)) |> length
  in
    if (twoCount < oneCount) then playerTwoMarker else playerOneMarker

-- View

view : Model -> Html BoardView.Msg
view model =
  div []
      [h1 [] [text "Tic Tac Toe!"]
      , (BoardView.getBoard model.boardSize model.boardState)
      ]
