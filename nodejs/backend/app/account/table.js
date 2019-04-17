const pool 		= require('../../databasePool')	;
const { hash } 	= require('./helper')			;

class AccountTable{
	static storeAccount({username, password, email}){
		const usernameHash 	= hash(username);
		const passwordHash 	= hash(password);
		const emailHash		= hash(email);
		return new Promise((resolve, reject) =>{
			if(username.length > 64){
				const error = new Error('Username is too long');
				return reject(error);
			}
			if(password.length > 64){
				const error = new Error('Password is too long');
				return reject(error);
			}

			pool.query(
				'INSERT INTO account("usernameHash", "passwordHash","emailHash") VALUES($1, $2, $3)',
				[usernameHash, passwordHash, emailHash],
				(error, response) => {
					if(error) return reject (error);

					resolve();
				}
			);
		});
	}
	static checkAccount({username,email, password, passwordrepet}){

		const usernameHash 	= hash(username);
		const emailHash		= hash(email);
		return new Promise((resolve,reject) => {
			var re = /\S+@\S+\.\S+/;
			if(password !== passwordrepet){
				const error = new Error('Two password is not match.');
				return reject(error);
			}
			if(!re.test(email)){
				const error = new Error('The email is invalid');
				return reject(error);
			}
			pool.query(
				'SELECT id, "passwordHash", "sessionId", "emailHash" FROM account WHERE "usernameHash" = $1 OR "emailHash" = $2' ,
				[usernameHash, emailHash],
				(error, response) => {
					if (error) return reject(error);
					resolve({ account: response.rows[0] });
				}
			)
		});

	}
	static getAccount({ username }){
		const usernameHash = hash(username);
		return new Promise((resolve, reject) => {
			pool.query(
				'SELECT id, "passwordHash", "sessionId", "emailHash" FROM account WHERE "usernameHash" = $1 OR "emailHash" = $1',
				[usernameHash],
				(error, response) => {
					if (error) return reject(error);

					resolve({ account: response.rows[0]});
				}
			)
		});
	}

	static updateSessionId({sessionId, usernameHash}){
		return new Promise ((resolve, reject) => {
			pool.query(
				'UPDATE account SET "sessionId" = $1 WHERE "usernameHash" = $2',
				[sessionId, usernameHash],
				(error, response) => {
					if(error) return reject(error);

					resolve();
				}
			)
		});
	}
}

module.exports = AccountTable;