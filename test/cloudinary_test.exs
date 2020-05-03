defmodule CloudinaryTest do
  use ExUnit.Case
  doctest Cloudinary

  describe "is_remote_url?/1" do
    test "with relative path" do
      assert Cloudinary.is_remote_url?("relative/path.jpg") == false
    end

    test "with local absolute path" do
      assert Cloudinary.is_remote_url?("/absolute/path.svg") == false
    end

    test "with local path with file protocol" do
      assert Cloudinary.is_remote_url?("file:///absolute/path.png") == false
    end

    test "with ftp uri" do
      assert Cloudinary.is_remote_url?("ftp://example.com/path/to/something.3gp") == true
    end

    test "with http uri" do
      assert Cloudinary.is_remote_url?("http://example.com/path/to/something.mpg") == true
    end

    test "with https uri" do
      assert Cloudinary.is_remote_url?("https://example.com/path/to/something.gif") == true
    end

    test "with data uri" do
      assert Cloudinary.is_remote_url?(
               "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg=="
             ) == true
    end

    test "with s3 uri" do
      assert Cloudinary.is_remote_url?("s3://example.com/path/to/bucket/object.mp4") == true
    end

    test "with gs uri" do
      assert Cloudinary.is_remote_url?("gs://example.com/path/to/bucket/object.tif") == true
    end
  end
end
