const express = require('express')
const app = express()
var alert = require('alert-node');


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
})

app.get('/create_account', function (req, res){
  res.render('createAccount');

})

app.get('/home', function (req, res) {
  var up1 = "UPDATE networthinfo Set totalAssets = ASSET.totA FROM (Select userID, sum(amount) totA from itemsEntered where type = 1 Group by userId) ASSET WHERE networthinfo.userID = ASSET.userID;";
  var up2 = "UPDATE networthinfo Set totalLiabilities = LIAB.totA FROM (Select userID, sum(amount) totA from itemsEntered where type = 0 Group by userId) LIAB WHERE networthinfo.userID = LIAB.userID;";
  var up3 = "UPDATE netWorthInfo SET netWorth = (totalAssets - totalLiabilities);";
  var query = "select * from networthinfo where userid = '" + ID + "';";
  db.task('get-everything',task => {
  return task.batch([
    task.any(up1),
    task.any(up2),
    task.any(up3),
    task.any(query)
  ]);
    })
    .then(function (rows) { 
        res.render('home',{
          my_title: "Home Page",
          data: rows[3]
      })
    })
    .catch(function (err) {
            // display error message in case an error
            //
            //alert('error');
            res.render('home', {
                title: 'Home Page Error',
                data: ''
            })
        })
})


app.get('/add', function (req, res){
  var query = "select * from itemsentered where userid = '" + ID + "';";
  db.any(query)
    .then(function (rows) { 
        res.render('Calculation',{
      my_title: "Add Page",
      data: rows
    })
  })
})



app.get('/edit', function (req, res){
  var query = "select * from itemsentered where userid = '" + ID + "';";
  db.any(query)
    .then(function (rows) { 
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

app.post('/add/commit', function (req, res){
  var name = req.body.names;
  var Asset = req.body.a;
  var Liab = req.body.s;
  var value = req.body.value;
  var cat = req.body.cat;
  var indic;
  if(Asset && Liab){
  alert('Cannot be both an Asset and a Liability');
  res.redirect('/add');
  }
  else if(Asset){
  indic = 1;
  }
  else if(Liab){
  indic = 0;
  }
  else{
  alert('Must be either an Asset or a Liability');
  res.redirect('/add');
  }
  
  if(isNaN(value)){
     alert('Value has to be a number');
     res.redirect('/add');
  }
  
  var query = "insert into itemsEntered (itemID, userID, name, category, type, amount) values ((Select max(itemID) + 1 from (select * from itemsEntered) a), '" + ID + "','" + name + "','" + cat + "','" + indic + "','" + value + "');"
  db.any(query);
  res.redirect('/add');
})


app.post('/edit/commit', function (req, res){
  var name = req.body.names;
  var amount = req.body.newV;

  var edit = "UPDATE itemsEntered Set amount = '" + amount + "' WHERE itemID = (SELECT itemID FROM itemsEntered WHERE name = '" + name + "');";
  var del = "Delete from itemsEntered where itemID = (SELECT itemID FROM itemsEntered WHERE name = '" + name + "');";


  if(isNaN(amount)){
     alert('Value has to be a number');
     res.redirect('/edit');
  }

  if(amount == 0){
  db.any(del);
  }
  else{
  db.any(edit);
  }
  res.redirect('/edit');
})

/*
app.post('/home/calc', function(req, res){
  var up1 = "UPDATE networthinfo Set totalAssets = ASSET.totA FROM (Select userID, sum(amount) totA from itemsEntered where type = 1 Group by userId) ASSET WHERE networthinfo.userID = ASSET.userID;";
  var up2 = "UPDATE networthinfo Set totalLiabilities = LIAB.totA FROM (Select userID, sum(amount) totA from itemsEntered where type = 0 Group by userId) LIAB WHERE networthinfo.userID = LIAB.userID;";
  var up3 = "UPDATE netWorthInfo SET netWorth = (totalAssets - totalLiabilities);";

  db.task('get-everything', task => {
  return task.batch([
    task.any(up1),
    task.any(up2),
    task.any(up3)
  ])
  })
  .then(info => {
  res.render('/home');
  console.log('hi');
  })
  .catch(error => {
  console.log('f');
  })
})*/
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
