require_relative 'item'
require_relative 'enhanced_item'
require_relative 'aged_brie'
require_relative 'backstage_pass'
require_relative 'generic_item'
require_relative 'sulfuras'
require_relative 'conjured'

class GildedRose

  def initialize(items)
    @items = items.map { |item| EnhancedItem::from_item(item) }
  end

  def update_quality()
    @items.each do |item|
      item.update
    end
  end
end

