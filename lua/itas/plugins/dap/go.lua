local status, dap_go = pcall(require, "dap-go")
if not status then
    print("Dap-go plugin isn't avaliable!")
    return
end

dap_go.setup({})
