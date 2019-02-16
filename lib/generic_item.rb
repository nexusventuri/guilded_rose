class GenericItem < EnhancedItem
  def update_quality
    item.quality -= 1
    item.quality -= 1 if item.sell_in < 0
  end
end
