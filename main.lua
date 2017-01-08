-- main.lua

Gamestate = require "lib/Gamestate"
local bump = require "lib/bump"
require "math"

require "states/menu"
require "states/game"

-- global copy function
function copy(obj, seen)
  if type(obj) ~= 'table' then return obj end
  if seen and seen[obj] then return seen[obj] end
  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
  return res
end

-- some global variables
windowWidth = nil
windowHeight = nil
world = bump.newWorld() -- create a world with bump

function love.load(arg)
  math.randomseed(os.time()) -- seed love.math.rand() using os time
  love.graphics.setDefaultFilter("nearest", "nearest") -- set nearest pixel distance

  love.window.setMode(576, 480, {resizable=false, vsync=true, msaa=0}) -- set the window mode
  windowWidth = love.graphics.getWidth()
  windowHeight = love.graphics.getHeight()

  -- load fonts
  smallFont = love.graphics.newFont("lib/kenpixel_mini.ttf", 14)
  medFont = love.graphics.newFont("lib/kenpixel_mini.ttf", 25)
  bigFont = love.graphics.newFont("lib/kenpixel_mini.ttf", 100)
  love.graphics.setFont(bigFont)

  Gamestate.registerEvents() -- prep Gamestate
  Gamestate.switch(menu) -- swtich to the main menu screenl
end
