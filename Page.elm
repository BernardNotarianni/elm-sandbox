module Page where

import ProductList exposing (Model, Action, init, update, view, counts)
import Login exposing (Model, Action, init, update, view)
import Carrousel exposing (view)

import String exposing (join)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)



-- MODEL

type alias Model =
  { counters : ProductList.Model
  , login : Login.Model
  }

init : Model
init =
  { counters = ProductList.init 5
  , login = Login.init
  }


counters : Model -> List Int
counters model =
  ProductList.counts model.counters


total : Model -> Int
total model =
  counters model |> List.sum


-- UPDATE

type Action
  = CountIt ProductList.Action
  | LogIt Login.Action
  | AddProduct

update : Action -> Model -> Model
update action model =
  case action of
    CountIt counterPairAction ->
      { model | counters <- ProductList.update counterPairAction model.counters }
    AddProduct ->
      { model | counters <- ProductList.append 12 model.counters }
    LogIt loginAction ->
      { model | login <- Login.update loginAction model.login }

-- VIEW

par : List String -> Html
par textLines =
  p [ ] (textLines |> List.map text)

view : Signal.Address Action -> Model -> Html
view address model =
  div [ class "container" ] [
    div [ class "row"] [
      div [ class "twelve column"] [
        h1 [ ] [ text "The page with nested components" ],
        par [
          "Elm is an amazing langage to create HTML/JS web-applications. ",
          "I enjoy very much programming with it."
        ],

        p [ ]
        [ b [ ] [ text "The current counters are: "]
        , String.join ", " (List.map toString (counters model)) |> text
        ],

        p [ ] [ b [ ] [ text "Total= "], total model |> toString |> text ],

        div [ class "row" ]
        [ div [class "one-half column" ]
          [ h2 [ ] [ text "The counters" ]
          , par [ "This is another paragraph." ]
          , button [ onClick address AddProduct ] [ text "Add counter" ]
          , div [ ] [ viewProduct address model.counters ]
          ]
        , div [class "one-half column" ]
          [ h2 [ ] [ text "The Login" ]
          , par [ "You have a login page just here." ]
          , div [ ] [ viewLogin address model.login ]
          ]
        ]
      ]
    ]
  ]


viewProduct : Signal.Address Action -> ProductList.Model -> Html
viewProduct address model =
  ProductList.view (Signal.forwardTo address (CountIt)) model


viewLogin : Signal.Address Action -> Login.Model -> Html
viewLogin address model =
  Login.view (Signal.forwardTo address (LogIt)) model
