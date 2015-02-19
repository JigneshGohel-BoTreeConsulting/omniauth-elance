require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Elance < OmniAuth::Strategies::OAuth2
      # Strategy name
      option :name, "elance"

      # Options being passed to initialize client from the OAuth2 Gem.
      # Note: Elance API's OAuth2 interface uses base uri as:
      # https://api.elance.com/api2 thus passing custom authorize_url and
      # token_url
      option :client_options, {
          site: 'https://api.elance.com',
          authorize_url: '/api2/oauth/authorize',
          token_url: '/api2/oauth/token'
      }

      # Called after authentication has succeeded.
      uid {
        raw_info['userId']
      }

      info do
        {
          userName: raw_info['userName'],
          name: raw_info['businessName']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        # Reference: https://www.elance.com/q/api2/methods/profiles/my
        # parsed is a method available in https://github.com/intridea/oauth2/blob/master/lib/oauth2/response.rb
        access_token.options[:mode] = :query
        raw_info = access_token.get("/api2/profiles/my").parsed || {}
        data = raw_info['data']
        data = data['providerProfile'] if data
        data || {}
      end

      def token_params
        super.tap do |params|
          params[:client_id] = client.id
          params[:client_secret] = client.secret
          params[:grant_type] = "authorization_code"
        end
      end

      def build_access_token
        token_url_params = { :code => request.params['code'],
                             :redirect_uri => callback_url }.merge(token_params.to_hash(:symbolize_keys => true))
        opts = { parse: :json,
                 headers: {'Content-Type' => 'application/x-www-form-urlencoded'},
                 body: token_url_params }
        parsed_response = client.request(:post, client.token_url(), opts).parsed
        hash = {
          :access_token => parsed_response['data']['access_token'],
          :expires_in => parsed_response['data']['expires_in'],
          :refresh_token => parsed_response['data']['refresh_token'],
          :token_type => parsed_response['data']['token_type']
        }
        ::OAuth2::AccessToken.from_hash(client, hash)
      end
    end
  end
end