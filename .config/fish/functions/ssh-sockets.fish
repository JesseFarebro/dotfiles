function ssh-sockets --description "Manage SSH ControlMaster sockets"
    # Parse arguments
    argparse l/list -- $argv

    # Config: Must match your ~/.ssh/config ControlPath
    set -q SSH_SOCKET_DIR; or set SSH_SOCKET_DIR ~/.cache/ssh/sockets

    # --- LIST MODE (Internal) ---
    if set -q _flag_list
        if not test -d $SSH_SOCKET_DIR
            return 0
        end

        for socket in (find $SSH_SOCKET_DIR -type s -maxdepth 1 2>/dev/null)
            set -l filename (basename $socket)

            # PARSING: Expects format "user@host:port"
            # We explicitly capture user, host, and port variables
            if string match -r '^(?<user>[^@]+)@(?<host>[^:]+):(?<port>\d+)$' -- $filename >/dev/null

                # Check if socket is alive (0=Active, 255=Stale)
                if ssh -O check -S "$socket" localhost >/dev/null 2>&1
                    set status_label Active
                else
                    set status_label Stale
                end

                # Output Columns:
                # 1:Path 2:User 3:Host 4:Port 5:Status
                echo -e "$socket\t$user\t$host\t$port\t$status_label"
            end
        end
        return 0
    end

    # --- INTERACTIVE MODE ---

    set -l list_cmd "fish -c 'ssh-sockets --list'"

    if not test -d $SSH_SOCKET_DIR
        echo "Error: Socket directory '$SSH_SOCKET_DIR' does not exist."
        return 1
    end

    # FZF COMMAND EXPLANATION:
    # We use {2} (User), {3} (Host), and {4} (Port) to reconstruct the original SSH command.
    # The command becomes: ssh -S {1} -p {4} {2}@{3}
    # This matches the socket expectations perfectly, bypassing auth.

    eval $list_cmd | fzf --header "Enter: Attach | Ctrl-X: Kill | Ctrl-D: Cleanup Stale | Ctrl-R: Reload" \
        --delimiter "\t" \
        --with-nth "2,3,4,5" \
        --preview-window=down:30% \
        --preview "echo '--- Socket Info ---'; 
                   echo 'User:   {2}'; 
                   echo 'Host:   {3}'; 
                   echo 'Port:   {4}'; 
                   echo 'Status: {5}';
                   echo;
                   if test '{5}' = 'Active';
                       echo '--- Connection Check ---';
                       ssh -O check -S {1} localhost 2>&1;
                   else;
                       echo '!!! Socket is STALE !!!';
                       echo 'The process is dead but the file remains.';
                       echo 'Press Ctrl-D to delete.';
                   end" \
        --bind "ctrl-x:execute-silent(ssh -O exit -S {1} localhost 2>/dev/null)+reload($list_cmd)" \
        --bind "ctrl-d:execute-silent(rm {1})+reload($list_cmd)" \
        --bind "ctrl-r:reload($list_cmd)" \
        --bind "enter:execute(if test '{5}' = 'Active'; ssh -S {1} -p {4} {2}@{3}; else; echo 'Cannot attach to stale socket'; sleep 1; end)"
end
