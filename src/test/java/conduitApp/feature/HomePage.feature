
Feature: Tests for the home page

    Background: Define URL
        Given url apiUrl
    
    @debug
    Scenario: Get all tags
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags contains ['enim', 'est']
        And match response.tags !contains 'truck'
        And match response.tags contains any ['panda', 'cat', 'est']
        And match response.tags == '#array'
        And match each response.tags == '#string'
    
    Scenario: Get 10 articles from the page
        * def timeValidator = read("classpath:helpers/timeValidator.js")
        Given params {limit:10, offset:0}
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles == '#[10]'
        And match response == {"articles":"#array", "articlesCount":"#number"} //verify the structure of the object
        And match response.articles[0].createdAt contains '2024'
        And match response..bio contains null 
        #all bio keys in the object no matter where they are located. Equals to response.articles[*].author.bio
        And match each response..following == false
        And match each response..following == "#boolean"
        And match each response..bio == "##string" //## means it can be null or not present
        And match each response.articles == 
        """
            {
            "slug":"#string",
            "title": "#string",
            "description": "#string",
            "body": "#string",
            "tagList": "#array",
            "createdAt": "#? timeValidator(_)",
            "updatedAt": "#? timeValidator(_)",
            "favorited": "#boolean",
            "favoritesCount": "#number",
            "author": {
                "username": "#string",
                "bio": "##string",
                "image": "#string",
                "following": "#boolean"
            }
        }
        """    

        # And match response.articlesCount == 251