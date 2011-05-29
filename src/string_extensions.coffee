###*
Returns true if this string only contains whitespace characters.

@name blank
@methodOf String#

@returns Whether or not this string is blank.
@type Boolean
###
String::blank = ->
  /^\s*$/.test(this)

###*
Returns a new string that is a camelCase version.

@name camelize
@methodOf String#
###
String::camelize = ->
  this.trim().replace /(\-|_|\s)+(.)?/g, (match, separator, chr) ->
    if chr then chr.toUpperCase() else ''

###*
Returns a new string with the first letter capitalized and the rest lower cased.

@name capitalize
@methodOf String#
###
String::capitalize = ->
  this.charAt(0).toUpperCase() + this.substring(1).toLowerCase()

###*
Return the class or constant named in this string.

@name constantize
@methodOf String#

@returns The class or constant named in this string.
@type Object
###
String::constantize = ->
  if this.match /[A-Z][A-Za-z0-9]*/
    eval("var that = #{this}")
    that
  else
    throw "String#constantize: '#{this}' is not a valid constant name."

###*
Returns a new string that is a more human readable version.

@name humanize
@methodOf String#
###
String::humanize = ->
  this.replace(/_id$/, "").replace(/_/g, " ").capitalize()

###*
Parse this string as though it is JSON and return the object it represents. If it
is not valid JSON returns the string itself.

@name parse
@methodOf String#

@returns Returns an object from the JSON this string contains. If it
is not valid JSON returns the string itself.
@type Object
###
String::parse = () ->
  try
    JSON.parse(this)
  catch e
    this.toString()

###*
Returns a new string in Title Case.
@name titleize
@methodOf String#
###
String::titleize = ->
  this.split(/[- ]/).map (word) ->
    word.capitalize()
  .join(' ')

###*
Assumes the string is something like a file name and returns the 
contents of the string without the extension.

"neat.png".witouthExtension() => "neat"

@name withoutExtension
@methodOf String#
###
String::withoutExtension = ->
  this.replace(/\.[^\.]*$/, '')

