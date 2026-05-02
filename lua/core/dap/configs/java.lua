local ok, jdtls = pcall(require, "jdtls")
if not ok then
  return
end

jdtls.setup_dap({
  hotcodereplace = "auto",
})

require("jdtls.dap").setup_dap_main_class_configs()
