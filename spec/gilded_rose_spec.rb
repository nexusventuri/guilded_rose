require File.join(File.dirname(__FILE__), '..', 'lib', 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = wait_two_days([Item.new("foo", 0, 0)])
      expect(items[0].name).to eq "foo"
    end
  end

  context 'Aged brie' do
    it 'increases in quality every day' do
      items = wait_two_days([Item.new('Aged Brie', sell_in = 3, quality=1)])
      expect(items[0].quality).to eq 3
    end

    it 'does not increase the quality over 50' do
      items = wait_two_days([Item.new('Aged Brie', sell_in = 0, quality=49)])
      expect(items[0].quality).to eq 50
    end

    it 'increases in quality twice as fast after sell in date' do
      items = wait_two_days([Item.new('Aged Brie', sell_in = 0, quality=1)])
      expect(items[0].quality).to eq 5
    end

    it 'can have negative sell in date' do
      items = wait_two_days([Item.new('Aged Brie', sell_in = 0, quality=1)])
      expect(items[0].sell_in).to eq(-2)
    end
  end

  context 'Generic item' do
    it 'decreases in quality' do
      items = wait_two_days([Item.new('Generic item', sell_in = 3, quality=20)])
      expect(items[0].quality).to eq 18
    end

    it 'after sell in date decreases in quality twice as fast' do
      items = wait_two_days([Item.new('Generic item', sell_in = 0, quality=20)])
      expect(items[0].quality).to eq 16
    end

    it 'does not decrease in quality below 0' do
      items = wait_two_days([Item.new('Generic item', sell_in = 0, quality=1)])
      expect(items[0].quality).to eq 0
    end

    it 'can have negative sell in date' do
      items = wait_two_days([Item.new('Generic item', sell_in = 0, quality=1)])
      expect(items[0].sell_in).to eq(-2)
    end
  end

  context 'Conjured items' do
    it 'decreases in quality' do
      items = wait_two_days([Item.new('Conjured fish', sell_in = 3, quality=20)])
      expect(items[0].quality).to eq 16
    end

    it 'after sell in date decreases in quality twice as fast' do
      items = wait_two_days([Item.new('Conjured cake', sell_in = 0, quality=20)])
      expect(items[0].quality).to eq 12
    end

    it 'does not decrease in quality below 0' do
      items = wait_two_days([Item.new('Generic item', sell_in = 0, quality=1)])
      expect(items[0].quality).to eq 0
    end

    it 'can have negative sell in date' do
      items = wait_two_days([Item.new('Generic item', sell_in = 0, quality=1)])
      expect(items[0].sell_in).to eq(-2)
    end
  end

  context 'Sulfuras' do
    it 'does not change in value' do
      items = wait_two_days([Item.new('Sulfuras, Hand of Ragnaros', sell_in = 0, quality=80)])
      expect(items[0].quality).to eq 80
    end

    it 'can have negative sell in date' do
      items = wait_two_days([Item.new('Sulfuras, Hand of Ragnaros', sell_in = -1, quality=1)])
      expect(items[0].sell_in).to eq(-1)
    end
  end

  context 'Backstage passes' do
    it 'increases in value every day' do
      items = wait_two_days([Item.new('Backstage passes to a TAFKAL80ETC concert', sell_in = 50, quality=30)])
      expect(items[0].quality).to eq 32
    end

    it 'increases twice in value when there are 10 days or less from the concert' do
      items = wait_two_days([Item.new('Backstage passes to a TAFKAL80ETC concert', sell_in = 10, quality=30)])
      expect(items[0].quality).to eq 34
    end

    it 'increases the value by 3 when there are 5 days or less from the concert' do
      items = wait_two_days([Item.new('Backstage passes to a TAFKAL80ETC concert', sell_in = 5, quality=30)])
      expect(items[0].quality).to eq 36
    end

    it 'decreases the value to 0 after the concert' do
      items = wait_two_days([Item.new('Backstage passes to a TAFKAL80ETC concert', sell_in = 1, quality=30)])
      expect(items[0].quality).to eq 0
    end
  end

  def wait_two_days(items)
    rose = GildedRose.new(items)
    rose.update_quality()
    rose.update_quality()
    items
  end
end
