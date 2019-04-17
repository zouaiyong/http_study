-- Copyright (C) 2019 by chrono

local misc = ngx.shared.misc

local key = ngx.var.http_host .. "time"
local time = tonumber(misc:get(key))

if not time then
    time = ngx.time()
    misc:set(key, time, 10)   -- seconds
end

local str = "HTTP Original Server\n" ..
            "Now is " .. ngx.http_time(time)


ngx.header['Content-Length'] = #str
--ngx.header['Content-Type'] = 'text/plain'

ngx.header['Cache-Control'] = 'public, max-age=10'
ngx.header['Expires'] = ngx.http_time(time + 10)

ngx.header['Last-Modified'] = ngx.http_time(time)
ngx.header['ETag'] = string.format('"%x-%x"', time, #str)

ngx.print(str)

