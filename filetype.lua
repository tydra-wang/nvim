-- kubeconfig is a yaml file
vim.filetype.add {
    pattern = {
        -- default kube config file
        [".*/%.kube/config"] = "yaml",
        -- kubeconf script managed configs
        [".*/%.kube/kubeconfigs/[^.]*"] = "yaml",
    },
}
