module AI exposing (..)

import Array exposing (..)
import Board exposing (..)
import Game exposing (winner, gameOver, Board)
import Maybe exposing (withDefault)
import List.Extra
import Model exposing (model)
import Debug

p1 : String
p1 = model.playerOneMarker

p2 : String
p2 = model.playerTwoMarker

chooseMove : String -> Board -> (Int, Int)
chooseMove aiMarker board =
  let scores = (scoredSpaces aiMarker board) in
    case (List.Extra.maximumBy snd (scoredSpaces aiMarker board)) of
      Just choice -> fst choice
      Nothing -> (0,0) 

scoredSpaces : String -> Board -> List ((Int, Int), Int)
scoredSpaces aiMarker board =
  let scores = (toList (map (\x -> minimax aiMarker x 0) (hypotheticalBoards board))) in
    let spaces = (toList (availableSpaces board 0 0 [])) in
      List.Extra.zip spaces scores

minimax : String -> Board -> Int -> Int
minimax player board depth =
  let score = gameOutcome player board depth in
  if (gameOver board) then score
  else
    if (activePlayer board p1 p2) == player then
      withDefault 0 (List.maximum (toList (map (\hypBoard -> (minimax player hypBoard (depth + 1))) (hypotheticalBoards board))))
    else
      withDefault 0 (List.minimum (toList (map (\hypBoard -> (minimax player hypBoard (depth + 1))) (hypotheticalBoards board))))


hypotheticalBoards : Board -> Array (Array (Array String))
hypotheticalBoards currentBoard =
  let openSpaces = (availableSpaces currentBoard 0 0 []) in
    map (\x -> fillSpace (fst x) (snd x) (activePlayer currentBoard p1 p2) currentBoard) openSpaces

gameOutcome : String -> Board -> Int -> Int
gameOutcome player board depth =
  case (winner board) of
  Just winner ->
    if (winner == player) then (10 - depth)
    else depth - 10
  Nothing -> 0
