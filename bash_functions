### Development

# Checks for unsynced work in all git repositories in the current directory
# - Branches without upstreams
# - Branches ahead of their upstreams
# - Working directory changes
function devstatus() {
  # Default path
  local DEV_STATUS_PATH="."

  # Sets path if provided
  if [ -n "$1" ]; then
    DEV_STATUS_PATH=$1
  fi

  # Path to every .git directory with .git part removed
  local REPO_PATHS=$(find $DEV_STATUS_PATH -type d -name ".git" | rev | cut -c6- | rev)

  for repo_path in $REPO_PATHS; do
    local BRANCH_REFS=$(git -C $repo_path for-each-ref refs/heads --format='%(refname)')

    local NO_UPSTREAM_SET_BRANCHES=()
    local AHEAD_OF_UPSTREAM_BRANCHES=()
    local WORKING_DIRECTORY_CHANGES=false

    for branch_ref in $BRANCH_REFS; do
      local BRANCH=$(git -C $repo_path rev-parse --abbrev-ref $branch_ref)

      # Define local variable separately to preserve return code
      local UPSTREAM_REF
      UPSTREAM_REF=$(git -C $repo_path rev-parse $BRANCH@{upstream} 2>/dev/null)

      # Branch has no upstream
      if [ "$?" != "0" ]; then
        NO_UPSTREAM_SET_BRANCHES+=("$BRANCH")
      else
        local AHEAD_COUNT=$(git -C $repo_path rev-list --count $UPSTREAM_REF..$branch_ref)

        # Branch is ahead of upstream
        if [ "$AHEAD_COUNT" != "0" ]; then
          AHEAD_OF_UPSTREAM_BRANCHES+=("$BRANCH")
        fi
      fi
    done

    local WORKING_DIRECTORY_STATUS=$(git -C $repo_path status --porcelain)

    # Working directory has changes
    if [ -n "$WORKING_DIRECTORY_STATUS" ]; then
      WORKING_DIRECTORY_CHANGES=true
    fi

    # Output
    echo "$repo_path"

    if [ ! ${#NO_UPSTREAM_SET_BRANCHES[@]} -eq 0 ]; then
      for unsynced_branch in "${NO_UPSTREAM_SET_BRANCHES[@]}"; do
        echo "  - No upstream set: $unsynced_branch"
      done
    fi

    if [ ! ${#AHEAD_OF_UPSTREAM_BRANCHES[@]} -eq 0 ]; then
      for unsynced_branch in "${AHEAD_OF_UPSTREAM_BRANCHES[@]}"; do
        echo "  - Ahead of upstream: $unsynced_branch"
      done
    fi

    if [ "$WORKING_DIRECTORY_CHANGES" = true ]; then
      echo "  - Uncommitted working directory changes"
    fi
  done
}
