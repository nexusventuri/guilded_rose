require_relative 'item'
require_relative 'enhanced_item'
require_relative 'aged_brie'

class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      next if item.name == "Sulfuras, Hand of Ragnaros"
      if item.name == "Aged Brie"
        brie = AgedBrie.new(item)
        brie.update
      elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
        update_backstage_concert_quality(item)
        update_backstage_concert_sell_in(item)
        constrain_item_quality(item)
      else
        update_generic_item_quality(item)
        update_generic_item_sell_in(item)
        constrain_item_quality(item)
      end
    end
  end

  def constrain_item_quality(item)
    if item.quality > 50
      item.quality = 50
    elsif item.quality < 0
      item.quality = 0
    end
  end

  def update_backstage_concert_quality(item)
    item.quality += 1

    if item.sell_in < 6
      item.quality += 2
    elsif item.sell_in < 11
      item.quality += 1
    end
  end

  def update_backstage_concert_sell_in(item)
    item.sell_in -= 1
    item.quality = 0 if item.sell_in <= 0
  end

  def update_generic_item_quality(item)
    item.quality -= 1 if item.quality > 0
  end

  def update_generic_item_sell_in(item)
    item.sell_in -= 1
    item.quality -= 1 if item.sell_in < 0
  end
end

