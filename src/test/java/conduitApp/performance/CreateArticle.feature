Feature: Articles

Background: Define URL
    Given url apiUrl
    * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set articleRequestBody.article.title = dataGenerator.getRandomArticleJson().title
    * set articleRequestBody.article.body = dataGenerator.getRandomArticleJson().body
    * set articleRequestBody.article.description = __gatling.Description

    * def sleep = function(ms){java.lang.Thread.sleep(ms)}
    * def pause = karate.get('__gatling.pause', sleep)

Scenario: Create and Delete an article
    * configure headers = {"Authorization":#('Token ' + __gatling.token)}

    Given path 'articles'
    And request articleRequestBody
    And header karateName = 'Create article'
    When method Post
    Then status 201
    * def articleId = response.article.slug

    * pause(5000)

    Given path 'articles', articleId
    When method Delete
    Then status 204
    
