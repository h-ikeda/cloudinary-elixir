# Cloudinary

[Cloudinary](https://cloudinary.com) is a cloud service that helps to manage
images, videos and other assets. This package provides an unofficial
integration with Cloudinary service for Elixir applications.

## Installation

The package can be installed by adding `cloudinary_sdk` to your list of
dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:cloudinary_sdk, "~> 0.0.1"}
  ]
end
```

## Configuration

This package reads the configuration from the application environment. The key
`:cloud_name` or `:url` must be supplied.

```elixir
import Config

config :cloudinary,
  cloud_name: "<your_cloud_name>", # required if :url is not supplied.
  api_key: "<your_api_key>",
  api_secret: "<your_api_secret>",
  secure: true
  private_cdn: true,
  secure_distribution: "<your_secure_distribution>",
  # Or use a cloudinary URL instead
  url: "cloudinary://<your_api_key>:<your_api_secret>@<your_cloud_name>/<your_secure_distribution>"
```
