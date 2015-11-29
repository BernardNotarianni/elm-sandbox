module Page where

import CounterPair exposing (Model, Action, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)



-- MODEL

type alias Model =
  { counters : CounterPair.Model
  }

init : Model
init =
  { counters = CounterPair.init 0 0
  }

-- UPDATE

type Action
  = Modify CounterPair.Action

update : Action -> Model -> Model
update action model =
  case action of
    Modify counterPairAction ->
      { counters = CounterPair.update counterPairAction model.counters }

-- VIEW

par : List String -> Html
par textLines =
  p [ ] (textLines |> List.map text)

view : Signal.Address Action -> Model -> Html
view address model =
  div [ class "container" ] [
    div [ class "row"] [
      div [ class "twelve column"] [
        h1 [ ] [ text "The page with two counters" ],
        par [
          "Elm is an amazing langage to create HTML/JS web-applications. ",
          "I enjoy very much programming with it."
        ],
        h2 [ ] [ text "Those are the counters you are looking for" ],
        par [
          "This is another paragraph."
        ],
        div [ ] [ viewCounter address model.counters ]

      ]
    ]
  ]

viewCounter : Signal.Address Action -> CounterPair.Model -> Html
viewCounter address model =
  CounterPair.view (Signal.forwardTo address (Modify)) model
