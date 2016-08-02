module Update exposing (..)

import Actions exposing (..)
import Model exposing (Model)
import Array exposing (..)

update : Action -> Model -> Model
update message model =
  let activePlayerMarker = activePlayer model.boardState model.playerOneMarker model.playerTwoMarker in
  case message of
    Mark col row ->
      { model | boardState = (fillSpace col row activePlayerMarker model.boardState) }

fillSpace : Int -> Int -> String -> Array (Array String) -> Array (Array String)
fillSpace colNum rowNum marker boardState =
  case (get rowNum boardState) of
  Just row -> (set rowNum (set colNum marker row) boardState)
  Nothing -> boardState

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
