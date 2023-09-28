local status, live_server = pcall(require, "live-server")
if not status then
    print("Live server plugin isn't avaliable!")
    return
end

live_server.setup()
