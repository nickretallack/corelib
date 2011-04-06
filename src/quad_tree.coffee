((window) ->
  QuadTree = (I) ->
    I ||= {}
    
    $.reverseMerge I,
      bounds:
        x: 0
        y: 0
        width: 480
        height: 320
      maxDepth: 4
      maxChildren: 5
      
    root = Node(I.bounds, I.maxDepth, I.maxChildren)

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
      
    findIndex = (item) ->
      bounds = I.bounds
      left = !(item.x > bounds.x + bounds.width / 2)
      top = !(item.y > bounds.y + bounds.height / 2)
            
      index = TOP_LEFT
      
      if left && !top
        index = BOTTOM_LEFT
      else
        if top
          index = TOP_RIGHT
        else
          index = BOTTOM_RIGHT
      
      return index
      
    self =
      I: I
      
      clear: ->
        I.children.clear()
        
        I.nodes.invoke('clear')
        
        I.nodes.clear()
    
      insert: (item) ->
        index = findIndex(item)
       
        if I.nodes.length
          return I.nodes[index].insert(item)
          
        I.children.push(item)
        
        if (I.depth < I.maxDepth) && (I.children.length > I.maxChildren)
          self.subdivide()
          
          I.children.each (child) ->
            self.insert(child)
          
          I.children.clear()    
      
      retrieve: (item) ->
        if I.nodes.length
          index = findIndex(item)
    
          return I.nodes[index].retrieve(item)
      
        return I.children    
          
      subdivide: ->
        increased_depth = I.depth + 1
    
        x_bounds = I.bounds.x
        y_bounds = I.bounds.y
        width = I.bounds.width
        height = I.bounds.height
        
        half_width = (width / 2).floor() 
        half_height = (height / 2).floor()
        x_midpoint = x_bounds + half_width
        y_midpoint = y_bounds + half_height  
        
        I.nodes[TOP_LEFT] = Node
          bounds:
            x: x_bounds
            y: y_bounds
            width: half_width
            height: half_height
          depth: increased_depth
          
        I.nodes[TOP_RIGHT] = Node
          bounds:
            x: x_midpoint
            y: y_bounds
            width: half_width
            height: half_height
          depth: increased_depth
          
        I.nodes[BOTTOM_LEFT] = Node
          bounds:
            x: x_bounds
            y: y_midpoint
            width: half_width
            height: half_height
          depth: increased_depth
          
        I.nodes[BOTTOM_RIGHT] = Node
          bounds:
            x: x_midpoint
            y: y_midpoint
            width: half_width
            height: half_height
          depth: increased_depth
    
    self
      
  window.QuadTree = QuadTree
)(window)