((window) ->
  QuadTree = (I) ->
    I ||= {}
    
    $.reverseMerge I,
      bounds:
        x: 0
        y: 0
        width: 480
        height: 320
      maxChildren: 5        
      maxDepth: 4
      
    root = Node
      bounds: I.bounds 
      maxDepth: I.maxDepth
      maxChildren: I.maxChildren

    self =
      I: I
      
      root: -> root
    
      clear: -> root.clear()
    
      insert: (obj) ->
        if Object.isArray(obj)
          obj.each (item) ->
            root.insert(item) 
        else
          root.insert(obj)
              
      retrieve: (item) -> root.retrieve(item).copy()
        
    self
      
  Node = (I) ->
    I ||= {}
    
    $.reverseMerge I,
      bounds: 
        x: 0
        y: 0
        width: 120
        height: 80
      children: []
      depth: 0
      maxChildren: 5
      maxDepth: 4
      nodes: []
      
    TOP_LEFT = 0
    TOP_RIGHT = 1
    BOTTOM_LEFT = 2
    BOTTOM_RIGHT = 3
      
    findQuadrants = (item) ->
      bounds = I.bounds
      
      x = bounds.x
      y = bounds.y
      
      x_midpoint = x + halfWidth()
      y_midpoint = y + halfHeight()
      
      left = item.x <= x_midpoint
      right = item.x + item.width > x_midpoint
      top = item.y <= y_midpoint
      bottom = item.y + item.height > y_midpoint
            
      quadrants = []
      
      if left
        if top
          quadrants.push(TOP_LEFT)
        if bottom
          quadrants.push(BOTTOM_LEFT)
      else
        if top
          quadrants.push(TOP_RIGHT)
        if bottom
          quadrants.push(BOTTOM_RIGHT)
      
      return quadrants
      
    halfWidth = -> (I.bounds.width / 2).floor()     
    halfHeight = -> (I.bounds.height / 2).floor()

    subdivide = ->
      increased_depth = I.depth + 1
            
      half_width = halfWidth() 
      half_height = halfHeight()
       
      4.times (n) ->
        I.nodes[n] = Node
          bounds:
            x: half_width * (n % 2)
            y: half_height * (if n < 2 then 0 else 1)
            width: half_width
            height: half_height
          depth: increased_depth
          maxChildren: I.maxChildren
          maxDepth: I.maxDepth
 
    self =
      I: I
      
      clear: ->
        I.children.clear()
        
        I.nodes.invoke('clear')
        
        I.nodes.clear()
    
      insert: (item) ->
        if I.nodes.length
          index = findQuadrant(item)
        
          I.nodes[index].insert(item)
        
          return true
          
        I.children.push(item)
        
        if (I.depth < I.maxDepth) && (I.children.length > I.maxChildren)
          subdivide()
          
          I.children.each (child) ->
            self.insert(child)
          
          I.children.clear()    
      
      retrieve: (item) ->
        quadrants = findQuadrants(item)
        
        quadrants.each (quadrant) ->
          return I.nodes[quadrant]?.retrieve(item) || I.children  
                      
    self
      
  window.QuadTree = QuadTree
)(window)