Feature: Añadir productos

  Background:
    * url urlBase
    * def response = call read('classpath:bdd/auth/loginAuth.feature@CP1')
    * def token = response.token
    * header Authorization = "Bearer " +token
    * header Accept = "application/json"

  @CP1
  Scenario: Añadir un producto
    Given path "/api/v1/producto"
    And request
      """
        {
          "codigo": 'AB0030',
          "nombre": 'ALTERNADOR PL200NS',
          "medida": 'UND ',
          "marca": 'Generico',
          "categoria": 'Repuestos',
          "precio": '35.00',
          "stock": '48',
          "estado": '3',
          "descripcion": 'ALTERNADOR PL200NS'
        }
      """
    When method post
    Then status 200
    And match response.codigo == 'AB0030'
    And match response.estado == '3'


  @CP2
  Scenario Outline: Añadir un producto desde archivo CSV
    Given path "/api/v1/producto"
    And request { codigo: '#(codigo)',nombre: '#(nombre)',medida: '#(medida)',marca: '#(marca)',categoria: '#(categoria)',precio: '#(precio)',stock: '#(stock)',estado: '#(estado)',descripcion: '#(descripcion)' }
    When method post
    Then status 200

    Examples:
      | read('classpath:resources/csv/auth/dataProduct.csv') |

  @CP3
  Scenario: Añadir un producto desde archivo JSON
    Given path "/api/v1/producto"
    And request read("classpath:resources/json/auth/dataProduct.json")
    When method post
    Then status 200
    * print response

  @CP4
  Scenario Outline: Añadir un producto dinámico
    Given path "/api/v1/producto"
    And request { "codigo": "<codigo>","nombre": "<nombre>" ,"medida": "<medida>" ,"marca": "<marca>" ,"categoria": "<categoria>" ,"precio": "<precio>" ,"stock": "<stock>" ,"estado": "<estado>" ,"descripcion": "<descripcion>" }
    When method post
    Then status <status>
    Examples:
      | codigo | nombre             | medida | marca    | categoria | precio | stock | estado | descripcion        | status |
      | AB0050 | ALTERNADOR PL200NS | UND    | Generico | Repuestos | 35.00  | 48    | 3      | ALTERNADOR PL200NS | 200    |