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
end
