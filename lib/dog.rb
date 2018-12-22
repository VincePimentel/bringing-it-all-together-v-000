class Dog
  attr_accessor :name, :breed
  attr_reader :id

  def initialize(info = {name, breed, id = nil})
    @id = info[:id]
    @name = info[:name]
    @breed = info[:breed]
  end

end
