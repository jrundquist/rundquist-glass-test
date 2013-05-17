google = require('googleapis')
OAuth2Client = google.OAuth2Client;

express = require('express')
app = express()



google
  .discover('mirror', 'v1' )
  .execute (err,client) ->
    #console.log client


app.get '/', (req, res) ->
  url = oauth2Client.generateAuthUrl({
    access_type: 'offline',
    scope: [
      'https://www.googleapis.com/auth/glass.timeline'
      'https://www.googleapis.com/auth/userinfo.profile'
    ].join ' '
  });
  res.json url

app.get '/oauth2callback', (req, res) ->
  code = req.query?.code
  oauth2Client.getToken code, (err, tokens) ->
    res.json tokens
    console.log err, tokens
