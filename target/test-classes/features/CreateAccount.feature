Feature: Post Request API - TEK Insurance

  Background: 
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def tokenGeneratorResponse = call read("GenerateToken.feature")
    * def tokenValue = tokenGeneratorResponse.response.token
    * header Authorization = "Bearer " + tokenValue
    * path "/api/accounts/add-primary-account"


  Scenario: Create a new Account with Data Generator
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
 
 
  Scenario: Create a new Account using Post Request
    * request
      """
      {
      "id": 0,
      "email": "karate.phantom@tekschool.us",
      "firstName": "karate",
      "lastName": "phantom",
      "title": "Mr.",
      "gender": "MALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "student",
      "dateOfBirth": "2000-01-12",
      "new": true
      }
      """
    * method post
    * status 201
    * print response
