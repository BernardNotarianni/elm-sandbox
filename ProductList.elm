module ProductList where

import Product
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- MODEL

type alias Model =
  List Product.Model


init : Int -> Model
init num =
  List.map Product.init [0..(num-1)]


counts : Model -> List Int
counts model =
  List.map (\p -> p.counter) model


append : Product.Id -> Model -> Model
append id model =
  let
    newProduct = Product.init id
  in
    model ++ [newProduct]

-- UPDATE

type Action
    = Reset
    | Update Product.Id Product.Action


update : Action -> Model -> Model
update action model =
  case action of
    Reset -> init 3

    Update id act ->
      let updateProduct p =
        if p.id == id then Product.update act p
        else p
      in
        List.map updateProduct model


-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  let
    viewProduct product = Product.view (Signal.forwardTo address (Update product.id)) product
  in
    div []
    [ div [] (List.map viewProduct model)
    , button [ onClick address Reset ] [ text "RESET" ]
    ]
