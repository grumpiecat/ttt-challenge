module Update exposing (..)

import Model exposing (..)
import Array exposing (..)
import String
import AI
import Board exposing (..)

update : Msg -> Model -> (Model, Cmd Msg)
update message model =
  let activePlayerMarker = activePlayer model.boardState model.playerOneMarker model.playerTwoMarker in
  case message of
    Mark row col ->
      { model | boardState = fillSpace row col activePlayerMarker model.boardState }
      ! []

    PlayRound row col ->
      let playersChoiceBoard = fillSpace row col activePlayerMarker model.boardState in
        let aiChoice = AI.chooseMove model.playerTwoMarker playersChoiceBoard in
          { model | boardState = fillSpace (fst aiChoice) (snd aiChoice) model.playerTwoMarker playersChoiceBoard }
          ! []
