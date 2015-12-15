import CounterList exposing (init, update, view)
import Html exposing (..)
import Html.Events exposing (on, targetValue)

import StartApp.Simple


-- WIRE IT FOR ELM REACTOR

main : Signal Html
main =
  StartApp.Simple.start
    { model = init 10
    , update = update
    , view = view
    }
