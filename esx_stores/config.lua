Config = {}

Config.webhook = "WEBHOOK"						-- Webhook to send logs to discord
Config.lang = "hu"								-- Set the file language [en/br]
Config.ESXSHAREDOBJECT = "esx:getSharedObject" 	-- Change your getshared object event here, in case you are using anti-cheat

Config.format = {
	['currency'] = 'USD',						-- This is the format of the currency, so that your currency sign appears correctly [Examples: BRL, USD]
	['location'] = 'en-US'						-- This is the location of your country, to format the decimal places according to your standard [Examples: pt-BR, en-US]
}

-- Here are the places where the person can open the market menu
-- You can add as many locations as you want, just use the location already created as an example
Config.market_locations = {
	["market_1"] = {															-- ID
		['buy_price'] = 90000,													-- Price to buy this market
		['sell_price'] = 60000,													-- Price to sell this market
		['coord'] = {-709.57403564453,-905.34161376953,19.215591430664},		-- Coordinate to open the menu
		['garage_coord'] = {-707.13,-924.98,19.02,179.01},						-- Garage coordinates, where the trucks will spawn (coordinates composed of x, y, z, h)
		['sell_blip_coords'] = {												-- The coordinates where customes will buy things on this store (coordinates composed of x, y, z)
			{-714.77520751953,-912.22875976562,19.215589523315},
			{-707.40911865234,-913.48266601562,19.215589523315},
			{-711.70471191406,-912.08258056641,19.215587615967}
		},
		['deliveryman_coord'] = {-714.55,-917.8,19.22},							-- Coord where the deliveryman will take the jobs you've created
		['type'] = '247store', 													-- Insert here the market type ID
	},
	["ammunation_1"] = {
		['buy_price'] = 600000,
		['sell_price'] = 400000,
		['coord'] = {14.470663070679,-1106.0792236328,29.797006607056},
		['garage_coord'] = {27.71,-1113.25,29.3,329.89},
		['sell_blip_coords'] = {
			{22.207113265991,-1107.1591796875,29.797008514404}
		},
		['deliveryman_coord'] = {6.4807109832764,-1100.4821777344,29.797006607056},
		['type'] = 'ammunation',
	}
}

