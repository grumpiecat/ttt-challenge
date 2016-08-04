module Game exposing (..)

import Array exposing (..)
import Maybe exposing (andThen)
import Array.Extra
import List.Extra
import String

p1 : String
p1 = "X"

p2 : String
p2 = "O"

type alias Board
  = Array (Array String)

type alias PlayerMarker
  = String

gameOver : Board -> Bool
gameOver board =
  if (catsGame board) then True else
  case (winner board) of
  Just player -> True
  Nothing ->  False

winner : Board -> Maybe PlayerMarker
winner board =
  Maybe.oneOf [horizontalWinner board, verticalWinner board, diagonalWinner board]

horizontalWinner : Board -> Maybe PlayerMarker
horizontalWinner board =
  let listifiedBoard = ((map toList board) |> toList) in
  sliceWinner board listifiedBoard

verticalWinner : Board -> Maybe PlayerMarker
verticalWinner board  =
  let listifiedTransposedBoard = ((map toList (transpose board)) |> toList) in
  sliceWinner board listifiedTransposedBoard

diagonalWinner : Board -> Maybe PlayerMarker
diagonalWinner board =
  sliceWinner board [(toList (getDiagonalOne board 0 empty))
               ,(toList (getDiagonalTwo board 0 empty))]

sliceWinner : Board -> List (List String) -> Maybe PlayerMarker
sliceWinner board listifiedBoard =
  case List.Extra.find
    (\row -> ((List.all ((==) p1) row) || (List.all ((==) p2) row)))
      listifiedBoard of
  Just row -> (List.head row)
  Nothing -> Nothing

catsGame : Board -> Bool
catsGame board =
  let flattenedList = (map toList board) |> toList |> List.concat
  in List.all (\x -> (not (String.isEmpty x))) flattenedList

transpose : Board -> Board
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

getDiagonalOne : Board -> Int -> Array String -> Array String
getDiagonalOne board currentRow diagonal =
  case (get currentRow board) of
  Just row ->
    case (get currentRow row) of
      Just val -> getDiagonalOne board (currentRow + 1) (push val diagonal)
      Nothing -> diagonal
  Nothing -> diagonal

getDiagonalTwo : Board -> Int -> Array String -> Array String
getDiagonalTwo board currentRow diagonal =
  case (get currentRow board) of
  Just row ->
    case (get ((length board) - 1 - currentRow) row) of
      Just val -> getDiagonalTwo board (currentRow + 1) (push val diagonal)
      Nothing -> diagonal
  Nothing -> diagonal
