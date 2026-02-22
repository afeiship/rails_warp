# RailsWarp
> A Rails plugin for elegant, hash-based response wrapper for clean Rails API responses.

## Usage

RailsWarp is automatically included into ActionController and Jbuilder. You don't need to include any module manually.

### Controllers

Call `ok` and `fail` directly in your controllers:

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

#### Parameters

- `data` - The response data (any JSON-serializable object)
- `message` - Custom message (default: "success" for ok, "error" for fail)
- `code` - HTTP status code (default: 200 for ok, 500 for fail)
- Additional keyword arguments are merged into the response

#### Response Format

```json
{
  "success": true,
  "code": 200,
  "message": "success",
  "data": { ... }
}
```

#### HTTP Status Mapping

- `200`, `201`, `204`: returned as-is
- `400`: bad_request
- `401`: unauthorized
- `403`: forbidden
- `404`: not_found
- `422`: unprocessable_entity
- `500`: internal_server_error

#### Global Error Handling

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

### Jbuilder Templates

Use `json.ok` and `json.fail` in your Jbuilder templates:

```ruby
# app/views/users/show.json.jbuilder
json.ok message: "User found", code: 200
json.data do
  json.id @user.id
  json.name @user.name
end

# app/views/shared/error.json.jbuilder
json.fail message: "not found", code: 404
json.data do
  json.resource "User"
end
```

#### With Partials

```ruby
# app/views/users/index.json.jbuilder
json.ok message: "Users retrieved", code: 200
json.data do
  json.array! @users, partial: "users/user", as: :user
end
```

#### Extra Fields

Additional keyword arguments are merged into the response root:

```ruby
json.ok data: { list: @items }, meta: { total: @items.count }
```

#### Aliases

You can also use `json.warp_ok` and `json.warp_fail` as aliases.

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

## Contributing

Contribution directions go here.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
