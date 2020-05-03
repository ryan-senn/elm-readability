module DaleChallTest exposing (suite)

import DaleChall
import Expect exposing (Expectation)
import Test exposing (..)


suite : Test
suite =
    describe "Test ColemanLiau module"
        [ test "test config score" config
        , test "test text to config" text
        ]


config : () -> Expectation
config _ =
    { words = 87, difficultWords = 32, sentences = 2 }
        |> DaleChall.score
        |> Expect.within (Expect.Absolute 0.000000001) 11.601916091954022


text : () -> Expectation
text _ =
    """
Homebuyers will be able to inspect properties and attend on site auctions from next weekend as the state government ditches another coronavirus restriction in its bid to kickstart the economy.

Almost six weeks since Prime Minister Scott Morrison announced real estate auctions and open houses were banned as part of a national cabinet crackdown on gatherings, Treasurer Dominic Perrottet and Health Minister Brad Hazzard have agreed the health measure could be wound back in response to the ongoing low number of corona virus cases in the state.
    """
        |> DaleChall.configFromText
        |> Expect.equal { words = 87, difficultWords = 32, sentences = 2 }
