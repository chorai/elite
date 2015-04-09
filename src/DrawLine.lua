
local DrawLine = class("DrawLine", function()
    return cc.DrawNode:create()
end)

function DrawLine:ctor()
end

function DrawLine:create(vecs)
    local drawLine = DrawLine.new()
    drawLine:init(vecs)
    return drawLine
end

function DrawLine:init(vecs)

    local temVec = nil
    if vecs ~= nil then
        for key, var in ipairs(vecs) do
            if temVec ~=nil then
                self:drawSegment(cc.p(temVec.x,temVec.y),cc.p(var.x,var.y),3,cc.c4f(255,255,255,255))
                temVec = var
            end
        end
    end

end


function DrawLine:remove()
    local remove = cc.RemoveSelf:create()
    self:runAction(remove)
end

return DrawLine