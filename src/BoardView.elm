module BoardView exposing (..)

import Array exposing (..)
import String
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (attribute)

type Msg
  = Mark Int Int

type alias BoardState
  = Array (Array String)

type alias Model =
  {
    sideLength : Int
  , boardState : BoardState
  , playerOneMarker : String
  , playerTwoMarker : String
  }

getBoard : Model -> Html Msg
getBoard model =
  table [ attribute "id" "game-newBoard" ] [
    tbody [] (getRowElements [] 0 model)
  ]

getRowElements : List (Html Msg) -> Int -> Model -> List (Html Msg)
getRowElements filledRows thisRow model =
  if thisRow == model.sideLength then filledRows
    else getRowElements (filledRows ++ [tr [] [td [] (getSpaces [] thisRow 0 model)]])
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
  then button [(attribute "id" ("space-" ++ (toString cellID))), onClick (Mark col row)]
              [(text (getSpaceText cellID model.boardState))]
  else div [(attribute "id" ("space-" ++ (toString cellID)))]
           [text (getSpaceText cellID model.boardState)]

getSpaceText : Int -> BoardState -> String
getSpaceText cellNum boardState =
  let flatBoard = (map toList boardState) |> toList |> List.concat |> fromList in
  case (get cellNum flatBoard) of
    Just val -> val
    Nothing -> "This is not a valid space."
