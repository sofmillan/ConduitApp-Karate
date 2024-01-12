Feature: Articles

    Background: Define URL
        Given url apiUrl
    
    Scenario: Create a new article
     
        Given path 'articles/'
        And request {"article":{"title": "Naevi", "description": "Random topic A", "body": ".", "tagList": []}}
        When method Post
        Then status 201
        And match response.article.title == 'Naevi'
    
    Scenario: Create and Delete an article

        Given path 'articles/'
        And request {"article":{"title": "Article to delete", "description": "Random topic ZA", "body": ".", "tagList": []}}
        When method Post
        Then status 201
        * def articleId = response.article.slug

        Given path 'articles', articleId
        When method Delete
        Then status 204
        
        
