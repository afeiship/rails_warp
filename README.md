# RailsWarp
> A Rails plugin for elegant, hash-based response wrapper for clean Rails API responses.

## Usage

RailsWarp is automatically included into ActionController and Jbuilder. You don\u2019t need to include any module manually.

- Controllers: call ok and fail directly.

Basic controller examples:

```ruby
class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    ok data: { user: user }
  end

  def create
    user = User.new(user_params)
    if user.save
      ok data: { user: user }, message: "created", code: 201
    else
      fail message: "validation error", code: 422, data: { errors: user.errors.full_messages }
    end
  end
end
```

Add extra fields (merged into the response):

```ruby
ok data: { user: user }, meta: { request_id: request.request_id }
```

HTTP status mapping:
- 200, 201, 204: returned as-is
- 400: bad_request
- 401: unauthorized
- 403: forbidden
- 404: not_found
- 422: unprocessable_entity
- 500: internal_server_error

Global error handling example:

```ruby
class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound do |e|
    fail message: e.message, code: 404
  end

  rescue_from StandardError do |e|
    fail message: "internal error", code: 500, data: { error: e.class.name }
  end
end
```

Jbuilder usage (already mixed in, call ok/fail inside templates):

```ruby
# app/views/users/show.json.jbuilder
json.ok data: { user: { id: @user.id, name: @user.name } }, message: "ok"

# app/views/shared/error.json.jbuilder
json.fail message: "not found", code: 404, data: { resource: "User" }

# extra fields
json.ok data: { list: @items.map { |i| { id: i.id, name: i.name } } }, meta: { total: @items.count }
```

Aliases in Jbuilder: you can also use `json.warp_ok` and `json.warp_fail`.


## Installation
Add this line to your application's Gemfile:

```ruby
gem "rails_warp"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install rails_warp
```

## Resources
- https://chat.qwen.ai/c/a6cd0b11-a440-4595-9f8b-0352b416a145

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
