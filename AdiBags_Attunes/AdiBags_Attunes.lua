--[[
AdiBags_Attunes - Adds Attune filters to AdiBags.
Copyright 2024 Khaos
All rights reserved.
--]]

local _, ns = ...

local addon = LibStub('AceAddon-3.0'):GetAddon('AdiBags')
local L = setmetatable({}, {__index = addon.L})

do -- Localization
	--@localization(locale="enUS", format="lua_additive_table", handle-unlocalized="english")@
	local locale = GetLocale()
	if locale == "frFR" then
		--@localization(locale="frFR", format="lua_additive_table", handle-unlocalized="ignore")@
	elseif locale == "deDE" then
		--@localization(locale="deDE", format="lua_additive_table", handle-unlocalized="ignore")@
	elseif locale == "esMX" then
		--@localization(locale="esMX", format="lua_additive_table", handle-unlocalized="ignore")@
	elseif locale == "ruRU" then
		--@localization(locale="ruRU", format="lua_additive_table", handle-unlocalized="ignore")@
	elseif locale == "esES" then
		--@localization(locale="esES", format="lua_additive_table", handle-unlocalized="ignore")@
	elseif locale == "zhTW" then
		--@localization(locale="zhTW", format="lua_additive_table", handle-unlocalized="ignore")@
	elseif locale == "zhCN" then
		--@localization(locale="zhCN", format="lua_additive_table", handle-unlocalized="ignore")@
	elseif locale == "koKR" then
		--@localization(locale="koKR", format="lua_additive_table", handle-unlocalized="ignore")@
	end
end

-- The filter itself

-- Use a priority very high to catch items before they go into other slots
local setFilter = addon:RegisterFilter("Attunes", 90, 'ABEvent-1.0')
setFilter.uiName = L['Attunes Filter']
setFilter.uiDesc = L['Put items that can be attuned (and are not) in its own section']

function setFilter:OnInitialize()
	self.db = addon.db:RegisterNamespace('Attunes', {
		profile = { Attunes_sort = true },
	})
end

local function UpdateSets(...)
	setFilter:UpdateSets(...)
	setFilter:SendMessage('AdiBags_FiltersChanged')
end

function setFilter:OnEnable()
	addon:UpdateFilters()
end

function setFilter:OnDisable()
	addon:UpdateFilters()
end

local setNames = {}

function setFilter:UpdateSets()
	
end

function setFilter:Filter(slotData)
	local tempItemLink = slotData.link
	local itemId = tonumber(tempItemLink:match('item:(%d+)'))
	if SynastriaCoreLib then
		local itemValid = SynastriaCoreLib.CheckItemValid(itemId)
		if not (itemValid == -2 or itemValid > 0) then
			return
		end
		
		if SynastriaCoreLib.IsAttunable(itemId) then
			return L['Needs Attune']
		else
			return
		end
	end
end

function setFilter:GetFilterOptions()
	return {
		Attunes_sort = {
			name = L['Separate Attunes'],
			desc = L['WIP: Seperate Attunes better'],
			type = 'toggle',
			order = 10,
		},
	}, addon:GetOptionHandler(self, true)
end