defmodule CloudinaryTest do
  use ExUnit.Case
  doctest Cloudinary

  test "greets the world" do
    assert Cloudinary.hello() == :world
  end
end
