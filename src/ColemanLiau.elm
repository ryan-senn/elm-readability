module ColemanLiau exposing (Config, configFromText, score)

{-| Dale-Chall readability formula. See <https://en.wikipedia.org/wiki/Coleman-Liau_index>

@docs Config, configFromText, score

-}

import Utility


{-| Record that hold the required data to calculate a score.
-}
type alias Config =
    { words : Float
    , sentences : Float
    , letters : Float
    }


{-| Generate a Config record from a text string.
-}
configFromText : String -> Config
configFromText text =
    let
        wordCount =
            String.words text
                |> List.length
                |> toFloat

        sentenceCount =
            Utility.sentenceCount text
                |> toFloat

        letterCount =
            String.toList text
                |> List.filter Char.isAlpha
                |> List.length
                |> toFloat
    in
    Config wordCount sentenceCount letterCount


{-| Get the Coleman-Liau score for a Config record.
-}
score : Config -> Float
score { words, sentences, letters } =
    letterWeight * ((letters / words) * 100) - sentenceWeight * ((sentences / words) * 100) - base


letterWeight : Float
letterWeight =
    0.0588


sentenceWeight : Float
sentenceWeight =
    0.296


base : Float
base =
    15.8
