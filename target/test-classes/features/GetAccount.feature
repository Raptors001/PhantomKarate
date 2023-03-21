Feature: TEK Insurance API GET Account Service

  Background: 
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def tokenGeneratorResponse = call read("GenerateToken.feature")
    * def tokenValue = tokenGeneratorResponse.response.token
    * header Authorization = "Bearer " + tokenValue

  @getAccount
  Scenario: Get Primary Person Account
    * path "/api/accounts/get-primary-account"
    * param primaryPersonId = 5522
    * method get
    * status 200
    * print response
    * def responseID = response.id
    * def responseFirstName = response.firstName
    * def responseLastName = response.lastName
    * match responseID == 5523
    * match responseFirstName == "Najla"
    * match responseLastName == "Yaqubi"
    
    
    @getAllAccounts
    Scenario: get All Accounts
    * path "/api/accounts/get-all-accounts"
    * method get 
    * status 200
    * print response[0].id
    
    
    
    
    
    
    
    
    
    
    
    
    
