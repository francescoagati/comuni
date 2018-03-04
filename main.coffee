csv = require 'csvdata'
Sequelize = require 'sequelize'
natural = require('natural')
normalization = require 'normalization'
ngram = require 'simplengrams'
_ = require 'underscore'
bravey = require 'bravey'


date_reg = new bravey.Language.IT.DateEntityRecognizer("test")
time_reg = new bravey.Language.IT.TimeEntityRecognizer("test")
PorterStemmerIt = require('./node_modules/natural/lib/natural/stemmers/porter_stemmer_it');
load_data = ->
    data = await csv.load './comuni.csv'
  

    content = for el in data 
        normalization el.input

    store = content

    s = normalization "devo partire domani alle 15 per roma e dopodomani devo prendere un treno per napoli alle 18"

    n1 = ngram s,1
    n2 = ngram s,2
    n3 = ngram s,3
    n4 = ngram s,4
    n5 = ngram s,5
    n6 = ngram s,6


    response = []
    for words in [n1,n2,n3,n4]
        for word in words
          for el in store when el.indexOf(word.join(" ")) == 0 && word.join(" ").length > 3
            response.push [el,word.join(" ")]

    distinct = _.unique response
    
    console.log (words for words in response when words[0] is words[1]) 
    console.log date_reg.getEntities s
    console.log time_reg.getEntities s
#   classifier = new natural.BayesClassifier()

#   for el in data
#     console.log el
#     classifier.addDocument el.input.toLowerCase(),el.input.toLowerCase()

#   classifier.train()

#   classifier.save 'classifier.json', (err, classifier) ->
#     console.log 'the end'

load_data()



  