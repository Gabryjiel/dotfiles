return {
  {
    -- LINTING
    "mfussenegger/nvim-lint",
    keys = {
      { "<leader>cn", "<cmd>NvimLint<cr>", desc = "[N]vim lint" },
    },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        -- https://github.com/codespell-project/codespell
        -- https://golangci-lint.run/
        go = { "codespell", "golangcilint" },
        -- https://htmlhint.com/
        -- https://www.html-tidy.org/
        html = { "htmlhint", "tidy" },
        -- https://github.com/mantoni/eslint_d.js
        -- https://github.com/zaach/jsonlint
        json = { "jsonlint" },
        -- https://github.com/mrtazz/checkmake
        make = { "checkmake" },
        -- https://alexjs.com/
        -- https://github.com/DavidAnson/markdownlint
        -- https://docs.getwoke.tech/
        markdown = { "alex", "markdownlint", "woke" },
        -- https://github.com/rust-lang/rust-clippy
        rust = { "clippy" },
        -- https://www.shellcheck.net/
        sh = { "shellcheck" },
      }

      -- WARNING: Removed luacheck linter due to problem with folke/neodev
      -- https://github.com/mpeterv/luacheck
      -- lua = { "luacheck" },

      -- Checkmake requires a ini file in the current directory
      -- Otherwise you have to specify a global one
      lint.linters.checkmake.args = {
        "--format='{{.LineNumber}}:{{.Rule}}:{{.Violation}}\n'",
        "--config",
        os.getenv("HOME") .. "/.config/checkmake.ini",
      }

      -- NOTE: We need custom logic for handling YAML linting.
      --
      -- https://github.com/rhysd/actionlint
      -- https://github.com/adrienverge/yamllint (https://yamllint.readthedocs.io/en/stable/rules.html)
      -- https://github.com/stoplightio/spectral (`npm install -g @stoplight/spectral-cli`)
      vim.api.nvim_create_autocmd({
        "BufWritePost",
      }, {
        group = vim.api.nvim_create_augroup("Linting", { clear = true }),
        callback = function(ev)
          -- print(string.format('event fired: %s', vim.inspect(ev)))
          -- print(vim.bo.filetype)
          if
            (string.find(ev.file, ".github/workflows/") or string.find(ev.file, ".github/actions/"))
            and vim.bo.filetype == "yaml"
          then
            lint.try_lint("actionlint")
          elseif vim.bo.filetype == "yaml" then
            lint.try_lint("yamllint")
          else
            lint.try_lint()
          end
        end,
      })

      vim.api.nvim_create_user_command("NvimLint", function() require("lint").try_lint("") end, {
        desc = "Lint file with nvim-lint",
      })
    end,
  },
}
