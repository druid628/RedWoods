--[[
    Necrosis LdC
    Copyright (C) 2005-2008  Lom Enfroy

    This file is part of Necrosis LdC.

    Necrosis LdC is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Necrosis LdC is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Necrosis LdC; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
--]]

------------------------------------------------------------------------------------------------------
-- Necrosis LdC
-- Par Lomig (Kael'Thas EU/FR) & Tarcalion (Nagrand US/Oceanic)
-- Contributions deLiadora et Nyx (Kael'Thas et Elune EU/FR)
--
-- Skins et voix Françaises : Eliah, Ner'zhul
--
-- Version Allemande par Geschan
-- Version Espagnole par DosS (Zul’jin)
-- Version Russe par Komsomolka
--
-- Version $LastChangedDate: 2010-11-13 23:56:59 +0100 (sam., 13 nov. 2010) $
------------------------------------------------------------------------------------------------------

local new, del
do
	local cache = setmetatable({}, {__mode='k'})
	function new(populate, ...)
		local tbl
		local t = next(cache)
		if ( t ) then
			cache[t] = nil
			tbl = t
		else
			tbl = {}
		end
		if ( populate ) then
			local num = select("#", ...)
			if ( populate == "hash" ) then
				assert(math.fmod(num, 2) == 0)
				local key
				for i = 1, num do
					local v = select(i, ...)
					if not ( math.fmod(i, 2) == 0 ) then
						key = v
					else
						tbl[key] = v
						key = nil
					end
				end
			elseif ( populate == "array" ) then
				for i = 1, num do
					local v = select(i, ...)
					table.insert(tbl, i, v)
				end
			end
		end
		return tbl
	end
	function del(t)
		for k in next, t do
			t[k] = nil
		end
		cache[t] = true
	end
end


-- Fonction pour relocaliser  automatiquemlent des éléments en fonction du client
function Necrosis:SpellLocalize(tooltip)

	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Relocalisation des Sorts
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	if not tooltip then
		self.Spell = {
			[1] = {Id = 5784,	Length = 0,	Type = 0}, -- Felsteed
			[2] = {Id = 23161,	Length = 0,	Type = 0}, -- Dreadsteed
			[3] = {Id = 688,	Length = 0,	Type = 0}, -- Imp || Diablotin
			[4] = {Id = 697,	Length = 0,	Type = 0}, -- Voidwalker || Marcheur
			[5] = {Id = 712,	Length = 0,	Type = 0}, -- Succubus || Succube
			[6] = {Id = 691,	Length = 0,	Type = 0}, -- Fellhunter
			[7] = {Id = 30146,	Length = 0,	Type = 0}, -- Felguard
			[8] = {Id = 1122,	Length = 600,	Type = 3}, -- Infernal
			[9] = {Id = 710,	Length = 30,	Type = 2}, -- Banish
			[10] = {Id = 1098,	Length = 300,	Type = 2}, -- Enslave
			[11] = {Id = 20707,	Length = 900,	Type = 1}, -- Soulstone Resurrection || Résurrection de pierre d'ame
			[12] = {Id = 348,	Length = 15,	Type = 6}, -- Immolate
			[13] = {Id = 5782,	Length = 20,	Type = 6}, -- Fear
			[14] = {Id = 172,	Length = 18,	Type = 5}, -- Corruption
			[15] = {Id = 48181,	Length = 8,		Type = 3}, -- Hanter (cooldown)
			[16] = {Id = 603,	Length = 60,	Type = 3}, -- Bane of Doom || Plaie funeste
			[17] = {Id = 30283,	Length = 20,	Type = 3}, -- Shadowfury || Furie de l'ombre
			[18] = {Id = 6353,	Length = 60,	Type = 3}, -- Soul Fire || Feu de l'âme
			[19] = {Id = 6789,	Length = 120,	Type = 3}, -- Death Coil || Voile mortel
			[20] = {Id = 17877,	Length = 15,	Type = 3}, -- Shadowburn || Brûlure de l'ombre
			[21] = {Id = 17962,	Length = 10,	Type = 3}, -- Conflagration
			[22] = {Id = 980,	Length = 24,	Type = 4}, -- Bane of Agony || Plaie Agonie
			[23] = {Id = 702,	Length = 120,	Type = 4}, -- Curse of Weakness || Malédiction de Faiblesse
			[24] = {Id = 47193,	Length = 60,	Type = 3}, -- Demonic Empowerment || Renforcement démoniaque
			[25] = {Id = 1714,	Length = 30,	Type = 4}, -- Curse of Tongues || Malédiction Langage
			[26] = {Id = 1490,	Length = 300,	Type = 4}, -- Curse of the Elements || Malédiction Eléments
			[27] = {Id = 47241,	Length = 180,	Type = 3}, -- Metamorphosis || Metamorphose
			[28] = {Id = 47862,	Length = 30,	Type = 6}, -- DEPRECATED
			[29] = {Id = 5484,	Length = 40,	Type = 3}, -- Howl of Terror || Hurlement de terreur
			[30] = {Id = 18540,	Length = 1800,	Type = 3}, -- DEPRECATED
			[31] = {Id = 687,	Length = 0,		Type = 0}, -- Demon Armor || Armure démoniaque
			[32] = {Id = 5697,	Length = 600,	Type = 2}, -- Unending Breath || Respiration interminable
			[33] = {Id = 54785,	Length = 45,	Type = 3}, -- Bond démoniaque
			[34] = {Id = 126,	Length = 0,		Type = 0}, -- Eye of Kilrogg
			[35] = {Id = 1098,	Length = 0,		Type = 0}, -- Enslave Demon
			[36] = {Id = 696,	Length = 0,		Type = 0}, -- DEPRECATED
			[37] = {Id = 698,	Length = 120,	Type = 3}, -- Ritual of Summoning || Rituel d'invocation
			[38] = {Id = 19028,	Length = 0,		Type = 0}, -- Soul Link || Lien spirituel
			[39] = {Id = 50589,	Length = 30,	Type = 3}, -- Immolation Aura || Aura d'immolation
			[40] = {Id = 18223,	Length = 12,	Type = 4}, -- Curse of Exhaustion || Malédiction d'épuisement
			[41] = {Id = 1454,	Length = 0,		Type = 0}, -- Life Tap || Connexion
			[42] = {Id = 48181,	Length = 12,	Type = 6}, -- Haunt || Hanter (dot)
			[43] = {Id = 6229,	Length = 30,	Type = 3}, -- Shadow Ward || Gardien de l'ombre
			[44] = {Id = 18788,	Length = 60,	Type = 3}, -- DEPRECATED
			[45] = {Id = 686,	Length = 0,		Type = 0}, -- Shadow Bolt
			[46] = {Id = 30108,	Length = 15,	Type = 6}, -- Unstable Affliction || Affliction instable
			[47] = {Id = 28176,	Length = 0,		Type = 0}, -- Fel Armor || Gangrarmure
			[48] = {Id = 27243,	Length = 18,	Type = 5}, -- Seed of Corruption || Graine de Corruption
			[49] = {Id = 29858,	Length = 180,	Type = 3}, -- SoulShatter || Brise âme
			[50] = {Id = 29893,	Length = 300,	Type = 3}, -- Ritual of Souls || Rituel des âmes
			[51] = {Id = 693,	Length = 0,		Type = 0}, -- Create Soulstone || Création pierre d'âme
			[52] = {Id = 6201,	Length = 0,		Type = 0}, -- Create Healthstone || Création pierre de soin
			[53] = {Id = 74434,	Length = 45,	Type = 3}, -- Soulburn || Brûlure d'âme
		}
		-- Type 0 = Pas de Timer || no timer
		-- Type 1 = Timer permanent principal || Standing main timer
		-- Type 2 = Timer permanent || main timer
		-- Type 3 = Timer de cooldown || cooldown timer
		-- Type 4 = Timer de malédiction || curse timer
		-- Type 5 = Timer de corruption || corruption timer
		-- Type 6 = Timer de combat || combat timer

		self.Spell[11].Name = GetSpellInfo(self.Spell[11].Id)
	end

	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Relocalisation des Tooltips
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- stones || Pierres
	local buttonTooltip = new("array",
		"Soulstone",
		"Healthstone"
	)
	local colorCode = new("array",
		"|c00FF99FF", "|c0066FF33"
	)
	for i, button in ipairs(buttonTooltip) do
		if not self.TooltipData[button] then
			self.TooltipData[button] = {}
		end
		self.TooltipData[button].Label = colorCode[i]..self.Translation.Item[button].."|r"
	end
	del(buttonTooltip)
	del(colorCode)

	-- Buffs
	local buttonTooltip = new("array",
		"Domination",
		"Enslave",
		"Armor",
		"FelArmor",
		"Aqua",
		"Kilrogg",
		"Banish",
		"TP",
		"RoS",
		"SoulLink",
		"ShadowProtection",
		"Renforcement"
	)
	local buttonName = new("array",
		15, 35, 31, 47, 32, 34, 9, 37, 50, 38, 43, 24
	)
	for i, button in ipairs(buttonTooltip) do
		if not self.TooltipData[button] then
			self.TooltipData[button] = {}
		end
		self.TooltipData[button].Label = "|c00FFFFFF"..GetSpellInfo(self.Spell[buttonName[i]].Id).."|r"
	end
	del(buttonTooltip)
	del(colorCode)
	del(buttonName)

	-- Demons
	local buttonTooltip = new("array",
		"Sacrifice",
		"Metamorphosis",
		"Bond",
		"Immolation",
		"Renforcement",
		"Enslave"
	)
	local buttonName = new("array",
		44, 27, 33, 39, 24, 35
	)
	for i, button in ipairs(buttonTooltip) do
		if not self.TooltipData[button] then
			self.TooltipData[button] = {}
		end
		self.TooltipData[button].Label = "|c00FFFFFF"..GetSpellInfo(self.Spell[buttonName[i]].Id).."|r"
	end
	del(buttonTooltip)
	del(colorCode)
	del(buttonName)

	-- Curses || Malédiction
	local buttonTooltip = new("array",
		"Weakness",
		"Agony",
		"Tongues",
		"Exhaust",
		"Elements",
		"Doom",
		"Corruption"
	)
	local buttonName = new("array",
		23, 22, 25, 40, 26, 16, 14
	)
	for i, button in ipairs(buttonTooltip) do
		if not self.TooltipData[button] then
			self.TooltipData[button] = {}
		end
		self.TooltipData[button].Label = "|c00FFFFFF"..GetSpellInfo(self.Spell[buttonName[i]].Id).."|r"
	end
	del(buttonTooltip)
	del(colorCode)
	del(buttonName)
end