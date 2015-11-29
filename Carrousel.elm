module Carrousel where

import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Mouse
import Html exposing (..)


view : Signal Html
view =
  Signal.map fromElement (Signal.map (scene (600,420)) Mouse.position)



scene : (Int,Int) -> (Int,Int) -> Element
scene (w,h) (x,y) =
  let
    (dx,dy) =
      (toFloat x - toFloat w / 2, toFloat h / 2 - toFloat y)
  in
    collage w h
      [ ngon 3 50
          |> filled blue
          |> rotate (atan2 dy dx)
      , ngon 6 30
          |> filled orange
          |> move (dx, dy)
      ]
