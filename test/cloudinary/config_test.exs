defmodule Cloudinary.ConfigTest do
  use ExUnit.Case
  doctest Cloudinary.Config
  alias Cloudinary.Config
  import Config

  describe "parse_url/1" do
    test "with only cloudname" do
      assert parse_url("cloudinary://test-cloud-name") == %Config{cloud_name: "test-cloud-name"}
    end

    test "with cloud name and api key/secret" do
      assert parse_url("cloudinary://abcd1234:wxyz7890@test-cloud-name/") == %Config{
               cloud_name: "test-cloud-name",
               api_key: "abcd1234",
               api_secret: "wxyz7890"
             }
    end

    test "with cloud name and domain name of the CDN distribution" do
      assert parse_url("cloudinary://cloud-name/cdn.domain") == %Config{
               cloud_name: "cloud-name",
               secure_distribution: "cdn.domain",
               private_cdn: true
             }
    end

    test "with cloud name and optional configurations by query string" do
      assert parse_url("cloudinary://test?secure&upload_preset=default&cname=cdn.ex") == %Config{
               cloud_name: "test",
               secure: true,
               upload_preset: "default",
               cname: "cdn.ex"
             }
    end

    test "with cloud name and cdn_subdomain option" do
      assert parse_url("cloudinary://test_name/?cdn_subdomain") == %Config{
               cloud_name: "test_name",
               cdn_subdomain: true
             }
    end

    test "ignores unknown options in query string" do
      assert parse_url("cloudinary://cloud_name?ignored=ignored_option") == %Config{
               cloud_name: "cloud_name"
             }
    end
  end
end
