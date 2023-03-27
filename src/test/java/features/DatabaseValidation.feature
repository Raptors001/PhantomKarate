Feature: Validate Database result

  @DBValidation
  Scenario: DB Validation
    * def createAccount = callonce read('CreateAccount.feature@CreateAccount')
    * def responseId = createAccount.response.id
    * def dataBaseUtility = Java.type("test.api.DataBaseUtility")
    * def queryResult = dataBaseUtility.queryResult("select * from primary_person where id = '"+responseId+"'")
    * karate.write(queryResult,'DBResponse.json')
    * def DBResponse = read('file:./target/DBResponse.json')
    * match DBResponse[0].email == createAccount.response.email
    * match DBResponse[0].first_name == createAccount.response.firstName
    * match DBResponse[0].last_name == createAccount.response.lastName
    * match DBResponse[0].marital_status == createAccount.response.maritalStatus
