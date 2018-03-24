var levelup = require('levelup')
var leveldown = require('leveldown')
var csv = require('csvdata');
const slugify = require('slugify')
const ngram = require('simplengrams')
// 1) Create our store
var db = levelup(leveldown('./mydb'))

// 2) Put a key & value
db.put('name', 'levelup', function (err) {
    if (err) return console.log('Ooops!', err) // some kind of I/O error

    // 3) Fetch by key
    db.get('name', function (err, value) {
        if (err) return console.log('Ooops!', err) // likely the key was not found

        // Ta da!
        console.log('name=' + value)
    })
})


var load_data;


load_data = async function () {
    var data;
    data = (await csv.load('./comuni.csv'));
    return data
};

(async function () {

    let data = await load_data();
    data.forEach((el) => {


        db.put(el.input.toLowerCase(), slugify(el.input.toLowerCase()))

        db.put('da ' + el.input.toLowerCase(), 'from:' + slugify(el.input.toLowerCase()))
        db.put('a ' + el.input.toLowerCase(), 'to:' + slugify(el.input.toLowerCase()))
        db.put('per ' + el.input.toLowerCase(), 'from:' + slugify(el.input.toLowerCase()))
        db.put('verso ' + el.input.toLowerCase(), 'from:' + slugify(el.input.toLowerCase()))


    })

    //data.forEach((el) => console.log(slugify(el.input)) )


    //data.forEach( el => db.get(el.input, response => console.log(response) ))

    //console.log(data)

})()