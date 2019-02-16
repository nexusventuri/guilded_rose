class EnhancedItem
  attr_reader :item

  def self.from_item(item)
    if item.name =~ /^Conjured/
      Conjured.new(item)
    elsif item.name == "Sulfuras, Hand of Ragnaros"
      Sulfuras.new(item)
    elsif item.name == "Aged Brie"
      AgedBrie.new(item)
    elsif item.name == "Backstage passes to a TAFKAL80ETC concert"
      BackstagePass.new(item)
    else
      GenericItem.new(item)
    end
  end

  def initialize(item)
    @item = item
  end

  def update
    update_quality
    update_sell_in
    constrain_item_quality
  end

  def constrain_item_quality
    if item.quality > 50
      item.quality = 50
    elsif item.quality < 0
      item.quality = 0
    end
  end
end
