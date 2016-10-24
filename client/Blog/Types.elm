module Blog.Types exposing (..)

import Blog.Api as Api


type alias Model =
    { route : Route
    , content : Backend
    , error : Maybe String
    }


type Backend
    = PostList (List Api.PostOverview)
    | SeriesPosts Api.PostSeries
    | PostDetail Api.BlogPost
    | BackendError String


type Frontend
    = SeePostList
    | SeePostDetail BlogPostId
    | SeeSeriesPostDetail BlogPostId SeriesId



-- frontend other:
-- | SeeSeriesList


type alias BlogPostId =
    Int


type alias SeriesId =
    Int


type Msg
    = NoOp
    | FromBackend Backend
    | FromFrontend Frontend
    | Error String


type Route
    = HomeRoute
    | PostDetailRoute BlogPostId
    | SeriesPostDetailRoute SeriesId BlogPostId