-- Here you configure each type of market available to buy
Config.market_types = {
	['247store'] = {							-- Market type ID
		['stock_capacity'] = 100,				-- Max stock capacity
		['upgrades'] = {						-- Definition of each upgrade
			['stock'] = {						-- Stock capacity
				['price'] = 11000,				-- Price to upgrade
				['level_reward'] = {			-- Reward of each level (max level: 5)
					[0] = 0,
					[1] = 30,
					[2] = 60,
					[3] = 90,
					[4] = 120,
					[5] = 150,
				}
			},
			['truck'] = {						-- Truck capacity
				['price'] = 8000,
				['level_reward'] = {
					[0] = 0,
					[1] = 5,
					[2] = 10,
					[3] = 15,
					[4] = 20,
					[5] = 25,
				}
			},
			['relationship'] = {				-- Relationship
				['price'] = 10000,
				['level_reward'] = {
					[0] = 0,
					[1] = 5,
					[2] = 10,
					[3] = 15,
					[4] = 20,
					[5] = 25,
				}
			},
		},
		['market_items'] = {					-- Here you configure the items definitions
			['cerveja'] = {						-- The item ID
				['name'] = "Beer",				-- The item display name
				['price_to_customer'] = 250,	-- Price the customer will pay when buy the product in store
				['price_to_owner'] = 50,		-- Price the store owner must pay when importing goods to your store
				['amount_to_owner'] = 15,		-- Amount of goods the owner will get when importing to store (This value can be increased if he upgraded his truck capacity)
				['amount_to_delivery'] = 15,	-- Max amount of goods the owner can set when creating a job to deliveryman
				['page'] = 0					-- Set on which page this item will appear
			},
			['tequila'] = {
				['name'] = "Tequila",
				['price_to_customer'] = 250,
				['price_to_owner'] = 50,
				['amount_to_owner'] = 15,
				['amount_to_delivery'] = 15,
				['page'] = 0
			},
			['vodka'] = {
				['name'] = "Vodka",
				['price_to_customer'] = 250,
				['price_to_owner'] = 50,
				['amount_to_owner'] = 15,
				['amount_to_delivery'] = 15,
				['page'] = 0
			},
			['whisky'] = {
				['name'] = "Whisky",
				['price_to_customer'] = 250,
				['price_to_owner'] = 50,
				['amount_to_owner'] = 15,
				['amount_to_delivery'] = 15,
				['page'] = 0
			},
			['conhaque'] = {
				['name'] = "Brandy",
				['price_to_customer'] = 250,
				['price_to_owner'] = 50,
				['amount_to_owner'] = 15,
				['amount_to_delivery'] = 15,
				['page'] = 0
			},
			['absinto'] = {
				['name'] = "Absinthe",
				['price_to_customer'] = 250,
				['price_to_owner'] = 50,
				['amount_to_owner'] = 15,
				['amount_to_delivery'] = 15,
				['page'] = 0
			},
			['energetico'] = {
				['name'] = "Energetic",
				['price_to_customer'] = 600,
				['price_to_owner'] = 120,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['page'] = 0
			},
			['chocolategaroto'] = {
				['name'] = "Chocolate",
				['price_to_customer'] = 600,
				['price_to_owner'] = 120,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['page'] = 0
			},
			['chocolatekopenhagen'] = {
				['name'] = "Kopenhagen",
				['price_to_customer'] = 600,
				['price_to_owner'] = 120,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['page'] = 0
			},

			['mochila'] = {
				['name'] = "Backpack",
				['price_to_customer'] = 10000,
				['price_to_owner'] = 2000,
				['amount_to_owner'] = 5,
				['amount_to_delivery'] = 5,
				['page'] = 1
			},
			['roupas'] = {
				['name'] = "Clothes",
				['price_to_customer'] = 5000,
				['price_to_owner'] = 1000,
				['amount_to_owner'] = 5,
				['amount_to_delivery'] = 5,
				['page'] = 1
			},
			['mascara'] = {
				['name'] = "Mask",
				['price_to_customer'] = 5000,
				['price_to_owner'] = 1000,
				['amount_to_owner'] = 5,
				['amount_to_delivery'] = 5,
				['page'] = 1
			},

			['telefone'] = {
				['name'] = "CellPhone",
				['price_to_customer'] = 2500,
				['price_to_owner'] = 500,
				['amount_to_owner'] = 5,
				['amount_to_delivery'] = 5,
				['page'] = 2
			},
			['isca'] = {
				['name'] = "Bait",
				['price_to_customer'] = 300,
				['price_to_owner'] = 60,
				['amount_to_owner'] = 15,
				['amount_to_delivery'] = 15,
				['page'] = 2
			},
			['garrafavazia'] = {
				['name'] = "Empty bottle",
				['price_to_customer'] = 15,
				['price_to_owner'] = 1,
				['amount_to_owner'] = 15,
				['amount_to_delivery'] = 15,
				['page'] = 2
			},
			['militec'] = {
				['name'] = "Militec-1",
				['price_to_customer'] = 3000,
				['price_to_owner'] = 600,
				['amount_to_owner'] = 5,
				['amount_to_delivery'] = 5,
				['page'] = 2
			},
			['repairkit'] = {
				['name'] = "Repair Kit",
				['price_to_customer'] = 5000,
				['price_to_owner'] = 1000,
				['amount_to_owner'] = 5,
				['amount_to_delivery'] = 5,
				['page'] = 2
			},
			['ferramentas'] = {
				['name'] = "Tools",
				['price_to_customer'] = 20,
				['price_to_owner'] = 2,
				['amount_to_owner'] = 15,
				['amount_to_delivery'] = 15,
				['page'] = 2
			},
			['serra'] = {
				['name'] = "Saw",
				['price_to_customer'] = 4000,
				['price_to_owner'] = 800,
				['amount_to_owner'] = 5,
				['amount_to_delivery'] = 5,
				['page'] = 2
			},
			['furadeira'] = {
				['name'] = "Drilling machine",
				['price_to_customer'] = 4000,
				['price_to_owner'] = 800,
				['amount_to_owner'] = 5,
				['amount_to_delivery'] = 5,
				['page'] = 2
			},
			['radio'] = {
				['name'] = "Radio",
				['price_to_customer'] = 1000,
				['price_to_owner'] = 200,
				['amount_to_owner'] = 10,
				['amount_to_delivery'] = 10,
				['page'] = 2
			}
		},
		['pagination'] = {						-- Create pages to your market items (max 5 pages)
			[0] = "Food",
			[1] = "Clothing",
			[2] = "Utilites"
		},
		['blips'] = {							-- Create the blips on map
			['id'] = 52,						-- Blip ID [Set this value 0 to dont have blip]
			['name'] = "Market",				-- Blip Name
			['color'] = 4,						-- Blip Color
			['scale'] = 0.5,					-- Blip Scale
		}
	},

	['ammunation'] = {
		['stock_capacity'] = 100,
		['upgrades'] = {
			['stock'] = {
				['price'] = 5000,
				['level_reward'] = {
					[0] = 0,
					[1] = 15,
					[2] = 30,
					[3] = 45,
					[4] = 50,
					[5] = 65,
				}
			},
			['truck'] = {
				['price'] = 7000,
				['level_reward'] = {
					[0] = 0,
					[1] = 5,
					[2] = 10,
					[3] = 15,
					[4] = 20,
					[5] = 25,
				}
			},
			['relationship'] = {
				['price'] = 6000,
				['level_reward'] = {
					[0] = 0,
					[1] = 5,
					[2] = 10,
					[3] = 15,
					[4] = 20,
					[5] = 25,
				}
			},
		},
		['market_items'] = {
			['wbody|WEAPON_KNIFE'] = {
				['name'] = "Knife",
				['price_to_customer'] = 2000,
				['price_to_owner'] = 1000,
				['amount_to_owner'] = 4,
				['amount_to_delivery'] = 4,
				['page'] = 0
			},
			['wbody|WEAPON_DAGGER'] = {
				['name'] = "Dagger",
				['price_to_customer'] = 2000,
				['price_to_owner'] = 1000,
				['amount_to_owner'] = 4,
				['amount_to_delivery'] = 4,
				['page'] = 0
			},
			['wbody|WEAPON_KNUCKLE'] = {
				['name'] = "Knuckle",
				['price_to_customer'] = 2000,
				['price_to_owner'] = 1000,
				['amount_to_owner'] = 4,
				['amount_to_delivery'] = 4,
				['page'] = 0
			},
			['wbody|WEAPON_SWITCHBLADE'] = {
				['name'] = "Switchblade",
				['price_to_customer'] = 2000,
				['price_to_owner'] = 1000,
				['amount_to_owner'] = 4,
				['amount_to_delivery'] = 4,
				['page'] = 0
			},
			['wbody|WEAPON_WRENCH'] = {
				['name'] = "Wrench",
				['price_to_customer'] = 2000,
				['price_to_owner'] = 1000,
				['amount_to_owner'] = 4,
				['amount_to_delivery'] = 4,
				['page'] = 0
			},
			['wbody|WEAPON_HAMMER'] = {
				['name'] = "Hammer",
				['price_to_customer'] = 2000,
				['price_to_owner'] = 1000,
				['amount_to_owner'] = 4,
				['amount_to_delivery'] = 4,
				['page'] = 0
			},
			['wbody|WEAPON_GOLFCLUB'] = {
				['name'] = "Golfclub",
				['price_to_customer'] = 2000,
				['price_to_owner'] = 1000,
				['amount_to_owner'] = 4,
				['amount_to_delivery'] = 4,
				['page'] = 0
			},
			['wbody|WEAPON_CROWBAR'] = {
				['name'] = "Crowbar",
				['price_to_customer'] = 2000,
				['price_to_owner'] = 1000,
				['amount_to_owner'] = 4,
				['amount_to_delivery'] = 4,
				['page'] = 0
			},
			['wbody|WEAPON_HATCHET'] = {
				['name'] = "Hatchet",
				['price_to_customer'] = 2000,
				['price_to_owner'] = 1000,
				['amount_to_owner'] = 4,
				['amount_to_delivery'] = 4,
				['page'] = 0
			},
			['wbody|WEAPON_BAT'] = {
				['name'] = "Bat",
				['price_to_customer'] = 2000,
				['price_to_owner'] = 1000,
				['amount_to_owner'] = 4,
				['amount_to_delivery'] = 4,
				['page'] = 0
			},
			['wbody|WEAPON_BOTTLE'] = {
				['name'] = "Bottle",
				['price_to_customer'] = 2000,
				['price_to_owner'] = 1000,
				['amount_to_owner'] = 4,
				['amount_to_delivery'] = 4,
				['page'] = 0
			},
			['wbody|WEAPON_BATTLEAXE'] = {
				['name'] = "Battleaxe",
				['price_to_customer'] = 2000,
				['price_to_owner'] = 1000,
				['amount_to_owner'] = 4,
				['amount_to_delivery'] = 4,
				['page'] = 0
			},
			['wbody|WEAPON_POOLCUE'] = {
				['name'] = "Poolcue",
				['price_to_customer'] = 2000,
				['price_to_owner'] = 1000,
				['amount_to_owner'] = 4,
				['amount_to_delivery'] = 4,
				['page'] = 0
			},
			['wbody|WEAPON_STONE_HATCHET'] = {
				['name'] = "Stone Hatchet",
				['price_to_customer'] = 2000,
				['price_to_owner'] = 1000,
				['amount_to_owner'] = 4,
				['amount_to_delivery'] = 4,
				['page'] = 0
			},

			['wbody|WEAPON_PISTOL'] = {
				['name'] = "Pistol",
				['price_to_customer'] = 190000,
				['price_to_owner'] = 95000,
				['amount_to_owner'] = 1,
				['amount_to_delivery'] = 1,
				['page'] = 1
			},
			['wbody|WEAPON_PISTOL_MK2'] = {
				['name'] = "Pistol MKII",
				['price_to_customer'] = 220000,
				['price_to_owner'] = 110000,
				['amount_to_owner'] = 1,
				['amount_to_delivery'] = 1,
				['page'] = 1
			},
			['wbody|WEAPON_COMBATPISTOL'] = {
				['name'] = "Combat Pistol",
				['price_to_customer'] = 245000,
				['price_to_owner'] = 122500,
				['amount_to_owner'] = 1,
				['amount_to_delivery'] = 1,
				['page'] = 1
			},
			['wbody|WEAPON_APPISTOL'] = {
			['name'] = "Automatic Pistol",
			['price_to_customer'] = 5000,
			['price_to_owner'] = 25,
			['amount_to_owner'] = 1,
			['amount_to_delivery'] = 1,
			['page'] = 1
			},
			['wbody|WEAPON_PISTOL50'] = {
				['name'] = "Pistol .50",
				['price_to_customer'] = 320000,
				['price_to_owner'] = 160000,
				['amount_to_owner'] = 1,
				['amount_to_delivery'] = 1,
				['page'] = 1
			},
			['wbody|WEAPON_REVOLVER'] = {
				['name'] = "Revolver",
				['price_to_customer'] = 360000,
				['price_to_owner'] = 180000,
				['amount_to_owner'] = 1,
				['amount_to_delivery'] = 1,
				['page'] = 1
			},
			['wbody|WEAPON_REVOLVER_MK2'] = {
				['name'] = "Revolver MKII",
				['price_to_customer'] = 380000,
				['price_to_owner'] = 190000,
				['amount_to_owner'] = 1,
				['amount_to_delivery'] = 1,
				['page'] = 1
			},
			['wbody|WEAPON_VINTAGEPISTOL'] = {
				['name'] = "Vintage Pistol",
				['price_to_customer'] = 420000,
				['price_to_owner'] = 210000,
				['amount_to_owner'] = 1,
				['amount_to_delivery'] = 1,
				['page'] = 1
			},
			['wbody|WEAPON_SNSPISTOL'] = {
				['name'] = "SNS Pistol",
				['price_to_customer'] = 200000,
				['price_to_owner'] = 100000,
				['amount_to_owner'] = 1,
				['amount_to_delivery'] = 1,
				['page'] = 1
			},
			['wbody|WEAPON_SNSPISTOL_MK2'] = {
				['name'] = "SNS Pistol MKII",
				['price_to_customer'] = 210000,
				['price_to_owner'] = 105000,
				['amount_to_owner'] = 1,
				['amount_to_delivery'] = 1,
				['page'] = 1
			},
			['wbody|WEAPON_MARKSMANPISTOL'] = {
				['name'] = "Marksman Pistol",
				['price_to_customer'] = 400000,
				['price_to_owner'] = 200000,
				['amount_to_owner'] = 1,
				['amount_to_delivery'] = 1,
				['page'] = 1
			},
			['wbody|WEAPON_HEAVYPISTOL'] = {
				['name'] = "Heavy Pistol",
				['price_to_customer'] = 400000,
				['price_to_owner'] = 200000,
				['amount_to_owner'] = 1,
				['amount_to_delivery'] = 1,
				['page'] = 1
			},
			-- ['wbody|WEAPON_STUNGUN'] = {
			-- 	['name'] = "Stun Gun",
			-- 	['price_to_customer'] = 5000,
			-- 	['price_to_owner'] = 2500,
			-- 	['amount_to_owner'] = 1,
			-- 	['amount_to_delivery'] = 1,
			-- 	['page'] = 1
			-- },
			['wbody|WEAPON_DOUBLEACTION'] = {
				['name'] = "Double-Action Revolver",
				['price_to_customer'] = 450000,
				['price_to_owner'] = 225000,
				['amount_to_owner'] = 1,
				['amount_to_delivery'] = 1,
				['page'] = 1
			},

			['wbody|WEAPON_ASSAULTRIFLE'] = {
				['name'] = "Assault Rifle",
				['price_to_customer'] = 600000,
				['price_to_owner'] = 300000,
				['amount_to_owner'] = 1,
				['amount_to_delivery'] = 1,
				['page'] = 2
			},
			['wbody|WEAPON_ASSAULTRIFLE_MK2'] = {
				['name'] = "Assault Rifle MKII",
				['price_to_customer'] = 800000,
				['price_to_owner'] = 400000,
				['amount_to_owner'] = 1,
				['amount_to_delivery'] = 1,
				['page'] = 2
			},
			['wbody|WEAPON_CARBINERIFLE'] = {
				['name'] = "Carbine Rifle",
				['price_to_customer'] = 600000,
				['price_to_owner'] = 300000,
				['amount_to_owner'] = 1,
				['amount_to_delivery'] = 1,
				['page'] = 2
			},
			['wbody|WEAPON_CARBINERIFLE_MK2'] = {
				['name'] = "Carbine Rifle MKII",
				['price_to_customer'] = 800000,
				['price_to_owner'] = 400000,
				['amount_to_owner'] = 1,
				['amount_to_delivery'] = 1,
				['page'] = 2
			},

			['wbody|WEAPON_FLARE'] = {
				['name'] = "Flare",
				['price_to_customer'] = 1000,
				['price_to_owner'] = 25,
				['amount_to_owner'] = 15,
				['amount_to_delivery'] = 15,
				['page'] = 3
			},
			['wbody|WEAPON_FLASHLIGHT'] = {
				['name'] = "Flashlight",
				['price_to_customer'] = 2000,
				['price_to_owner'] = 25,
				['amount_to_owner'] = 15,
				['amount_to_delivery'] = 15,
				['page'] = 3
			},
			['wbody|WEAPON_FIREWORK'] = {
				['name'] = "Firework",
				['price_to_customer'] = 3000,
				['price_to_owner'] = 25,
				['amount_to_owner'] = 15,
				['amount_to_delivery'] = 15,
				['page'] = 3
			},
			['wbody|GADGET_PARACHUTE'] = {
				['name'] = "Parachute",
				['price_to_customer'] = 1000,
				['price_to_owner'] = 25,
				['amount_to_owner'] = 15,
				['amount_to_delivery'] = 15,
				['page'] = 3
			},
			['colete'] = {
				['name'] = "Bulletproof vest",
				['price_to_customer'] = 30000,
				['price_to_owner'] = 25,
				['amount_to_owner'] = 15,
				['amount_to_delivery'] = 15,
				['page'] = 3
			}			
		},
		['pagination'] = {
			[0] = "Melee weapons",
			[1] = "Pistols",
			[2] = "Rifles",
			[3] = "Others"
		},
		['blips'] = {
			['id'] = 110,
			['name'] = "Ammunation",
			['color'] = 4,
			['scale'] = 0.5,
		}
	}
}

