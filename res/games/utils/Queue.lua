local Queue = class('Queue' )

function Queue:ctor()
	self:reset()
end

function Queue:pop()
	local ret = nil
	if self._index < self._border then
		ret = self._data[self._index]
		self._data[self._index] = nil
		self._index = self._index + 1

	else
		self:reset()

	end

	return ret	
end

function Queue:push( d )
	self._data[self._border] = d
	self._border = self._border + 1
end

function Queue:front()
	if self._index < self._border then
		return self._data[self._index]
	end

	return ret
end

function Queue:back()
	if self._border > 0 then
		return self._data[self._border - 1 ]
	end

	return nil
end

function Queue:at( index )
	return self._data[self._index + index - 1]
end

function Queue:size()
	return self._border - self._index
end

function Queue:empty()
	return self:size() == 0
end

function Queue:clear()
	if self:empty() then
		for i = self._index, self._border do
			self._data[i] = nil
		end
	end

	self:reset()
end

function Queue:reset()
	self._index  = 0
	self._border = 0
	self._data   = {}
end

return Queue