# Script and command aliases for bash

# Improve ls
#   F = append type indicator
#   h = human readable formatting
if [[ "$OSTYPE" == "darwin"* ]]; then # OSX
	alias ls="ls -Fh"
else
	alias ls="ls -Fh --color=auto"
fi

# List all
#   A = show all but . and ..
#   l = long list formatting
alias ll="ls -lA"

### SSH
# Attribution: http://rabexc.org/posts/pitfalls-of-ssh-agents

# Start or bind to existing SSH agent
function startagent() {
	# Default life of keys is 180 seconds
	local SSH_KEY_LIFE=180

	# Sets custom life if provided
	if [ -n "$1" ]; then
		SSH_KEY_LIFE=$1
	fi

	function try_bind_to_last_session() {
		# Bind the last ssh-agent to this session if it exists and is readable
		if [ -r ~/.ssh-agent ]; then
			eval "$(cat ~/.ssh-agent)" >/dev/null
		fi
	}

	# Create an agent if not started
	# Exit code is 1 if there are no keys to list, 2 if agent is not running
	ssh-add -l &>/dev/null

	# Agent not running
	if [ "$?" == "2" ]; then
		# Bind the last ssh-agent to this session if it exists and is readable
		try_bind_to_last_session

		# Create a new agent if last one is not alive
		ssh-add -l &>/dev/null

		# Agent not running
		if [ "$?" == "2" ]; then
			# Writes ssh-agent session set up commands to file
			(umask 066; ssh-agent -t $SSH_KEY_LIFE > ~/.ssh-agent)

			# Bind to that session
			try_bind_to_last_session

			# Error if that failed
			ssh-add -l &>/dev/null

			# Agent not running
			if [ "$?" == "2" ]; then
				echo "Failed to start new agent"
				return 1
			else
				echo "Started and bound to agent { pid: $SSH_AGENT_PID, life: $SSH_KEY_LIFE }"
			fi
		else
			echo "Bound to agent { pid: $SSH_AGENT_PID }"
		fi
	# Special OSX agent is running
	elif [ -z "$SSH_AGENT_PID" ]; then
		local OSX_AGENT=$(ps aux | grep "[/]usr/bin/ssh-agent -l" | awk '{print $2}')

		# Set the agent pid in this session
		SSH_AGENT_PID=$OSX_AGENT
		export SSH_AGENT_PID

		echo "Linking to OSX agent"
		echo "Agent { pid: $SSH_AGENT_PID } already exists"
	else
		echo "Agent { pid: $SSH_AGENT_PID } already exists"
	fi
}

# Kill bound SSH agent
function killagent() {
	# Kill agent if running
	ssh-add -l &>/dev/null

	# Agent running
	if [ "$?" != "2" ]; then
		PID=$SSH_AGENT_PID

		eval "$(ssh-agent -k)" >/dev/null

		echo "Killed agent { pid: $PID }"
	else
		echo "No agent to kill"
	fi
}

# Show all SSH agents
function listagents() {
	ps aux | grep [s]sh-agent
}

# Kill all SSH agents
function killallagents() {
	# Find pids of running agents
	local SSH_AGENTS=$(ps aux | grep [s]sh-agent | awk '{print $2}')

	for pid in $SSH_AGENTS; do
		kill -9 $pid

		echo "Killed agent { pid: $pid }"
	done
}

# Start an agent if not started and load every key in the ~/.keys directory
function addkeys() {
	# Default life of keys is 180 seconds
	local SSH_KEY_LIFE=180

	# Sets custom life if provided
	if [ -n "$1" ]; then
		SSH_KEY_LIFE=$1
	fi

	startagent

	if [ "$?" != "0" ]; then
		echo "Failed to start or bind to agent"
		return 1
	fi

	# Check if keys directory exists
	if [ ! -d ~/.keys ]; then
		echo "Keys directory (~/.keys) does not exist"
		return 1
	fi

	local KEYS=$(find ~/.keys -type f)

	for key in $KEYS; do
		# Check if key is loaded in agent
		ssh-add -l | grep $key >/dev/null

		# Add if not loaded
		if [ "$?" != "0" ]; then
			ssh-add -t $SSH_KEY_LIFE $key
		fi
	done

	ssh-add -l
}
