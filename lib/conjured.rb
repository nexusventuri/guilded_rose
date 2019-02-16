class Conjured < EnhancedItem
  def update_quality
    item.quality -= 2
    item.quality -= 2 if item.sell_in < 0
  end
end
