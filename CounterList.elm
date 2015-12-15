module CounterList where

import Counter
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- MODEL

type alias Id = Int

type alias CounterLine =
  { id : Id
  , counter : Counter.Model
  }

type alias Model =
  List CounterLine


initLine : Int -> CounterLine
initLine id =
  { id = id, counter = Counter.init 0 }

init : Int -> Model
init num =
  List.map initLine [0..(num-1)]


counts : Model -> List Int
counts model =
  List.map (\m -> m.counter) model


counterId : Id -> Model -> Counter.Model
counterId id model =
  let
    counterLine =  List.filter (\m -> m.id == id) model |> List.head
  in
    case counterLine of
      Nothing -> Counter.init 0
      Just c -> c.counter

-- UPDATE

type Action
    = Reset
    | Update Id Counter.Action


update : Action -> Model -> Model
update action model =
  case action of
    Reset -> init 3

    Update id act ->
      let updateCounter m =
        if m.id == id then { m | counter <- Counter.update act m.counter }
        else m
      in
        List.map updateCounter model


-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  let
    viewCounter line = Counter.view (Signal.forwardTo address (Update line.id)) line.counter
  in
    div []
    [ div [] (List.map viewCounter model)
    , button [ onClick address Reset ] [ text "RESET" ]
    ]
