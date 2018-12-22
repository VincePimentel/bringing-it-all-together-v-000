class Dog
  attr_accessor :name, :breed
  attr_reader :id

  def initialize(id = nil, hash)
    @id = id
  end

end
