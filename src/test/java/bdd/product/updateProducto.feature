Feature: Añadir productos

  Background:
    * url urlBase
    * def response = call read('classpath:bdd/auth/loginAuth.feature@CP1')
    * def token = response.token
    * header Authorization = "Bearer " +token
    * header Accept = "application/json"
    * print response

  @CP1
  Scenario: Actualizar producto - 1
    * def idproducto = 1
    Given url urlBase
    And path "/api/v1/producto/" + idproducto
    And request
      """
        {
          "codigo": "PRO001",
          "nombre": "ALTERNADOR PL200NS2",
          "slug": "slug01/prueba",
          "medida": "UND2 ",
          "marca": "Generico",
          "categoria": "Repuestos",
          "precio": "16.00",
          "stock": "41",
          "estado": "3",
          "descripcion": "ALTERNADOR PL200NS2"
        }
      """
    When method put
    Then status 200

  @CP2
  Scenario Outline: Listar producto - 2
    Given url urlBase
    And path "/api/v1/producto/" + "<idproducto>"
    And request { "codigo": "<codigo>", "nombre": "<nombre>", "slug": "<slug>", "medida": "<medida>", "marca": "<marca>", "categoria": "<categoria>", "precio": "<precio>", "stock": "<stock>", "estado": "<estado>", "descripcion": "<descripcion>" }
    When method put
    Then status <status>

    Examples:
      | idproducto | codigo | nombre              | slug          | medida | marca    | categoria | precio | stock | estado | descripcion         | status |
      | 1          | PRO001 | ALTERNADOR PL200NS1 | slug01/prueba | UND1   | Generico | Repuestos | 50.00  | 60    | 3      | ALTERNADOR PL200NS1 | 200    |