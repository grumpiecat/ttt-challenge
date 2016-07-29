module TestRunner exposing (..)

import ElmTest exposing (..)
import BoardViewTest
import MainTest

tests : List Test
tests =
    [ MainTest.modelTests
    , MainTest.updateTests
    , BoardViewTest.viewTests ]

main : Program Never
main =
    runSuite (suite "All Tests" tests)
