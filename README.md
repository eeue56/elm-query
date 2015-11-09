# elm-query


Elm-query provides a way of manipulating and querying DOM elements without turning to ports.


## Getting nodes by class

```elm

funnyNodes : List Query.QueryNode
funnyNodes = Query.getAll ".funny"

```

## Getting a node by id

```elm

nameNode : Maybe QueryNode
nameNode = Query.get "#name"

```

## Seeing if the active element is any of those with a given class

```elm

isAnyFunnyActive : Bool
isAnyFunnyActive =
    Query.getAll ".funny"
        |> List.filter (Query.isActiveElement)
        |> List.isEmpty
        |> not

```

## Focusing an element

```elm

focused : Effects QueryNode
focused =
    case Query.get "#name" of
        Just node ->
            Query.focus node
                |> Effects.task
        Nothing -> Effects.none

```
