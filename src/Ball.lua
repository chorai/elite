
local Ball = class("Ball", function()
    return cc.Sprite:create("ball_hell.png")
end)

Ball.MOVING = 0
Ball.BROKEN = 1

Ball._state = 0
Ball._type = 0

Ball.size = 0
Ball.scalePer = 0.3 -- TODO 这个要弄成可变的！！

Ball.type = {
    [1] = "ball_adore.png",
    [2] = "ball_boom.png",
    [3] = "ball_boss.png",
    [4] = "ball_cold.png",
    [5] = "ball_hell.png",
}

function Ball:ctor()
end

function Ball:create(type)
    local ball = Ball.new()
    ball:init(type)
    return ball
end

function Ball:init(type)
    self._type = type
    self:setTexture(cc.Director:getInstance():getTextureCache():addImage(self.type[type]))
    local size = self:getContentSize()
--    if type == 2 then
--        self.scalePer = 0.4
--    else
--        self.scalePer= 0.25
--    end
    self:setScale(self.scalePer)
    self.size = (size.width/2) * self.scalePer
    local pBall = cc.PhysicsBody:createCircle(((size.width-10)/2) * self.scalePer, cc.PhysicsMaterial(1, 0, 0.4))
    --    local w = (size.width/2) * self.scalePer
    --    local pBall = cc.PhysicsBody:createBox(cc.size(w, w),cc.PhysicsMaterial(1, 0.6, 0.3))
    pBall:setDynamic(true)
    pBall:setRotationEnable(true)
    --    pBall:setMoment(PHYSICS_INFINITY) --モーメント(大きいほど回転しにくい)
    pBall:setMass(1.0) --重さ
    self:setPhysicsBody(pBall)
end


function Ball:brokenBullet()
    self:stopAllActions()
    local remove = cc.RemoveSelf:create()
    self:runAction(remove)
    self._state = self.BROKEN
end

function Ball:getPosition()
    local pos = {}
    pos.x = self:getPositionX()
    pos.y = self:getPositionY()
    return pos
end

function Ball:getState()
    return self._state
end

function Ball:getType()
    return self._type
end

return Ball

