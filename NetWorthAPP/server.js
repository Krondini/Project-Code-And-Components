const express = require('express')
const app = express()

app.use(express.static('public'));
app.set('view engine', 'ejs')

app.get('/home', function (req, res) {
  res.render('home');
})

app.get('/add', function (req, res){
  res.render('Calculation');
})

app.get('/edit', function (req, res){
  res.render('edit');
})

app.get('/create_account', function (req, res){
  res.render('createAccount');
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