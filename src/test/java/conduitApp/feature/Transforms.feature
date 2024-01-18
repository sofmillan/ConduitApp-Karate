Feature: Transforms
    Scenario: karate map operation
        * def fun = function(x){return x * x}
        * def list = [1,2,3]
        * def result = karate.map(list, fun)
        * match result == [1,4,9]

    Scenario: karate filter operation
        * def fun = function(x){return x%2 ==0}
        * def list = [1,2,3,4]
        * def result = karate.filter(list, fun)   
        * match result == [2,4]
    
    Scenario: merge
        * def foo = {a:1}
        * def bar = karate.merge(foo, {b:2})
        * match bar == {a:1,b:2}   

    Scenario: convert array of primitives into array of objects
        * def list = ['Hao', 'Ricky']
        * def data = karate.mapWithKey(list, 'name')
        * match data == [{name:'Hao'}, {name:'Ricky'}]