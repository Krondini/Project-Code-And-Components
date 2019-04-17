import React, { Component } from 'react';

class Networthinfo extends Component{
	state = {Networthinfo: {userID: 12345, factor1: 1.1, factor2: 2.2, factor3: 3.3, netWorth: 6.6} };

	componentDidMount(){
		this.fetchNetworthinfo();
	}

	fetchNetworthinfo = () => {
		fetch('http://localhost:3000/account/login')
		.then(response => console.log('response',response));
	};
	render(){
		const {Networthinfo} = this.state;

		return(
			<div> 
				<p> UserID 	: {Networthinfo.userID}  	</p>
				<p> factor1	: {Networthinfo.factor1} 	</p>
				<p> factor2	: {Networthinfo.factor2} 	</p>
				<p> factor3	: {Networthinfo.factor3} 	</p>
				<p> netWorth: {Networthinfo.netWorth} 	</p>
			</div>
		)
	}
}

export default Networthinfo;


