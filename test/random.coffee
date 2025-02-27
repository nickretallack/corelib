module "Random"

test "methods", ->
  ok(Random.angle)
  ok(Random.often)
  ok(Random.sometimes)

test "Global rand", ->
  n = rand(2)
  ok(n == 0 || n == 1, "rand(2) gives 0 or 1")
  
  f = rand();
  ok(f <= 1 || f >= 0, "rand() gives numbers between 0 and 1")

module()