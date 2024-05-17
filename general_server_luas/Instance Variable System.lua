maximumInstanceVariables = 5

instanceTotalIndices = 0 -- The total number of incices and their counters.
instanceIndex = {} -- The instance ID corresponding to an instance counter.
instanceVariables = {} -- An array of arrays containing variables.


function InstanceSystemCreateVariables(instanceId)
	local hasBeenAdded = false

	for i=1,instanceTotalIndices,1 do
		if (instanceVariables[i][1] == nil) then -- If the first value of an array is nil, then it can be reused.
			instanceIndex[i] = instanceId

			instanceVariables[i] = {}

			-- Initalize instance variables.
			for j=1,maximumInstanceVariables,1 do
				instanceVariables[i][j] = 0
			end

			hasBeenAdded = true
			break
		end
	end

	if (hasBeenAdded == false) then
		instanceTotalIndices = instanceTotalIndices + 1

		instanceIndex[instanceTotalIndices] = instanceId

		instanceVariables[instanceTotalIndices] = {}
		-- Initalize instance variables.
		for j=1,maximumInstanceVariables,1 do
			instanceVariables[instanceTotalIndices][j] = 0
		end
	end
end

-- Returns the instance variable corresponding to the specified instanceId and index.
-- Returns nil if no variable was found for the specified instanceId and/or index.
function InstanceSystemGetVariable(instanceId, variableIndex)
	for i=1,instanceTotalIndices,1 do
		if (instanceIndex[i] == instanceId) then
			return instanceVariables[i][variableIndex]
		end
	end

	return nil
end

-- Attempts to set the variable for the specified instanceId at the specified index
-- in the variables array.
-- Does nothing if the specified instanceId doesn't correspond to any existing
-- entry.
function InstanceSystemSetVariable(instanceId, index, variable)
	if (index < maximumInstanceVariables and index > 0) then
		for i=1,instanceTotalIndices,1 do
			if (instanceIndex[i] == instanceId) then
				instanceVariables[i][index] = variable
			end
		end
	end
end

-- Resets all data held for the specified instanceId.
-- Does nothing if there was no data being held for the specified instanceId.
function InstanceSystemFinish(instanceId)
	for i=1,instanceTotalIndices,1 do
		if (instanceIndex[i] == instanceId) then
			instanceIndex[i] = nil

			-- Initalize instance variables.
			for j=1,maximumInstanceVariables,1 do
				instanceVariables[i][j] = 0
			end

			break
		end
	end
end
