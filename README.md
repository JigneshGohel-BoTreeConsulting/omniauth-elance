omniauth-elance
===============

Elance API OAuth2 Strategy for OmniAuth.

Supports the OAuth 2.0 server-side and client-side flows. Read the [Elance API docs](https://www.elance.com/q/api2/getting-started) for more details. 

## Installing

Add to your `Gemfile`:

```ruby
gem 'omniauth-elance'
```

Then `bundle install`.

## Usage

`OmniAuth::Strategies::Elance` is simply a Rack middleware.Read the [OmniAuth 1.0](https://github.com/intridea/omniauth) and [OAuth 2.0](https://github.com/intridea/oauth2) docs for detailed instructions


Here's a quick example, adding the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :elance, ENV['ELANCE_API_KEY'], ENV['ELANCE_API_SECRET']
end
```

## Auth Hash

Here's an example [Auth Hash](https://github.com/intridea/omniauth/wiki/Auth-Hash-Schema) available in `request.env['omniauth.auth']`:

```ruby
{
  :provider => 'elance',
  :uid => '1234567',
  :info => {
    :userName => 'jgohel',
    :name => 'Jignesh Gohel'
  },
  :credentials => {
    :token => 'ABCDEF...', # access token, which you may wish to store
    :secret => '1321747205', # access token secret
  },
  :extra => {
    :raw_info => {
		    userId: "4124672",
		    userName: "t_mosby",
		    businessName: "Ted Mosby",
		    companyUserId: null,
		    companyLoginName: null,
		    companyBusinessName: null,
		    tagLine: "Professional PHP Development",
		    overview: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
		    hourlyRate: "33"
		    ...
		    ...
		    ... more fields...
  }
}
```

...more fields... available can be found at https://www.elance.com/q/api2/methods/profiles/my#Response


## License

Copyright (c) 2013 by Jignesh Gohel

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

