functional-lua
==============

Simple Implementation of Functional Programming Resources

Functional.lua is a module written in Lua which implements some functional programming
features such as map, filter, reduce, any, all (of Haskell and Python) with feature range
and rangerandom (inspired by Python) to generate lists (without support list comprehensions),
and replicate to repeat elements of lists (itertools repeat the Python).

Functions:
--
> functional.range(from[, to[, step]]) -> table 
> functional.map(f, ...) -> table 
> functional.reduce(x[, op]) -> number
> functional.filter(f, x) -> table
> functional.rangerandom(max[, m, [n]]) -> table
> functional.any(f, x) -> boolean
> functional.all(f, x) -> boolean 
> functional.replicate(x,y) -> table 


-- Function range: Generate list of elements
--
> range(from[, to[, step]]) 

Examples:

> range(10) => {1,2,3,4,5,6,7,8,9,10} 
> range(2,5) => {2,3,4,5} 
> range(-2,4,2) => {-2,0,2,4} 

param from: number 
param to: number (optional) 
param step: number (optional, default: 1) 
return: table 

-- Function rangerandom: Generate list pseudo-random
--
> rangerandom(max[, m,[ n]]) 

Examples: 

> rangerandom(2) => {0.039280343353413, 0.43763759659493} 
> rangerandom(5,-10,0) => {-9,0,-2,5,-3} 

param max: number of elements 
param m, n: interval of choice random m, n
return: table 

-- Function map: Applies the function f on each table passed as argument
--
> map( f, ...) 

Example:

> f = function(a,b) return a + b end 
> x, y = {2,4}, {2,4} 
> map(f,x,y) ==> table: {4,16} 

param f: function 
param ... : multiples parameters of lists(table)
return: table or nil 

-- Function reduce: Reduce table according to the operation defined
--
> reduce(x[, op]) 

Example: 

> reduce({2,4,6}}) => number: 12 
> reduce({2,4,6}, '*') => number: 48 

param x: table 
param op: string, operation mathematic: +,-,*,/,^ (default: +) 

return: number 

-- Function filter: Creates a list starting from x where x a for each function f is true
--
> filter(f, x) 

Example:

> f = function(a) if type(a) == 'number' then return true end return false end 
> filter(f, {'aa','bc',123, '1567', 5, 8, 0, 'a'}) -> {123, 5, 8, 0} 

param: f: function 
param: x: table 
return: table 

--Function any: Returns true if any element of x is true for the function f(x)
--
> any(f, x)

Example:

> function f(a) if type(a) == 'number' then return true end return false end 
> any(f, {2,3,4,5}) -> true 
> any(f, {2,3,4,'aba'}) - -> true 
> any(f, {'lol', 'test', '2'}) -> false 

param f: function
param x: table 
return: boolean 

--Function all: Returns true if all element of x is true for the function f(x)
--
> all(f, x) 

Example: 

> function f(a) if type(a) == 'number' then return true end return false end 
> all(f, {2,3,4,5}) -> true 
> all(f, {2,3,4,'aba'}) - -> false 
> all(f, {'lol', 'test', '2'}) -> false 

param f: function
param x: table 
return: boolean

--Function replicate: Generates a list of elements x of y
--
> replicate(x, y) 

Example: 

> replicate('a',5) -> {'a', 'a', 'a', 'a'}
> replicate({2}, 3) -> {{2}, {2}}
> replicate(2, 4) -> {2, 2, 2, 2} 

param x: number, string, table, function 
param y: number > 0
return: table 
