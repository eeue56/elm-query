module Main where

import Query
import Html exposing (..)
import Html.Attributes exposing (id, src, href, class)
import Html.Events exposing (..)
import Debug
import StartApp
import Task
import Effects exposing (Effects, Never)



type Action = Focus | Clicked | Noop

type alias Model = Int

model : Model
model = 0

update : Action -> Model -> (Model, Effects Action)
update action model =
    case action of
        Clicked ->
            let

                nodes = Query.getAll ".funny"
                inputNodes = Query.getAll ".sad"
                isFocusedOutside =
                    List.filter (Query.isActiveElement) inputNodes
                        |> List.isEmpty

                focuser : Effects Action
                focuser =
                    if isFocusedOutside then
                        case List.head inputNodes of
                            Just v ->
                                Query.focus v
                                    |> Task.map (\x -> Focus)
                                    |> Effects.task

                            Nothing -> Effects.none
                    else
                        Effects.none
            in
                case nodes of
                    first::_ ->
                        List.filter (Query.eq first) nodes
                            |> List.length
                            |> (\n -> (n, focuser))
                    _ -> (0, focuser)
        Focus ->
            (model, Effects.none)
        Noop ->
            (model, Effects.none)



clicks : Signal.Mailbox Action
clicks = Signal.mailbox Noop

view address model =
    div
        [ id "dave", onClick address Clicked ]
        [ text <| toString model
        , div [ class "funny" ] [ text "Joke" ]
        , div [ class "funny" ] [ text "Story"]
        , div [ class "funny" ] [ text "Joke" ]
        , input [ class "sad" ] []
        , input [ class "sad" ] []
        ]

app =
        StartApp.start
            { init = (model, Effects.none)
            , view = view
            , update = update
            , inputs = [] }

main =
    app.html

port tasks : Signal (Task.Task Never ())
port tasks =
    app.tasks

