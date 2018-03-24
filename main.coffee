levelup = require('levelup')
leveldown = require('leveldown')

csv = require 'csvdata'
#Sequelize = require 'sequelize'
#natural = require('natural')
normalization = require 'normalization'
ngram = require 'simplengrams'
_ = require 'underscore'
bravey = require 'bravey'


db = levelup(leveldown('./mydb'))

get = (key) -> new Promise (resolve) -> db.get key, (err, response) -> resolve "" + response


date_reg = new bravey.Language.IT.DateEntityRecognizer("test")
time_reg = new bravey.Language.IT.TimeEntityRecognizer("test")
#PorterStemmerIt = require('./node_modules/natural/lib/natural/stemmers/porter_stemmer_it');
load_data = ->
    #data = await csv.load './comuni.csv'

    #content =  (normalization el.input for el in data) 
    #store = content

    #s = normalization "devo partire domani alle 15 per trepalle e dopodomani devo prendere un treno per napoli alle 18"

    s = normalization "vorrei prenotare un treno per latina che passa per bologna che parte il 10 marzo alle 20"


    n1 = ngram s,1
    n2 = ngram s,2
    n3 = ngram s,3
    n4 = ngram s,4
    n5 = ngram s,5
    n6 = ngram s,6


    response = []
    for words in [n1, n2, n3, n4]
        for word in words
          word_join = word.join " "
          
          #console.log await get word_join
          
          if word_join.length > 3 and await get(word_join) isnt undefined
            response.push [await get(word_join), word_join]
          #for el in store when el.indexOf(word_join) is 0 && word_join.length > 3
          #  response.push [el,word_join]

    distinct = _.unique response
    
    console.log distinct

    for words in distinct when words[0] is words[1] 
        s = s.replace words[0],"#{words[1]}[#{words[0]}]"

    for entity in date_reg.getEntities s
        s = s.replace entity.string,"#{entity.string}[#{entity.value}]" 

    for entity in time_reg.getEntities s
        console.log entity
        s = s.replace entity.string,"#{entity.string}[#{entity.value}]" 


    console.log s

    #console.log (words for words in response when words[0] is words[1]) 
    #console.log date_reg.getEntities s
    #console.log time_reg.getEntities s
#   classifier = new natural.BayesClassifier()

#   for el in data
#     console.log el
#     classifier.addDocument el.input.toLowerCase(),el.input.toLowerCase()

#   classifier.train()

#   classifier.save 'classifier.json', (err, classifier) ->
#     console.log 'the end'

load_data()



  