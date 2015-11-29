module Login (Model, init, Action, update, view) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- MODEL

type alias Model =
  { firstname : String
  , lastname : String
  , logged : Bool
  }


init : Model
init =
  { firstname = ""
  , lastname = ""
  , logged = False
  }


-- UPDATE

type Action
  = SetFirstName String
  | SetLastName String
  | Submit


update : Action -> Model -> Model
update action model =
  case action of
    SetFirstName s -> { model | firstname <- s }
    SetLastName s -> { model | lastname <- s }
    Submit -> { model | logged <- True }


-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  if model.logged then
    viewLogged address model
  else
    viewForm address model


viewForm : Signal.Address Action -> Model -> Html
viewForm address model =
  div []
    [ div [ ]
      [ div [ class "row" ]
        [ div [ class "six columns"]
          [ div [ ]
            [ input
              [ placeholder "First name"
              , value model.firstname
              , on "input" targetValue (\str -> Signal.message address (SetFirstName str))
              ]
              []
            , input
              [ placeholder "Last name"
              , value model.lastname
              , on "input" targetValue (\str -> Signal.message address (SetLastName str))
              ]
              []
            , button [ onClick address Submit ] [ text "Login" ]
            , text (toString model)
            ]
          ]
        ]
      ]
    ]

viewLogged : Signal.Address Action -> Model -> Html
viewLogged address model =
  div []
    [ div [ ]
      [ div [ class "row" ]
        [ div [ class "six columns"]
          [ div [ ]
            [ hello model
            , text (toString model)
            ]
          ]
        ]
      ]
    ]

hello : Model -> Html
hello model =
  "Hello " ++ model.firstname ++ " " ++ model.lastname |> text
