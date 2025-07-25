ESX 					= nil
TriggerEvent(Config.ESXSHAREDOBJECT, function(obj) ESX = obj end)

local vrp_ready = nil
function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

Citizen.CreateThread(function()
	Wait(5000)
	MySQL.Sync.execute([[
		CREATE TABLE IF NOT EXISTS `store_business` (
			`market_id` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
			`user_id` VARCHAR(50) NOT NULL,
			`stock` VARCHAR(50) NOT NULL DEFAULT '[]' COLLATE 'utf8mb4_general_ci',
			`stock_upgrade` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
			`truck_upgrade` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
			`relationship_upgrade` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
			`money` INT(10) UNSIGNED NOT NULL DEFAULT '0',
			`total_money_earned` INT(10) UNSIGNED NOT NULL DEFAULT '0',
			`total_money_spent` INT(10) UNSIGNED NOT NULL DEFAULT '0',
			`goods_bought` INT(10) UNSIGNED NOT NULL DEFAULT '0',
			`distance_traveled` DOUBLE UNSIGNED NOT NULL DEFAULT '0',
			`total_visits` INT(10) UNSIGNED NOT NULL DEFAULT '0',
			`customers` INT(10) UNSIGNED NOT NULL DEFAULT '0',
			PRIMARY KEY (`market_id`) USING BTREE
		)
		COLLATE='utf8mb4_general_ci'
		ENGINE=InnoDB
		;
		CREATE TABLE IF NOT EXISTS `store_balance` (
			`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
			`market_id` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
			`income` BIT(1) NOT NULL,
			`title` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
			`amount` INT(10) UNSIGNED NOT NULL,
			`date` INT(10) UNSIGNED NOT NULL,
			PRIMARY KEY (`id`) USING BTREE
		)
		COLLATE='utf8mb4_general_ci'
		ENGINE=InnoDB
		;
		CREATE TABLE IF NOT EXISTS `store_jobs` (
			`id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
			`market_id` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
			`name` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
			`reward` INT(10) UNSIGNED NOT NULL DEFAULT '0',
			`product` VARCHAR(50) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_general_ci',
			`amount` INT(11) NOT NULL DEFAULT '0',
			`progress` BIT(1) NOT NULL DEFAULT b'0',
			PRIMARY KEY (`id`) USING BTREE
		)
		COLLATE='utf8mb4_general_ci'
		ENGINE=InnoDB
		;
	]])

	MySQL.Sync.execute("UPDATE `store_jobs` SET progress = 0", {});
end)

local version = 1
Citizen.CreateThread(function()
				

						if arr_ips['version'] ~= version then
							if Config.lang == "br" then
								print("^2["..GetCurrentResourceName().."] Uma nova atualizacao esta disponivel, entre em contato comigo no Discord Lixeiro Charmoso#1104^7")
							else
								print("^2["..GetCurrentResourceName().."] A new update is available, contact me on Discord Lixeiro Charmoso#1104^7")
							end
						end
						return
				
				end
			
			end, "GET", "", {})
	
end)

-- Config checker
Citizen.CreateThread(function()
	for k,v in pairs(Config.market_locations) do
		if not Config.market_types[v.type] then
			if Config.lang == "br" then
				print("^8["..GetCurrentResourceName().."] Erro detectado no seu arquivo de configuracao, o tipo '"..v.type.."' nao esta cadastrado em Config.market_types^7")
			else
				print("^8["..GetCurrentResourceName().."] Error detected in your configuration file, the type '"..v.type .."' is not registered in Config.market_types^7")
			end
		end
	end
end)

