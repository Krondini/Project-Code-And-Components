const express = require('express')
const app = express()


app.use(express.static('public'));
app.set('view engine', 'ejs');
var pgp = require('pg-promise')();

var bodyParser = require('body-parser'); //Ensure our body-parser tool has been added
app.use(bodyParser.json());              // support json encoded bodies
app.use(bodyParser.urlencoded({ extended: true })); // support encoded bodies

const dbConfig = {
  host: 'localhost',
  port: 5432,
  database: 'net_worth_db',
  user: 'postgres',
  password: 'pass'
};

var db = pgp(dbConfig);

// set the view engine to ejs
app.set('view engine', 'ejs');
app.use(express.static(__dirname + '/'));//This line is necessary for us to use relative paths and access our resources directory



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
            req.flash('error', err);
            res.render('home', {
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
	// Retrive information from form

	var user = req.body.username;
	var	pass = req.body.password;
	var	email_ = req.body.email;
	
	// Retrive possible queries
	var user_query = 'SELECT username FROM userInfo WHERE username = user;';
		email_query = 'SELECT email FROM userInfo WHERE email = email_;';
	
	// Compare form info to queries
	// If info does match anything in DB
	// Send an alert and repromt form
	db.task('get-everything', task => {
		return task.batch([
			task.any(user_query),
			task.any(email_query)
			]);
	})
	.then(function (user, pass, email_) {
		if (user == user_query)
		{
			alert('This username is already taken');
			res.render('create_account');
		} 
		else if(email_ == email_query)
		{
			alert('This email address is already taken');
			res.render('create_account');
		}
		else{
			alert('Account created!');
		}
	})
	.catch(function (err){
		req.flash('Error', err);
		res.redirect('/home');
	});
});



app.get('/share', function (req, res){
  res.render('share');
})

app.get('/login', function (req, res){
  res.render('login');
})

app.listen(3000, function () {
  console.log('Example app listening on port 3000!')
})