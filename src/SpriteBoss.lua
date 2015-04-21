--------------------------------------------------------------------------------
-- SpriteBoss
-- 【クラス】Player
-- @date 2014/12/24
-- @author  Cho Rai
local SpriteBoss = class("SpriteBoss", function()
    return cc.Sprite:create()
end)
SpriteBoss.active             = nil
SpriteBoss.canBeAttack        = nil
SpriteBoss.hp                 = nil
SpriteBoss.atk                = nil
SpriteBoss.power              = nil
SpriteBoss.speed              = nil
SpriteBoss.bulleSpeed         = nil
SpriteBoss.bulletPowerValue   = nil
SpriteBoss.delayTime          = nil
SpriteBoss.size               = nil
SpriteBoss.label_hp           = nil
SpriteBoss.slider_hp          = nil
SpriteBoss.action             = nil

local SPRITE_EVENT            = "SPRITE_BOSS_EVENT"

SpriteBoss.damage = {
    [1] = 123,
    [2] = 123,
    [3] = 123,
    [4] = 123,
    [5] = 123,
}

--------------------------------------------------------------------------------
-- ctor
function SpriteBoss:ctor()
    self.active = true
    self.canBeAttack = false
    self.hp = 20
    self.atk = 10000
    self.power = 1.0
    self.speed = 220
    self.bulleSpeed = 900
    self.bulletPowerValue = 1
    self.delayTime = 0.1
end
--------------------------------------------------------------------------------
-- create
function SpriteBoss:create()
    local player = SpriteBoss.new()
    player:init()
    return player
end

function SpriteBoss:addArmature()
    local node = cc.CSLoader:createNode("huchey.csb")
    self.action = cc.CSLoader:createTimeline("huchey.csb")
    node:runAction(self.action)
    self.action:play("idel", true)
    self:addChild(node)
    local function onFrameEvent(frame)
        if nil == frame then
            return
        end
        local str = frame:getEvent()
        if str == "hurted" then
            self.action:play("idel", true)
        elseif(str == "atked") then

            self.action:play("idel", true)
        end
    end
    self.action:setFrameEventCallFunc(onFrameEvent)

    local function callBack(event)
        local data = event._data
        self:playEvent(data)
    end
    --    EventDispatchManager:createEventDispatcher(self,"SELECT_CARD_FROM_FOOTER",callBack)
    EventDispatchManager:createEventDispatcher(self,SPRITE_EVENT,callBack)
end

function SpriteBoss:playEvent(data)
    self:addDamage(data)
    self.action:play(data.action, false)
end

function SpriteBoss:broadCastEvent(data)
    EventDispatchManager:broadcastEventDispatcher(SPRITE_EVENT,data)
end
--------------------------------------------------------------------------------
-- init
function SpriteBoss:init()
    self:addArmature()
    self:setPosition(cc.p(WIN_SIZE.width/2, WIN_SIZE.height/2 + 80))
    -- hp value
    self.label_hp = cc.Label:createWithBMFont("Font/arial-14.fnt", self.hp)
    self.label_hp:setSystemFontSize(30)
    self.label_hp:setColor(cc.c3b(255,255, 255))

    --    local hp = ccui.ImageView:create()
    --    hp:setScale(0.3)
    --    hp:setPosition(self.size.width/2 ,self.size.height + 20)
    --    hp:loadTexture("status_hp.png")
    --    hp:addChild(self.label_hp)
    --    self:addChild(hp)
    --    self.label_hp:setPosition(hp:getContentSize().width/2,hp:getContentSize().height/2)
end
--------------------------------------------------------------------------------
-- attack
function SpriteBoss:attack()
end
--------------------------------------------------------------------------------
-- hurt
function SpriteBoss:hurt(damageValue)
    self.hp = self.hp - damageValue
    self.label_hp:setString(self.hp)

    self.action:play("hurt",false)
    if self.hp <= 0 then
        self.active = false
    end
end
--------------------------------------------------------------------------------
-- isCanAttack
function SpriteBoss:isCanAttack()
    return self.canBeAttack
end
--------------------------------------------------------------------------------
-- isActive
function SpriteBoss:isActive()
    return self.active
end
--------------------------------------------------------------------------------
-- destroy
function SpriteBoss:destroy()
    if Global:getInstance():getAudioState() == true then
        cc.SimpleAudioEngine:getInstance():playEffect("Music/shipDestroyEffect.mp3")
    end
    self:removeFromParent()
end

function SpriteBoss:addDamage(data)
    local labelAtlas = ccui.TextAtlas:create()

    local count = data.count
    local type = data.type

    local function actionEnd()
    end

    local damage = 0
    if count >= 4 then
        damage = self.damage[type] * count * 2 -- 4个以上伤害x2
        local action1 = cc.ScaleTo:create(0.1, 2)
        local action2 = cc.ScaleTo:create(0.1, 1.5)
        local action3 = cc.DelayTime:create(1.5)
        local action4 = cc.FadeOut:create(0.5)
        local action5 = cc.DelayTime:create(0.5)
        local action6 = cc.RemoveSelf:create()
        local action7 = cc.CallFunc:create(actionEnd)
        labelAtlas:runAction(cc.Sequence:create(action1, action2,action3,action4,action5,action6,action7))
    else
        damage = self.damage[type] * count
        local action1 = cc.MoveBy:create(2,cc.p(0,80))
        local action2 = cc.FadeOut:create(2)
        local action = cc.Spawn:create(action1,action2)
        local action4 = cc.RemoveSelf:create()
        labelAtlas:runAction(cc.Sequence:create(action,action4))
    end

    labelAtlas:setProperty(damage, "labelatlas.png", 17, 22, "0")
    labelAtlas:setPosition(self:getContentSize().width/2,self:getContentSize().height)
    self:addChild(labelAtlas)
end

function SpriteBoss:getPosition()
    local pos = {}
    pos.x = self:getPositionX()
    pos.y = self:getPositionY()
    return pos
end

return SpriteBoss