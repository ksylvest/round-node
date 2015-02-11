
Application = require './application'
Collection = require './collection'
errors = require '../errors'

module.exports = class Applications extends Collection

  # Note: type and name are used in Collection
  type: Application
  key: 'name'


  # Content requires name
  create: (content, callback) ->
    @resource().create content, (error, resource) =>
      return callback(error) if error

      application = new Application(resource, @client())

      @add(content.name, application)

      callback(null, application)
