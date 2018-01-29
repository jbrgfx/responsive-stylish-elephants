module Update exposing (update)

import Model exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        SetScreenSize size ->
            { model | screenSize = getScreenSize size } ! []


getScreenSize size =
    if size.width <= 800 then
        Phone
    else if size.width <= 1000 then
        Tablet
    else
        Desktop



-- else
--     BigDesktop
