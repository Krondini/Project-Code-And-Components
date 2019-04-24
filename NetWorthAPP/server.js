const express = require('express')
const app = express()


app.use(express.static('public'));
app.set('view engine', 'ejs');
var pgp = require('pg-promise')();

var bodyParser = require('body-parser'); //Ensure our body-parser tool has been added
app.use(bodyParser.json());              // support json encoded bodies
app.use(bodyParser.urlencoded({ extended: true })); // support encoded bodies

var popup = require('popups');


const dbConfig = {
  host: 'localhost',
  port: 5432,
  database: 'net_worth_db',
  user: 'postgres',
  password: 'XIAOxiao1998!'
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
  var query = "select * from itemsentered where userid = '"+ ID +"';";
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
  var query = "select * from itemsentered where userid = '"+ ID +"';";
  db.any(query)
    .then(function (rows) { 
  console.log(rows)
        res.render('edit',{
      my_title: "edit Page",
      data: rows
    })
  })
})


// helper functions that work with database
class table {
  static storeAccount (use,pas,ema,repas){
    return new Promise( (resolve, reject) => {
      if(repas != pas){
        const error = new Error('repet passord does not match');
        return reject(error);
      }
      if(use.length > 64){
        const error = new Error('Username is too long');
        return reject(error);
      }
      if(pas.length > 64){
        const error = new Error('Password is too long');
        return reject(error);
      }
      var q = "insert into userInfo (userID, firstName, lastName, username, password, email) values( (Select max(userID) + 1 from (select * from userInfo) a),'NA', 'NA', $1, $2, $3)"
      db.none(
        q,
        [use, pas, ema]
      );
      resolve();
    });
  }
}

var username = '';


app.post('/create_account/add_user',function (req, res){

  var usr = req.body.username;
  var pass = req.body.password;
  var email_ = req.body.email;
  var repas = req.body.repassword;
  console.log(usr);
  console.log(pass);
  console.log(email_);
  console.log(repas);

  //var user_query = 'SELECT * FROM userInfo;';
  var user_query = "SELECT username FROM userInfo WHERE username = '"+ usr + "';";
  var email_query = "SELECT email FROM userInfo where email = '" + email_ +"';";

  db.task('get-everything', task => {
    return task.batch([
      task.none(user_query),
      task.none(email_query)
      ]);
  })
  .then(info => {
    return table.storeAccount(usr, pass, email_, repas);
  })
  .then( () => {
   
    res.redirect('/home');
    console.log('it worked!!!!!!!!!!!!!!!!');
    
  })
  .catch(error => {
    res.redirect('/create_account');
    popup.alert({content: 'Username or Email is already exist'});
    console.log('there is an error');
    throw (error);
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
