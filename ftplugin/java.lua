pcall(function()
  local jdtls_path = vim.fn.expand("~/.local/share/jdtls")
  local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
  local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name
  local user_config_dir = jdtls_path .. "/config_linux"
  local config = {
    cmd = {
      "java",
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.level=ALL",
      "-Xmx1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens",
      "java.base/java.util=ALL-UNNAMED",
      "--add-opens",
      "java.base/java.lang=ALL-UNNAMED",
      "-jar",
      launcher_jar,
      "-configuration",
      user_config_dir,
      "-data",
      workspace_dir,
    },
    root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
    settings = {
      java = {
        inlayHints = {
          parameterNames = { enabled = "all" },
        },
      },
    },
  }
  require("jdtls").start_or_attach(config)
end)
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("JavaIndent", { clear = true }),
  pattern = { "java" },
  command = "setlocal shiftwidth=4 tabstop=4",
})
