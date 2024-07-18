return {
  "Exafunction/codeium.vim",
  event = "BufEnter",
  config = function()
    vim.cmd("CodeiumDisable")
  end
}
