module Query where

import Task exposing (Task)
import Native.Query

type QueryNode = QueryNode

type alias Query = String


get : Query -> Maybe QueryNode
get =
    Native.Query.get

getAll : Query -> List QueryNode
getAll =
    Native.Query.getAll


eq : QueryNode -> QueryNode -> Bool
eq =
    Native.Query.eq

focus : QueryNode -> Task never QueryNode
focus =
    Native.Query.focus

activeElement : () -> QueryNode
activeElement =
    Native.Query.activeElement

isActiveElement : QueryNode -> Bool
isActiveElement elm =
    eq (activeElement ()) elm

--xOf : String -> QueryNode -> String
