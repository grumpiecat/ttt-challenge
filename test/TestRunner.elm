module TestRunner exposing (..)

import ElmTest exposing (..)
import BoardViewTest
import MainTest
import GameTest

tests : List Test
tests =
    [
      MainTest.modelTests
    , BoardViewTest.viewTests
    , GameTest.gameTests
    ]

main : Program Never
main =
    runSuite (suite "All Tests" tests)
