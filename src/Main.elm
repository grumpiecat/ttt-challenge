module Main exposing (..)

import Html.App
import Model
import Update
import View

main : Program Never
main = Html.App.beginnerProgram
  {
    model = Model.model
  , update = Update.update
  , view = View.view
  }
