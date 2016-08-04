module Board exposing (..)

import Array exposing (..)
import String

availableSpaces : Array (Array String) -> Int -> Int -> List (Int, Int) -> Array (Int, Int)
availableSpaces board rowNum colNum foundSpaces =
  case (get rowNum board) of
  Just row ->
    case (get colNum row) of
    Just val -> if (String.isEmpty val)
                then (availableSpaces board rowNum (colNum + 1) ((rowNum, colNum) :: foundSpaces))
                else (availableSpaces board rowNum (colNum + 1) foundSpaces)
    Nothing -> availableSpaces board (rowNum + 1) 0 foundSpaces
  Nothing -> foundSpaces |> List.reverse |> fromList


fillSpace : Int -> Int -> String -> Array (Array String) -> Array (Array String)
fillSpace rowNum colNum marker boardState =
  if (spaceIsOpen (rowNum, colNum) (availableSpaces boardState 0 0 []))
  then case (get rowNum boardState) of
    Just row -> (set rowNum (set colNum marker row) boardState)
    Nothing -> boardState
  else boardState

spaceIsOpen : (Int, Int) -> Array (Int, Int) -> Bool
spaceIsOpen space availableSpaces =
  List.member space (toList availableSpaces)


activePlayer : Array (Array String) -> String -> String -> String
activePlayer board playerOneMarker playerTwoMarker =
  let oneCount : Int
      oneCount = board |> flattenArray |> filter (\n -> (n == playerOneMarker)) |> length

      twoCount : Int
      twoCount = board |> flattenArray |> filter (\n -> (n == playerTwoMarker)) |> length
  in if (twoCount < oneCount) then playerTwoMarker else playerOneMarker

flattenArray : Array (Array a) -> Array a
flattenArray twoDArr =
  (map toList twoDArr) |> toList |> List.concat |> fromList
