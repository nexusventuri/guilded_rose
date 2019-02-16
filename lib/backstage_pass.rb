class BackstagePass < EnhancedItem
  def update_quality
    item.quality += 1

    if item.sell_in < 6
      item.quality += 2
    elsif item.sell_in < 11
      item.quality += 1
    end
  end

  def update_sell_in
    item.sell_in -= 1
    item.quality = 0 if item.sell_in <= 0
  end
end
