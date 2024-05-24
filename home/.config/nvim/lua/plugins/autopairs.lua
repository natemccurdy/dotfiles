return {
  url = "https://github.com/windwp/nvim-autopairs",
  event = { "InsertEnter" },
  opts = {
    check_ts = true, -- use treesitter to check for a pair.
    ts_config = {
      lua = { "string" }, -- it will not add pair on that treesitter node
      javascript = { "template_string" },
      java = false, -- don't check treesitter on java
    },
  },
}
