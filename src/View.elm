module View exposing (view)

-- import AppStyles

import Element exposing (..)
import Html exposing (..)
import Html.Events exposing (onClick)
import Model exposing (..)


blockAttributes screenSize =
    case screenSize of
        Phone ->
            [ width (px 600), height (px 100) ]

        Tablet ->
            [ width (px 1200), height (px 100) ]

        Desktop ->
            [ width (px 1800), height (px 100) ]


wrapper : Model -> Element Msg
wrapper model =
    Element.row
        [ padding 4

        -- , paddingTop 4
        -- , paddingBottom 4
        , spacing 10
        ]
        [ pageArea model ]


pageArea : Model -> Element Msg
pageArea model =
    if model.screenSize == Phone then
        Element.column
            [ width (px 600) ]
            [ headerArea
            , phoneMenu -- show instead of sidebarArea
            , contentArea model
            , footerArea
            ]
    else
        Element.column
            [ width (px 1200) ]
            [ headerArea
            , contentArea model
            , footerArea
            ]


headerArea : Element Msg
headerArea =
    row
        []
        [ newTabLink
            []
            { url = "http://package.elm-lang.org/packages/mdgriffith/stylish-elephants/4.0.0"
            , label = Element.text "stylish-elephants 4.0.0: package docs"
            }
        ]


footerArea : Element msg
footerArea =
    row
        []
        [ newTabLink
            []
            { url = "https://github.com/jbrgfx"
            , label = Element.text "jbrgfx's github repos."
            }
        ]


sidebarTitle : Element msg
sidebarTitle =
    row
        [ padding 8 ]
        [ Element.text "External Links"
        ]


phoneMenuTitle : Element msg
phoneMenuTitle =
    row
        [ padding 6

        -- , paddingBottom 2
        ]
        [ Element.text "External Links »"
        ]


phoneMenu : Element msg
phoneMenu =
    row
        [ padding 2

        -- , paddingLeft 6
        ]
        [ -- phoneMenuTitle
          -- ,
          newTabLink
            []
            { url = "https://github.com/jbrgfx"
            , label = Element.text "jbrgfx's github repos."
            }

        -- , Element.link "https://becoming-functional.com/responsive-design-with-elm-style-elements-9d0eca8eb9ed" <|
        --     Element.description
        --         "Test-drive, part 2 | "
        -- , Element.link "https://www.dailydrip.com/topics/elm/drips/style-elements" <|
        --     Element.description
        --         "Daily Drip"
        ]


sidebarArea : Model -> Element Msg
sidebarArea model =
    if model.screenSize == Phone then
        Element.empty
    else
        row
            []
            [ -- elmlogo
              -- ,
              newTabLink
                []
                { url = "http://package.elm-lang.org/packages/mdgriffith/stylish-elephants/4.0.0"
                , label = Element.text "stylish-elephants 4.0.0: package docs"
                }
            ]


contentArea : Model -> Element Msg
contentArea model =
    Element.row
        []
        [ sidebarArea model
        , mainContentArea model
        ]



--bodyWidth : ScreenSize -▷ Element.Internal.Model.Attribute variation msg


bodyWidth screenSize =
    if screenSize == Phone then
        width (px 600)
    else
        width (px 1200)


blocks : Model -> List (Element Msg)
blocks model =
    List.map (\elem -> singleBlock model elem)
        [ "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F" ]


singleBlock : Model -> String -> Element Msg
singleBlock model value =
    el
        (blockAttributes model.screenSize)
        (Element.text value)


mainContentArea : Model -> Element Msg
mainContentArea model =
    Element.row
        [ padding 20, spacing 10, bodyWidth model.screenSize ]
        (blocks model)



--
-- view : Model -> Html Msg


view model =
    Element.layout [] <|
        wrapper model
