Feature: Sign up

    Background: Preconditions
        Given url apiUrl

    Scenario: New user
        Given path 'users'
        Given def userData = {email: 'test2005@test.com', user:'supercharger'}
        And request 
        """
        {
            "user": {
                "email": "#(userData.email)",
                "password": "kard",
                "username": "#(userData.user)"
            }
        }
        """ 
        When method Post
        Then status 201