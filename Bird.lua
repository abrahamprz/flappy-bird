--[[
    Bird Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The Bird is what we control in the game via clicking or the space bar; whenever we press either,
    the bird will flap and go up a little bit, where it will then be affected by gravity. If the bird hits
    the ground or a pipe, the game is over.
]]

Bird = Class{}

local GRAVITY = 10
local JUMP_HEIGHT = GRAVITY / 5
local LEFT_TOP_OFFSET = 2
local RIGHT_BOTTOM_OFFSET = 4

function Bird:init()
    -- load bird image from disk and assign its width and height
    self.image = love.graphics.newImage('bird.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    -- position bird in the middle of the screen
    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)

    -- Y velocity; gravity
    self.dy = 0
end

function Bird:collides(pipe)
    -- both offsets are used to shrink the bounding box to give the player
    -- a little of a leeway with the collision
    if (self.x + LEFT_TOP_OFFSET) + (self.width - RIGHT_BOTTOM_OFFSET) >= pipe.x and self.x + LEFT_TOP_OFFSET <= pipe.x + PIPE_WIDTH then
        if (self.y + LEFT_TOP_OFFSET) + (self.height - RIGHT_BOTTOM_OFFSET) >= pipe.y and self.y + LEFT_TOP_OFFSET <= pipe.y + PIPE_HEIGHT then
            return true
        end
    end

    return false
end

function Bird:update(dt)
    -- apply gravity to velocity
    self.dy = self.dy + GRAVITY * dt

    -- add a sudden burst of negative gravity if we hit the space bar
    if love.keyboard.wasPressed('space') then
        self.dy = -JUMP_HEIGHT
    end

    -- apply current velocity to Y position
    self.y = self.y + self.dy
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end