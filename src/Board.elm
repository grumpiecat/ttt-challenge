module Board exposing (..)

import Array exposing (..)
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (attribute)

-- Model

type alias BoardSize = Int

boardSize : BoardSize
boardSize = 9

newBoard : Array String
newBoard =
  initialize boardSize (\n -> (toString n))

marker : String
marker = "X"

spaceIsFilled : Int -> CurrentBoard -> Bool
spaceIsFilled space board =
  ((get space board) == Just marker)


-- Update

type Msg
  = Mark Int

type alias CurrentBoard = Array String

-- View

getBoardView : CurrentBoard -> BoardSize -> Html Msg
getBoardView currentBoard boardSize =
  table [ attribute "id" "game-board" ] [
    tbody [] (getRows [] 0 boardSize currentBoard)
  ]

getRows : List (Html Msg) -> Int -> Int -> CurrentBoard -> List (Html Msg)
getRows filledRows thisRow numRows model =
  if thisRow == numRows then filledRows
    else getRows (filledRows ++ [tr [] [ td [] (getSpaces [] thisRow 0 numRows model)]])
      (thisRow + 1) numRows model

getSpaces : List (Html Msg) -> Int -> Int -> Int -> CurrentBoard -> List (Html Msg)
getSpaces cells thisRow thisCol numCols model =
    if thisCol == numCols then cells
    else
      let
        cellID : Int
        cellID = thisRow * numCols + thisCol
      in
      getSpaces (cells ++ [td [] [ getSpaceInnerHTML cellID model ]]) thisRow (thisCol + 1) numCols model

getSpaceInnerHTML : Int -> CurrentBoard -> Html Msg
getSpaceInnerHTML cellID model =
  if (spaceIsFilled cellID model)
  then div [(attribute "id" ("space-" ++ (toString cellID)))] [(text (getSpaceText cellID model))]
  else button [(attribute "id" ("space-" ++ (toString cellID))), onClick (Mark cellID)] [(text (getSpaceText cellID model))]

getSpaceText : Int -> CurrentBoard -> String
getSpaceText space model =
  case (get space model) of
    Just val -> val
    Nothing -> "?"
