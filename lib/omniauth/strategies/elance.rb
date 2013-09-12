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
          site: "https://api.elance.com/api2",
          authorize_url: 'api2/oauth/authorize',
          token_url: 'api2/oauth/token'
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
        @raw_info ||= access_token.get('/profiles/my?catId=10183')

        data = @raw_info['data']
        data = data['providerProfile'] if data
        data
      end

    end
  end
end