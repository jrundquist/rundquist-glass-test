crypto = require('ezcrypto').Crypto
mongoose = require('mongoose')
Schema = mongoose.Schema

# Schema Setup
UserSchema = new Schema(
  email:
    type: String
    index: true
  firstName: String
  lastName: String
  oauthInfo: {}
  token: String
  token_type: String
  refresh_token: String
  timelineItems: [{}]
)


UserSchema.set 'toJSON', virtuals: true
UserSchema.set 'toObject', virtuals: true


UserSchema.virtual('id')
  .get( () -> this._id.toHexString() )

UserSchema.virtual('name')
  .get( () -> "#{@.firstName} #{@.lastName}".trim() )
  .set( (fullName) ->
    p = fullName.split ' '
    @.firstName = p[0]
    @.lastName = p[1]
  )

UserSchema.method('credentials', (app) ->
    oauth2Client = new app.google.OAuth2Client(
      process.env.GOOGLE_CLIENT_ID,
      process.env.GOOGLE_CLIENT_SECRET,
      process.env.GOOGLE_REDIRECT_URL);
    oauth2Client.credentials =
      token_type: @.token_type
      access_token: @.token,
      refresh_token: @.refresh_token
    oauth2Client
  )


UserSchema.pre 'save', (next) ->
    next()





# Exports
exports.UserSchema = module.exports.UserSchema = UserSchema
exports.boot = module.exports.boot = (app) ->
  mongoose.model 'User', UserSchema
  app.models.User = mongoose.model 'User'


