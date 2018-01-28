module View exposing (view)

-- import AppStyles

import Element exposing (..)
import Element.Attributes exposing (..)
import Html exposing (..)
import Html.Events exposing (onClick)
import Model exposing (..)


blockAttributes screenSize =
    case screenSize of
        Phone ->
            [ width (percent 100), height (px 100) ]

        Tablet ->
            [ width (percent 50), height (px 100) ]

        Desktop ->
            [ width (percent 33), height (px 100) ]

        BigDesktop ->
            [ width (percent 25), height (px 100) ]


wrapper : Model -> Element AppStyles.MyStyles variation Msg
wrapper model =
    Element.row AppStyles.PageStyle
        [ padding 4
        , paddingTop 4
        , paddingBottom 4
        , spacing 10
        ]
        [ pageArea model ]


pageArea : Model -> Element AppStyles.MyStyles variation Msg
pageArea model =
    if model.screenSize == Phone then
        Element.column AppStyles.PageStyle
            [ width (percent 100) ]
            [ headerArea
            , phoneMenu -- show instead of sidebarArea
            , contentArea model
            , footerArea
            ]
    else
        Element.column AppStyles.PageStyle
            [ width (percent 100) ]
            [ headerArea
            , contentArea model
            , footerArea
            ]


headerArea : Element AppStyles.MyStyles variation Msg
headerArea =
    el AppStyles.HeaderStyle
        [ paddingLeft 12
        , paddingTop 8
        , paddingBottom 8
        ]
        (Element.newTab
            "http://package.elm-lang.org/packages/mdgriffith/style-elements/4.2.1/"
         <|
            Element.text "λ style-element docs"
        )


footerArea : Element AppStyles.MyStyles variation msg
footerArea =
    el AppStyles.FooterStyle
        [ paddingLeft 12
        , paddingTop 8
        , paddingBottom 8
        ]
        (Element.newTab "https://github.com/mdgriffith/style-elements/" <|
            Element.text "λ github source"
        )


sidebarTitle : Element AppStyles.MyStyles variation msg
sidebarTitle =
    row AppStyles.SidebarTitleStyle
        [ paddingBottom 8 ]
        [ Element.text "External Links"
        ]


phoneMenuTitle : Element AppStyles.MyStyles variation msg
phoneMenuTitle =
    row AppStyles.PhoneMenuTitleStyle
        [ paddingLeft 6
        , paddingBottom 2
        ]
        [ Element.text "External Links »"
        ]


phoneMenu : Element AppStyles.MyStyles variation msg
phoneMenu =
    wrappedRow AppStyles.PhoneMenuStyle
        [ paddingTop 2
        , paddingLeft 6
        ]
        [ phoneMenuTitle
        , Element.link "https://becoming-functional.com/test-driving-the-elm-style-elements-library-7e7771c4159a" <|
            Element.text "Test-drive, part 1 | "
        , Element.link "https://becoming-functional.com/responsive-design-with-elm-style-elements-9d0eca8eb9ed" <|
            Element.text
                "Test-drive, part 2 | "
        , Element.link "https://www.dailydrip.com/topics/elm/drips/style-elements" <|
            Element.text
                "Daily Drip"
        ]


sidebarArea : Model -> Element AppStyles.MyStyles variation Msg
sidebarArea model =
    if model.screenSize == Phone then
        Element.empty
    else
        Element.column AppStyles.SidebarStyle
            [ paddingLeft 12
            , paddingTop 20
            , width (percent 20)
            ]
            [ sidebarTitle
            , Element.text "■ Tutorials ■"
            , Element.newTab "https://becoming-functional.com/test-driving-the-elm-style-elements-library-7e7771c4159a" <|
                Element.text
                    "   » Test-drive, part 1"
            , Element.newTab "https://becoming-functional.com/responsive-design-with-elm-style-elements-9d0eca8eb9ed" <|
                Element.text
                    "   » Test-drive, part 2"
            , Element.newTab "https://www.dailydrip.com/topics/elm/drips/style-elements" <|
                Element.text
                    "   » Daily Drip"
            , Element.text "■ Api Docs ■"
            , Element.newTab "http://package.elm-lang.org/packages/mdgriffith/style-elements/4.2.1/" <|
                Element.text
                    "   » Package"
            , Element.newTab "http://package.elm-lang.org/packages/mdgriffith/style-elements/4.2.1/Element#image" <|
                Element.text
                    "   » Image"
            , Element.newTab "http://package.elm-lang.org/packages/mdgriffith/style-elements/4.2.1/Element#navigation" <|
                Element.text
                    "   » Navigation"
            , Element.newTab "http://package.elm-lang.org/packages/mdgriffith/style-elements/4.2.1/Element#link" <|
                Element.text
                    "   » Link"
            , Element.newTab "http://package.elm-lang.org/packages/mdgriffith/style-elements/4.2.1/Element#newTab" <|
                Element.text
                    "   » newTab"
            , Element.newTab "https://mdgriffith.gitbooks.io/style-elements/content/" <|
                Element.text
                    "   » Git Book"
            , Element.text "■ Video ■"
            , Element.newTab "https://www.youtube.com/watch?v=NYb2GDWMIm0" <|
                Element.text
                    "   » Elm Europe 2017"
            , Element.newTab "https://docs.google.com/presentation/d/1s7VPbvuv6m9-S7ePm0R5loqRnHsZEHHVbZALJpWAARo/edit#slide=id.g1f5f3b47d0_0_684" <|
                Element.text
                    "   » Author's slides"
            ]


contentArea : Model -> Element AppStyles.MyStyles variation Msg
contentArea model =
    Element.row AppStyles.ContentStyle
        []
        [ sidebarArea model
        , mainContentArea model
        ]



--bodyWidth : ScreenSize -▷ Element.Internal.Model.Attribute variation msg


bodyWidth screenSize =
    if screenSize == Phone then
        width (percent 100)
    else
        width (percent 80)


blocks : Model -> List (Element AppStyles.MyStyles variation Msg)
blocks model =
    List.map (\elem -> singleBlock model elem)
        [ "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F" ]


singleBlock : Model -> String -> Element AppStyles.MyStyles variation Msg
singleBlock model value =
    el AppStyles.BlockStyle
        (blockAttributes model.screenSize)
        (Element.text value)


mainContentArea : Model -> Element AppStyles.MyStyles variation Msg
mainContentArea model =
    Element.wrappedRow AppStyles.BodyStyle
        [ padding 20, spacing 10, bodyWidth model.screenSize ]
        (blocks model)


view : Model -> Html Msg
view model =
    Element.layout AppStyles.stylesheet <|
        wrapper model
