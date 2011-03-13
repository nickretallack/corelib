(->
  rgbParser = /^rgba?\((\d{1,3}),\s*(\d{1,3}),\s*(\d{1,3}),?\s*(\d\.?\d*)?\)$/

  toHex = (bits) ->
    s = parseInt(bits).toString(16)

    s = '0' + s if s.length == 1 
 
  parseColor = (colorString) ->
    false if !colorString || colorString == 'transparent'

    bits = rgbParser.exec(colorString)
    return [
      bits[1]
      bits[2]
      bits[3]
    ]

  window.Color = (color) ->
    color ||= "rgba(0, 0, 0, 0)"
    
    parsedColor = null

    if color[0] != "#"
      parsedColor = "#" + (parseColor(color) || "FFFFFF")
    else
      parsedColor = parseColor(color)
      
    alpha = parsedColor[4]

    channels = [
      parseInt(parsedColor[1]) 
      parseInt(parsedColor[2])
      parseInt(parsedColor[3])
      if alpha? then parseFloat(alpha) else 0.0
    ]

    self =
      channels: channels
      r: (val) ->
        if val?
          channels[0] = val
          return self
        else
          channels[0]
        
      g: (val) ->
        if val?
          channels[1] = val
          return self
        else
          channels[1]
          
      b: (val) ->
        if val?
          channels[2] = val
          return self
        else
          channels[2]
          
      a: (val) ->
        if val?
          channels[3] = val
          return self
        else
          channels[3]

      equals: (other) ->
        return other.r == self.r &&
          other.g == self.g &&
          other.b == self.b &&
          other.a = self.a

      rgba: ->
        return "rgba(#{self.r}, #{self.g}, #{self.b}, #{self.a})"

      toString: ->
        return (if self.a == 1 then toHex([self.r, self.g, self.b]) else self.rgba())

    return self
)()
