# Token lives in the login keychain, not on disk:
#   security add-generic-password -a "$USER" -s jira-api-token -U -w '<token>'
jira() {
  if [[ -z $JIRA_API_TOKEN ]]; then
    export JIRA_API_TOKEN="$(security find-generic-password -s jira-api-token -w 2>/dev/null)"
    [[ -n $JIRA_API_TOKEN ]] || {
      print -u2 "jira: no 'jira-api-token' in the keychain"
      return 1
    }
  fi
  command jira "$@"
}
