module View exposing (view)

import Color exposing (..)
import Element exposing (..)
import Element.Background as Background exposing (..)
import Element.Border as Border exposing (..)
import Element.Font as Font exposing (..)
import Html exposing (..)
import Model exposing (..)


blockAttributes screenSize =
    case screenSize of
        Phone ->
            [ Element.width (px 800)
            ]

        Tablet ->
            [ Element.width (px 1000)
            ]

        Desktop ->
            [ Element.width (px 1200)
            ]


wrapper : Model -> Element Msg
wrapper model =
    Element.column
        []
        [ pageArea model ]


pageArea : Model -> Element Msg
pageArea model =
    if model.screenSize == Phone then
        Element.column
            [ Element.alignLeft
            ]
            [ headerArea
            , phoneMenu -- show instead of sidebarArea
            , contentArea model
            , aboutExperiment
            , footerArea
            ]
    else
        Element.column
            [ Element.alignTop
            , paddingRight gutter
            , spaceEvenly
            ]
            [ headerArea
            , contentArea
                model
            , aboutExperiment
            , footerArea
            ]


headerArea : Element Msg
headerArea =
    row
        [ Element.alignLeft ]
        [ newTabLink
            [ Element.alignLeft ]
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
        [ padding 8
        ]
        [ Element.text "Sidebar Links"
        ]


phoneMenuTitle : Element msg
phoneMenuTitle =
    column
        [ paddingLeft 0
        ]
        [ Element.text "Phone Menu »"
        ]


phoneMenu : Element msg
phoneMenu =
    row
        [ Element.alignLeft ]
        [ phoneMenuTitle
        , newTabLink
            [ Font.underline
            , Font.color Color.white
            , Background.color Color.darkBlue
            , spacingXY 10 0
            ]
            { url = "https://becoming-functional.com/responsive-design-with-elm-style-elements-9d0eca8eb9ed"
            , label = Element.text "Test-drive Article"
            }
        , newTabLink
            [ Font.underline
            , Font.color Color.white
            , Background.color Color.darkBlue
            , spacingXY 10 0
            ]
            { url = "https://github.com/billperegoy/elm-page-layout"
            , label = Element.text "elm-page-layout"
            }
        ]


sidebarArea : Model -> Element Msg
sidebarArea model =
    if model.screenSize == Phone then
        Element.empty
    else
        column
            [ Border.solid
            , Border.width 1
            , Element.alignLeft
            , Element.width (px 200)
            , Element.height (px 87)
            , Font.size 16
            , paddingRight 10
            ]
            [ sidebarTitle
            , row
                [ Element.width (px 110)
                , Element.alignRight
                , Font.underline
                , Font.color Color.blue
                ]
                [ newTabLink
                    []
                    { url = "https://becoming-functional.com/responsive-design-with-elm-style-elements-9d0eca8eb9ed"
                    , label = Element.text "Test-drive Article"
                    }
                ]
            , row
                [ Element.width (px 110)
                , Element.alignRight
                , Font.underline
                , Font.color Color.blue
                ]
                [ newTabLink
                    -- , newTabLink
                    []
                    { url = "https://github.com/billperegoy/elm-page-layout"
                    , label = Element.text "elm-page-layout"
                    }
                ]
            ]


contentArea : Model -> Element Msg
contentArea model =
    row
        [ padding gutter ]
        [ sidebarArea model
        , column
            [ Element.padding 8
            , Element.alignLeft
            , Border.solid
            , Border.width 1
            , Element.width (px 400)

            -- , Element.height (px 100)
            ]
            [ mainContentArea model
            ]
        ]


bodyWidth screenSize =
    if screenSize == Phone then
        Element.width (px 600)
    else if screenSize == Tablet then
        Element.width (px 800)
    else
        Element.width (px 1000)


type alias Person =
    { firstName : String
    , lastName : String
    }


persons : List Person
persons =
    [ { firstName = "David"
      , lastName = "Bowie"
      }
    , { firstName = "Florence"
      , lastName = "Welch"
      }
    ]


mainContentArea : Model -> Element Msg
mainContentArea model =
    Element.table
        []
        { data = persons
        , columns =
            [ { header = Element.text "First Name"
              , view =
                    \person ->
                        Element.text person.firstName
              }
            , { header = Element.text "Last Name"
              , view =
                    \person ->
                        Element.text person.lastName
              }
            ]
        }


aboutExperiment =
    paragraph
        [ paddingBottom 20
        , Font.size 14
        ]
        [ Element.text "This refactoring of https://github.com/billperegoy/elm-page-layout is an experiment in converting a style-elements 4.2.1. project into one that uses the stylish-elephants 4.0.0 (the next version of style-elements)." ]


gutter =
    20



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


view : Model -> Html Msg
view model =
    Element.layout
        [ Background.color white
        , padding gutter
        , spacing gutter
        ]
    <|
        wrapper model
