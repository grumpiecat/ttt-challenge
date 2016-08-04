module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Model exposing (init, subscriptions)
import Update
import View

main : Program Never
main = App.program
  {
    init = init
  , view = View.view
  , update = Update.update
  , subscriptions = subscriptions
  }