RegisterServerEvent("vrp_stores:getData")
AddEventHandler("vrp_stores:getData",function(key)
	if vrp_ready then
		local source = source
		local xPlayer = ESX.GetPlayerFromId(source)
		local user_id = xPlayer.identifier
		if user_id then
			local sql = "SELECT user_id FROM `store_business` WHERE market_id = @market_id";
			local query = MySQL.Sync.fetchAll(sql, {['@market_id'] = key});
			if query and query[1] then
				if query[1].user_id == user_id then
					openUI(source,key,false)
				else
					TriggerClientEvent("Notify",source,"negado",Lang[Config.lang]['already_has_owner'])
				end
			else
				local price = Config.market_locations[key].buy_price
				-- local ok = vRP.request(source,Lang[Config.lang]['buy_message']:format(price), 30)
				-- if ok then
					local sql = "SELECT market_id FROM `store_business` WHERE user_id = @user_id";
					local query = MySQL.Sync.fetchAll(sql, {['@user_id'] = user_id});
					if query and query[1] then
						TriggerClientEvent("Notify",source,"negado",Lang[Config.lang]['already_has_business'])
					else
						money = xPlayer.getAccount('bank').money
						if money >= price then
							xPlayer.removeAccountMoney('bank', price)
							local sql = "INSERT INTO `store_business` (user_id,market_id,stock) VALUES (@user_id,@market_id,@stock);";
							MySQL.Sync.execute(sql, {['@market_id'] = key, ['@user_id'] = user_id, ['@stock'] = json.encode({})});
							TriggerClientEvent("Notify",source,"sucesso",Lang[Config.lang]['businnes_bougth'])
							openUI(source,key,false)
							SendWebhookMessage(Config.webhook,Lang[Config.lang]['logs_bought']:format(key,user_id..os.date("\n["..Lang[Config.lang]['logs_date'].."]: %d/%m/%Y ["..Lang[Config.lang]['logs_hour'].."]: %H:%M:%S")))
						else
							TriggerClientEvent("Notify",source,"negado",Lang[Config.lang]['insufficient_funds'])
						end
					end
				-- end
			end
		end
	end
end)

RegisterServerEvent("vrp_stores:openMarket")
AddEventHandler("vrp_stores:openMarket",function(key)
	if vrp_ready then
		local source = source
		local xPlayer = ESX.GetPlayerFromId(source)
		local user_id = xPlayer.identifier
		if user_id then
			local sql = "UPDATE `store_business` SET total_visits = total_visits + 1 WHERE market_id = @market_id";
			MySQL.Sync.execute(sql, {['@market_id'] = key});
			openUI(source,key,false,true)
		end
	end
end)

RegisterServerEvent("vrp_stores:getJob")
AddEventHandler("vrp_stores:getJob",function(key)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local user_id = xPlayer.identifier
	if user_id then
		local sql = "SELECT id,name,reward FROM store_jobs WHERE market_id = @market_id AND progress = 0 ORDER BY id ASC";
		local query = MySQL.Sync.fetchAll(sql, {['@market_id'] = key})[1];
		if query == nil then
			TriggerClientEvent("Notify",source,"negado",Lang[Config.lang]['no_available_jobs'])
		end
		local sql = "SELECT user_id FROM store_business WHERE market_id = @market_id";
		local query_2 = MySQL.Sync.fetchAll(sql, {['@market_id'] = key})[1];
		if query_2.user_id == user_id then
			TriggerClientEvent("Notify",source,"negado",Lang[Config.lang]['cannot_do_own_job'])
			query = nil
		end
		TriggerClientEvent("vrp_stores:getJob",source,key,query)
	end
end)

RegisterServerEvent("vrp_stores:startJob")
AddEventHandler("vrp_stores:startJob",function(key,id)
	local source = source
	local sql = "SELECT * FROM store_jobs WHERE id = @id ORDER BY id ASC";
	local query = MySQL.Sync.fetchAll(sql, {['@id'] = id})[1];
	if query.progress == 0 then
		local sql = "UPDATE `store_jobs` SET progress = 1 WHERE id = @id";
		MySQL.Sync.execute(sql, {['@id'] = id});
		TriggerClientEvent("vrp_stores:startContract",source,query.product,0,query)
	else
		TriggerClientEvent("vrp_stores:getJob",source,key,nil)
		TriggerClientEvent("Notify",source,"negado",Lang[Config.lang]['job_already_in_progress'])
	end
end)

RegisterServerEvent("vrp_stores:failed")
AddEventHandler("vrp_stores:failed",function(query_delivery)
	if data then
		local sql = "UPDATE `store_jobs` SET progress = 0 WHERE id = @id";
		MySQL.Sync.execute(sql, {['@id'] = query_delivery.id});
	end
end)

