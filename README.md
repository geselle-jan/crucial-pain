# crucial-pain

An HTML5 game by out of scope.

## creating new levels

To create new levels you have to use the [Tiled Map Editor](http://www.mapeditor.org).
With tiled you can then open the template file `/asset/level/template.tmx` and change to size of the map.
Then you can either copy and pase the sample entities or stamp new ones to the object an wall layer.
To get an idea which properties are supported take a closer look at the property fields of the existing entities.

## inserting levels into the game

Finished Levels can be inserted by opening `/class/state/Preloader.coffee` and adding the exported tiled json file to the tilemap.
Make sure that you keep the naming convention of consecutive numbers, as the level manager will look for the next map by incrementing the current map name.