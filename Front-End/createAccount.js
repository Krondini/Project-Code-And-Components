function checkFields()
{
		var username = document.getElementById('username').value;
		var password = document.getElementById('password').value;
		var re_password = document.getElementById('re-password').value;
		var email = document.getElementById('email').value;

		if((username == '') || (password == '') || (re_password == '') || 
		(email == ''))
	{
		alert("There are empty fields, check your entries!");
		return false;
	};
	return true;
}