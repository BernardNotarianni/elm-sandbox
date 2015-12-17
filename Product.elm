module Product where

import Counter
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- MODEL

type alias Id = Int

type alias Model =
  { id : Id, counter : Counter.Model }

init : Int -> Model
init id =
  { id = id, counter = Counter.init 0 }


-- UPDATE


type Action = Update Counter.Action

update : Action -> Model -> Model
update action model =
  case action of
    Update act -> { model | counter <- Counter.update act model.counter }

-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  div []
  [ text ("Product id=" ++ (toString model.id))
  , div [] [Counter.view (Signal.forwardTo address Update) model.counter]
  ]
