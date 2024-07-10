return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"rust_analyzer",
					"jdtls",
					"pyright",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Setup all LSPs in "ensure_installed"
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
			})
			lspconfig.pyright.setup({
				capabilities = capabilities,
			})

			vim.keymap.set("n", "<leader>i", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.cmd("command AddLsp vsplit | edit ~/.config/nvim/lua/plugins/lsp-config.lua")
		end,
	},
	--[[
  {
    "mfussenegger/nvim-jdtls",
    config = function()
      local HOME = os.getenv("HOME")

      local jdtls = require("jdtls")
      -- local lsp = require("plug.lsp.handlers")
      -- local global = require("config.globals").jdtls

      -- jar patterns to search for
      local jar_patterns = {
        "/dev/microsoft/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
        "/dev/dgileadi/vscode-java-decompiler/server/*.jar",
        "/dev/microsoft/vscode-java-test/java-extension/com.microsoft.java.test.plugin/target/*.jar",
        "/dev/microsoft/vscode-java-test/java-extension/com.microsoft.java.test.runner/target/*.jar",
        "/dev/microsoft/vscode-java-test/java-extension/com.microsoft.java.test.runner/lib/*.jar",
      }

      -- Find root of project
      local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", "src" }
      local root_dir = require("jdtls.setup").find_root(root_markers)
      if root_dir == "" or root_dir == nil then
        return
      end

      -- local capabilities = lsp.capabilities
      local extendedClientCapabilities = jdtls.extendedClientCapabilities
      extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
      -- capabilities = vim.tbl_deep_extend("force", extendedClientCapabilities, capabilities)

      local function get_bundles(jar_patternos)
        -- npm install broke: https://github.com/npm/cli/issues/2508
        -- So gather the required jars manually; this is based on the gulpfile.js in the vscode-java-test repo
        -- stolen from mfussnegger
        local plugin_path =
        "/dev/microsoft/vscode-java-test/java-extension/com.microsoft.java.test.plugin.site/target/repository/plugins/"
        local bundle_list = vim.tbl_map(function(x)
          return require("jdtls.path").join(plugin_path, x)
        end, {
          "junit-jupiter-*.jar",
          "junit-platform-*.jar",
          "junit-vintage-engine_*.jar",
          "org.opentest4j*.jar",
          "org.apiguardian.api_*.jar",
          "org.eclipse.jdt.junit4.runtime_*.jar",
          "org.eclipse.jdt.junit5.runtime_*.jar",
          "org.opentest4j_*.jar",
        })

        vim.list_extend(jar_patternos, bundle_list)
        local bundles = {}
        for _, jar_pattern in ipairs(jar_patternos) do
          for _, bundle in ipairs(vim.split(vim.fn.glob(HOME .. jar_pattern), "\n")) do
            if
                not vim.endswith(bundle, "com.microsoft.java.test.runner-jar-with-dependencies.jar")
                and not vim.endswith(bundle, "com.microsoft.java.test.runner.jar")
            then
              table.insert(bundles, bundle)
            end
          end
        end

        return bundles
      end

      local function get_libs(project_root)
        local find_jar_libs_cmd = "find " .. project_root .. "/libs -type f | grep jar"
        local extract_classpathentries_cmd = "grep 'classpathentry kind=\"lib\"' "
            .. project_root
            .. "/.classpath | sed 's/.*classpathentry kind=\"lib\" path=\"//' | sed 's/\".*//'"

        if vim.fn.filereadable(project_root .. "/.classpath") == 1 then
          local libs = require("config.helper").cmd_to_table(extract_classpathentries_cmd)

          local new_table = {}
          for _, lib in ipairs(libs) do
            table.insert(new_table, project_root .. "/" .. lib)
          end
          return new_table
        end

        return require("config.helper").cmd_to_table(find_jar_libs_cmd)
      end

      jdtls.start_or_attach({
        cmd = {'/path/to/jdt-language-server/bin/jdtls'},
        -- capabilities = capabilities,
        --[[
        on_attach = function(client, bufnr)
          lsp.on_attach(client, bufnr)

          jdtls.setup_dap({
            hotcodereplace = "auto",
            config_overrides = {
              vmArgs = global.vmArgs,
              args = global.args,
            },
          })

          -- local opts = { noremap = true, silent = true, buffer = bufnr }
          -- local map = vim.keymap.set
          -- map("n", "<A-o>", "<Cmd>lua require('jdtls').organize_imports()<CR>", opts)
          -- map("n", "crv", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
          -- map("v", "crv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
          -- map("n", "crc", "<Cmd>lua require('jdtls').extract_constant()<CR>", opts)
          -- map("v", "crc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", opts)
          -- map("n", "crm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)

          require("jdtls.dap").setup_dap_main_class_configs() -- needs to be called to activate the dap function
        end,
        ] ] - -  // Need to close up properly next time I keep working on this
        root_dir = root_dir,
        -- NOTE: look here for a list of options:
        -- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        settings = {
          java = {
            signatureHelp = { enabled = true },
            configuration = {
              -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
              -- And search for `interface RuntimeOption`
              -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
              runtimes = {
                {
                  name = "JavaSE-1.8",
                  path = HOME .. "/.local/jdks/jdk8u332-b09/",
                  default = true,
                },
                {
                  name = "JavaSE-11",
                  path = HOME .. "/.local/jdks/jdk-11.0.9.1+1/",
                },
                {
                  name = "JavaSE-15",
                  path = HOME .. "/.local/jdks/jdk-15.0.2+7/",
                },
                {
                  name = "JavaSE-16",
                  path = HOME .. "/.local/jdks/jdk-16.0.1+9/",
                },
                {
                  name = "JavaSE-17",
                  path = HOME .. "/.local/jdks/jdk-17.0.2+8/",
                },
                {
                  name = "JavaSE-18",
                  path = HOME .. "/.local/jdks/jdk-18+36/",
                },
              },
            },
            project = {
              -- import all jar files under the libs directory
              referencedLibraries = get_libs(root_dir),
            },
            referenceCodeLens = {
              enabled = true,
            },
            format = {
              enabled = true,
              insertSpaces = true,
            },
            codeGeneration = {
              tostring = {
                listArrayContents = true,
                skipNullValues = true,
              },
              useBlocks = true,
              hashCodeEquals = {
                useInstanceof = true,
                useJava7Objects = true,
              },
              generateComments = false,
              insertLocation = true,
            },
            maven = {
              downloadSources = true,
              updateSnapshots = true,
            },
          },
        },
        init_options = {
          bundles = get_bundles(jar_patterns),
        },
      })
    end,
  },
  ]]
	--
}
