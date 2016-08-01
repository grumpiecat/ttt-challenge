module Main exposing (..)

import Html exposing (..)
import Html.App
import Array exposing (..)
import BoardView

main : Program Never
main = Html.App.beginnerProgram
  {
    model = model
  , update = update
  , view = view
  }

-- Model
type alias BoardState
  = Array (Array String)

type alias Model =
  {
    sideLength : Int
  , boardState : BoardState
  , playerOneMarker : String
  , playerTwoMarker : String
  }

sideLength : Int
sideLength = 3

model : Model
model =
  {
    sideLength = sideLength
  , boardState = ((repeat sideLength << repeat sideLength) "")
  , playerOneMarker = "X"
  , playerTwoMarker = "O"
  }

flattenArray : Array (Array a) -> Array a
flattenArray twoDArr =
  (map toList twoDArr) |> toList |> List.concat |> fromList


activePlayer : BoardState -> String -> String -> String
activePlayer board playerOneMarker playerTwoMarker =
  let oneCount : Int
      oneCount = board |> flattenArray |> filter (\n -> (n == playerOneMarker)) |> length

      twoCount : Int
      twoCount = board |> flattenArray |> filter (\n -> (n == playerTwoMarker)) |> length
  in if (twoCount < oneCount) then playerTwoMarker else playerOneMarker

-- Update

type alias Msg =
  BoardView.Msg

update : Msg -> Model -> Model
update message model =
  let activePlayerMarker = activePlayer model.boardState model.playerOneMarker model.playerTwoMarker in
  case message of
    BoardView.Mark col row ->
      { model | boardState = (fillSpace col row activePlayerMarker model.boardState) }

fillSpace : Int -> Int -> String -> Array (Array String) -> Array (Array String)
fillSpace colNum rowNum marker boardState =
  case (get rowNum boardState) of
  Just row -> (set rowNum (set colNum marker row) boardState)
  Nothing -> boardState

-- View

view : Model -> Html BoardView.Msg
view model =
  div []
    [ h1 [] [text "Tic Tac Toe!"]
    -- , (BoardView.getBoard model.sideLength model.boardState)
    ]
