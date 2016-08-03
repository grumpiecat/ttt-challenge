module AI exposing (..)

import Array exposing (..)
import String

placeAI : String -> Array (Array String) -> Array (Array String)
placeAI marker board =
  let openSpaces = availableSpaces board 0 0 [] |> List.reverse |> fromList in
  case (get 0 openSpaces) of
  Just tup ->
    case (get (fst tup) board) of
    Just row -> (set (fst tup) (set (snd tup) marker row) board)
    Nothing -> board
  Nothing -> board

availableSpaces : Array (Array String) -> Int -> Int -> List (Int, Int) -> List (Int, Int)
availableSpaces board rowNum colNum foundSpaces =
  case (get rowNum board) of
  Just row ->
    case (get colNum row) of
    Just val -> if (String.isEmpty val)
                then (availableSpaces board rowNum (colNum + 1) ((rowNum, colNum) :: foundSpaces))
                else (availableSpaces board rowNum (colNum + 1) foundSpaces)
    Nothing -> availableSpaces board (rowNum + 1) 0 foundSpaces
  Nothing -> foundSpaces
