
local Ball = class("Ball", function()
    return cc.Sprite:create("status_hp.png")
end)

Ball.MOVING = 0
Ball.BROKEN = 1

Ball._state = 0

Ball.size = 0

function Ball:ctor()
end

function Ball:create()
    local ball = Ball.new()
    ball:init()
    return ball
end

function Ball:init()
--    local texture = cc.Director:getInstance():getTextureCache():addImage("status_hp.png")
--    local spriteFrame = cc.SpriteFrame:createWithTexture(texture, cc.rect(0, 0, self.size, self.size))
--    self:createWithSpriteFrame(spriteFrame)
    
--    self:setScale(1)
    local size = self:getContentSize()
    self.size = size.width/2
    local pBall = cc.PhysicsBody:createCircle(size.width/2, cc.PhysicsMaterial(1.0, 0.6, 0.3))
    pBall:setDynamic(true)
    pBall:setRotationEnable(true)
    pBall:setMoment(PHYSICS_INFINITY)
    pBall:setMass(1.0)
    self:setPhysicsBody(pBall)
end


function Ball:brokenBullet()
    self:stopAllActions()
    local remove = cc.RemoveSelf:create()
    self:runAction(remove)
    self._state = self.BROKEN
end

function Ball:getState()
    return self._state
end

return Ball

