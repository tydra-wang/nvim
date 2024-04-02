# syntax=docker/dockerfile:1
FROM alpine
WORKDIR /root
RUN apk add git ripgrep make neovim gcc musl-dev
ADD --keep-git-dir=true https://github.com/tydra-wang/nvim.git#main .config/nvim
RUN nvim --headless +"lua require('lazy').restore({wait=true})" +qa
