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

var ID = 0;

// set the view engine to ejs
app.set('view engine', 'ejs');
app.use(express.static(__dirname + '/'));//This line is necessary for us to use relative paths and access our resources directory



// Redirection because we're lazy
app.get('/', function(req,res){
  res.redirect('/home');
})


app.get('/share', function (req, res){
  res.render('share');
})

app.get('/login', function (req, res){
  res.render('login');
<<<<<<< HEAD
})

app.get('/create_account', function (req, res){
  res.render('createAccount');

})

=======
})

app.get('/create_account', function (req, res){
  res.render('createAccount');

})

>>>>>>> eded17218b385265e7fc7a83a12e4a51f37f5513


app.get('/home', function (req, res) {
  var query = "select * from networthinfo where userid = '" + ID + "';";
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


app.post('/create_account/add_user',function (req, res){

  var usr = req.body.username;
  var pass = req.body.password;
  var email_ = req.body.email;
  console.log(usr);
  console.log(pass);
  console.log(email_);

  //var user_query = 'SELECT * FROM userInfo;';
  var user_query = "SELECT username FROM userInfo WHERE username = '"+ usr + "';";
  var email_query = "SELECT email FROM userInfo where email = '" + email_ +"';";

  db.task('get-everything', task => {
    return task.batch([
      task.any(user_query),
      task.any(email_query)
      ]);
  })
  .then(info => {
    res.redirect('/create_account');
    console.log('it worked!!!!!!!!!!!!!!!!');
  })
  .catch(error => {
    res.redirect('/create_account');
    console.log('there was an error!!!');
})
})

app.post('/login/verify', function (req, res){
  var username = req.body.username;
  var password = req.body.password;
  var query = "SELECT username, password, userID FROM userInfo WHERE username = '" + username + "' AND password = '" + password + "';";
  db.any(query)
    .then(function (rows) { 
        if(rows.length == 1){
      ID = rows[0].userid;
      res.redirect('/home');
  }
  else{
    res.redirect('/login');
  }
})
})


/*
<<<<<<< HEAD
app.post('/create_account', function (req, res){
  // Retrive information from form
=======

app.post('/create_account', function (req, res){
  // Retrive information from form

>>>>>>> eded17218b385265e7fc7a83a12e4a51f37f5513
  var user = req.body.username;
  var pass = req.body.password;
  var email_ = req.body.email;
  
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
*/


app.listen(3000, function () {
  console.log('Example app listening on port 3000!')
})
