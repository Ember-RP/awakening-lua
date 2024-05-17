function update(event, player, msg, Type, lang)

    player_type = player:GetGMRank()
    
    if player_type >= 5 then 
	
		if msg == "%push lua sargeras" then
		
			os.execute ('bash /home/develop/awake/main/bin/lua_scripts/update_lua.sh &')
			player:SendBroadcastMessage("Successfully pushed Lua Scripts. This is a stable version push. Don't forget to merge changes in from master. Some Modules require restarts or .reload eluna")
		
		elseif msg == "%push log sargeras" then
		
			os.execute ('bash /home/develop/awake/main/bin/lua_scripts/push_log.sh &')
			player:SendBroadcastMessage("Successfully pushed Lua Log")
		
		elseif msg == "%push dbc sargeras" then
		
			os.execute ('bash /home/develop/awake/main/bin/lua_scripts/update_dbc.sh &')
			player:SendBroadcastMessage("Successfully pushed DBC Files. This requires a restart. This is a stable version push. Don't forget to merge changes in from master.")
		
		elseif msg == "%push core sargeras" then
		
			os.execute ('bash /home/develop/compile_sargeras.sh &')
			player:SendBroadcastMessage("Successfully started compiling core. This requires a restart but please wait a few minutes for compiling to finish. This is a stable version push. Don't forget to merge changes in from master.")

		elseif msg == "%push lua proudmoore" then
		
			os.execute ('bash /home/develop/awake/proudmoore/bin/lua_scripts/update_lua.sh &')
			player:SendBroadcastMessage("Successfully pushed Lua Scripts. Some Modules require restarts or .reload eluna")
		
		elseif msg == "%push log proudmoore" then
		
			os.execute ('bash /home/develop/awake/proudmoore/bin/lua_scripts/push_log.sh &')
			player:SendBroadcastMessage("Successfully pushed Lua Log")
		
		elseif msg == "%push dbc proudmoore" then
		
			os.execute ('bash /home/develop/awake/proudmoore/bin/lua_scripts/update_dbc.sh &')
			player:SendBroadcastMessage("Successfully pushed DBC Files. This requires a restart")
			
		elseif msg == "%push core proudmoore" then
		
			os.execute ('bash /home/develop/compile_proudmoore.sh &')
			player:SendBroadcastMessage("Successfully started compiling core. This requires a restart but please wait a few minutes for compiling to finish.")
				
		elseif msg == "%push lua andorhal" then
		
			os.execute ('bash /home/develop/awake/andorhal/bin/lua_scripts/update_lua.sh &')
			player:SendBroadcastMessage("Successfully pushed Lua Scripts. Some Modules require restarts or .reload eluna")
		
		elseif msg == "%push log andorhal" then
		
			os.execute ('bash /home/develop/awake/andorhal/bin/lua_scripts/push_log.sh &')
			player:SendBroadcastMessage("Successfully pushed Lua Log")
		
		elseif msg == "%push dbc andorhal" then
		
			os.execute ('bash /home/develop/awake/andorhal/bin/lua_scripts/update_dbc.sh &')
			player:SendBroadcastMessage("Successfully pushed DBC Files. This requires a restart")
			
		elseif msg == "%push core andorhal" then
		
			os.execute ('bash /home/develop/compile_andorhal.sh &')
			player:SendBroadcastMessage("Successfully started compiling core. This requires a restart but please wait a few minutes for compiling to finish.")


		elseif msg == "%push lua tichondrius" then
		
			os.execute ('bash /home/develop/awake/tichondrius/bin/lua_scripts/update_lua.sh &')
			player:SendBroadcastMessage("Successfully pushed Lua Scripts. Some Modules require restarts or .reload eluna")
		
		elseif msg == "%push log tichondrius" then
		
			os.execute ('bash /home/develop/awake/tichondrius/bin/lua_scripts/push_log.sh &')
			player:SendBroadcastMessage("Successfully pushed Lua Log")
		
		elseif msg == "%push dbc tichondrius" then
		
			os.execute ('bash /home/develop/awake/tichondrius/bin/lua_scripts/update_dbc.sh &')
			player:SendBroadcastMessage("Successfully pushed DBC Files. This requires a restart")
			
		elseif msg == "%push core tichondrius" then
		
			os.execute ('bash /home/develop/compile_tichondrius.sh &')
			player:SendBroadcastMessage("Successfully started compiling core. This requires a restart but please wait a few minutes for compiling to finish.")
			
			

		end
    end
end


RegisterPlayerEvent(18,update)
