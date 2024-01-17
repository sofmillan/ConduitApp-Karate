Feature: Sign up

    Background: Preconditions
        * def dataGenerator = Java.type('helpers.DataGenerator')
        Given url apiUrl

    Scenario: New user
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUser = dataGenerator.getRandomUser()
        
    

        Given path 'users'
        And request 
        """
        {
            "user": {
                "email": #(randomEmail),
                "password": "kard",
                "username": #(randomUser)
            }
        }
        """ 
        When method Post
        Then status 201
        And match response ==
        """
            {
                "user": {
                    "id": "#number",
                    "email": #(randomEmail),
                    "username": #(randomUser),
                    "bio": null,
                    "image": "#string",
                    "token": "#string"
                }
            }
        """


        #instantiate an object and calling method
            # * def jsFunction = 
        # """
        #     function(){
        #         let DataGenerator = Java.type('helpers.DataGenerator')
        #         let generator = new DataGenerator();
        #         console.log(generator.getRandomUser2());
        #         return generator.getRandomUser2()
        #     }
        # """    
        # * def randomUser2 = call jsFunction 
        # then use the randomUser2 variable in your request and match