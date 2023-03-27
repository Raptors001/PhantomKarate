Feature: Rest API JSON Response body schema validation

  Scenario: Response Schema Validation
    * def createAccount = callonce read('CreateAccount.feature@CreateAccount')
    * match createAccount.response ==
      """
      {
      "id": '#number',
      "email": '#string',
      "title": '#string',
      "firstName": '#string',
      "lastName": '#string',
      "gender": '#string',
      "maritalStatus": '#string',
      "employmentStatus": '#string',
      "dateOfBirth": '#present',
      "user": '#present'
      }
      """
      
