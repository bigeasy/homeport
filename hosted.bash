function homeport_emit_evaluated_variable() {
    local name=$1
    eval 'local value=$(echo $'$name')'
    echo "$name=$(printf %q $value)"
}

function homeport_emit_evaluated() {
    if [ "$homeport_evaluated" -eq 1 ]; then
        homeport_emit_evaluated_variable homeport_unix_user
        homeport_emit_evaluated_variable homeport_namespace
        homeport_emit_evaluated_variable homeport_tag
        homeport_emit_evaluated_variable homeport_image_name
        homeport_emit_evaluated_variable hoemport_home_container
        printf -v vargs '%q ' "$@"
        echo ''
        echo 'eval set -- '$vargs
        echo ''
        cat "$homeport_path/functions.bash"
        echo ''
        cat "$homeport_path/containerized.bash"
        echo ''
        cat "$homeport_path/getopt.bash"
        echo ''
        cat "$homeport_command_path"
    else
        return 1
    fi
}

function homeport_source_tarball() {
    cd "$homeport_path" && tar cf - .
}
