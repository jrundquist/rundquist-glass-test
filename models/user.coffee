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

UserSchema.pre 'save', (next) ->
    next()



# Exports
exports.UserSchema = module.exports.UserSchema = UserSchema
exports.boot = module.exports.boot = (app) ->
  mongoose.model 'User', UserSchema
  app.models.User = mongoose.model 'User'


