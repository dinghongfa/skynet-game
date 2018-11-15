--[[
	@ filename : share_memoryd.lua
	@ author   : zhangshiqian1214@163.com
	@ modify   : 2017-08-23 17:53
	@ company  : zhangshiqian1214
]]

local skynet = require "skynet"
local stm    = require "skynet.stm"

local command = {}

local stmobj_map = {}

function command.get_stmobj(name)
	local stmobj = stmobj_map[name]
	if not stmobj then
		return
	end
	return stm.copy(stmobj)
end

function command.set_stmobj(name, data)
	local stmobj = stmobj_map[name]
	if not stmobj then
		stmobj = stm.new(skynet.pack(data))
		stmobj_map[name] = stmobj
		return
	end
	stmobj(skynet.pack(data))
	return
end

skynet.start(function()
	skynet.dispatch("lua", function(session, address, cmd, ...)
		local f = command[cmd]
		if session > 0 then
			skynet.retpack(f(...))
		else
			f(...)
		end
	end)
end)