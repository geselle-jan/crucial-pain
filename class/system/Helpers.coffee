Helpers = 
    GetRandom: (low, high) ->
        ~ ~(Math.random() * (high - low)) + low
    GetDirectionFromVelocity: (sprite, tolerance) ->
        vel = sprite.body.velocity
        v = undefined
        h = undefined
        x = vel.x
        y = vel.y
        if x == 0
            h = 'none'
        if x > 0
            h = 'Right'
        if x < 0
            h = 'Left'
        if y == 0
            v = 'none'
        if y > 0
            v = 'Down'
        if y < 0
            v = 'Up'
        if h == 'none' and v == 'none'
            return 'standDown'
        x = Math.abs(x)
        y = Math.abs(y)
        if x > y
            h = if x < tolerance then 'stand' + h else 'walk' + h
            h
        else
            v = if y < tolerance then 'stand' + v else 'walk' + v
            v
    ScoreToString: (s) ->
        ms = s % 1000
        s = (s - ms) / 1000
        str = '' + s + '.' + Math.floor(ms / 100) + 's'
        str