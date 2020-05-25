#####
# presentation slides:
#   https://docs.google.com/presentation/d/1CzU-_g-a3FBOrNyUYAgjqqwZOrEHIPYyvz7F2uga3m0/edit?usp=sharing
# command to run test:
#   rspec --format documentation 2020-05-19-rubysg-meetup-enumerator_spec.rb
#

require_relative "2020-05-19-rubysg-meetup-enumerator"

RSpec.describe FruitsBasket do
  subject { FruitsBasket.new }

  context "each" do
    let(:enum) { subject.each }

    it "returns an Enumerator when called without block" do
      expect(enum.class).to eq Enumerator
    end

    it "calls next and return yielded objects" do
      fruit_1 = enum.next
      expect(fruit_1.class).to eq Fruit
      expect(fruit_1.name).to eq "apple"

      fruit_2 = enum.next
      expect(fruit_2.class).to eq Fruit
      expect(fruit_2.name).to eq "banana"

      fruit_3 = enum.next
      expect(fruit_3.class).to eq Fruit
      expect(fruit_3.name).to eq "orange"
    end

    it "raise end iteration" do
      enum.next
      enum.next
      enum.next

      expect { enum.next }.to raise_error StopIteration
    end
  end

  context "custom_each" do
    let(:enum) { subject.custom_each }

    it "returns an Enumerator when called without block" do
      expect(enum.class).to eq CustomEnumerator
    end

    it "calls next and return yielded objects" do
      fruit_1 = enum.next
      expect(fruit_1.class).to eq Fruit
      expect(fruit_1.name).to eq "apple"

      fruit_2 = enum.next
      expect(fruit_2.class).to eq Fruit
      expect(fruit_2.name).to eq "banana"

      fruit_3 = enum.next
      expect(fruit_3.class).to eq Fruit
      expect(fruit_3.name).to eq "orange"
    end

    it "raise StopIteration when there are no more iterations" do
      enum.next
      enum.next
      enum.next

      expect { enum.next }.to raise_error StopIteration
    end
  end
end
