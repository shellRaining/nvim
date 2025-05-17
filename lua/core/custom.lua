local M = {}

function M.convert_to_utf8()
  local input_file = vim.fn.expand("%:p")
  if input_file == "" then
    vim.notify("当前没有打开文件", vim.log.levels.ERROR)
    return
  end
  local default_output = vim.fn.expand("%:r") .. "-utf8." .. vim.fn.expand("%:e", true)
  local output_file = vim.fn.input("保存为 (留空默认 " .. default_output .. "): ", default_output, "file")

  if output_file == "" then
    output_file = default_output
  end
  -- 保证路径完整
  output_file = vim.fn.fnamemodify(output_file, ":p")

  -- iconv -f 自动探测当前fileencoding, fallback到 cp936（你可以手动设置）
  local src_encoding = vim.bo.fileencoding ~= "" and vim.bo.fileencoding or "cp936"
  -- 构建shell命令
  local cmd = string.format('iconv -f %s -t utf-8 "%s" > "%s"', src_encoding, input_file, output_file)
  local ok = os.execute(cmd)
  if ok == 0 then
    vim.notify("转码成功: " .. output_file, vim.log.levels.INFO)
  else
    vim.notify("转码失败: " .. cmd, vim.log.levels.ERROR)
  end
end

vim.api.nvim_create_user_command("ConvertToUTF8", M.convert_to_utf8, {})

return M
