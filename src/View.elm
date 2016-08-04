module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (attribute, style)
import Html.Events exposing (..)
import Model exposing (..)
import Array exposing (..)
import String exposing (isEmpty)
import Game exposing (gameOver)
import Board exposing (activePlayer)

view : Model -> Html Msg
view model =
  div [] [
    h1 [] [text "Tic Tac Toe!"]
    , div [] [
        div [ (attribute "id" "game-over-banner"),
            (style [("visibility", (if (gameOver model.boardState) then "visible" else "hidden"))])]
            [text "Game Over."]
      , (getBoard model)
    ]
  ]

getBoard : Model -> Html Msg
getBoard model =
  table [ attribute "id" "game-board" ] [
    tbody [] (getRowElements [] 0 model)
  ]

getRowElements : List (Html Msg) -> Int -> Model -> List (Html Msg)
getRowElements filledRows thisRow model =
  if thisRow == model.sideLength then filledRows
    else getRowElements (filledRows ++ [tr [] (getSpaces [] thisRow 0 model)])
      (thisRow + 1) model

getSpaces : List (Html Msg) -> Int -> Int -> Model -> List (Html Msg)
getSpaces cells thisRow thisCol model =
  if thisCol == model.sideLength then cells
  else
    getSpaces (cells ++ [td [] [getSpaceInnerHTML thisCol thisRow model]]) thisRow (thisCol + 1) model

getSpaceInnerHTML : Int -> Int -> Model -> Html Msg
getSpaceInnerHTML col row model =
  let cellID = row * model.sideLength + col in
  if (String.isEmpty (getSpaceText cellID model.boardState))
  then button [(attribute "id" ("space-" ++ (toString cellID))),
               (attribute "class" "btn btn-default"),
               onClick (Mark col row)]
              [(text (getSpaceText cellID model.boardState))]
  else div [(attribute "id" ("space-" ++ (toString cellID)))
           ,(attribute "class" "filled-space")]
           [text (getSpaceText cellID model.boardState)]

getSpaceText : Int -> Array (Array String) -> String
getSpaceText cellNum boardState =
  let flatBoard = (map toList boardState) |> toList |> List.concat |> fromList in
  case (get cellNum flatBoard) of
    Just val -> val
    Nothing -> "This is not a valid space."
