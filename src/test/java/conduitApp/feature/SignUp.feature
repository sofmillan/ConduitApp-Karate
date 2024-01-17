#run the scenarios in order, not randomly
@paralle=false
Feature: Sign up

    Background: Preconditions
        * def dataGenerator = Java.type('helpers.DataGenerator')
        Given url apiUrl
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUser = dataGenerator.getRandomUser()
        

    Scenario: New user
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
        * print randomEmail
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

        #Same feature again and again, the only difference is 
    Scenario Outline: Validate sign up error messages
        Given path 'users'
        And request 
        """
        {
            "user": {
                "email": "<email>",
                "password": "<password>",
                "username": "<username>"
            }
        }
        """ 
        When method Post
        Then status 422
        And match response == <errorResponse>
        Examples:
            | email               | password | username      | errorResponse                                        |
            | #(randomEmail)      | natty    | darling123    | {"errors":{"username":["has already been taken"]}}   | 
            | sugarcoat@gmail.com | natty    | #(randomUser) | {"errors":{"email":["has already been taken"]}}      | 
            |                     | natty    | #(randomUser) | {"errors":{"email":["can't be blank"]}}              | 
            | sugarcoat@gmail.com | natty    |               | {"errors":{"username":["can't be blank"]}}           | 
            | #(randomEmail)      |          | #(randomUser) | {"errors":{"password":["can't be blank"]}}           | 
