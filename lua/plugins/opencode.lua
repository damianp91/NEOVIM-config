return {
  "opencode-nvim/opencode.nvim",
  dir = "~/.local/share/nvim/opencode",
  lazy = true,
  config = function()
    local opencode = require("opencode")

    opencode.setup({
      api_key = os.getenv("OPENCODE_API_KEY") or "your-api-key-here",
      model = "opencode/big-pickle",

      keymaps = {
        toggle = "<leader>oc",
        ask = "<leader>oa",
        explain = "<leader>oe",
        refact = "<leader>or",
      },

      ui = {
        position = "right",
        width = 50,
        border = "rounded",
      },

      features = {
        auto_save = true,
        syntax_highlight = true,
        code_completion = true,
        error_handling = true,
      }
    })

    vim.api.nvim_create_user_command("OpenCode", function(opts)
      opencode.open()
    end, { desc = "Open OpenCode assistant" })

    vim.api.nvim_create_user_command("OpenCodeAsk", function(opts)
      local question = table.concat(opts.fargs, " ")
      opencode.ask(question)
    end, {
      desc = "Ask OpenCode a question",
      nargs = "*",
      complete = "file"
    })

    vim.api.nvim_create_user_command("OpenCodeExplain", function(opts)
      opencode.explain_selection()
    end, { desc = "Explain current code with OpenCode" })

    vim.api.nvim_create_user_command("OpenCodeRefactor", function(opts)
      opencode.refactor_selection()
    end, { desc = "Refactor current code with OpenCode" })

    local wk = require("which-key")
    wk.register({
      ["<leader>o"] = {
        name = "OpenCode",
        c = { "<cmd>OpenCode<cr>", "Toggle OpenCode" },
        a = { "<cmd>OpenCodeAsk ", "Ask OpenCode" },
        e = { "<cmd>OpenCodeExplain<cr>", "Explain Code" },
        r = { "<cmd>OpenCodeRefactor<cr>", "Refactor Code" },
      }
    })
  end
}