RegisterServerEvent("vrp_stores:startContract")
AddEventHandler("vrp_stores:startContract",function(key,item)
	local source = source
	local sql = "SELECT truck_upgrade, relationship_upgrade FROM `store_business` WHERE market_id = @market_id";
	local query = MySQL.Sync.fetchAll(sql, {['@market_id'] = key});
	local amount = (Config.market_types[Config.market_locations[key].type].market_items[item].amount_to_owner + Config.market_types[Config.market_locations[key].type].upgrades.truck.level_reward[query[1].truck_upgrade])
	local price = Config.market_types[Config.market_locations[key].type].market_items[item].price_to_owner * amount
	local discount = Config.market_types[Config.market_locations[key].type].upgrades.relationship.level_reward[query[1].relationship_upgrade]
	discount = math.floor((price * discount)/100)
	local total_price = price-discount
	if tryGetMarketMoney(key,total_price) then
		insertBalanceHistory(key,1,Lang[Config.lang]['buy_products_expenses']:format(amount,Config.market_types[Config.market_locations[key].type].market_items[item].name),total_price)
		TriggerClientEvent("vrp_stores:startContract",source,item,query[1].truck_upgrade)
	else
		TriggerClientEvent("Notify",source,"negado",Lang[Config.lang]['insufficient_funds'])
	end
end)

RegisterServerEvent("vrp_stores:finishContract")
AddEventHandler("vrp_stores:finishContract",function(key,item,truck_level,distance,query_delivery)
	local source = source
	local sql = "SELECT stock, truck_upgrade, stock_upgrade FROM `store_business` WHERE market_id = @market_id";
	local query = MySQL.Sync.fetchAll(sql, {['@market_id'] = key});
	local arr_stock = json.decode(query[1].stock)
	if not arr_stock[item] then arr_stock[item] = 0 end
	local amount = 0
	if query_delivery then
		distance = 0
		amount = tonumber(query_delivery.amount)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.addAccountMoney('bank', tonumber(query_delivery.reward) or 0)
		local sql = "DELETE FROM `store_jobs` WHERE id = @id;";
		MySQL.Sync.execute(sql, {['@id'] = query_delivery.id});
	else
		amount = (Config.market_types[Config.market_locations[key].type].market_items[item].amount_to_owner + Config.market_types[Config.market_locations[key].type].upgrades.truck.level_reward[query[1].truck_upgrade])
	end
	if getStockAmount(query[1].stock) + amount <= Config.market_types[Config.market_locations[key].type].stock_capacity + Config.market_types[Config.market_locations[key].type].upgrades.stock.level_reward[query[1].stock_upgrade] then
		arr_stock[item] = arr_stock[item] + amount
	else
		amount = Config.market_types[Config.market_locations[key].type].stock_capacity + Config.market_types[Config.market_locations[key].type].upgrades.stock.level_reward[query[1].stock_upgrade] - getStockAmount(query[1].stock)
		arr_stock[item] = arr_stock[item] + amount
		TriggerClientEvent("Notify",source,"negado",Lang[Config.lang]['stock_full'])
	end
	local sql = "UPDATE `store_business` SET stock = @stock, goods_bought = goods_bought + @amount, distance_traveled = distance_traveled + @distance WHERE market_id = @market_id";
	MySQL.Sync.execute(sql, {['@market_id'] = key, ['@stock'] = json.encode(arr_stock), ['@amount'] = amount, ['@distance'] = distance});
end)

RegisterServerEvent("vrp_stores:buyItem")
AddEventHandler("vrp_stores:buyItem",function(key,data)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local user_id = xPlayer.identifier
	data.amount = tonumber(data.amount) or 0
	if data.amount > 0 then
		local sql = "SELECT stock FROM `store_business` WHERE market_id = @market_id";
		local query = MySQL.Sync.fetchAll(sql, {['@market_id'] = key});
		arr_stock = {}
		if query and query[1] then
			arr_stock = json.decode(query[1].stock)
			if not arr_stock[data.item_id] then arr_stock[data.item_id] = 0 end
		else
			arr_stock[data.item_id] = 999
		end
		if arr_stock[data.item_id] >= data.amount then
			local itemDef = Config.market_types[Config.market_locations[key].type].market_items[data.item_id]
			local total_price = itemDef.price_to_customer*data.amount
			money = xPlayer.getAccount('bank').money
			if money >= total_price then
				xPlayer.removeAccountMoney('bank', total_price)
				xPlayer.addInventoryItem(data.item_id, data.amount)
				if query and query[1] then
					giveMarketMoney(key,total_price)
					arr_stock[data.item_id] = arr_stock[data.item_id] - data.amount
					insertBalanceHistory(key,0,Lang[Config.lang]['bought_item']:format(data.amount,itemDef.name),total_price)
					local sql = "UPDATE `store_business` SET stock = @stock, customers = customers + 1, total_money_earned = total_money_earned + @money WHERE market_id = @market_id";
					MySQL.Sync.execute(sql, {['@market_id'] = key, ['@money'] = total_price, ['@stock'] = json.encode(arr_stock)});
				end
				SendWebhookMessage(Config.webhook,Lang[Config.lang]['logs_item_bought']:format(key,data.item_id,data.amount,user_id..os.date("\n["..Lang[Config.lang]['logs_date'].."]: %d/%m/%Y ["..Lang[Config.lang]['logs_hour'].."]: %H:%M:%S")))
				TriggerClientEvent("Notify",source,"sucesso",Lang[Config.lang]['bought_item_2']:format(data.amount,itemDef.name))
			else
				TriggerClientEvent("Notify",source,"negado",Lang[Config.lang]['insufficient_funds'])
			end
		else
			TriggerClientEvent("Notify",source,"negado",Lang[Config.lang]['stock_empty'])
		end
		openUI(source,key,true,true)
	end
end)

