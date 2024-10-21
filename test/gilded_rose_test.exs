defmodule GildedRoseTest do
  use ExUnit.Case
  import GlidedRose.Assertions

  test "begin the journey of refactoring" do
    items = [%Item{name: "foo", sell_in: 0, quality: 0}]
    GildedRose.update_quality(items)
    %{name: firstItemName} = List.first(items)
    assert "foo" == firstItemName
  end

  test "backstage pass" do
    assert_backstage_pass_quality(22, 8, 20)
    assert_backstage_pass_quality(23, 4, 20)
    assert_backstage_pass_quality(0, 0, 20)
  end
end
