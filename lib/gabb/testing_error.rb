class TestingError < StandardError

  def to_s
    Pry.start(binding)
    "Testing Error: The code works, but does not work as intended"
  end

end
