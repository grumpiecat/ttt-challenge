module Update exposing (..)

import Model exposing (..)
import AI
import Board exposing (..)
import Task
import Process

update : Msg -> Model -> (Model, Cmd Msg)
update message model =
  let activePlayerMarker = activePlayer model.boardState model.playerOneMarker model.playerTwoMarker in
  case message of
    StartNewGame ->
      { model | activeGame = False, boardState = Model.emptyBoard }
      ! []

    BeginPlayerPlayer ->
      { model | activeGame = True, gameType = playerPlayerType }
      ! []

    BeginPlayerAI ->
      { model | activeGame = True, gameType = playerAIType }
      ! []

    SingleMove row col ->
      { model | boardState = fillSpace row col activePlayerMarker model.boardState }
      ! []

    PlayerMoveVsAI row col ->
      if activePlayerMarker == model.playerOneMarker then
        let playersChoiceBoard = fillSpace row col activePlayerMarker model.boardState in
        ({ model | boardState = playersChoiceBoard, loading = True},
          Task.map2 (\_ b -> b) (Process.sleep 10) (Task.succeed AIMove) |> Task.perform identity identity)
      else (model, Cmd.none)

    AIMove ->
      let choice = AI.chooseMove activePlayerMarker model.boardState in
        let updatedBoard = fillSpace (fst choice) (snd choice) activePlayerMarker model.boardState in
        ({ model | loading = False, boardState = updatedBoard }, Cmd.none)

    OutOfTurnWarning ->
      (Debug.log "OOTW" { model | turnWarning = True }, Cmd.none)
