module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (attribute)
import Html.Events exposing (onClick)
import Actions exposing (..)
import Model exposing (Model)
import Array exposing (..)
import String exposing (isEmpty)

view : Model -> Html Action
view model =
  div []
    [
      h1 [] [text "Tic Tac Toe!"]
    , h1 [(attribute "id" "game-over-banner"), (attribute "hidden" "true")]
         [text "Game Over."]
    , (getBoard model)
    ]

getBoard : Model -> Html Action
getBoard model =
  table [ attribute "id" "game-newBoard" ] [
    tbody [] (getRowElements [] 0 model)
  ]

getRowElements : List (Html Action) -> Int -> Model -> List (Html Action)
getRowElements filledRows thisRow model =
  if thisRow == model.sideLength then filledRows
    else getRowElements (filledRows ++ [tr [] [td [] (getSpaces [] thisRow 0 model)]])
      (thisRow + 1) model

getSpaces : List (Html Action) -> Int -> Int -> Model -> List (Html Action)
getSpaces cells thisRow thisCol model =
  if thisCol == model.sideLength then cells
  else
    getSpaces (cells ++ [td [] [getSpaceInnerHTML thisCol thisRow model]]) thisRow (thisCol + 1) model

getSpaceInnerHTML : Int -> Int -> Model -> Html Action
getSpaceInnerHTML col row model =
  let cellID = row * model.sideLength + col in
  if (String.isEmpty (getSpaceText cellID model.boardState))
  then button [(attribute "id" ("space-" ++ (toString cellID))), onClick (Mark col row)]
              [(text (getSpaceText cellID model.boardState))]
  else div [(attribute "id" ("space-" ++ (toString cellID)))]
           [text (getSpaceText cellID model.boardState)]

getSpaceText : Int -> Array (Array String) -> String
getSpaceText cellNum boardState =
  let flatBoard = (map toList boardState) |> toList |> List.concat |> fromList in
  case (get cellNum flatBoard) of
    Just val -> val
    Nothing -> "This is not a valid space."