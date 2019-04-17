const { Router } 	= require	('express')				;
const AccountTable 	= require	('../account/table')	;
const { hash }  	= require	('../account/helper')	;
const {setSession}	= require	('./helper')			;
const Session 		= require	('../account/session')	;


const router = new Router();



router.post('/signup', (req, res, next) => {

	const { username, password, passwordrepet, email } = req.body;

	AccountTable.checkAccount({ username, email,password, passwordrepet })
		.then(({ account }) => {
			if(!account){
				return AccountTable.storeAccount({ username, password, email })
			}
			else {
				const error = new Error('This username or email has already been taken');
				throw error;
			}
		})
		.then( () => {
			return setSession({username,res});
		})
		.then(({message}) => res.json({message}))
		.catch(error => next(error));
	
});



router.post('/login', (req,res,next) => {
	const {username, password} = req.body;

	AccountTable.getAccount({username})
		.then(({ account }) => {
			if (account && account.passwordHash === hash(password)){
				const { sessionId } = account;
				return setSession({username, res, sessionId});
			} else {
				const error = new Error('Incorrect username/password');
				throw error;
			}
		})
		.then(({message}) => res.json({message}))
		.catch(error => next(error));
});



router.get('/logout',(req,res,next) => {
	const { username } = Session.parse(req.cookies.sessionString);

	AccountTable.updateSessionId({
		sessionId: null,
		usernameHash: hash(username)
	}).then(()=>{
		res.clearCookie('sessionString');

		res.json({message: 'Successful logout'})
	}).catch(error => next(error));
});



module.exports = router;