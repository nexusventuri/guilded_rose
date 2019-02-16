require_relative 'item'

class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      next if item.name == "Sulfuras, Hand of Ragnaros"
      if item.name == "Aged Brie" or item.name == "Backstage passes to a TAFKAL80ETC concert"
        update_brie_or_concert_quality(item)
      else
        if item.quality > 0
          item.quality = item.quality - 1
        end
      end

      item.sell_in = item.sell_in - 1

      if item.sell_in < 0
        if item.name == "Aged Brie"
          if item.quality < 50
            item.quality = item.quality + 1
          end
        else
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            item.quality = 0
          else
            if item.quality > 0
              item.quality = item.quality - 1
            end
          end
        end
      end
    end
  end

  def update_brie_or_concert_quality(item)
    item.quality = item.quality + 1
    update_backstage_concert_quality(item)

    if item.quality > 50
      item.quality = 50
    end
  end

  def update_backstage_concert_quality(item)
    if item.name == "Backstage passes to a TAFKAL80ETC concert"
      if item.sell_in < 6
        item.quality = item.quality + 2
      elsif item.sell_in < 11
        item.quality = item.quality + 1
      end
    end
  end
end

