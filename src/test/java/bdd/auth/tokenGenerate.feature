Feature: Inicio de Sesion

  Background:
    * url urlBase

  @login
  Scenario: Generar Token
    Given path "/api/login"
    And request { "email": "carmen14@gmail.com", "password": "12345678" }
    When method post
    Then status 200
    * print response
    * def authToken = response.access_token