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
        [ Font.size 14 ]
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
        , Element.width fill
        ]
        [ Element.text "Phone Menu »"
        ]


phoneMenu : Element msg
phoneMenu =
    row
        [ Font.size 12 ]
        [ phoneMenuTitle
        , newTabLink
            [ Font.underline
            , Font.color Color.white
            , Background.color Color.darkBlue
            ]
            { url = "https://becoming-functional.com/responsive-design-with-elm-style-elements-9d0eca8eb9ed"
            , label = Element.text "Test-drive Article |"
            }
        , newTabLink
            [ Font.underline
            , Font.color Color.white
            , Background.color Color.darkBlue
            ]
            { url = "https://github.com/billperegoy/elm-page-layout"
            , label = Element.text " elm-page-layout |"
            }
        , newTabLink
            [ Font.underline
            , Font.color Color.white
            , Background.color Color.darkBlue
            ]
            { url = "https://github.com/lucamug/elm-spa-boilerplate"
            , label = Element.text " elm-spa-boilerplate"
            }
        ]


sidebarArea : Model -> Element Msg
sidebarArea model =
    if model.screenSize == Phone then
        Element.empty
    else
        column
            [ Element.alignLeft
            , Element.width (px 180)
            , Element.height (px 110)
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
            , row
                [ Element.width (px 110)
                , Element.alignRight
                , Font.underline
                , Font.color Color.blue
                ]
                [ newTabLink
                    -- , newTabLink
                    []
                    { url = "https://github.com/lucamug/elm-spa-boilerplate"
                    , label = Element.text "elm-spa-boilerplate"
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
            , Element.width (px 450)
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
    , middleName : String
    , lastName : String
    }


persons : List Person
persons =
    [ { firstName = "David"
      , middleName = "Robert"
      , lastName = "Bowie"
      }
    , { firstName = "Florence"
      , middleName = "Leontine Mary"
      , lastName = "Welch"
      }
    ]



-- mainContentArea : Model -> Element Msg


mainContentArea model =
    {- Credit lucamug for the code below (shared via elm-lang-slack ) -}
    indexedTable attrCont
        { data = persons
        , columns =
            [ { header =
                    --         el (Element.width fill :: attrA) <|
                    --             Element.text "Index"
                    --   , view =
                    --         \index persons ->
                    --             el (alternateCellAttr index) <|
                    --                 Element.text <|
                    --                     toString index
                    --   }
                    -- , { header =
                    el (Element.width fill :: attrA) <|
                        Element.text "First Name"
              , view =
                    \index persons ->
                        el (alternateCellAttr index) <|
                            Element.text persons.firstName
              }
            , { header =
                    el (Element.width fill :: attrA) <|
                        Element.text "Middle Name"
              , view =
                    \index persons ->
                        el (alternateCellAttr index) <|
                            Element.text persons.middleName
              }
            , { header =
                    el (Element.width fill :: attrA) <|
                        Element.text "Last Name"
              , view =
                    \index persons ->
                        el (alternateCellAttr index) <|
                            Element.text persons.lastName
              }
            ]
        }


attrBackground : List (Element.Attribute msg)
attrBackground =
    [ Background.color darkCharcoal

    -- Background.color <| rgb 0x65 0x8D 0xB5
    , Font.color white
    ]


attrCont : List (Element.Attribute msg)
attrCont =
    [ padding 1
    , spacing 1
    ]
        ++ attrBackground


attrA : List (Element.Attribute msg)
attrA =
    [ Background.color <| rgb 0xD1 0xE5 0xFA
    , Font.color black
    , padding 1
    ]


attrB : List (Element.Attribute msg)
attrB =
    [ Background.color white
    , Font.color black
    , padding 1
    ]


attrC : List (Element.Attribute msg)
attrC =
    [ Background.color darkBlue
    , Font.color white
    , padding 1
    ]


alternateCellAttr : Int -> List (Element.Attribute msg)
alternateCellAttr index =
    if index % 2 == 0 then
        Element.width fill :: attrC
    else
        Element.width fill :: attrB



{- Credit lucamug for the code above (shared via elm-lang-slack ) -}


aboutExperiment =
    paragraph
        [ paddingBottom 20
        , Font.size 14
        ]
        [ Element.text "This refactoring of https://github.com/billperegoy/elm-page-layout is an experiment in converting a style-elements 4.2.1. project into one that uses the stylish-elephants 4.0.0 (the next version of style-elements). Thanks to lucamug for adding an example of alterate row colors using indexedTable in his source: https://github.com/lucamug/elm-spa-boilerplate/blob/master/src/Pages/Examples.elm#L314,L319." ]


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
