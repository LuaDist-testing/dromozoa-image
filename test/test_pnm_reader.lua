-- Copyright (C) 2015 Tomoyuki Fujimori <moyu@dromozoa.com>
--
-- This file is part of dromozoa-image.
--
-- dromozoa-image is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- dromozoa-image is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with dromozoa-image.  If not, see <http://www.gnu.org/licenses/>.

local image = require "dromozoa.image"

local img = image.read_pnm([[
P2
# Shows the word "FEEP" (example from Netpbm man page on PGM)
24 7
15
0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
0  3  3  3  3  0  0  7  7  7  7  0  0 11 11 11 11  0  0 15 15 15 15  0
0  3  0  0  0  0  0  7  0  0  0  0  0 11  0  0  0  0  0 15  0  0 15  0
0  3  3  3  0  0  0  7  7  7  0  0  0 11 11 11  0  0  0 15 15 15 15  0
0  3  0  0  0  0  0  7  0  0  0  0  0 11  0  0  0  0  0 15  0  0  0  0
0  3  0  0  0  0  0  7  7  7  7  0  0 11 11 11 11  0  0 15  0  0  0  0
0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0
]])

assert(img:width() == 24)
assert(img:height() == 7)
assert(img:channels() == 1)
assert(img:min() == 0)
assert(img:max() == 15)

local n = 0
for p in img:each() do
  n = n + 1
  -- print(p.Y)
  assert(p.R == p.Y)
  assert(p.G == p.Y)
  assert(p.B == p.Y)
  assert(p.A == 15)
end
assert(n == 24 * 7)

local n = 0
local m = 0
for p in img:each(2, 4, 2, 4) do
  n = n + 1
  m = m + p.Y
  -- print(p.x, p.y, "|", p.R, p.G, p.B, p.Y, p.A)
  assert(p.Y == 0 or p.Y == 3)
  assert(p.A == 15)
end
assert(n == 9)
assert(m == 21)

local img = image.read_pnm([[
P6
3 1
65535
]] .. ("\255\0\0\1\0\0"):rep(3))

local p = img:pixel()
-- print(p)
assert(p.R == 0xff00)
assert(p.G == 0x0001)
assert(p.B == 0x0000)
