require File.join(File.dirname(__FILE__), '..', 'lib', 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end
  end

  context 'Aged brie' do
    it 'Increases in quality every day' do
      items = [Item.new('Aged Brie', sell_in = 3, quality=1)]
      rose = GildedRose.new(items)
      rose.update_quality()
      rose.update_quality()
      expect(items[0].quality).to eq 3
    end

    it 'Does not increase the quality over 50' do
      items = [Item.new('Aged Brie', sell_in = 0, quality=49)]
      rose = GildedRose.new(items)
      rose.update_quality()
      rose.update_quality()
      expect(items[0].quality).to eq 50
    end

    it 'Increases in quality twice as fast after sell in date' do
      items = [Item.new('Aged Brie', sell_in = 0, quality=1)]
      rose = GildedRose.new(items)
      rose.update_quality()
      rose.update_quality()
      expect(items[0].quality).to eq 5
    end
  end

  context 'Generic item' do
    it 'Decreases in quality' do
      items = [Item.new('Generic item', sell_in = 3, quality=20)]
      rose = GildedRose.new(items)
      rose.update_quality()
      rose.update_quality()
      expect(items[0].quality).to eq 18
    end

    it 'After sell in date decreases in quality twice as fast' do
      items = [Item.new('Generic item', sell_in = 0, quality=20)]
      rose = GildedRose.new(items)
      rose.update_quality()
      rose.update_quality()
      expect(items[0].quality).to eq 16
    end

    it 'Does not decrease in quality below 0' do
      items = [Item.new('Generic item', sell_in = 0, quality=1)]
      rose = GildedRose.new(items)
      rose.update_quality()
      rose.update_quality()
      expect(items[0].quality).to eq 0
    end

    it 'Can have negative sell in date' do
      items = [Item.new('Generic item', sell_in = 0, quality=1)]
      rose = GildedRose.new(items)
      rose.update_quality()
      rose.update_quality()
      expect(items[0].sell_in).to eq(-2)
    end
  end
end
