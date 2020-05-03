module DaleChall exposing (Config, configFromText, score, gradeLevel)

{-| Dale-Chall readability formula. See <https://en.wikipedia.org/wiki/Dale-Chall_readability_formula>

@docs Config, configFromText, score, gradeLevel

-}

import DaleChallList exposing (simpleWords)
import Utility


{-| Record that hold the required data to calculate a score.
-}
type alias Config =
    { words : Float
    , difficultWords : Float
    , sentences : Float
    }


{-| Generate a Config record from a text string.
-}
configFromText : String -> Config
configFromText text =
    let
        words =
            text
                |> String.toLower
                |> String.words
                |> List.foldl (\word acc -> acc ++ String.split "-" word) []

        wordCount =
            List.length words |> toFloat

        difficultWordCount =
            words
                |> List.filter difficultWordFilter
                |> List.length
                |> toFloat

        sentenceCount =
            Utility.sentenceCount text |> toFloat
    in
    Config wordCount difficultWordCount sentenceCount


{-| Get the Dale-Chall score for a Config record.
-}
score : Config -> Float
score { words, difficultWords, sentences } =
    let
        difficultWordRatio =
            difficultWords / words

        score_ =
            difficultWordWeight * difficultWordRatio * 100 + (wordWeight * words) / sentences
    in
    if difficultWordRatio > difficultWordThreshold then
        score_ + adjustment

    else
        score_


{-| Get the grade level for a Dale-Chall score.
-}
gradeLevel : Float -> String
gradeLevel score_ =
    if score_ <= 4.9 then
        "4th-grade student or lower"

    else if score_ >= 5.0 && score_ <= 5.9 then
        "5th or 6th-grade student"

    else if score_ >= 6.0 && score_ <= 6.9 then
        "7th or 8th-grade student"

    else if score_ >= 7.0 && score_ <= 7.9 then
        "9th or 10th-grade student"

    else if score_ >= 8.0 && score_ <= 8.9 then
        "11th or 12th-grade student"

    else
        "13th to 15th-grade (college) student"


difficultWordFilter : String -> Bool
difficultWordFilter word =
    let
        word_ =
            word
                |> String.toList
                |> List.filter Char.isAlpha
                |> String.fromList
    in
    not (word_ == "") && not (List.member word_ simpleWords)


difficultWordWeight : Float
difficultWordWeight =
    0.1579


wordWeight : Float
wordWeight =
    0.0496


difficultWordThreshold : Float
difficultWordThreshold =
    0.05


adjustment : Float
adjustment =
    3.6365
