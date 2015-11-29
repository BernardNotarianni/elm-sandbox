import CounterPair exposing (Model, Action, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)

import StartApp.Simple


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
        h1 [ ] [ text "My first amazing app" ],
        par [
          "Elm is an amazing langage to create HTML/JS web-applications. ",
          "I enjoy very much programming with it."
        ],
        h2 [ ] [ text "Let add some text here" ],
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


-- WIRE IT TOGETHER

main : Signal Html
main =
  StartApp.Simple.start
    { model = init
    , update = update
    , view = view
    }
