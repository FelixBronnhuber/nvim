-- overseer.lua
return {
  'stevearc/overseer.nvim',
  opts = {},
  config = function()
    -- Load the plugin
    require('overseer').setup()

    -- Your custom code to find and run shell scripts
    local files = require 'overseer.files'

    local generator = function(opts, cb)
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
    end

    -- Register the generator function with overseer
    require('overseer').register_template {
      name = 'Run Shell Scripts',
      generator = generator,
    }
  end,
}
