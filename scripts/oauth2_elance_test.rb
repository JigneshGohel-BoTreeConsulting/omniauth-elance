# References:
# http://wiki.openstreetmap.org/wiki/OAuth_ruby_examples
# https://github.com/intridea/oauth2/blob/master/lib/oauth2/client.rb
# https://github.com/intridea/omniauth-oauth2/blob/master/lib/omniauth/strategies/oauth2.rb
# https://github.com/intridea/oauth2/blob/master/lib/oauth2/strategy/auth_code.rb
# https://github.com/intridea/oauth2/blob/master/lib/oauth2/access_token.rb
require 'rubygems'
require 'oauth2'
require 'date'
require 'yaml'

auth={}

puts "First, request for an API key at"
puts "https://www.elance.com/q/api/request-key"
puts "Enter the consumer key you are assigned:"
auth["client_id"] = gets.strip
puts "Enter the consumer secret you are assigned:"
auth["client_secret"] = gets.strip
puts "Your application is now set up, but you need to register"
puts "this instance of it with your user account."

client_opts = {
  site: 'https://api.elance.com',
  authorize_url: 'api2/oauth/authorize',
  token_url: 'api2/oauth/token'
}

@client = OAuth2::Client.new(auth["client_id"], auth["client_secret"], client_opts)

puts "Visit the following URL, log in if you need to, and authorize the app"
authorize_url = @client.auth_code.authorize_url

puts authorize_url

puts "When you've authorized the request, enter the verifier code you are assigned:"

verifier = gets.strip

puts "Converting the authorization code into access token..."

@access_token= @client.get_token(verifier)

auth["token"] = @access_token.token
auth["token_secret"] = @access_token.secret

#File.open('auth.yaml', 'w') { |f| YAML.dump(auth, f) }

puts "Done.Following are the credentials to be used to access the API"
puts "#{auth}"


