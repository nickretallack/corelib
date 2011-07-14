( ->
  module "Point"

  test "#add", ->
    p1 = Point(5, 6)
    p2 = Point(7, 5)

    result = p1.add(p2)

    equals result.x, p1.x + p2.x
    equals result.y, p1.y + p2.y

  test "#add two arg", ->
    point = Point(3, 7)
    x = 2
    y = 1

    result = point.add(x, y)

    equals result.x, point.x + x
    equals result.y, point.y + y

  test "#subtract", ->
    p1 = Point(5, 6)
    p2 = Point(7, 5)

    result = p1.subtract(p2)

    equals result.x, p1.x - p2.x
    equals result.y, p1.y - p2.y

  test "#norm", ->
    p = Point(2, 0)

    normal = p.norm()
    equals normal.x, 1

    normal = p.norm(5)    
    equals normal.x, 5

  test "#scale", ->
    p1 = Point(5, 6)
    scalar = 2

    result = p1.scale(scalar)

    equals result.x, p1.x * scalar
    equals result.y, p1.y * scalar

  test "#floor", ->
    p1 = Point(7.2, 6.9)

    ok Point(7, 6).equal(p1.floor())

  test "#equal", ->
    ok Point(7, 8).equal(Point(7, 8))

  test "#magnitude", ->
    equals Point(3, 4).magnitude(), 5

  test ".fromAngle", ->
    p = Point.fromAngle(Math.TAU / 4)

    equalEnough p.x, 0, TOLERANCE
    equals p.y, 1

  module undefined
)()

