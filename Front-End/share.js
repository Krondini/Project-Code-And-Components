//install nodemailer first
//enter: npm install nodemailer  
var nodemailer = require('nodemailer'); 


var transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'youremail@gmail.com', //We need to create a public email address to send the information;
    pass: 'yourpassword'
  }
});

var targetemail = document.getElementById("mailto");

var mailOptions = {
  from: 'youremail@gmail.com',
  to: 'myfriend@yahoo.com',
  subject: 'Your friend'+ user.firstname + user.lastname + 'share networth with you!',
  text: 'That was easy!'
};

transporter.sendMail(mailOptions, function(error, info){
  if (error) {
    console.log(error);
  } else {
    console.log('Email sent: ' + info.response);
  }
}); 