
The lua math.random is seeded at launch by the value 0



-- the goal of this module is to use a stored random value as seed instead of time
-- because unixtime with only second precision is predictable!

-- the LUASEEDFILE is used if defined
-- else the $HOME/.luaseed was used

-- attention: the math.randomseed() seems have strange effect in case of float number

-- the current code is little ugly ...



# seed info

Lua use the ANSI rand() .
LuaJIT uses a [Enhanced PRNG](http://luajit.org/extensions.html#math_random).

## lua5.1

[see math_randomseed](http://www.lua.org/source/5.1/lmathlib.c.html#math_randomseed)
```
lua5.1 -e 'r=math.random     r1=r() math.randomseed(0) r2=r() assert(r1==r2) print(r(), r(), r())'
0.84018771715471	0.39438292681909	0.78309922375861
```

## lua5.2

[see math_randomseed](http://www.lua.org/source/5.2/lmathlib.c.html#math_randomseed)
```
lua5.2 -e 'r=math.random r() r1=r() math.randomseed(0) r2=r() assert(r1==r2) print("discard", r(), r())'
discard		0.39438292681909	0.78309922375861
```


## luajit

```
luajit -e 'r=math.random     r1=r() math.randomseed(0) r2=r() assert(r1==r2) print(r(), r(), r())'
0.79420629243124        0.69885246563716        0.5901037417281
```

