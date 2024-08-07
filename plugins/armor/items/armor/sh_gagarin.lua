ITEM.name = "'Gagarin' Special Operations Suit"
ITEM.model = "models/kek1ch/military_outfit.mdl"
ITEM.replacements = "models/nasca/stalker/male_gagarin.mdl"
ITEM.description= "A top-spec assault suit." 
ITEM.longdesc = "The very cutting edge along the 'Stingray' suit line, the Gagarin was intended to be fielded for Operation Fairway, but due to various issues was never fielded until quite recently, in the hands of select Military Stalkers as a field test. Its mix of combat and environmental protection is a balance unmatched."
ITEM.width = 2
ITEM.height = 3
ITEM.price = 450000
ITEM.flag = "A"
ITEM.br = 0.35
ITEM.fbr = 10
ITEM.ar = 0.28
ITEM.far = 3
ITEM.isArmor = true
ITEM.repairCost = ITEM.price/100*1
ITEM.overlayPath = "vgui/overlays/hud_merc"
ITEM.img = Material("vgui/hud/xm40.png")
ITEM.noBusiness = true
ITEM.artifactcontainers = {"3"}
ITEM.weight = 22
ITEM.weightClass = 3
ITEM.ballisticRating = 55
ITEM.res = {
	["Impact"] = 0.30,
	["Rupture"] = 0.30,
	["Bullet"] = 0.32,
	["Shock"] = 0.35,
	["Burn"] = 0.50,
	["Radiation"] = 0.18,
	["Chemical"] = 0.20,
	["Psi"] = 0.15,
}
ITEM.newSkin = 0
ITEM.bodyGroups = {
	["helmet"] = 1,
}