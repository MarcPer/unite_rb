
# unite_rb

Brings units to numeric variables in Ruby.

## Getting started

Install gem:

```
gem install unite_rb
```

Usage:

```ruby
require "unite_rb"

s = UniteRb::Scope.new
s.dimensions  = [:m, :km, :min, :s]

# Define relations between units using 'add', 'sub', 'mul', 'div'
s.equate(:km, s.mul(:m, 1000))
s.equate(:s, s.div(:min, 60))

dist_to_iss = s.var(408, :km)
dist_to_iss2 = s.var(408_000, :m)
time_to_sun = s.var(8, :min)

# Comparisons
dist_to_iss == dist_to_iss2 # => true
dist_to_iss > dist_to_iss2  # => false
dist_to_iss < time_to_sun # => UniteRb::UnrelatedDimensions: No relation exists between dimensions km and min

# Arithmetic
puts dist_to_iss + dist_to_iss2 # => 816 km

# Convert
time_to_sun_in_s = time_to_sun.convert(:s)
time_to_sun_in_s.dim  # => s
puts time_to_sun_in_s # => 480 s
```

## To be done

- Allow dimensions to be multiplied to generate new dimensions (e.g. `s.div(:m, :s)`)
- Enable complex relations between units, for example:
  ```ruby
  s = UniteRb::Scope.new
  s.dimensions  = [:C, :F]

  s.equate(:C, s.mul(5/9, s.sub(:F, 32))) # C = 5/9(F - 32)
  ```

