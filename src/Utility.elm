module Utility exposing (sentenceCount)

{-| Utility

@docs sentenceCount

-}

import Regex


{-| Count the number of sentences in a text string.
-}
sentenceCount : String -> Int
sentenceCount text =
    let
        mRegex =
            Regex.fromString "([^ \u{000D}\n][^!?\\.\u{000D}\n]+[\\w!?\\.]+)"
    in
    Maybe.map (\regex -> Regex.find regex text |> List.length) mRegex |> Maybe.withDefault 0
