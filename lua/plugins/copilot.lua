-- lua/plugins/copilot.lua
return {
  -- GitHub Copilot (core completions)
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
      vim.g.copilot_filetypes = { ["*"] = true }
    end,
  },

  -- Copilot Chat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" },
    },
    event = "VeryLazy",
    config = function()
      local ok_core, _ = pcall(require, "copilot")
      if not ok_core then
        vim.notify("Copilot (github/copilot.vim) not found/loaded", vim.log.levels.WARN)
      end

      local ok, chat = pcall(require, "CopilotChat")
      if not ok then
        vim.notify("CopilotChat.nvim not found", vim.log.levels.ERROR)
        return
      end

      -- Preferred model order (strongest first). Adjust if your account exposes different names.
      local preferred_models = {
        "OpenAI GPT-5.1-Codex-Max",
        "OpenAI GPT-5.1-Codex",
        "OpenAI GPT-5-Codex",
        "OpenAI GPT-4o",
        "gpt-4o",
        "Claude Opus 4.5",
        "Claude Opus 4.1",
      }

      local function choose_default_model()
        if vim.g.copilotchat_model and vim.g.copilotchat_model ~= "" then
          return vim.g.copilotchat_model
        end
        return preferred_models[1] or "gpt-4o"
      end

      vim.g.copilotchat_model = choose_default_model()

      vim.api.nvim_create_user_command("CopilotChatModel", function(opts)
        local model = opts.args
        if model == nil or model == "" then
          vim.notify("Usage: :CopilotChatModel <model> (see :CopilotChatModels)", vim.log.levels.WARN)
          return
        end
        vim.g.copilotchat_model = model
        vim.notify("CopilotChat model set to: " .. model .. " (verify with :CopilotChatModels)", vim.log.levels.INFO)
      end, {
        nargs = 1,
        complete = function(_, _, _)
          return {}
        end,
      })

      chat.setup({
        debug = false,
        show_help = "yes",
        model = function()
          return vim.g.copilotchat_model
        end,
        prompts = {
          Explain = "Explain how this code works.",
          Review = "Review this code and provide suggestions.",
          FixCode = "Fix the bugs in this code.",
          Optimize = "Optimize this code for performance.",
          ExplainRust = "Explain this Rust code with focus on ownership.",
          ExplainAssembly = "Explain this assembly code in detail.",
        },
        auto_follow_cursor = true,
        window = {
          layout = "float",
          relative = "editor",
          width = 0.8,
          height = 0.8,
          row = 2,
        },
        mappings = {
          complete = { detail = "Use @<Tab> or /<Tab> for options.", insert = "<Tab>" },
          close = { normal = "q", insert = "<C-c>" },
          submit_prompt = { normal = "<CR>", insert = "<C-s>" },
          show_info = { normal = "gp" },
          show_context = { normal = "gs" },
        },
      })
    end,
  },
}
