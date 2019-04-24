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
    static storeAccount (use,pas,ema,repas, first, last){
      return new Promise( (resolve, reject) => {
        var re = /\S+@\S+\.\S+/;
        if(!use || !pas || !ema || !repas || !first || !last){
          const error = new Error('Please enter all box');
          return reject(error);
        }
        if(!re.test(ema)){
          const error = new Error('The email is invalid');
          return reject(error);
        }
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
        var q = "insert into userInfo (userID, firstName, lastName, username, password, email) values( (Select max(userID) + 1 from (select * from userInfo) a),$4, $5, $1, $2, $3)"
        db.none(
          q,
          [use, pas, ema,first, first, last]
        );
        resolve();
      });
    }
  }

app.post('/create_account/add_user',function (req, res){
  var first = req.body.first;
  var last = req.body.last
  var usr = req.body.username;
  var pass = req.body.password;
  var email_ = req.body.email;
  var repas = req.body.repassword;
  console.log(usr);
  console.log(pass);
  console.log(email_);
  console.log(repas);
  console.log(first);
  console.log(last);


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
    return table.storeAccount( usr, pass, email_, repas, first, last );
  })
  .then( () => {
    var query = "SELECT username, password, userID FROM userInfo WHERE username = '" + usr + "' AND password = '" + pass + "';";
      return db.any(query);
  })
  .then(rows => {
    if(rows.length == 1){
      ID = rows[0].userid;
      res.redirect('/home');
    }
    else{
      res.redirect('/login');
    }
  })
  .catch(error => {
    res.redirect('/create_account');
    //popup.alert({content: 'Username or Email is already exist'});
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
          console.log(ID);
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






















app.get('/share', function (req, res){
  res.render('share',{
    failed : false
  })
})







app.post('/share', function (req, res){

  var selector1 = null;
  var selector2 = null;
  var selector3 = null;

  if (req.body.selector1 != undefined)
  {
    selector1 = req.body.selector1;
  }

  if (req.body.selector2 != undefined)
  {
    selector2 = req.body.selector2;
  }

  if (req.body.selector3 != undefined)
  {
    selector3 = req.body.selector3;
  }

//install nodemailer first
//enter: npm install nodemailer  

    var nodemailer = require('nodemailer'); 

  var transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: 'netWorthAppShare@gmail.com', //We need to create a public email address to send the information;
      pass: '123networth'
    }
  });

  var targetemail = req.body.email;
  var targetcomment = req.body.comment;

  var send_text = "12345";
  var user_email = "select email from userInfo where userID = '" + ID + "';" ;
  var user_name_1 = "select firstName from userInfo where userID = '" + ID + "';" 
  var user_name_2 = "select lastName from userInfo userID = '" + ID + "';";
  var net_worth = "select netWorth from netWorthInfo where userID = '" + ID + "';";
  
  var total_assets = "select totalAssets from netWorthInfo where userID = '" + ID + "';";
  var total_liabilities = "select totalLiabilities from netWorthInfo where userID = '"+ ID +"';";

  var select = "select *, (SELECT totalLiabilities FROM netWorthInfo Where userID = 1), (select totalAssets from netWorthInfo where userID = 1), (select netWorth from netWorthInfo where userID  =1)from userInfo where userID = '" + ID + "';";

  var a ='';
  var b ='';
  db.task('get-everything', task => {
    return task.batch([
      // task.any(user_email),
      // //task.any(user_name_1),
      // //task.any(user_name_2),
      // task.any(net_worth),
      // task.any(total_assets),
      // task.any(total_liabilities)
      task.one(select)
      ]);
  })
  .then(info => {
    //res.redirect('/create_account'); 
    var {email}             = info[0];
    var {firstname}         = info[0];
    var {lastname}          = info[0];
    var {networth}          = info[0];
    var {totalAssets}       = info[0];
    var {totalassets}       = info[0];
    var {totalliabilities}  = info[0];
    console.log(info[0]);
    if(selector1 != null)
    { 
      console.log(firstname);
      console.log(send_text);
      send_text = "Your friend " + firstname  + " " + lastname + " has networth of " + networth + 
      ", total assets of " + totalassets + ", and total liabilities of " + totalliabilities + ".";
      console.log(send_text);
      
    }
    else if(selector2 != null)
    {
      send_text = "Your friend " + firstname + " " + lastname + " has networth of " + networth + 
      ", total assets of " + totalassets + ".";
    }
    
    else if(selector3 !=null)
    {
      send_text = "Your friend " + firstname + " " + lastname + " has networth of " + networth +
      ".";
    } 

    a = firstname;
    b = lastname;
    
    send_text += "\n Comment: " + targetcomment;
    var mailOptions = {
      from: 'netWorthAppShare@gmail.com',
      to: 'liru4968@colorado.edu',
      //liru4968@colorado.edu
      subject: 'Your friend '+ a + " " + b + ' share networth with you!',
      text: send_text
    };
    return transporter.sendMail(mailOptions, function(error, info){
      if (error) {
        res.render('share',{
          failed: true
        })
        // 'alert-node'.alert('Email send failed')
        //console.log(error);
        console.log(mailOptions);
      } else {
        res.render('home',
        {
          share: true
        })
        //alert('email sent successfully')
        console.log(mailOptions);
        console.log('Email sent: ' + info.response);
      }
    }); 
  })
  .then(() => {

  })
  .catch(error => {
    console.log('there was an error!!!');
    //res.redirect('/create_account');
    throw (error);
    
  })



    /*var targetemail = req.body
  
    var user_id = "select userID from userInfo where email = targetemail";
  
    var user_name = "select firstName from userInfo where email = targetemail" + ' ' + "select lastName from userInfo where email = targetemail";
  
    var send_text = '';"

  if(document.getElementById("High").checked = true)
  {
    send_text = "Your friend " + user_name + " has networth of " + "select netWorth from netWorthInfo where userID = user_id" + 
    ", total assets of " + "select totalAssets from netWorthInfo where userID = user_id" + ", and total liabilities" + 
    "select totalLiabilities from netWorthInfo where userID = user_id";
  }
  else if(document.getElementById("Medium").checked = true)
  {
    send_text = "Your friend " + user_name + " has networth of " + "select netWorth from netWorthInfo where userID = user_id" + 
    ", and total assets of " + "select totalAssets from netWorthInfo where userID = user_id" + ".";
  }
  else if(document.getElementById("Low").checked = true)
  {
    send_text = "Your friend " + user_name + " has networth of " + "select netWorth from netWorthInfo where userID = user_id" + 
    ".";
  }
  */



  
})


app.listen(3000, function () {
  console.log('Example app listening on port 3000!')
})
