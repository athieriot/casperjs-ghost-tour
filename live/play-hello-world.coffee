casper = require('casper').create {
    verbose: false,
    logLevel: "debug",
    clientScripts: ["includes/underscore-min.js"]
}

testedName = 'Aurelien'
testedRepetition = 5

casper.start 'http://localhost:9000/', () ->
    @test.assertTitle 'The \'helloworld\' application', 'hello world application expected'
    @test.assertTextExists 'Configure', 'you can configure the app'

    @fill 'form[action="/hello"]', { name: testedName, repeat: testedRepetition, 'color': 'red' }, true

casper.then () ->
    @test.assertTitle 'Here is the result:', 'result page expected'

casper.then () ->
    @test.assertTextExists "Hello #{testedName}!", 'message displayed correctly'
    @test.assertUrlMatch /name=Aurelien/, 'search term has been submitted'

    @captureSelector 'page.png', 'html'

    @test.assertEval (times, name) -> 
       elements = __utils__.findAll 'li'
       return false if elements.length is not times

       _.every elements, (e) ->
          e.textContent is "Hello #{name}!"
                         
    , "message displayed more that #{testedRepetition} times", [testedRepetition, testedName]

casper.thenClick '.buttons a', () ->
    @test.assertTitle 'The \'helloworld\' application', 'hello world application expected'

casper.back () ->
    @test.assertTitle 'Here is the result:', 'result page expected'

casper.run () ->
    @test.done 7     #checks that 7 assertions have been executed
    @test.renderResults true
