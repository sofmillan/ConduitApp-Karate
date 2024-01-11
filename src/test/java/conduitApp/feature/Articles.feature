Feature: Articles

    Background: Define URL
        Given url 'https://api.realworld.io/api/'
        * def tokenResponse = callonce read('classpath:helpers/GenerateToken.feature'){"email":"sugarcoat@gmail.com","password":"natty"}
        * def token = tokenResponse.authToken
    
    Scenario: Create a new article
        Given header Authorization = 'Token '+token
        Given path 'articles/'
        And request {"article":{"title": "NaevisZ", "description": "Random topic A", "body": ".", "tagList": []}}
        When method Post
        Then status 201
        And match response.article.title == 'NaevisZ'
    
    Scenario: Create and Delete an article
        Given header Authorization = 'Token '+token
        Given path 'articles/'
        And request {"article":{"title": "Article to delete", "description": "Random topic ZA", "body": ".", "tagList": []}}
        When method Post
        Then status 201
        * def articleId = response.article.slug

        Given header Authorization = 'Token '+token
        And path 'articles', articleId
        When method Delete
        Then status 204
        
        
