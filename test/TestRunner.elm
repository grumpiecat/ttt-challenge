module TestRunner exposing (..)

import ElmTest exposing (..)
import ModelTest
import UpdateTest
import ViewTest
import GameTest
import AITest

tests : List Test
tests =
    [
      ModelTest.modelTests
    , UpdateTest.updateTests
    , ViewTest.viewTests
    , GameTest.gameTests
    , AITest.aiTests
    ]

main : Program Never
main =
    runSuite (suite "All Tests" tests)
