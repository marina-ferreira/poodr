# Bad 🤢
def diameters # has more than one responsibility
  wheel.collect do |wheel|
    wheel.rim + wheel.tire * 2
  end
end

# Good 😻
def diameters
  wheel.collect { |wheel| diameter(wheel) }
end

def diameter(wheel)
  wheel.rim + wheel.tire * 2
end

# Bad 🤢
def gear_inches # calculates the gear_inches AND calculates the wheel diameter
  ratio * (rim + tire * 2)
end

# Good 😻
def gear_inches
  ratio * diameter
end

def diameter
  rim + tire * 2
end
