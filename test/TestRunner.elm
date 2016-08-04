module TestRunner exposing (..)

import ElmTest exposing (..)
import ModelTest
import UpdateTest
import ViewTest
import GameTest
import AITest
import BoardTest

tests : List Test
tests =
    [
      ModelTest.modelTests
    , UpdateTest.updateTests
    , ViewTest.viewTests
    , GameTest.gameIsOver
    , GameTest.boardWinner
    , AITest.aiTests
    , BoardTest.boardTests
    ]

main : Program Never
main =
    runSuite (suite "All Tests" tests)
