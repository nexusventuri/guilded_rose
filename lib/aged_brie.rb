class AgedBrie < EnhancedItem
  def update_quality
    item.quality += 1
    item.quality += 1 if item.sell_in < 0
  end

  def update_sell_in
    item.sell_in -= 1
  end
end
