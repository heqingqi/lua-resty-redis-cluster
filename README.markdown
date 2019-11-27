Install
=======
	1、make
	2、make install

	默认openresty安装目录为/usr/local/openresty，如果需要修改其他目录，修改Makefile

使用方法
=======
	local config = {
              name = "缓存名称",
            --授权密码；如果没有redis没有授权密码，就空
            auth = "密码",
            --连接池超时时间
            keepalive_timeout = 5000,
            --连接池保存连接的数量
            keepalive_cons = 200,
            serv_list = {
                {ip="172.16.200.85", port = 7000},
                {ip="172.16.200.85", port = 7001},
                {ip="172.16.200.85", port = 7002},
                {ip="172.16.200.191", port = 7003},
                {ip="172.16.200.191", port = 7004},
                {ip="172.16.200.191", port = 7005},
            },
        }
        local redis_cluster = require "resty.rediscluster"
        local red = redis_cluster:new(config)
        local ok, err = red:set("dog", "an animal")
        if not ok then
             ngx.say("failed to set dog: ", err)
             return
        end
        local results, err = red:get("dog")
        if not results then
             ngx.say("failed to get dog: ", err)
             return
        end
        ngx.say(results)


