module TestRunner exposing (..)

import ElmTest exposing (..)
import BoardTest
import MainTest

tests : List Test
tests =
    [ MainTest.modelTests
    , MainTest.updateTests
    , BoardTest.modelTests
    , BoardTest.viewTests ]

main : Program Never
main =
    runSuite (suite "All Tests" tests)
