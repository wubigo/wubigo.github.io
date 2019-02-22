Basic Server Setup
To start off, we need to set the password of the PostgreSQL user (role) called "postgres"; we will not be able to access the server externally otherwise. As the local “postgres” Linux user, we are allowed to connect and manipulate the server using the psql command.

In a terminal, type:


sudo -u postgres psql postgres
this connects as a role with same name as the local user, i.e. "postgres", to the database called "postgres" (1st argument to psql).

Set a password for the "postgres" database role using the command:

\password postgres
and give your password when prompted. The password text will be hidden from the console for security purposes.

Type Control+D or \q to exit the posgreSQL prompt.

Create database

To create the first database, which we will call "mydb", simply type:


 sudo -u postgres createdb mydb
 
 
 
 
#sudo nano /etc/postgresql/9.3/main/pg_hba.conf
and change the line 
host    all             all             0.0.0.0/0    md5


# Database administrative login by Unix domain socket
local   all             postgres                                peer
to

# Database administrative login by Unix domain socket
local   all             postgres                                md5
Now you should reload the server configuration changes and connect pgAdmin III to your PostgreSQL database server.

sudo /etc/init.d/postgresql reload



```
cayley_v0.6.1_linux_amd64$ cat cayley.cfg
{
"listen_host": "0.0.0.0",
"database": "sql",
"db_path": "postgres://postgres:psql@db/cayley?sslmode=disable",
"read_only": false
}


$cayley init --config=cayley.cfg
$cayley http --config=cayley.cfg
$cayley load --config=cayley.cfg --quads=data/testdata.nq


```

```
Cayley looks in the following locations for the configuration file

Command line flag
The environment variable $CAYLEY_CFG
/etc/cayley.cfg
```

