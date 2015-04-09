
-- size
--FRAME_SIZE = cc.Director:getInstance():getOpenGLView():getFrameSize()
--ORIGIN = cc.Director:getInstance():getVisibleOrigin()
--VISIBLE_SIZE = cc.Director:getInstance():getVisibleSize()
--WIN_SIZE = cc.Director:getInstance():getWinSize()

PLANE_BULLET_TYPE               = 0
ENEMY_BULLET_TYPE               = 1

PLANE_CATEGORY_MASK             = 0x01
PLANE_COLLISION_MASK            = 0x00
PLANE_CONTACTTEST_MASK          = 0x0c
PLANE_BULLET_CATEGORY_MASK      = 0x02
PLANE_BULLET_COLLISION_MASK     = 0x00
PLANE_BULLET_CONTACTTEST_MASK   = 0x04

ENEMY_CATEGORY_MASK             = 0x04
ENEMY_COLLISION_MASK            = 0x00
ENEMY_CONTACTTEST_MASK          = 0x03

ENEMY_BULLET_CATEGORY_MASK      = 0x08
ENEMY_BULLET_COLLISION_MASK     = 0x00
ENEMY_BULLET_CONTACTTEST_MASK   = 0x01

--------------------------------------
CATEGORY_MASK_PLAYER_A          = 0x01
COLLISION_MASK_PLAYER_A         = 0x00
CONTACTTEST_MASK_PLAYER_A       = 0x0c

CATEGORY_MASK_PLAYER_A_ATK      = 0x01     -- 0001
COLLISION_MASK_PLAYER_A_ATK     = 0x00
CONTACTTEST_MASK_PLAYER_A_ATK   = 0x04      -- 0100

CATEGORY_MASK_PLAYER_B          = 0x04      -- 0100
COLLISION_MASK_PLAYER_B         = 0x00
CONTACTTEST_MASK_PLAYER_B       = 0x03      -- 0011

CATEGORY_MASK_PLAYER_B_ATK             = 0x04   -- 0011
COLLISION_MASK_PLAYER_B_ATK            = 0x00
CONTACTTEST_MASK_PLAYER_B_ATK          = 0x01   -- 0001