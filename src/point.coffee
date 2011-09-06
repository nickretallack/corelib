( ->
  ###*
  Create a new point with given x and y coordinates. If no arguments are given
  defaults to (0, 0).

  <code><pre>
     point = Point()

     p.x
  => 0

     p.y
  => 0

     point = Point(-2, 5)

     p.x
  => -2

     p.y
  => 5
  </pre></code>

  @name Point
  @param {Number} [x]
  @param {Number} [y]
  @constructor
  ###
  Point = (x, y) ->
    __proto__: Point::

    ###*
    The x coordinate of this point.
    @name x
    @fieldOf Point#
    ###
    x: x || 0
    ###*
    The y coordinate of this point.
    @name y
    @fieldOf Point#
    ###
    y: y || 0

  Point:: =
    ###*
    Creates a copy of this point.

    @name copy
    @methodOf Point#
    @type Point
    @returns A new point with the same x and y value as this point.

    <code><pre>
      point = Point(1, 1)
      pointCopy = point.copy()

      point.equal(pointCopy)
      => true

      point == pointCopy
      => false     
    </pre></code>
    ###
    copy: ->
      Point(@x, @y)

    ###*
    Adds a point to this one and returns the new point. You may
    also use a two argument call like <code>point.add(x, y)</code>
    to add x and y values without a second point object.

    <code><pre>
       point = Point(2, 3).add(Point(3, 4))

       point.x
    => 5

       point.y
    => 7

       anotherPoint = Point(2, 3).add(3, 4)

       anotherPoint.x
    => 5

       anotherPoint.y
    => 7
    </pre></code>

    @name add
    @methodOf Point#
    @param {Point} other The point to add this point to.
    @returns {Point} A new point, the sum of both.
    ###
    add: (first, second) ->
      @copy().add$(first, second)

    ###*
    Adds a point to this one, returning a modified point. You may
    also use a two argument call like <code>point.add(x, y)</code>
    to add x and y values without a second point object.

    <code><pre>
       point = Point(2, 3)

       point.x
    => 2

       point.y
    => 3

       point.add$(Point(3, 4))

       point.x
    => 5

       point.y
    => 7

       anotherPoint = Point(2, 3)
       anotherPoint.add$(3, 4)

       anotherPoint.x
    => 5

       anotherPoint.y
    => 7
    </pre></code>

    @name add$
    @methodOf Point#
    @param {Point} other The point to add this point to.
    @returns {Point} The sum of both points.
    ###
    add$: (first, second) ->
      if second?
        @x += first
        @y += second
      else
        @x += first.x
        @y += first.y

      return this

    ###*
    Subtracts a point to this one and returns the new point.

    <code><pre>
       point = Point(1, 2).subtract(Point(2, 0))

       point.x
    => -1

       point.y
    => 2

       anotherPoint = Point(1, 2).subtract(2, 0)

       anotherPoint.x
    => -1

       anotherPoint.y
    => 2
    </pre></code>

    @name subtract
    @methodOf Point#

    @param {Point} other The point to subtract from this point.
    @returns {Point} A new point, this - other.
    ###
    subtract: (first, second) ->
      @copy().subtract$(first, second)

    ###*
    Subtracts a point to this one and returns the new point.

    <code><pre>
       point = Point(1, 2)

       point.x
    => 1

       point.y
    => 2

       point.subtract$(Point(2, 0))

       point.x
    => -1

       point.y
    => 2

       anotherPoint = Point(1, 2)
       anotherPoint.subtract$(2, 0)

       anotherPoint.x
    => -1

       anotherPoint.y
    => 2
    </pre></code>

    @name subtract$
    @methodOf Point#

    @param {Point} other The point to subtract from this point.
    @returns {Point} The difference of the two points.
    ###
    subtract$: (first, second) ->
      if second?
        @x -= first
        @y -= second
      else
        @x -= first.x
        @y -= first.y

      return this

    ###*
    Scale this Point (Vector) by a constant amount.

    <code><pre>
       point = Point(5, 6).scale(2)

       point.x
    => 10

       point.y
    => 12
    </pre></code>

    @name scale
    @methodOf Point#

    @param {Number} scalar The amount to scale this point by.
    @returns {Point} A new point, this * scalar.
    ###
    scale: (scalar) ->
      @copy().scale$(scalar)

    ###*
    Scale this Point (Vector) by a constant amount. Modifies the point in place.

    <code><pre>
       point = Point(5, 6)

       point.x
    => 5

       point.y
    => 6

       point.scale$(2)

       point.x
    => 10

       point.y
    => 12
    </pre></code>

    @name scale$
    @methodOf Point#

    @param {Number} scalar The amount to scale this point by.
    @returns {Point} this * scalar.
    ###
    scale$: (scalar) ->
      @x *= scalar
      @y *= scalar

      return this

    ###*
    The norm of a vector is the unit vector pointing in the same direction. This method
    treats the point as though it is a vector from the origin to (x, y).

    <code><pre>
       point = Point(2, 3).norm()

       point.x
    => 0.5547001962252291

       point.y  
    => 0.8320502943378437

       anotherPoint = Point(2, 3).norm(2)

       anotherPoint.x
    => 1.1094003924504583

       anotherPoint.y   
    => 1.6641005886756874    
    </pre></code>

    @name norm
    @methodOf Point#

    @returns {Point} The unit vector pointing in the same direction as this vector.
    ###
    norm: (length=1.0) ->
      @copy().norm$(length)

    ###*
    The norm of a vector is the unit vector pointing in the same direction. This method
    treats the point as though it is a vector from the origin to (x, y). Modifies the point in place.

    <code><pre>
       point = Point(2, 3).norm$()

       point.x
    => 0.5547001962252291

       point.y  
    => 0.8320502943378437

       anotherPoint = Point(2, 3).norm$(2)

       anotherPoint.x
    => 1.1094003924504583

       anotherPoint.y   
    => 1.6641005886756874    
    </pre></code>

    @name norm$
    @methodOf Point#

    @returns {Point} The unit vector pointing in the same direction as this vector.
    ###
    norm$: (length=1.0) ->
      if m = @length()
        @scale$(length/m)
      else
        this

    ###*
    Floor the x and y values, returning a new point.

    <code><pre>
       point = Point(3.4, 5.8).floor()

       point.x
    => 3

       point.y
    => 5
    </pre></code>

    @name floor
    @methodOf Point#
    @returns {Point} A new point, with x and y values each floored to the largest previous integer.
    ###
    floor: ->
      @copy().floor$()

    ###*
    Floor the x and y values, returning a modified point.

    <code><pre>
       point = Point(3.4, 5.8)
       point.floor$()

       point.x
    => 3

       point.y
    => 5
    </pre></code>

    @name floor$
    @methodOf Point#
    @returns {Point} A modified point, with x and y values each floored to the largest previous integer.
    ###
    floor$: ->
      @x = @x.floor()
      @y = @y.floor()

      return this

    ###*
    Determine whether this point is equal to another point.
    @name equal
    @methodOf Point#

    @param {Point} other The point to check for equality.
    @returns {Boolean} true if the other point has the same x, y coordinates, false otherwise.
    ###
    equal: (other) ->
      @x == other.x && @y == other.y

    ###*
    Computed the length of this point as though it were a vector from (0,0) to (x,y)
    @name length
    @methodOf Point#

    @returns The length of the vector from the origin to this point.
    @type Number
    ###
    length: ->
      Math.sqrt(@dot(this))

    ###*
    Calculate the magnitude of this Point (Vector).
    @name magnitude
    @methodOf Point#

    @returns The magnitude of this point as if it were a vector from (0, 0) -> (x, y).
    @type Number
    ###
    magnitude: ->
      @length()

    ###*
    Returns the direction in radians of this point from the origin.
    @name direction
    @methodOf Point#

    @type Number
    ###
    direction: ->
      Math.atan2(@y, @x)

    ###*
    Calculate the dot product of this point and another point (Vector).
    @name dot
    @methodOf Point#

    @param {Point} other The point to dot with this point.
    @returns The dot product of this point dot other as a scalar value.
    @type Number
    ###
    dot: (other) ->
      @x * other.x + @y * other.y

    ###*
    Calculate the cross product of this point and another point (Vector). 
    Usually cross products are thought of as only applying to three dimensional vectors,
    but z can be treated as zero. The result of this method is interpreted as the magnitude 
    of the vector result of the cross product between [x1, y1, 0] x [x2, y2, 0]
    perpendicular to the xy plane.
    @name cross
    @methodOf Point#

    @param {Point} other The point to cross with this point.
    @returns The cross product of this point with the other point as scalar value.
    @type Number
    ###
    cross: (other) ->
      @x * other.y - other.x * @y

    ###*
    Computed the Euclidean between this point and another point.
    @name distance
    @methodOf Point#

    @param {Point} other The point to compute the distance to.
    @returns The distance between this point and another point.
    @type Number
    ###
    distance: (other) ->
      Point.distance(this, other)

  ###*
  @name distance
  @fieldOf Point
  @param {Point} p1
  @param {Point} p2
  @returns {Number} The Euclidean distance between two points.
  ###
  Point.distance = (p1, p2) ->
    Math.sqrt(Math.pow(p2.x - p1.x, 2) + Math.pow(p2.y - p1.y, 2))

  ###*
  Construct a point on the unit circle for the given angle.

  @name fromAngle
  @fieldOf Point

  @param {Number} angle The angle in radians
  @returns {Point} The point on the unit circle.
  ###
  Point.fromAngle = (angle) ->
    Point(Math.cos(angle), Math.sin(angle))

  ###*
  If you have two dudes, one standing at point p1, and the other
  standing at point p2, then this method will return the direction
  that the dude standing at p1 will need to face to look at p2.

  @name direction
  @fieldOf Point

  @param {Point} p1 The starting point.
  @param {Point} p2 The ending point.
  @returns {Number} The direction from p1 to p2 in radians.
  ###
  Point.direction = (p1, p2) ->
    Math.atan2(
      p2.y - p1.y,
      p2.x - p1.x
    )

  ###*
  @name ZERO
  @fieldOf Point

  @type Point
  ###
  Point.ZERO = Point()

  if Object.freeze
    Object.freeze Point.ZERO

  (exports ? this)["Point"] = Point
)()

