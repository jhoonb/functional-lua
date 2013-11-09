--[[
-- Module: functional.lua
-- Author: Jhonathan Paulo Banczek
-- Copyright: jpbanczek@gmail.com
-- 15-09-2013

-- DESCRIPTION
	Functional.lua is a module written in Lua which
	implements some functional programming features
	such as map, filter, reduce, any, all
	(of Haskell and Python) with feature range and
	rangerandom (inspired by Python) to generate lists
	(without support list comprehensions), and replicate 
	to repeat elements of lists (itertools repeat the Python).

-- DEPENDENCIES
	None.
--
--]]
---
-- FUNCTIONS | RETURN TYPE
-- | functional.map(f, ...) -> table
-- | functional.reduce(x[, op]) -> number
-- | functional.filter(f, x) -> table
-- | functional.range(from[, to, [step]] ) -> table
-- | functional.rangerandom(max[, m, [n]]) -> table 
-- | functional.any(f, x) -> boolean
-- | functional.all(f, x) -> boolean
-- | functional.replicate(x,y) -> table
------------------------------------------------------

-- define local functions
local random = math.random

-- table that store functions module
local functional = {}

functional._TYPE = 'module'
functional._NAME = 'functional'


-- Function: Generate list of elements
-- range(from[, to[, step]])
--
-- Examples:
--
-- range(10)     => {1,2,3,4,5,6,7,8,9,10}
-- range(2,5)    => {2,3,4,5}
-- range(-2,4,2) => {-2,0,2,4}
--
-- param from: number
-- param to: number (optional)
-- param step: number  (optional, default: 1)
-- return: table
--
function functional.range(from, to, step)

	assert(from and type(from) == 'number')

	local step = step or 1
	
	if not to then
		from, to = 1, from
	end

	assert(type(to) == 'number' and type(step) == 'number') 
	assert(from <= to)

	local aux = {}
	
	for i = from, to, step do table.insert(aux, i) end

	return aux

end


-- Function: Generate list pseudo-random
-- rangerandom(max[, m,[ n]])
--
-- Examples:
-- rangerandom(2)       => {0.039280343353413, 0.43763759659493}
-- rangerandom(5,-10,0) => {-9,0,-2,5,-3}
--
-- param max: number of elements
-- param m, n: interval of choice random [m, n](optional: default: [0.,1.]) 
-- return: table
--
function functional.rangerandom(max, m, n)

	assert(max and type(max) == 'number')
	assert(max > 0, 'Error in arguments: max < 0')

	if not m or not n then

		local aux = {}
		
		for i = 1, max do table.insert(aux, random()) end
		
		return aux

	else
		assert(type(m) == 'number' and type(n) == 'number')
		assert(m <= n)
		
		local aux = {}
		
		for i = 1, max do table.insert(aux, random(m, n)) end
		
		return aux
	end
end


-- Function: Map: applies the function f on each table passed as argument  
-- map( f, ...)
--
-- Example:
-- f = function(a,b) return a + b end
-- x, y = {2,4}, {2,4}
-- map(f,x,y) ==> table: {4,16}
--
-- param f: function
-- param ... : multiples parameters of lists(table) 
-- return: table or nil
--
function functional.map(f, ...)
	
	assert(f and ... and #... > 0 and type(f) == 'function')
	
	local tabs = {...}

	if type(tabs[1]) ~= 'table' then return nil end
	
	for i = 1, #tabs do
		if type(tabs[i]) ~= 'table' then return nil end
	end

	for i = 1, #tabs do
		if #tabs[i] ~= #tabs[1] then return nil end
	end
	
	local aux = {}

	for j = 1, #tabs[1] do
		local aux2 = {}
		for i = 1, #tabs do
			table.insert(aux2,tabs[i][j])
		end
		table.insert(aux, f(table.unpack(aux2)))
	end

	return aux
end
 

-- Function: Reduce table according to the operation defined
-- reduce(x[, op])
--
-- Example: 
-- reduce({2,4,6}}) 	=> number: 12
-- reduce({2,4,6}, '*') => number: 48
--
-- param x: table
-- param op: string, operation mathematic: +,-,*,/,^ (default: +)  
-- return: number
--
function functional.reduce(x, op)
	
	assert(x and #x > 0)
	
	local op = op or '+'
	
	if not(op == '+' or op == '-'  or op == '*') then
		if not(op == '/' or op == '^') then
			assert(nil)
		end
	end 

	local aux = x[1]

	for i = 2, #x do
		if op == '+' then
			aux = aux + x[i]
		elseif op == '-' then
			aux = aux - x[i]
		elseif op == '*' then
			aux = aux * x[i]
		elseif op == '/' then
			if x[i] == 0 then
				return 'inf' end
			aux = aux / x[i]
		elseif op == '^' then
			aux = aux ^ x[i]
		end
	end

	return aux
end


--
-- Function: filter, creates a list starting from x where x a for
-- each function f is true
-- filter(f, x)
--
-- Example:
-- f = function(a) if type(a) == 'number' then return true end return false end
-- filter(f, {'aa','bc',123, '1567', 5, 8, 0, 'a'}) -> {123, 5, 8, 0}
--
-- param: f: function
-- param: x: table
-- return: table
--
function functional.filter(f, x)

	assert(f and x and #x > 0)
	assert(type(f) == 'function')

	local aux = {}
	for i = 1, #x do
		if f(x[i]) then table.insert(aux,x[i]) end
	end

	return aux
end


--
-- Function: Returns true if any element of x is true for the function f(x)
-- any(f, x)
--
-- Example:
-- function f(a) if type(a) == 'number' then return true end return false end
-- any(f, {2,3,4,5}) 			-> true
-- any(f, {2,3,4,'aba'}) -		-> true
-- any(f, {'lol', 'test', '2'}) -> false
--
-- param f: function
-- param x: table 
-- return: boolean
--
function functional.any(f, x)

	assert(f and x and #x > 0)
	assert(type(f) == 'function')

	for i = 1, #x do 
		if f(x[i]) then return true end
	end

	return false
end


--
-- Function: Returns true if all element of x is true for the function f(x)
-- all(f, x)
--
-- Example:
-- function f(a) if type(a) == 'number' then return true end return false end
-- all(f, {2,3,4,5}) 			-> true
-- all(f, {2,3,4,'aba'}) -		-> false
-- all(f, {'lol', 'test', '2'}) -> false
--
-- param f: function
-- param x: table 
-- return: boolean
--
function functional.all(f, x)
	
	assert(f and x and #x > 0)
	assert(type(f) == 'function')

	for i = 1, #x do
		if not f(x[i]) then return false end
	end

	return true

end


--
-- Function: generates a list of elements x of y
-- replicate(x, y)
--
-- Example:
-- replicate('a',5) 	-> {'a', 'a', 'a', 'a'}
-- replicate({2}, 3) 	-> {{2}, {2}}
-- replicate(2, 4) 		-> {2, 2, 2, 2} 

-- param x: number, string, table, function
-- param y: number > 0
-- return: table
--
function functional.replicate(x, y)

	assert(x and y and y > 0)
	assert(type(y) == 'number')
	
	local aux = {}
	
	for i = 1, y do 
		table.insert(aux, x)
	end
	return aux
end

-- return module
return functional

-- end
