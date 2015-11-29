import Page exposing (init, update, view)
import Html exposing (..)
import StartApp.Simple

main : Signal Html
main =
  StartApp.Simple.start
    { model = init
    , update = update
    , view = view
    }
