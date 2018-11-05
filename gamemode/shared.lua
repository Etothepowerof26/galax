GM.Name = "Cosmic"
GM.Author = ""
DeriveGamemode("sandbox")
function GM:Initialize()
	self.BaseClass:Initialize()
end

module("cosmic", package.seeall)