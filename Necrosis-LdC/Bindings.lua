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
-- Version $LastChangedDate: 2010-11-11 18:54:06 +0100 (jeu., 11 nov. 2010) $
------------------------------------------------------------------------------------------------------


-- On définit G comme étant le tableau contenant toutes les frames existantes.
local _G = getfenv(0)

-- Création des raccourcis claviers
function Necrosis:BindName()

	-------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Première section
	-------------------------------------------------------------------------------------------------------------------------------------------------------

	-- Le Titre
	_G["BINDING_HEADER_Necrosis"] = "Necrosis LdC"

	-- La Sphere
	_G["BINDING_NAME_CLICK NecrosisButton:LeftButton"] = GetSpellInfo(self.Spell[NecrosisConfig.MainSpell].Id)

	-- mounts || Le Cheval
	if (NecrosisConfig.LeftMount) then
		_G["BINDING_NAME_CLICK NecrosisMountButton:LeftButton"] = GetSpellInfo(NecrosisConfig.LeftMount)
	else
		_G["BINDING_NAME_CLICK NecrosisMountButton:LeftButton"] = GetSpellInfo(self.Spell[1].Id)
	end
	
	if (NecrosisConfig.RightMount) then
		_G["BINDING_NAME_CLICK NecrosisMountButton:RightButton"] = GetSpellInfo(NecrosisConfig.RightMount)
	else
		_G["BINDING_NAME_CLICK NecrosisMountButton:RightButton"] = GetSpellInfo(self.Spell[2].Id)
	end

	--La Pierre de soin
	_G["BINDING_NAME_CLICK NecrosisHealthstoneButton:RightButton"] = GetSpellInfo(self.Spell[52].Id)
	_G["BINDING_NAME_CLICK NecrosisHealthstoneButton:LeftButton"] = self.Translation.Item.Healthstone.." - "..self.Localize["Utilisation"]
	_G["BINDING_NAME_CLICK NecrosisHealthstoneButton:MiddleButton"] = self.Translation.Item.Healthstone.." - "..self.Localize["Echange"]

	-- La Pierre d'âme
	_G["BINDING_NAME_CLICK NecrosisSoulstoneButton:RightButton"] = GetSpellInfo(self.Spell[51].Id)
	_G["BINDING_NAME_CLICK NecrosisSoulstoneButton:LeftButton"] = self.Translation.Item.Soulstone
	
	-------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Deuxième section
	-------------------------------------------------------------------------------------------------------------------------------------------------------
	
	_G["BINDING_HEADER_NecrosisSpell"] = "Necrosis - "..self.Config.Menus["Menu des Buffs"]
	
	_G["BINDING_NAME_CLICK NecrosisBuffMenuButton:LeftButton"] = self.Config.Menus["Menu des Buffs"]
	
	local buffID = {31, -- demon armor
	                47, -- fel armor 
	                32, -- unending breath
	                34, -- eye of killrogg
	                37, -- ritual of summoning
	                38, -- soul link
	                43, -- shadow ward
	                24} -- demonic empowerment
	for i = 1, #buffID, 1 do
		_G["BINDING_NAME_CLICK NecrosisBuffMenu"..i..":LeftButton"] = GetSpellInfo(self.Spell[ buffID[i] ].Id)
	end
	
	_G["BINDING_NAME_CLICK NecrosisBuffMenu10:LeftButton"] = GetSpellInfo(self.Spell[9].Id)
	_G["BINDING_NAME_CLICK NecrosisBuffMenu10:RightButton"] = GetSpellInfo(self.Spell[9].Id).." ("..self.Translation.Misc["Rank"].." 1)"

	-------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Troisième section
	-------------------------------------------------------------------------------------------------------------------------------------------------------
	
	_G["BINDING_HEADER_NecrosisPet"] = "Necrosis - "..self.Config.Menus["Menu des Demons"]
	
	_G["BINDING_NAME_CLICK NecrosisPetMenuButton:LeftButton"] = self.Config.Menus["Menu des Demons"]
	
	for i = 2, 6, 1 do
		_G["BINDING_NAME_CLICK NecrosisPetMenu"..i..":LeftButton"] = GetSpellInfo(self.Spell[i+1].Id)
	end
	
	local buttonID = {1, 7, 8, 9, 10}
	local BuffID = {15, -- fel domination
	                8,  -- summon infernal
	                30, -- ritual of doom
	                35, -- enslave demon
	                44} -- demonic sacrifice
	for i = 1, #buttonID, 1 do
		_G["BINDING_NAME_CLICK NecrosisPetMenu"..buttonID[i]..":LeftButton"] = GetSpellInfo(self.Spell[ BuffID[i] ].Id)
	end

	-------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Quatrième section
	-------------------------------------------------------------------------------------------------------------------------------------------------------
	
	-- Le Titre
	_G["BINDING_HEADER_NecrosisCurse"] = "Necrosis - "..self.Config.Menus["Menu des Maledictions"]
	
	_G["BINDING_NAME_CLICK NecrosisCurseMenuButton:LeftButton"] = self.Config.Menus["Menu des Maledictions"]
	
	local buffID = {23, -- curse of weakness
	                22, -- curse of agony
	                25, -- curse of tongues
	                40, -- curse of exhaustion
	                26, -- curse of the elements
	                16, -- curse of doom
	                14} -- corruption
	for i = 1, #buffID, 1 do
		_G["BINDING_NAME_CLICK NecrosisCurseMenu"..i..":LeftButton"] = GetSpellInfo(self.Spell[ buffID[i] ].Id)
	end

	-------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Cinquième section
	-------------------------------------------------------------------------------------------------------------------------------------------------------
	
	-- Le Titre
	_G["BINDING_HEADER_NecrosisMetamorphosis"] = "Necrosis - "..GetSpellInfo(self.Spell[27].Id)
	
	_G["BINDING_NAME_CLICK NecrosisMetamorphosisButton:LeftButton"] = GetSpellInfo(self.Spell[27].Id)
	
	local buffID = {39, -- Demon charge
			24, -- Demonic Empowerment
			33} -- Bon démoniaque
	for i = 1, #buffID, 1 do
		_G["BINDING_NAME_CLICK NecrosisMetamorphosisMenu"..i..":LeftButton"] = GetSpellInfo(self.Spell[ buffID[i] ].Id)
	end
end
