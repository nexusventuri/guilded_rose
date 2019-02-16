class Conjured < EnhancedItem
  def update_sell_in
    item.sell_in -= 1
  end

  def update_quality
    item.quality -= 2 if item.quality > 0
    item.quality -= 2 if item.sell_in < 0
  end
end
