docker run --rm -it \
  -v ~/.gitconfig:/etc/gitconfig \
  -v ~/development/:/root/development/ \
  mocaffy/dotfiles:base
