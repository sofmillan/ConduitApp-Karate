Feature: Articles

    Background: Define URL
        Given url 'https://api.realworld.io/api/'
    
    Scenario: Create a new article
        Given path 'users/login'
        And request {"user":{"email":"tubatu@gmail.com","password":"tubatuwariwari"}}
        When method Post
        Then status 200
        * def token = response.user.token

        Given header Authorization = 'Token '+token
        Given path 'articles/'
        And request {"article":{"title": "Narrow Maze", "description": "Random topic A", "body": ".", "tagList": []}}
        When method Post
        Then status 201
        And match response.article.title == 'Narrow Maze'
