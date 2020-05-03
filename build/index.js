const fs = require('fs')
const daleChall = require('dale-chall')
const pluralize = require('pluralize')

words = daleChall.reduce((acc, word) => {
    plural = pluralize(word)

    return [...acc, ...[word, plural]]
}, [])

uniqueWords = [...new Set(words)]

const content =
    `module DaleChallList exposing (simpleWords)

simpleWords : List String
simpleWords =
    [${uniqueWords.map(word => ' "' + word + '"')} ]
`

fs.writeFile("../src/DaleChallList.elm", content, error => { });