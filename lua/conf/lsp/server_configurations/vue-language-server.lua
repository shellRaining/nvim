return {
    filetypes = { "javascriptreact", "typescriptreact", "vue", "json" },
    on_attach = function(client, _)
        client.server_capabilities.documentFormattingProvider = false
    end,
}
