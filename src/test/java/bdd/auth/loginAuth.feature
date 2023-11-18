Feature: Logear al usuario al sistema

  Background:
    * url urlBase

  @CP1
  Scenario: Login de usuario en un archivo JSON
    Given path "/api/login"
    And request read('classpath:resources/json/auth/bodyLogin.json')
    When method post
    Then status 200
    * def token = response.access_token

  @CP2
  Scenario Outline: Login de usuario dinamico
    Given path "/api/login"
    And request {"email": '<email>', "password": '<password>'}
    When method post
    Then status 200
    Examples:
      | email              | password |
      | carmen14@gmail.com | 12345678 |

    @CP3
    Scenario: Login de usuario - Caso Fallido
      Given path "/api/login"
      And request { "email": "carmen15@gmail.com", "password": "12345678" }
      When method post
      Then status 401
      And match response.message == "Datos incorrectos"
      * def token = response.access_token

