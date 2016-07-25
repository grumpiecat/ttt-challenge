module TestRunner exposing (..)

import ElmTest exposing (..)
import BoardTest
import MainTest

tests : List Test
tests =
    [ BoardTest.boardTests
    , MainTest.mainTests ]

main : Program Never
main =
    runSuite (suite "All Tests" tests)
