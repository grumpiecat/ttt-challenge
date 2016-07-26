module Main exposing (..)

import Html exposing (..)
import Html.App
import Array exposing (..)

import Board

-- Main

main : Program Never
main = Html.App.beginnerProgram
  { model = model
  , update = update
  , view = view
  }

model : Array String
model = Board.newBoard

-- Model

type alias Model = Array String

update : Board.Msg -> Model -> Model
update message model =
  case message of
    Board.Mark space -> set space "X" model

-- View

view : Model -> Html Board.Msg
view model =
  div []
      [ h1 [] [text "Tic Tac Toe!"]
      , (Board.getBoardView model 3)
      ]
