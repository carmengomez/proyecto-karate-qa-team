Feature: Registrar nuevo usuario

  Background:
    * url urlBase

  @CP1
  Scenario: Registar nuevo usuario
    Given path "/api/register"
    And request { "email": "carmen6@gmail.com" ,"password": "12345678" ,"nombre": "Carmen" ,"tipo_usuario_id": 1 ,"estado": 1 }
    When method post
    Then status 200
    And match response.data.email == "carmen6@gmail.com"
    And match response.data.nombre == "Carmen"
    And match response.data.tipo_usuario_id == 1
    And match response.data.estado == 1

  @CP2
  Scenario Outline: Registrar nuevo usuario
    Given path "/api/register"
    And request {  "email": '<email>', "password": '<password>', "nombre": "<nombre>", "tipo_usuario_id": "<tipo_usuario_id>", "estado": "<estado>", }
    When method post
    Then status 200
    And match response.data.email == "<email>"
    And match response.data.nombre == "<nombre>"
    And match response.data.tipo_usuario_id == "<tipo_usuario_id>"
    And match response.data.estado == "<estado>"

    Examples:
      | email              | password | nombre | tipo_usuario_id | estado |
      | carmen13@gmail.com | 12345678 | Carmen | 1               | 1      |