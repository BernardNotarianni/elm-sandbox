import Login exposing (init, update, view)
import Html exposing (..)
import Html.Events exposing (on, targetValue)

import StartApp.Simple


-- WIRE IT FOR ELM REACTOR

main : Signal Html
main =
  StartApp.Simple.start
    { model = init
    , update = update
    , view = view
    }
