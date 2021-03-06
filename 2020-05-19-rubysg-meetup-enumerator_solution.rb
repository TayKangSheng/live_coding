#####
# presentation slides:
#   https://docs.google.com/presentation/d/1CzU-_g-a3FBOrNyUYAgjqqwZOrEHIPYyvz7F2uga3m0/edit?usp=sharing
# command to run test:
#   rspec --format documentation 2020-05-19-rubysg-meetup-enumerator_spec.rb
#

require "pry"

class Fruit
  attr_accessor :name, :weight

  def initialize(name, weight)
    @name = name
    @weight = weight
  end
end

class FruitsBasket
  def each
    return enum_for(:each) if not block_given?

    yield Fruit.new("apple", 2)
    yield Fruit.new("banana", 1)
    yield Fruit.new("orange", 3)
  end

  def custom_each
    return CustomEnumerator.enum_for(self, :custom_each) if not block_given?

    yield Fruit.new("apple", 2)
    yield Fruit.new("banana", 1)
    yield Fruit.new("orange", 3)
  end
end

class CustomEnumerator
  def self.enum_for(object, method)
    CustomEnumerator.new(object, method)
  end

  def initialize(object, method)
    @fiber = Fiber.new do
      object.send(method) do |x|
        Fiber.yield(x)
      end
    end
  end

  def next
    @fiber.resume ||
      raise(StopIteration.new("iteration reached an end"))
  end
end
