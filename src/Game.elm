module Game exposing (..)

import Array exposing (..)
import Maybe exposing (andThen)
import Array.Extra
import String

type alias Model =
  {
    sideLength : Int
  , boardState : Array (Array String)
  , playerOneMarker : String
  , playerTwoMarker : String
  }

type alias PlayerMarker
  = String

gameOver : Model -> Bool
gameOver model =
  horizontalWinner model || verticalWinner model || diagonalWinner model || catsGame model

horizontalWinner : Model -> Bool
horizontalWinner model =
  let listifiedBoard = ((map toList model.boardState) |> toList) in
  (List.any (sliceWinner model) listifiedBoard)

verticalWinner : Model -> Bool
verticalWinner model  =
  let listifiedTransposedBoard = ((map toList (transpose model.boardState)) |> toList) in
  (List.any (sliceWinner model) listifiedTransposedBoard)

diagonalWinner : Model -> Bool
diagonalWinner model =
  sliceWinner model (toList (getDiagonalOne model.boardState 0 empty))
  || sliceWinner model (toList (getDiagonalTwo model.boardState 0 empty))

catsGame : Model -> Bool
catsGame model =
  let flattenedList = (map toList model.boardState) |> toList |> List.concat
  in List.all (\x -> (not (String.isEmpty x))) flattenedList

sliceWinner : Model -> List String -> Bool
sliceWinner model board =
  (List.all (\x -> x == model.playerOneMarker) board) || (List.all (\x -> x == model.playerTwoMarker) board)

transpose : Array (Array a) -> Array (Array a)
transpose board =
  let
    firstRow = get 0 board
    restRows = Array.Extra.sliceFrom 1 board
  in
    case firstRow of
      Nothing -> board
      Just firstRow ->
        let
          vector = map (repeat 1) firstRow
          step row acc = Array.Extra.map2 (append) acc (map (repeat 1) row)
        in
          foldl step vector restRows

getDiagonalOne : Array (Array a) -> Int -> Array a -> Array a
getDiagonalOne board currentRow diagonal =
  case (get currentRow board) of
  Just row ->
    case (get currentRow row) of
      Just val -> getDiagonalOne board (currentRow + 1) (push val diagonal)
      Nothing -> diagonal
  Nothing -> diagonal

getDiagonalTwo : Array (Array a) -> Int -> Array a -> Array a
getDiagonalTwo board currentRow diagonal =
  case (get currentRow board) of
  Just row ->
    case (get ((length board) - 1 - currentRow) row) of
      Just val -> getDiagonalTwo board (currentRow + 1) (push val diagonal)
      Nothing -> diagonal
  Nothing -> diagonal
