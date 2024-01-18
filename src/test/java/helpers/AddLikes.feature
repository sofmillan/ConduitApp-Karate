Feature: Add likes
    Background:
        Given url apiUrl

    Scenario: add likes
        Given path 'articles',slug, 'favorite'
        And request {}
        When method Post
        Then status 200
        * def likesCount = response.article.favoritesCount
