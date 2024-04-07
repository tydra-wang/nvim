-- kubeconfig is a yaml file
vim.filetype.add {
    pattern = {
        -- default kube config file
        [".*/%.kube/config"] = "yaml",
        -- kubeconf is my script to manage multiple kubeconfigs with alias
        -- and they are stored under directory ~/.kube/kubeconfigs
        [".*/%.kube/kubeconfigs/.*"] = "yaml",
    },
}

return {}
