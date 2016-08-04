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
  if (model.activeGame == True) then
    div [] [
      h1 [] [text "Tic Tac Toe!"]
      , div [(attribute "id" "game-type-message")]
            [(gameTypeMessage model)]
      , div [] [
          if (gameOver model.boardState) then
          div [ (attribute "id" "game-over-banner")]
              [text "Game Over."]
          else (getBoard model)
      ]
    ]
  else splashScreen model

splashScreen : Model -> Html Msg
splashScreen model =
    div [] [
        h1 [] [text "Please choose a game type:"]
      , div [(attribute "id" "game-type-choice-container")] [
        button [
          (attribute "class" "game-type-choice"),
          (attribute "id" "player-player"),
          onClick BeginPlayerPlayer
        ] [text "Player v. Player"]
      , button [
          (attribute "class" "game-type-choice"),
          (attribute "id" "player-ai"),
          onClick BeginPlayerAI
        ] [text "Player v. Computer"]
      ]
    ]

gameTypeMessage : Model -> Html Msg
gameTypeMessage model =
  if (model.gameType == playerPlayerType)
  then h3 [] [text "Game Type: Two-Player"]
  else
      div [] [
        h3 [] [text "Game Type: Player vs. Computer"],
        h4 [] [text "Please give the computer time to choose its spot."]]


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
    getSpaces (cells ++ [td [] [getSpaceInnerHTML thisRow thisCol model]]) thisRow (thisCol + 1) model

getSpaceInnerHTML : Int -> Int -> Model -> Html Msg
getSpaceInnerHTML row col model =
  let cellID = row * model.sideLength + col in
  if (String.isEmpty (getSpaceText cellID model.boardState))
  then
    button [
      (attribute "id" ("space-" ++ (toString cellID))),
      (attribute "class" "board-space"),
      onClick
        (if (model.gameType == playerPlayerType)
        then (Mark row col)
        else (PlayRound row col))
    ]
    [(text (getSpaceText cellID model.boardState))]
  else
    div [
      (attribute "id" ("space-" ++ (toString cellID)))
     ,(attribute "class" "filled-space")]
      [text (getSpaceText cellID model.boardState)]

getSpaceText : Int -> Array (Array String) -> String
getSpaceText cellNum boardState =
  let flatBoard = (map toList boardState) |> toList |> List.concat |> fromList in
  case (get cellNum flatBoard) of
    Just val -> val
    Nothing -> "This is not a valid space."
