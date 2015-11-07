module Main where

import Query
import Html exposing (..)
import Html.Attributes exposing (id, src, href, class)
import Html.Events exposing (..)
import Debug


type Action = Clicked | Noop

type alias Model = Int

model : Model
model = 0

update : Action -> Model -> Model
update action model =
    case action of
        Clicked ->
            let

                nodes = Query.getAll ".funny"
                inputNodes = Query.getAll ".sad"
                isFocusedOutside =
                    List.filter (Query.isActiveElement) inputNodes
                        |> List.isEmpty

                _ =
                    if isFocusedOutside then
                        case List.head inputNodes of
                            Just v -> Query.focus v
                            Nothing -> ()
                    else
                        ()
            in
                case nodes of
                    first::_ ->
                        List.filter (Query.eq first) nodes
                            |> List.length
                    _ -> 0

        Noop -> model

model' =
    Signal.foldp
        update
        model
        clicks.signal

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

main = Signal.map (view clicks.address) model'
