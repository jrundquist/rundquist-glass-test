google = require('googleapis')
OAuth2Client = google.OAuth2Client;

express = require('express')
app = express()

oauth2Client = new OAuth2Client(
  process.env.GOOGLE_CLIENT_ID
  process.env.GOOGLE_CLIENT_SECRET
  process.env.GOOGLE_REDIRECT_URL)

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

app.listen(process.env.PORT || 8080)
