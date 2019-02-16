require_relative 'item'
require_relative 'enhanced_item'
require_relative 'aged_brie'
require_relative 'backstage_pass'
require_relative 'generic_item'
require_relative 'sulfuras'

class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if item.name == "Sulfuras, Hand of Ragnaros"
        Sulfuras.new(item).update
      elsif item.name == "Aged Brie"
        AgedBrie.new(item).update
      elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
        BackstagePass.new(item).update
      else
        GenericItem.new(item).update
      end
    end
  end
end

