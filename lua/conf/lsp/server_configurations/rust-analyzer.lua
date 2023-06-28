return {
    settings = {
        ['rust-analyzer'] = {
            diagnostics = {
                enable = true,
                experimental = {
                    enable = true,
                },
            },
            cargo = {
                allFeatures = true,
            },
        },
    },
}
