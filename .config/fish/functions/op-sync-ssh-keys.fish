function op-sync-ssh-keys
  # Iterate over the array of JSON entries and write the public keys
  for entry in (
    op item list --categories sshkey --format=json \
    | op item get - --format=json \
    | jq -c '{title,public_key: .fields[] | select(.id == "public_key").value}'
  )
    set --local title (echo $entry | jq -r '.title')
    set --local public_key (echo $entry | jq -r '.public_key')

    set --local filename (string replace -r ' ' '-' (string lower $title))
    if test -n "$public_key"
      echo $public_key > ~/.ssh/op-$filename.pub
      echo "Public key for $title has been written to ~/.ssh/op-$filename.pub"
    else
      echo "Error: No public key found for $title"
    end
  end

  echo "SSH key sync complete."
end
