
local Ball = class("Ball", function()
    return cc.Sprite:create("ball_hell.png")
end)

Ball.MOVING = 0
Ball.BROKEN = 1

Ball._state = 0
Ball._type = 0

Ball.size = 0
Ball.scalePer = 0.32 -- TODO 这个要弄成可变的！！
--Ball.scalePer = 0.5 -- TODO 这个要弄成可变的！！

--Ball.type = {
--    [1] = "donat_1.png",
--    [2] = "donat_2.png",
--    [3] = "donat_3.png",
--    [4] = "donat_4.png",
--    [5] = "cat_1.png",
--}

Ball.type = {
    [1] = "cat_1.png",
    [2] = "cat_1.png",
    [3] = "cat_1.png",
    [4] = "cat_1.png",
    [5] = "cat_1.png",
}

--Ball.type = {
--    [1] = "tsum_1.png", --毒
--    [2] = "tsum_2.png", --ATK
--    [3] = "tsum_1.png", --DEF
--    [4] = "tsum_2.png",
--    [5] = "tsum_2.png",--freeze
--}

function Ball:ctor()
end

function Ball:create(type)
    local ball = Ball.new()
    ball:init(type)
    return ball
end

function Ball:init(type)
  
    local _tagColor = {
        [1] = cc.c3b(30,92,9),
        [2] = cc.c3b(2,105,248),
        [3] = cc.c3b(239,225,13),
        [4] = cc.c3b(239,255,180),
        [5] = cc.c3b(255,255,255),
    }
    self:setColor(_tagColor[type])
    
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
    local pBall = cc.PhysicsBody:createCircle((self.size), cc.PhysicsMaterial(1, 0, 0.4))
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

