module Main exposing (..)

import Html exposing (..)
import Html.App
import Html.Events exposing (onClick)
import Html.Attributes exposing (attribute)

import Board exposing (newBoard)

-- Main

main : Program Never
main = Html.App.beginnerProgram
  { model = model
  , update = update
  , view = view
  }

-- Model

type alias Model = List Int

model : Model
model =
  newBoard

-- Messages

type Msg
  = Reverse | Drop3

-- Update

update : Msg -> Model -> Model
update message model =
  case message of
    Reverse -> model |> List.reverse
    Drop3 -> model |> List.drop 3

-- View

view : Model -> Html Msg
view model =
  div []
      [ h1 [] [text "Tic Tac Toe!"]
      , div [ attribute "id" "game-board" ] [text (toString model)]
      , button [onClick Reverse] [text "reverse"]
      , button [onClick Drop3] [text "drop 3"]
      ]
