-- overseer.lua
return {
  'stevearc/overseer.nvim',
  opts = {},
  config = function()
    local overseer = require 'overseer'

    -- Load the plugin
    overseer.setup {
      strategy = 'toggleterm',
    }

    -- Your custom code to find and run shell scripts
    local files = require 'overseer.files'

    local generator = function(opts, cb)
      -- Set opts.dir to the current working directory if it's not already set
      opts.dir = opts.dir or vim.fn.getcwd()

      local scripts = vim.tbl_filter(function(filename)
        return filename:match '%.sh$'
      end, files.list_files(opts.dir))

      local ret = {}
      for _, filename in ipairs(scripts) do
        table.insert(ret, {
          name = filename,
          params = {
            args = { optional = true, type = 'list', delimiter = ' ' },
          },
          builder = function(params)
            return {
              cmd = { files.join(opts.dir, filename) },
              args = params.args,
            }
          end,
        })
      end

      cb(ret)
      return scripts -- Return the list of scripts
    end

    -- Register the generator function with overseer
    overseer.register_template {
      name = 'Run Shell Scripts',
      generator = generator,
    }
    -- Check if `map` is already defined
    local map = vim.api.nvim_set_keymap

    -- Function to find shell scripts
    local function find_shell_scripts()
      local overseer = require 'overseer'
      local files = require 'overseer.files'
      local opts = { dir = vim.fn.getcwd() }

      local scripts = vim.tbl_filter(function(filename)
        return filename:match '%.sh$'
      end, files.list_files(opts.dir))

      return scripts
    end

    -- Function to run the overseer template
    local function run_overseer_template()
      local scripts = find_shell_scripts()
      if #scripts > 0 then
        overseer.run_template()
      else
        vim.notify('No shell scripts found in the current directory', vim.log.levels.WARN)
      end
    end

    -- Updated key mapping
    map('n', '<leader>os', [[:lua run_overseer_template()<CR>]], { noremap = true, silent = true, desc = 'overseer toggle' })

    -- Make the function globally accessible
    _G.run_overseer_template = run_overseer_template
  end,
}
