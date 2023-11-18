Feature: Listar producto por id

  Background:
    * url urlBase
    * def response = call read('classpath:bdd/auth/loginAuth.feature@CP1')
    * def token = response.token
    * header Authorization = "Bearer " +token
    * header Accept = "application/json"
    * print response

  @CP1
  Scenario: Listar producto - 1
    * def idproducto = 1
    Given url urlBase
    And path "/api/v1/producto/" + idproducto
    When method get
    Then status 200
    * print response

  @CP2
  Scenario Outline: Listar producto - 2
    Given url urlBase
    And path "/api/v1/producto/" + "<idproducto>"
    When method get
    Then status <status>

    Examples:
      | idproducto | status |
      | 1          | 200    |