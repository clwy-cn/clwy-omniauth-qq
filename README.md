# Omniauth QQ

This is QQ strategies collection for OmniAuth 2.0, which includes TQQ and QQ-Connect.

This gem package is forked from [beenhero/omniauth-qq](https://github.com/beenhero/omniauth-qq).
Since the original package has not been maintained for a long time, the dependent omniauth version has fallen seriously behind.
It conflicts with packages like omniauth-github within the same project. Therefore, it was forked and modified for maintenance purposes.
  
## [TQQ](http://open.t.qq.com/) OAuth
  Strategy from https://github.com/ballantyne/omniauth-tqq, credit go to Scott Ballantyne.
  Please note that some modifies had written into for my own purpose, like: raw_info attributes rewrote.
    
## [QQ-Connect](http://connect.qq.com/intro/login/) OAuth2
  Strategy from https://github.com/kaichen/omniauth-qq-connect, credit go to Kai Chen.

## Installation

Add to your `Gemfile`:

```ruby
gem "omniauth-rails_csrf_protection"
gem "clwy-clwy-omniauth-qq"
```

Then `bundle install`.


## Usage

`OmniAuth::Strategies::Qq` is simply a Rack middleware. Read the OmniAuth 1.0 docs for detailed instructions: https://github.com/intridea/omniauth.

Here's a quick example, adding the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :tqq, ENV['TQQ_KEY'], ENV['TQQ_SECRET'], token_params: { client_id: ENV["QQ_CONNECT_KEY"], client_secret: ENV["QQ_CONNECT_SECRET"] }
  config.omniauth :qq_connect, ENV["QQ_CONNECT_KEY"], ENV["QQ_CONNECT_SECRET"], token_params: { client_id: ENV["QQ_CONNECT_KEY"], client_secret: ENV["QQ_CONNECT_SECRET"] }
end
```

OmniAuth 2.0+ requires using HTTP POST as the request method to initiate the authentication, so your link should be configured with `method: :post`。

If you are using Rails and Devise, you can use the following code:

```erb
<%= form_tag("/users/auth/qq_connect", method: "post", data: { turbo: false }) do %>
  <button type="submit">
    QQ Login
  </button>
<% end %>
```

More details about how to use OmniAuth with Devise can be found here: https://github.com/heartcombo/devise/wiki/OmniAuth:-Overview

## Authentication Hash

Here's an example *Authentication Hash* available in `request.env['omniauth.auth']`:

### TQQ returns:

```ruby
{
  :provider => 'tqq',
  :uid => 'B11630C4...', # QQ call it openid
  :info => {
    :nickname => 'beenhero',
    :email => '',
    :name => 'beenhero',
    :location => '杭州',
    :image => 'http://app.qlogo.cn/mbloghead/b8bc8cee839d42d1824c/40',
    :description => '碳水化合物而已',
    :urls => { :Tqq => 't.qq.com/beenhero' },
  },
  :credentials => {
    :token => '2.00JjgzmBd7F...', # OAuth access_token, which you may wish to store
    :secret => 'ac737720847e...',
  },
  :extra => {
    :raw_info => {
      :data => {
        ... # data from http://open.t.qq.com/api/user/info?format=json, check by yourself
      },
      # extracted some general named attribute from [date]
      :gender => 'm', # m: male, f: female, '': none
      :followers_count: 53,
      :friends_count: 14,
    }
  }
}
```

### QQ-Connect returns:

```ruby
{
  :provider => 'qq_connect',
  :uid => 'B11630C4...', # QQ call it openid
  :info => {
    :nickname => 'beenhero',
    :image => 'http://qzapp.qlogo.cn/qzapp/100250034/B11630C4AAC8C17B57ECFEA80852C813/50',
    # so little info !? I think so, QQ-Connect only provides so, you can check from the raw_info below. Or you can try TQQ instead :)
  },
  :credentials => {
    :token => '2.00JjgzmBd7F...', # OAuth 2.0 access_token, which you may wish to store
    :expires_at => 1331780640, # when the access token expires (if it expires)
    :expires => true # if you request `offline_access` this will be false
  },
  :extra => {
    :raw_info => {
      ... # little info from https://graph.qq.com/user/get_user_info
    }
  }
}
```

## License

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.