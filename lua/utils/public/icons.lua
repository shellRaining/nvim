local M = {}

M.diagnostic = {
    Error = "",
    Warn = "",
    Hint = "",
    Info = "",
}

M.tag_level = {
    FIX = "",
    TODO = "",
    HACK = "",
    WARN = "",
    PERF = "",
    NOTE = "",
    TEST = "⏲",
}

M.lsp_kind = {
    Array = "",
    Boolean = "",
    Class = "",
    Color = "",
    Constant = "",
    Constructor = "",
    Copilot = "",
    Enum = "",
    EnumMember = "",
    Event = "",
    Field = "",
    File = "",
    Folder = "",
    Function = "",
    Interface = "",
    Key = "",
    Keyword = "",
    Method = "",
    Module = "",
    Namespace = "",
    Null = "",
    Number = "",
    Object = "",
    Operator = "",
    Package = "",
    Property = "",
    Reference = "",
    Snippet = "",
    String = "",
    Struct = "",
    Text = "",
    TypeParameter = "",
    Unit = "",
    Value = "",
    Variable = "",
}

return M
