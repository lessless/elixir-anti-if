defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  def update_item(item) do
    item =
      cond do
        sulfuras?(item) ->
          item

        generic?(item) ->
          if item.quality > 0 do
            if !sulfuras?(item) do
              decrease_quality(item)
            else
              item
            end
          else
            item
          end

        true ->
          cond do
            quality_less_than_50(item) ->
              item = increase_quality(item)

              cond do
                item.name == "Backstage passes to a TAFKAL80ETC concert" ->
                  item =
                    cond do
                      item.sell_in < 11 ->
                        cond do
                          quality_less_than_50(item) ->
                            increase_quality(item)

                          true ->
                            item
                        end

                      true ->
                        item
                    end

                  cond do
                    item.sell_in < 6 ->
                      cond do
                        quality_less_than_50(item) ->
                          increase_quality(item)

                        true ->
                          item
                      end

                    true ->
                      item
                  end

                true ->
                  item
              end

            true ->
              item
          end
      end

    item =
      cond do
        !sulfuras?(item) ->
          %{item | sell_in: item.sell_in - 1}

        true ->
          item
      end

    cond do
      item.sell_in < 0 ->
        cond do
          !aged_brie?(item) ->
            cond do
              !backstage_pass?(item) ->
                cond do
                  item.quality > 0 ->
                    cond do
                      !sulfuras?(item) ->
                        decrease_quality(item)

                      true ->
                        item
                    end

                  true ->
                    item
                end

              true ->
                %{item | quality: item.quality - item.quality}
            end

          true ->
            cond do
              quality_less_than_50(item) ->
                increase_quality(item)

              true ->
                item
            end
        end

      true ->
        item
    end
  end

  defp decrease_quality(item) do
    %{item | quality: item.quality - 1}
  end

  defp increase_quality(item) do
    %{item | quality: item.quality + 1}
  end

  defp quality_less_than_50(item) do
    item.quality < 50
  end

  def generic?(item) do
    !(sulfuras?(item) or backstage_pass?(item) or aged_brie?(item))
  end

  defp sulfuras?(item) do
    item.name == "Sulfuras, Hand of Ragnaros"
  end

  defp aged_brie?(item) do
    item.name == "Aged Brie"
  end

  defp backstage_pass?(item) do
    item.name == "Backstage passes to a TAFKAL80ETC concert"
  end
end
