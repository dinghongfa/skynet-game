local root       = "../"
local skynetroot = root.."skynet/"
package.path     = skynetroot.."lualib/?.lua;"
package.cpath    = skynetroot.."luaclib/?.so;"
local parser     = require "sprotoparser"

local protoDir = root .. "sproto/"
local spbDir   = root .. "spb/"
local sprotoGen = {}

function sprotoGen.create(files)
  local dumpFiles = {}
  
  for k, v in pairs(files) do
    local filename = protoDir .. v
    local f = assert(io.open(filename), "Can't open sproto filename["..filename.."]")
    local data = f:read "a"
    dumpFiles[k] = dumpFiles[k] or ""
    dumpFiles[k] = dumpFiles[k] .. data
  end

  for k, v in pairs(dumpFiles) do
    local file = io.open(spbDir .. k ..".spb", "w+b")
    file:write(parser.parse(v))
    file:close()
  end
  
end

local files = {
  ["package"] = "package.sproto",
}
sprotoGen.create(c2sfiles, "C2S.spb")