RegisterServerEvent("vrp_stores:createJob")
AddEventHandler("vrp_stores:createJob",function(key,data)
	local source = source
	local sql = "SELECT COUNT(id) as qtd FROM store_jobs WHERE market_id = @market_id";
	local count = MySQL.Sync.fetchAll(sql, {['@market_id'] = key})[1].qtd;
	if count < 50 then -- Limite interno
		local total_price = data.reward + (Config.market_types[Config.market_locations[key].type].market_items[data.product].price_to_owner * data.amount)
		if tryGetMarketMoney(key,total_price) then
			local sql = "INSERT INTO `store_jobs` (market_id,name,reward,product,amount) VALUES (@market_id,@name,@reward,@product,@amount);";
			MySQL.Sync.execute(sql, {['@market_id'] = key, ['@name'] = data.name, ['@reward'] = data.reward, ['@product'] = data.product, ['@amount'] = data.amount});
			insertBalanceHistory(key,1,Lang[Config.lang]['create_job_expenses']:format(data.name),total_price)
			openUI(source,key,true)
		else
			TriggerClientEvent("Notify",source,"negado",Lang[Config.lang]['insufficient_funds'])
		end
	end
end)

local cooldown = {}
RegisterServerEvent("vrp_stores:deleteJob")
AddEventHandler("vrp_stores:deleteJob",function(key,data)
	local source = source
	if cooldown[source] == nil then
		cooldown[source] = true
		local sql = "SELECT name,reward,product,amount,progress FROM `store_jobs` WHERE id = @id;";
		query = MySQL.Sync.fetchAll(sql,{['@id'] = data.job_id});
		if query[1] then
			if query[1].progress == 0 then
				local sql = "DELETE FROM `store_jobs` WHERE id = @id;";
				MySQL.Sync.execute(sql, {['@id'] = data.job_id});
				
				local total_price = query[1].reward + (Config.market_types[Config.market_locations[key].type].market_items[query[1].product].price_to_owner * query[1].amount)
				local sql = "UPDATE `store_business` SET total_money_spent = total_money_spent - @amount WHERE market_id = @market_id";
				MySQL.Sync.execute(sql, {['@amount'] = total_price, ['@market_id'] = key});
				giveMarketMoney(key,total_price)
				insertBalanceHistory(key,0,Lang[Config.lang]['create_job_income']:format(query[1].name),total_price)
				
				openUI(source,key,true)
			else
				TriggerClientEvent("Notify",source,"negado",Lang[Config.lang]['cant_delete_job'])
			end
		end
		SetTimeout(500,function()
			cooldown[source] = nil
		end)
	end
end)

RegisterServerEvent("vrp_stores:buyUpgrade")
AddEventHandler("vrp_stores:buyUpgrade",function(key,data)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local user_id = xPlayer.identifier
	if user_id then
		local sql = "SELECT "..data.id.."_upgrade FROM `store_business` WHERE market_id = @market_id";
		local query = MySQL.Sync.fetchAll(sql,{['@market_id'] = key})[1];
		if query[data.id.."_upgrade"] < 5 then
			local amount = Config.market_types[Config.market_locations[key].type].upgrades[data.id].price
			if tryGetMarketMoney(key,amount) then
				local sql = "UPDATE `store_business` SET "..data.id.."_upgrade = "..data.id.."_upgrade + 1 WHERE market_id = @market_id";
				MySQL.Sync.execute(sql, {['@market_id'] = key});

				insertBalanceHistory(key,1,Lang[Config.lang]['upgrade_expenses']:format(Lang[Config.lang][data.id.."_upgrade"]),amount)
				openUI(source,key,true)
			else
				TriggerClientEvent("Notify",source,"negado",Lang[Config.lang]['insufficient_funds'])
			end
		else
			TriggerClientEvent("Notify",source,"negado",Lang[Config.lang]['max_level'])
		end
	end
end)

