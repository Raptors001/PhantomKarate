Feature: Token Generator feature for Insurance API
	
	@generateToken
  Scenario: Generate Token
  Given url "https://tek-insurance-api.azurewebsites.net"
  * path "/api/token"
  * request {"username":"supervisor","password":"tek_supervisor"}
  * method post
  * print response
  * status 200
  * print response.token
  
	