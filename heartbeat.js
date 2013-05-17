var request = require('request');
console.log('Requesting [http://'+process.env.DOMAIN+'/imgur]')
request('http://'+process.env.DOMAIN+'/imgur', function (error, response, body) {
    if (!error && response.statusCode == 200) {
    console.log('  |-> Status: '+ response.statusCode);
  }else{
    console.log('  |-> '+ error.message);
  }
});