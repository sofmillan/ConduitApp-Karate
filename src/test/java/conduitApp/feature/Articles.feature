Feature: Articles

    Background: Define URL
        Given url apiUrl
        * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * set articleRequestBody.article.title = dataGenerator.getRandomArticleJson().title
        * set articleRequestBody.article.body = dataGenerator.getRandomArticleJson().body
        * set articleRequestBody.article.description = dataGenerator.getRandomArticleJson().description

    Scenario: Create a new article
     
        Given path 'articles/'
        And request articleRequestBody
        When method Post
        Then status 201
        And match response.article.title == articleRequestBody.article.title
    
    Scenario: Create and Delete an article

        Given path 'articles/'
        And request articleRequestBody
        When method Post
        Then status 201
        * def articleId = response.article.slug

        Given path 'articles', articleId
        When method Delete
        Then status 204
        
        
