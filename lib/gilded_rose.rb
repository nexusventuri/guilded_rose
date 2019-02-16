require_relative 'item'

class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      next if item.name == "Sulfuras, Hand of Ragnaros"
      if item.name == "Aged Brie"
        update_brie_quality(item)
        update_sell_in(item)
      elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
        update_backstage_concert_quality(item)

        update_sell_in(item)
      else
        if item.quality > 0
          item.quality -= 1
        end
        update_sell_in(item)
      end


      if item.sell_in < 0
        if item.name == "Aged Brie"
          if item.quality < 50
            item.quality += 1
          end
        elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
          item.quality = 0
        else
          if item.quality > 0
            item.quality -= 1
          end
        end
      end
    end
  end

  def constrain_item_quality(item)
    if item.quality > 50
      item.quality = 50
    end
  end

  def update_brie_quality(item)
    item.quality += 1
    constrain_item_quality(item)
  end

  def update_backstage_concert_quality(item)
    if item.name == "Backstage passes to a TAFKAL80ETC concert"
      item.quality += 1

      if item.sell_in < 6
        item.quality += 2
      elsif item.sell_in < 11
        item.quality += 1
      end

      constrain_item_quality(item)
    end
  end

  def update_sell_in(item)
    item.sell_in -= 1
  end
end

