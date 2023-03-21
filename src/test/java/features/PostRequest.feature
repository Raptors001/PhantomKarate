@PostRequest
Feature: Test Post Request Methods

  Background: 
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def tokenGeneratorResponse = call read("GenerateToken.feature")
    * def tokenValue = tokenGeneratorResponse.response.token
    * header Authorization = "Bearer " + tokenValue

  Scenario: Create a new Account with Data Generator
    * path "/api/accounts/add-primary-account"
    * def dataGenerator = Java.type("test.api.DataGenerator")
    * def getEmail = dataGenerator.getEmail()
    * def getFName = dataGenerator.getFirstName()
    * def getLName = dataGenerator.getLastName()
    * def getTitle = dataGenerator.getTitle()
    * def getDOB = dataGenerator.getDOB()
    * def getEmploymentStatus = dataGenerator.getEmploymentStatus()
    * def getGender = dataGenerator.getGender()
    * def getMaritalStatus = dataGenerator.getMaritalStatus()
    * request
      """
            {
        "id": 0,
        "email": "#(getEmail)",
        "firstName": "#(getFName)",
        "lastName": "#(getLName)",
        "title": "#(getTitle)",
        "gender": "#(getGender)",
        "maritalStatus": "#(getMaritalStatus)",
        "employmentStatus": "#(getEmploymentStatus)",
        "dateOfBirth": "#(getDOB)",
        "new": true
        }
      """
    * method post
    * status 201
    * print response
    * match response.firstName == getFName
    * match response.lastName == getLName
    * match response.email == getEmail
    * match response.title == getTitle
    * match response.gender == getGender
    * match response.maritalStatus == getMaritalStatus
    * assert response.id != null
    * karate.write(response,'createAccountResponse.json')

  Scenario: Add car request Test
    * path "/api/accounts/add-account-car"
    * def accountResponseInfo = read('file:./target/createAccountResponse.json')
    * param primaryPersonId = accountResponseInfo.id
    * request
      """
      {
      "id": 0,
      "make": "Toyota",
      "model": "Land Cruiser",
      "year": "2000",
      "licensePlate": "Phantom"
      }
      """
    * method post
    * status 201
    * print response
    * karate.write(response, 'createCarResponse.json')

  Scenario: add phone Number Request Test
    * path "/api/accounts/add-account-phone"
    * def accountResponseInfo = read('file:./target/createAccountResponse.json')
    * param primaryPersonId = accountResponseInfo.id
    * def requestbody = read('addPhoneRequestBody.json')
    * request requestbody
    * method post
    * status 201
    * print response

  Scenario: add address Request Test
    * path "/api/accounts/add-account-address"
    * def accountResponseInfo = read('file:./target/createAccountResponse.json')
    * param primaryPersonId = accountResponseInfo.id
    * request
      """
      {
      "id": 0,
      "addressType": "Home",
      "addressLine1": "6201 Leesburg Pike",
      "city": "Falls Church",
      "state": "VA",
      "postalCode": "22044",
      "countryCode": "001",
      "current": true
      }
      """
    * method post
    * status 201
    * print response

  Scenario: Update Car Request
    * path "/api/accounts/update-account-car"
    * def accountResponseInfo = read('file:./target/createAccountResponse.json')
    * param primaryPersonId = accountResponseInfo.id
    * def createCarResponseInfo = read('file:./target/createCarResponse.json')
    * def carId = createCarResponseInfo.id
    * request
      """
        {
        "id": #(carId),
        "make": "Toyota",
        "model": "Land Cruiser",
        "year": "2000",
        "licensePlate": "Phantom - Happy"
        }
      """
    * method put
    * status 200
    * print response

  Scenario: Delete the account
    * path "/api/accounts/delete-account"
    * def accountResponseInfo = read('file:./target/createAccountResponse.json')
    * param primaryPersonId = accountResponseInfo.id
    * method delete 
    * status 200
    * print response
    * assert response == "Account Successfully deleted"
