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

var targetemail = document.getElementById("sendEmail").value;

var user_id = "select userID from userInfo where email = targetemail";

var user_name = "select firstName from userInfo where email = targetemail" + ' ' + "select lastName from userInfo where email = targetemail";

var send_text = '';

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

var mailOptions = {
  from: 'youremail@gmail.com',
  to: targetemail,
  subject: 'Your friend '+ user_name + ' share networth with you!',
  text: send_text
};

transporter.sendMail(mailOptions, function(error, info){
  if (error) {
    console.log(error);
  } else {
    console.log('Email sent: ' + info.response);
  }
}); 