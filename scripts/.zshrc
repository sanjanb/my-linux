# Sourced in your shell config
function j() {
    z "$@" || return
    if [ -d ".venv" ]; then
        echo "Activating UV Virtual Environment..."
        source .venv/bin/activate
    elif [ -f "pyproject.toml" ]; then
        echo "Project detected. Run 'uv venv' to initialize."
    fi
}
