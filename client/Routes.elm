module Routes exposing (..)

import String
import UrlParser exposing (Parser, parse, (</>), format, int, oneOf, s, string)
import Navigation exposing (Location)
import Html.Attributes exposing (href, attribute)
import Html exposing (Html, Attribute, a)
import Html.Events exposing (onWithOptions)
import Api exposing (..)
import Types exposing (..)
import RouteUrl exposing (HistoryEntry(..), UrlChange)
import Debug exposing (..)


delta2url : Model -> Model -> Maybe UrlChange
delta2url previous current =
    case previous.route == current.route of
        True ->
            Nothing

        False ->
            Just <| UrlChange NewEntry <| toUrl current.route


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ format PostDetailRoute (s "posts" </> int)
        , format SeriesPostDetailRoute (s "series" </> int </> s "posts" </> int)
        , format HomeRoute (s "")
        ]


fromUrl : Location -> Result String Route
fromUrl location =
    log "parsed location" <| parse identity routeParser (String.dropLeft 1 location.hash)


location2messages : Location -> List Msg
location2messages location =
    case fromUrl location of
        Ok route ->
            case log "fromUrl route" route of
                HomeRoute ->
                    [ FromFrontend SeePostList ]

                PostDetailRoute postId ->
                    [ FromFrontend <| SeePostDetail postId ]

                SeriesPostDetailRoute seriesId postId ->
                    [ FromFrontend <| SeeSeriesPostDetail postId seriesId ]

        Err error ->
            [ Error error ]


toUrl : Route -> String
toUrl route =
    case log "toUrl route" route of
        HomeRoute ->
            "#"

        PostDetailRoute postId ->
            "#posts/" ++ toString postId

        SeriesPostDetailRoute seriesId postId ->
            "#series/" ++ toString seriesId ++ "/posts/" ++ toString postId
