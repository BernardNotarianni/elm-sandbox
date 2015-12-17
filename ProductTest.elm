import Product exposing (init, update, view)
import Html exposing (..)

import StartApp.Simple


-- WIRE IT FOR ELM REACTOR

main : Signal Html
main =
  StartApp.Simple.start
    { model = init 10
    , update = update
    , view = view
    }
