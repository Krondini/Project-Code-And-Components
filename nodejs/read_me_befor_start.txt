before start the program you need to change some file.

	1:inside backend/secrets/databaseConfiguration.js
					update database_name and password for database_user


	2:inside backend/bin/configure_db.sh
					update database_name and password for database_user
-----------------------------------------------------------------------------------------

if the database still not working and get some error about peer.
you might need update database user setting.
	
		change the file:
			/etc/postgresql/10/main/pg_hba.conf

			the line 
				local   all             postgres                                peer
			to
				local   all             postgres                                md5

		and restart the psql service

		in ubuntu the command for this is :
			cd /etc/postgresql/10/main
			sudo subl pg_hba.conf
			---edit the file---
			sudo service postgresql restart

-----------------------------------------------------------------------------------------
The commands for the nodejs

	in terminal open backend directory.


	npm run start			// is run the program with default node compiler.
							// if no input the program will do nothing, so npm run start will do nothing

	npm run dev				// is run the program contnusely use nodemon at background.

	npm run configure  	 	// is refresh the SQL database. this will set table to empty.

	npm run configure_dev  	// is refresh database then run program at background.

-----------------------------------------------------------------------------------------

without connecting to the frount_end I'm currently simulate the input and output with postman.