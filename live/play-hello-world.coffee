casper = require('casper').create()

casper.start 'http://localhost:9000/', () ->
   @fill 'form[action="/hello"]', { name: 'Aurelien', repeat: '5', 'color': 'red' }, true

casper.run()
