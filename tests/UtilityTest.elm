module UtilityTest exposing (suite)

import Expect exposing (Expectation)
import Test exposing (..)
import Utility


suite : Test
suite =
    describe "Test Utility module"
        [ test "Test sentence start" incompleteSentence
        , test "Test 3 sentences" threeSentences
        , test "Test multiline text" multilineText
        , test "Test punctuation" punctuation
        ]


incompleteSentence : () -> Expectation
incompleteSentence _ =
    "The green tree"
        |> Utility.sentenceCount
        |> Expect.equal 1


threeSentences : () -> Expectation
threeSentences _ =
    "The green tree is beautiful. Birds are nesting in its branches. Hakuna Matata."
        |> Utility.sentenceCount
        |> Expect.equal 3


multilineText : () -> Expectation
multilineText _ =
    """
    The green tree is beautiful.
    
    Birds are nesting in its branches. Hakuna Matata.


    Nice multiline text m8.
    """
        |> Utility.sentenceCount
        |> Expect.equal 4


punctuation : () -> Expectation
punctuation _ =
    """
    The green tree is beautiful!
    
    Birds are nesting in its branches? Hakuna Matata.

    Yes indeed!
    """
        |> Utility.sentenceCount
        |> Expect.equal 4
