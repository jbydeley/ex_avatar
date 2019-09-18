defmodule ExAvatarTest do
  use ExUnit.Case
  doctest ExAvatar

  test "should generate all combinations of letters" do
    assert ExAvatar.generate_names(letters: "ABC", colors: ["red"]) == [
             {"AA", "red"},
             {"AB", "red"},
             {"AC", "red"},
             {"BA", "red"},
             {"BB", "red"},
             {"BC", "red"},
             {"CA", "red"},
             {"CB", "red"},
             {"CC", "red"}
           ]
  end
end
