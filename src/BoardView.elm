module BoardView exposing (..)

import Array exposing (..)
import String
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (attribute)

type Msg
  = Mark Int

type alias Board
  = Array String

getBoard : Int -> Board -> Html Msg
getBoard boardSize boardState =
  table [ attribute "id" "game-newBoard" ] [
    tbody [] (getRows [] 0 boardSize boardState)
  ]

getRows : List (Html Msg) -> Int -> Int -> Board -> List (Html Msg)
getRows filledRows thisRow numRows boardState =
  if thisRow == numRows then filledRows
    else getRows (filledRows ++ [tr [] [td [] (getSpaces [] thisRow 0 numRows boardState)]])
      (thisRow + 1) numRows boardState

getSpaces : List (Html Msg) -> Int -> Int -> Int -> Board -> List (Html Msg)
getSpaces cells thisRow thisCol numCols boardState =
  if thisCol == numCols then cells
  else
    let
      cellID : Int
      cellID = thisRow * numCols + thisCol
    in
      getSpaces (cells ++ [td [] [getSpaceInnerHTML cellID boardState]]) thisRow (thisCol + 1) numCols boardState

getSpaceInnerHTML : Int -> Board -> Html Msg
getSpaceInnerHTML cellID boardState =
  if (String.isEmpty (getSpaceText cellID boardState))
  then button [(attribute "id" ("space-" ++ (toString cellID))), onClick (Mark cellID)]
              [(text (getSpaceText cellID boardState))]
  else div [(attribute "id" ("space-" ++ (toString cellID)))]
           [text (getSpaceText cellID boardState)]

getSpaceText : Int -> Board -> String
getSpaceText space boardState =
  case (get space boardState) of
    Just val -> val
    Nothing -> "This is not a valid space."