RegisterServerEvent("vrp_stores:withdrawMoney")
AddEventHandler("vrp_stores:withdrawMoney",function(key)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local user_id = xPlayer.identifier
	if user_id then
		local sql = "SELECT money FROM `store_business` WHERE market_id = @market_id";
		local query = MySQL.Sync.fetchAll(sql,{['@market_id'] = key})[1];
		local amount = tonumber(query.money)
		if amount and amount > 0 then
			local sql = "UPDATE `store_business` SET money = 0 WHERE market_id = @market_id";
			MySQL.Sync.execute(sql, {['@market_id'] = key});
			xPlayer.addAccountMoney('bank', amount)
			insertBalanceHistory(key,1,Lang[Config.lang]['money_withdrawn'],amount)
			TriggerClientEvent("Notify",source,"sucesso",Lang[Config.lang]['money_withdrawn'])
			openUI(source,key,true)
		end
	end
end)

RegisterServerEvent("vrp_stores:depositMoney")
AddEventHandler("vrp_stores:depositMoney",function(key,data)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local user_id = xPlayer.identifier
	if user_id then
		local amount = tonumber(data.amount)
		if amount and amount > 0 then
			money = xPlayer.getAccount('bank').money
			if money >= amount then
				xPlayer.removeAccountMoney('bank', amount)
				giveMarketMoney(key,amount)
				insertBalanceHistory(key,0,Lang[Config.lang]['money_deposited'],amount)
				TriggerClientEvent("Notify",source,"sucesso",Lang[Config.lang]['money_deposited'])
				openUI(source,key,true)
			else
				TriggerClientEvent("Notify",source,"negado",Lang[Config.lang]['insufficient_funds'])
			end
		else
			TriggerClientEvent("Notify",source,"negado",Lang[Config.lang]['invalid_value'])
		end
	end
end)

RegisterServerEvent("vrp_stores:sellMarket")
AddEventHandler("vrp_stores:sellMarket",function(key)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local user_id = xPlayer.identifier
	if user_id then
		local sql = "SELECT user_id FROM `store_business` WHERE market_id = @market_id";
		local query = MySQL.Sync.fetchAll(sql,{['@market_id'] = key})[1];
		if query.user_id == user_id then
			local sql = "DELETE FROM `store_business` WHERE market_id = @market_id;";
			MySQL.Sync.execute(sql, {['@market_id'] = key});
			local sql = "DELETE FROM `store_balance` WHERE market_id = @market_id;";
			MySQL.Sync.execute(sql, {['@market_id'] = key});
			local sql = "DELETE FROM `store_jobs` WHERE market_id = @market_id;";
			MySQL.Sync.execute(sql, {['@market_id'] = key});

			xPlayer.addAccountMoney('bank', Config.market_locations[key].sell_price)
			TriggerClientEvent("Notify",source,"sucesso",Lang[Config.lang]['store_sold'])
			SendWebhookMessage(Config.webhook,Lang[Config.lang]['logs_close']:format(key,user_id..os.date("\n["..Lang[Config.lang]['logs_date'].."]: %d/%m/%Y ["..Lang[Config.lang]['logs_hour'].."]: %H:%M:%S")))
		else
			TriggerClientEvent("Notify",source,"negado",Lang[Config.lang]['sell_error'])
		end
	end
end)

function giveMarketMoney(market_id,amount)
	local sql = "UPDATE `store_business` SET money = money + @amount WHERE market_id = @market_id";
	MySQL.Sync.execute(sql, {['@amount'] = amount, ['@market_id'] = market_id});
end

function tryGetMarketMoney(market_id,amount)
	local sql = "SELECT money FROM `store_business` WHERE market_id = @market_id";
	local query = MySQL.Sync.fetchAll(sql,{['@market_id'] = market_id})[1];
	if tonumber(query.money) >= amount then
		local sql = "UPDATE `store_business` SET money = @money, total_money_spent = total_money_spent + @amount WHERE market_id = @market_id";
		MySQL.Sync.execute(sql, {['@money'] = (tonumber(query.money) - amount), ['@amount'] = amount, ['@market_id'] = market_id});
		return true
	else
		return false
	end
end

function getStockAmount(stock)
	local arr_stock = json.decode(stock)
	local count = 0
	for k,v in pairs(arr_stock) do
		count = count + v
	end
	return count
end

