module HelloWorld where

import Html exposing (..)
import Html.Attributes exposing (..)


-- VIEW

par : List String -> Html
par textLines = 
  p [ ] (textLines |> List.map text) 


-- WIRE IT TOGETHER

main : Html
main =
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
        ]
      ]
    ]
  ]
