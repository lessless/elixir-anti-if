defmodule GlidedRose.Assertions do
  import ExUnit.Assertions

  def assert_backstage_pass(expected, sell_in, quality) do
    items = [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: sell_in, quality: quality}]
    items = GildedRose.update_quality(items)
    assert hd(items).quality == expected
  end
end