function insertBalanceHistory(market_id,income,title,amount)
	local sql = "INSERT INTO `store_balance` (market_id,income,title,amount,date) VALUES (@market_id,@income,@title,@amount,@date)";
	MySQL.Sync.execute(sql, {['@market_id'] = market_id, ['@income'] = income, ['@title'] = title, ['@amount'] = amount, ['@date'] = os.time()});
end

function openUI(source, key, reset, isMarket)
	local query = {}
	local xPlayer = ESX.GetPlayerFromId(source)
	local user_id = xPlayer.identifier
	if user_id then
		-- Busca os dados do usuário
		local sql = "SELECT * FROM `store_business` WHERE market_id = @market_id";
		query.store_business = MySQL.Sync.fetchAll(sql,{['@market_id'] = key})[1];
		
		-- Se não tiver dono se o usuário estiver abrindo o menu
		if isMarket and query.store_business == nil then
			query.store_business = {}
			query.store_business.stock = false
		else
			query.store_business.stock_amount = getStockAmount(query.store_business.stock)
		end

		-- Busca os dados dos trabalhos
		local sql = "SELECT * FROM `store_jobs` WHERE market_id = @market_id";
		query.store_jobs = MySQL.Sync.fetchAll(sql,{['@market_id'] = query.store_business.market_id});

		-- Busca os dados dos historicos bancários
		local sql = "SELECT * FROM `store_balance` WHERE market_id = @market_id ORDER BY id DESC";
		query.store_balance = MySQL.Sync.fetchAll(sql,{['@market_id'] = query.store_business.market_id});

		-- Busca as configs necessárias
		query.config = {}
		query.config.format = deepcopy(Config.format)
		query.config.market_locations = deepcopy(Config.market_locations[key])
		query.config.market_types = deepcopy(Config.market_types[Config.market_locations[key].type])

		-- Envia pro front-end
		TriggerClientEvent("vrp_stores:open",source, query, reset, isMarket or false)
	end
end

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

RegisterServerEvent("vrp_stores:vehicleLock")
AddEventHandler("vrp_stores:vehicleLock",function()
	local source = source
	TriggerClientEvent("vrp_stores:vehicleClientLock",source)
end)

RegisterServerEvent("vrp_stores:trydeleteobj")
AddEventHandler("vrp_stores:trydeleteobj",function(index)
    TriggerClientEvent("vrp_stores:syncdeleteobj",-1,index)
end)

function print_table(node)
    -- to make output beautiful
    local function tab(amt)
        local str = ""
        for i=1,amt do
            str = str .. "\t"
        end
        return str
    end
 
    local cache, stack, output = {},{},{}
    local depth = 1
    local output_str = "{\n"
 
    while true do
        local size = 0
        for k,v in pairs(node) do
            size = size + 1
        end
 
        local cur_index = 1
        for k,v in pairs(node) do
            if (cache[node] == nil) or (cur_index >= cache[node]) then
               
                if (string.find(output_str,"}",output_str:len())) then
                    output_str = output_str .. ",\n"
                elseif not (string.find(output_str,"\n",output_str:len())) then
                    output_str = output_str .. "\n"
                end
 
                -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
                table.insert(output,output_str)
                output_str = ""
               
                local key
                if (type(k) == "number" or type(k) == "boolean") then
                    key = "["..tostring(k).."]"
                else
                    key = "['"..tostring(k).."']"
                end
 
                if (type(v) == "number" or type(v) == "boolean") then
                    output_str = output_str .. tab(depth) .. key .. " = "..tostring(v)
                elseif (type(v) == "table") then
                    output_str = output_str .. tab(depth) .. key .. " = {\n"
                    table.insert(stack,node)
                    table.insert(stack,v)
                    cache[node] = cur_index+1
                    break
                else
                    output_str = output_str .. tab(depth) .. key .. " = '"..tostring(v).."'"
                end
 
                if (cur_index == size) then
                    output_str = output_str .. "\n" .. tab(depth-1) .. "}"
                else
                    output_str = output_str .. ","
                end
            else
                -- close the table
                if (cur_index == size) then
                    output_str = output_str .. "\n" .. tab(depth-1) .. "}"
                end
            end
 
            cur_index = cur_index + 1
        end
 
        if (#stack > 0) then
            node = stack[#stack]
            stack[#stack] = nil
            depth = cache[node] == nil and depth + 1 or depth - 1
        else
            break
        end
    end
 
    -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
    table.insert(output,output_str)
    output_str = table.concat(output)
   
    print(output_str)
end