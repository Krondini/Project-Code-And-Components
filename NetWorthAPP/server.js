const express = require('express')
const app = express()


app.use(express.static('public'));
app.set('view engine', 'ejs');
var pgp = require('pg-promise')();

const dbConfig = {
  host: 'localhost',
  port: 5432,
  database: 'net_worth_db',
  user: 'postgres',
  password: 'pass'
};

var db = pgp(dbConfig);


// Redirection because we're lazy
app.get('/', function(req,res){
	res.redirect('/home');
})

app.get('/home', function (req, res) {
  var query = "select * from networthinfo where userid = '1';";
  db.any(query)
    .then(function (rows) { 
  console.log(rows)
        res.render('home',{
      my_title: "Home Page",
      data: rows
    })
        })
  .catch(function (err) {
            // display error message in case an error
            request.flash('error', err);
            response.render('home', {
                title: 'Home Page Error',
                data: ''
            })
        })
})

app.get('/add', function (req, res){
  var query = "select * from itemsentered where userid = '1';";
  db.any(query)
    .then(function (rows) { 
  console.log(rows)
        res.render('Calculation',{
      my_title: "Add Page",
      data: rows
    })
  })
})

app.get('/edit', function (req, res){
  var query = "select * from itemsentered where userid = '1';";
  db.any(query)
    .then(function (rows) { 
  console.log(rows)
        res.render('edit',{
      my_title: "edit Page",
      data: rows
    })
  })
})

app.get('/create_account', function (req, res){
	res.render('createAccount');

})

app.post('/create_account', function (req, res){
	var user = req.body.username,
		pass = req.body.password,
		email = req.body.email;
	
})

app.get('/share', function (req, res){
  res.render('share');
})

app.get('/login', function (req, res){
  res.render('login');
})

app.listen(3000, function () {
  console.log('Example app listening on port 3000!')
})