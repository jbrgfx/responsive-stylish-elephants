module Main exposing (..)

import Html exposing (..)
import Initialize
import Model exposing (..)
import Subscriptions
import Update
import View


main : Program Never Model Msg
main =
    Html.program
        { init = Initialize.init
        , view = View.view
        , update = Update.update
        , subscriptions = Subscriptions.subscriptions
        }