-- Trucks for each level when upgrade the truck cargo
Config.trucks = {
	[0] = 'speedo',
	[1] = 'gburrito',
	[2] = 'mule3',
	[3] = 'mule4',
	[4] = 'pounder',
	[5] = 'pounder2'
}
Config.keyToUnlockTruck = 182 	-- Key L

-- Cargo delivery locations
Config.delivery_locations = {
	-- {-707.28985595703,-919.22088623047,19.013900756836}
	[1] = { -952.31, -1077.87, 2.48 },
	[2] = { -978.23, -1108.09, 2.16 },
	[3] = { -1024.49, -1139.6, 2.75 }, 
	[4] = { -1063.76, -1159.88, 2.56 }, 
	[5] = { -1001.68, -1218.78, 5.75 }, 
	[6] = { -1171.54, -1575.61, 4.51 }, 
	[7] = { -1097.94, -1673.36, 8.4 }, 
	[8] = { -1286.17, -1267.12, 4.52 }, 
	[9] = { -1335.75, -1146.55, 6.74 }, 
	[10] = { -1750.47, -697.09, 10.18 }, 
	[11] = { -1876.84, -584.39, 11.86 }, 
	[12] = { -1772.23, -378.12, 46.49 }, 
	[13] = { -1821.38, -404.97, 46.65 }, 
	[14] = { -1965.33, -296.96, 41.1 }, 
	[15] = { -3089.24, 221.49, 14.07 }, 
	[16] = { -3088.62, 392.3, 11.45 },
	[17] = { -3077.98, 658.9, 11.67 }, 
	[18] = { -3243.07, 931.84, 17.23 },
	[19] = { 1230.8, -1590.97, 53.77 }, 
	[20] = { 1286.53, -1604.26, 54.83 }, 
	[21] = { 1379.38, -1515.23, 58.24 }, 
	[22] = { 1379.38, -1515.23, 58.24 }, 
	[23] = { 1437.37, -1492.53, 63.63 }, 
	[24] = { 450.04, -1863.49, 27.77 },
	[25] = { 403.75, -1929.72, 24.75 }, 
	[26] = { 430.16, -1559.31, 32.8 }, 
	[27] = { 446.06, -1242.17, 30.29 },
	[28] = { 322.39, -1284.7, 30.57 }, 
	[29] = { 369.65, -1194.79, 31.34 },
	[30] = { 474.27, -635.05, 25.65 }, 
	[31] = { 158.87, -1215.65, 29.3 }, 
	[32] = { 154.68, -1335.62, 29.21 }, 
	[33] = { 215.54, -1461.67, 29.19 },
	[34] = { 167.46, -1709.3, 29.3 },
	[35] = { -444.47, 287.68, 83.3 }, 
	[36] = { -179.56, 314.25, 97.88 }, 
	[37] = { -16.07, 216.7, 106.75 }, 
	[38] = { 164.02, 151.87, 105.18 },
	[39] = { 840.2, -181.93, 74.19 }, 
	[40] = { 952.27, -252.17, 67.77 },
	[41] = { 1105.27, -778.84, 58.27 }, 
	[42] = { 1099.59, -345.68, 67.19 }, 
	[43] = { -1211.12, -401.56, 38.1 }, 
	[44] = { -1302.69, -271.32, 40.0 }, 
	[45] = { -1468.65, -197.3, 48.84 }, 
	[46] = { -1583.18, -265.78, 48.28 }, 
	[47] = { -603.96, -774.54, 25.02 },
	[48] = { -805.14, -959.54, 18.13 }, 
	[49] = { -325.07, -1356.35, 31.3 }, 
	[50] = { -321.94, -1545.74, 31.02 }, 
	[51] = { -428.95, -1728.13, 19.79 }, 
	[52] = { -582.38, -1743.65, 22.44 }, 
	[53] = { -670.43, -889.09, 24.5 },
	
	[54] = { 1691.4, 3866.21, 34.91 }, 
	[55] = { 1837.93, 3907.12, 33.26 },
	[56] = { 1937.08, 3890.89, 32.47}, 
	[57] = { 2439.7, 4068.45, 38.07 },
	[58] = { 2592.26, 4668.98, 34.08 }, 
	[59] = { 1961.53, 5184.91, 47.98 },
	[60] = { 2258.59, 5165.84, 59.12 }, 
	[61] = { 1652.7, 4746.1, 42.03 },
	[62] = { -359.09, 6062.05, 31.51 }, 
	[63] = { -160.13, 6432.2, 31.92 },
	[64] = { 33.33, 6673.27, 32.19 }, 
	[65] = { 175.03, 6643.14, 31.57 },
	[66] = { 22.8, 6488.44, 31.43 }, 
	[67] = { 64.39, 6309.17, 31.38 },
	[68] = { 122.42, 6406.02, 31.37 }, 
	[69] = { 1681.2, 6429.11, 32.18 },
	[70] = { 2928.01, 4474.74, 48.04 }, 
	[71] = { 2709.92, 3454.83, 56.32 },
	[72] = { -688.75, 5788.9, 17.34 }, 
	[73] = { -436.13, 6154.93, 31.48 },
	[74] = { -291.09, 6185.0, 31.49 }, 
	[75] = { 405.31, 6526.38, 27.69 },
	[76] = { -20.38, 6567.13, 31.88 }, 
	[77] = { -368.06, 6341.4, 29.85 },
	[78] = { 1842.89, 3777.72, 33.16 }, 
	[79] = { 1424.82, 3671.73, 34.18 },
	[80] = { 996.54, 3575.55, 34.62 }, 
	[81] = { 1697.52, 3596.14, 35.56 },
	[82] = { 2415.05, 5005.35, 46.68 }, 
	[83] = { 2336.21, 4859.41, 41.81},
	[84] = { 1800.9, 4616.07, 37.23 },
	[85] = { -453.3, 6336.9, 13.11 },
	[86] = { -425.4, 6356.43, 13.33 },
	[87] = { -481.9, 6276.47, 13.42 },
	[88] = { -693.92, 5761.95, 17.52 },
	[89] = { -682.03, 5770.96, 17.52 },
	[90] = { -379.44, 6062.07, 31.51 },
	[91] = { -105.68, 6528.7, 30.17 },
	[92] = { 35.02, 6662.61, 32.2 },
	[93] = { 126.41, 6353.64, 31.38 },
	[94] = { 48.15, 6305.99, 31.37 },
	[95] = { 1417.68, 6343.83, 24.01 },
	[96] = { 1510.21, 6326.28, 24.61 },
	[97] = { 1698.22, 6425.66, 32.77 },
	[98] = { 2434.69, 5011.7, 46.84 },
	[99] = { 1718.88, 4677.32, 43.66 },
	[100] = { 1673.21, 4958.09, 42.35 },
	[101] = { 1364.33, 4315.43, 37.67 },
	[102] = { -1043.6, 5326.84, 44.58 },
	[103] = { -329.63, 6150.58, 32.32 },
	[104] = { -374.41, 6191.04, 31.73 },
	[105] = { -356.63, 6207.34, 31.85 },
	[106] = { -347.15, 6224.69, 31.7 },
	[107] = { -315.61, 6194.0, 31.57 },
	[108] = { -33.3, 6455.87, 31.48 },
	[109] = { 405.52, 6526.59, 27.7 },
	[110] = { 1470.41, 6513.71, 21.23 },
	[111] = { 1593.73, 6460.56, 25.32 },
	[112] = { 1741.31, 6420.19, 35.05 },
}