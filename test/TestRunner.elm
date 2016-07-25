module Main exposing (..)

import ElmTest exposing (..)
import Board

tests : Test
tests =
    Board.tests

main : Program Never
main =
    runSuite tests
