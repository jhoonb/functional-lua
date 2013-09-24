functional-lua
==============

Simple Implementation of Functional Programming Resources

Functional.lua is a module written in Lua which implements some functional programming
features such as map, filter, reduce, any, all (of Haskell and Python) with feature range
and rangerandom (inspired by Python) to generate lists (without support list comprehensions),
and replicate to repeat elements of lists (itertools repeat the Python).

Functions:
--
> functional.range(from[, to[, step]]) -> table <br>
> functional.map(f, ...) -> table <br>
> functional.reduce(x[, op]) -> number<br>
> functional.filter(f, x) -> table<br>
> functional.rangerandom(max[, m, [n]]) -> table <br>
> functional.any(f, x) -> boolean <br>
> functional.all(f, x) -> boolean  <br>
> functional.replicate(x,y) -> table <br>


-- Function range: Generate list of elements
--
> range(from[, to[, step]])  <br>

Examples: <br>

> range(10) => {1,2,3,4,5,6,7,8,9,10}  <br>
> range(2,5) => {2,3,4,5}  <br>
> range(-2,4,2) => {-2,0,2,4}  <br>

param from: number  <br>
param to: number (optional)  <br>
param step: number (optional, default: 1)  <br>
return: table  <br>

-- Function rangerandom: Generate list pseudo-random
--
> rangerandom(max[, m,[ n]])  <br>

Examples:  <br>

> rangerandom(2) => {0.039280343353413, 0.43763759659493}  <br>
> rangerandom(5,-10,0) => {-9,0,-2,5,-3}  <br>

param max: number of elements  <br>
param m, n: interval of choice random m, n <br>
return: table  <br>

-- Function map: Applies the function f on each table passed as argument
--
> map( f, ...)  <br>

Example: <br>

> f = function(a,b) return a + b end  <br>
> x, y = {2,4}, {2,4}  <br>
> map(f,x,y) ==> table: {4,16}  <br>

param f: function  <br>
param ... : multiples parameters of lists(table) <br>
return: table or nil  <br>

-- Function reduce: Reduce table according to the operation defined
--
> reduce(x[, op])  <br>

Example:  <br>

> reduce({2,4,6}}) => number: 12  <br>
> reduce({2,4,6}, '*') => number: 48  <br>

param x: table  <br>
param op: string, operation mathematic: +,-,*,/,^ (default: +)  <br>
return: number  <br>

-- Function filter: Creates a list starting from x where x a for each function f is true
--
> filter(f, x)  <br>

Example: <br>

> f = function(a) if type(a) == 'number' then return true end return false end  <br>
> filter(f, {'aa','bc',123, '1567', 5, 8, 0, 'a'}) -> {123, 5, 8, 0}  <br>

param: f: function  <br>
param: x: table  <br>
return: table  <br>

--Function any: Returns true if any element of x is true for the function f(x)
--
> any(f, x) <br>

Example: <br>

> function f(a) if type(a) == 'number' then return true end return false end  <br>
> any(f, {2,3,4,5}) -> true  <br>
> any(f, {2,3,4,'aba'}) - -> true  <br>
> any(f, {'lol', 'test', '2'}) -> false  <br>

param f: function <br>
param x: table  <br>
return: boolean  <br>

--Function all: Returns true if all element of x is true for the function f(x)
--
> all(f, x)  <br>

Example:  <br>

> function f(a) if type(a) == 'number' then return true end return false end  <br>
> all(f, {2,3,4,5}) -> true  <br>
> all(f, {2,3,4,'aba'}) - -> false  <br>
> all(f, {'lol', 'test', '2'}) -> false  <br>

param f: function <br>
param x: table  <br>
return: boolean <br>

--Function replicate: Generates a list of elements x of y
--
> replicate(x, y)  <br>

Example:  <br>

> replicate('a',5) -> {'a', 'a', 'a', 'a'} <br>
> replicate({2}, 3) -> {{2}, {2}} <br>
> replicate(2, 4) -> {2, 2, 2, 2}  <br>

param x: number, string, table, function  <br>
param y: number > 0 <br>
return: table  <br>
