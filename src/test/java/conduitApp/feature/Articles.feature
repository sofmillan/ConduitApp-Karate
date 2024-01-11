Feature: Articles

    Background: Define URL
        Given url 'https://api.realworld.io/api/'
        Given path 'users/login'
        And request {"user":{"email":"sugarcoat@gmail.com","password":"natty"}}
        When method Post
        Then status 200
        * def token = response.user.token
    
    Scenario: Create a new article
        Given header Authorization = 'Token '+token
        Given path 'articles/'
        And request {"article":{"title": "Naevis3", "description": "Random topic A", "body": ".", "tagList": []}}
        When method Post
        Then status 201
        And match response.article.title == 'Naevis3'
    
    Scenario: Create and Delete an article
        Given header Authorization = 'Token '+token
        Given path 'articles/'
        And request {"article":{"title": "Article to delete", "description": "Random topic A", "body": ".", "tagList": []}}
        When method Post
        Then status 201
        * def articleId = response.article.slug

        Given header Authorization = 'Token '+token
        And path 'articles', articleId
        When method Delete
        Then status 204
        
        
