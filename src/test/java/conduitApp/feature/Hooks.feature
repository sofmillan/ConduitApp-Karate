Feature: Hooks

    Background: hooks
        # before hooks
        # * def result = call read('classpath:helpers/Dummy.feature')
        # * def username = result.username

        #after hooks
        * configure afterFeature = function(){ karate.call('classpath:helpers/Dummy.feature') }

        * configure afterScenario =
        """
            function(){
                karate.log('After Scenario ture Text')
            }
        """    

    Scenario: First scenario
        
        * print 'First scenario'
    
    Scenario: Second scenario
        
        * print 'Second scenario'
