module AITest exposing (..)

import ElmTest exposing (..)
import AI exposing (..)
import Array exposing (Array, fromList, map)

makeBoard : List (List String) -> Array (Array String)
makeBoard list =
  (map fromList (fromList list))

p1 : String
p1 = "X"

p2 : String
p2 = "O"

aiTests : Test
aiTests =
  suite "AI"
    [
      test "availableSpaces returns list of indices of all open spaces on board"
        <| assertEqual [(0,0)]
                       (availableSpaces ([["", p1, p2],[p2, p2, p1],[p1,p1,p2]] |> makeBoard) 0 0 [])

    , test "availableSpaces returns list of indices of all open spaces on board"
        <| assertEqual ([(0,0),(0,1),(0,2),(1,0),(1,1),(1,2),(2,0),(2,1),(2,2)] |> List.reverse)
                       (availableSpaces ([["","",""],["","",""],["","",""]] |> makeBoard) 0 0 [])

    , test "placeAI returns a board where the AI has put its mark on the first available space"
        <| assertEqual (makeBoard [["X", "O", ""], ["", "", ""], ["", "", ""]])
                       (placeAI "O" (makeBoard [["X", "", ""], ["", "", ""], ["", "", ""]]))
    ]
