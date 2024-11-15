# ls
#   -A = show all but . and ..
#   -F = append type indicator
#   -h = human readable formatting
#   -l = long list formatting
if command -v dircolors >/dev/null 2>&1; then
  alias ll="ls -AFhl --color=auto";
else
  alias ll="ls -AFhl"
fi

# SSH with agent forwarding
#   -A = connect with agent forwarding
alias ssf="ssh -A"
