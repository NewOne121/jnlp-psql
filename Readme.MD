This dockerfile composed to build image which contains postgresql11 server.
Probrbaly better idea it's to spinup separate postgresql pod from official repository and connect to this containder via localhost.
But it have it's caveats, here is the image with postgres. 
Please use approach with sparate jnlp postgresql container in case of any issues.

Image includes:
* Python3.7
* Postgresql11 server, client
* Sqlite 3.30.1
* Sonar
* Maven 8
