module View exposing (view)

-- import AppStyles

import Element exposing (..)
import Element.Border as Border exposing (..)
import Html exposing (..)
import Html.Events exposing (onClick)
import Model exposing (..)


blockAttributes screenSize =
    case screenSize of
        Phone ->
            [ Element.width (px 600), height (px 100) ]

        Tablet ->
            [ Element.width (px 1200), height (px 100) ]

        Desktop ->
            [ Element.width (px 1800), height (px 100) ]


wrapper : Model -> Element Msg
wrapper model =
    Element.row
        [ padding 4
        , alignLeft
        ]
        [ pageArea model ]


pageArea : Model -> Element Msg
pageArea model =
    if model.screenSize == Phone then
        Element.column
            [ Element.width (px 600)
            ]
            [ headerArea
            , phoneMenu -- show instead of sidebarArea
            , contentArea model
            , footerArea
            ]
    else
        Element.column
            []
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
            , label = Element.text "jbrgfx's github repos"
            }
        ]


sidebarTitle : Element msg
sidebarTitle =
    row
        [ padding 8 ]
        [ Element.text "Sidebar Links"
        ]


phoneMenuTitle : Element msg
phoneMenuTitle =
    row
        [ padding 6
        , paddingBottom 2
        ]
        [ Element.text "Phone Menu »"
        ]


phoneMenu : Element msg
phoneMenu =
    row
        [ padding 2
        , paddingLeft 6
        ]
        [ phoneMenuTitle
        , newTabLink
            []
            { url = "https://becoming-functional.com/responsive-design-with-elm-style-elements-9d0eca8eb9ed"
            , label = Element.text "Test-drive, part 2 | "
            }
        , newTabLink
            []
            { url = "https://www.dailydrip.com/topics/elm/drips/style-elements"
            , label = Element.text "Daily Drip"
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
            [ alignLeft
            , spacing 8
            ]
            [ sidebarTitle
            , newTabLink
                []
                { url = "https://becoming-functional.com/responsive-design-with-elm-style-elements-9d0eca8eb9ed"
                , label = Element.text "Test-drive, part 2 "
                }
            , newTabLink
                []
                { url = "https://www.dailydrip.com/topics/elm/drips/style-elements"
                , label = Element.text "Daily Drip"
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
        Element.width (px 600)
    else
        Element.width (px 800)


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
        [ bodyWidth model.screenSize ]
        (blocks model)



{- credit: https://github.com/opsb/cv-elm/blob/master/src/Extra/Element.elm -}


borderRight n =
    Border.widthEach { right = n, left = 0, top = 0, bottom = 0 }


borderBottom n =
    Border.widthEach { right = 0, left = 0, top = 0, bottom = n }



{- credit: https://github.com/opsb/cv-elm/blob/master/src/Extra/Element.elm -}


paddingRight n =
    paddingEach { right = n, left = 0, top = 0, bottom = 0 }


paddingTop n =
    paddingEach { bottom = 0, top = n, left = 0, right = 0 }



{- credit: https://github.com/opsb/cv-elm/blob/master/src/Extra/Element.elm -}


paddingBottom n =
    paddingEach { bottom = n, top = 0, left = 0, right = 0 }



{- credit: https://github.com/opsb/cv-elm/blob/master/src/Extra/Element.elm -}


paddingLeft n =
    paddingEach { right = 0, left = n, top = 0, bottom = 0 }



--
-- view : Model -> Html Msg


view model =
    Element.layout [] <|
        wrapper model
