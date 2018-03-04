csv = require 'csvdata'
ngram = require 'simplengrams'
natural = require('natural')
_ = require 'underscore'

fn  = (err,classifier) ->

    s = "voglio andare da milano a cologno monzese passando per segrate o cassano d'adda'"

    n1 = ngram s,1
    n2 = ngram s,2
    n3 = ngram s,3
    n4 = ngram s,4
    n5 = ngram s,5
    n6 = ngram s,6


    response = []
    for words in [n1,n2,n3,n4,n5,n6]
        for word in words
          response.push classifier.classify word


    console.log _.unique response


natural.BayesClassifier.load 'classifier.json', null,fn