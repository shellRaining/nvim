local ft = vim.filetype

-- for easy to use snippets
ft.add({
  pattern = {
    [".*.spec.ts"] = "jest.typescript",
    [".*.spec.js"] = "jest.javascript",
    [".*.wxml"] = "html",
    [".*.wxss"] = "css",
  },
})
