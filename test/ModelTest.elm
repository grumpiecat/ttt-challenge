module ModelTest exposing (..)

import ElmTest exposing (..)
import Model exposing (..)
import Array exposing (..)

emptyBoard : Array (Array String)
emptyBoard =
  ((repeat sideLength << repeat sideLength) "")

modelTests : Test
modelTests =
  suite "Model"
    [
      test "sideLength initializes to 3 (i.e. a 3x3 board)"
        <| assertEqual model.sideLength 3

    , test "boardState initialized with number of 'rows' (arrays) equal to the sideLength"
        <| assertEqual (length model.boardState) sideLength

    , test "boardState initialized with number of columns (in each row) equal to the sideLength)"
        <| assert (List.all (\n -> (length n) == sideLength) (toList model.boardState))

    , test "playerOneMarker initialize to X"
        <| assertEqual model.playerOneMarker "X"

    , test "playerTwoMarker initialize to O"
        <| assertEqual model.playerTwoMarker "O"

    , test "player vs player game is game-type 1"
        <| assertEqual playerPlayerType 1

    , test "player vs AI game is game-type 2"
        <| assertEqual playerAIType 2

    , test "gameType is initialized"
        <| assert ((model.gameType == playerPlayerType) ||
                   (model.gameType == playerAIType))
    ]
