local status, configs = pcall(require, "wilder")
if not status then
    print("Cmd autocomplete isn't working!")
    return
end

configs.setup({
    modes = {':', '/', '?'},
    next_key = '<Tab>',
    previous_key = '<S-Tab>'
})
configs.set_option("renderer", configs.popupmenu_renderer({
    -- higlighter applies higlighting to the candidates
    highlighter = configs.basic_highlighter()
}))
