# github-next-semantic-version-action

## What is it?

This is a GitHub Action that provides the [github-next-semantic-version](https://github.com/fabien-marty/github-next-semantic-version) tool/feature inside a GHA Workflow. This tool guesses **the next [semantic version](https://semver.org/)** from:

- existing **git tags** *(read from a locally cloned git repository)*
- and recently merged **pull-requests labels** *(read from the GitHub API)*

Unlinke plenty of "similar" tools, we don't use any "commit message parsing" here but only 
**configurable PR labels**.

## Usage

```yaml
- uses: actions/checkout@v4
  with:
    fetch-tags: true # we need to fetch tags to determine the latest version
    fetch-depth: 0 # fetch-tags is not enough because of a GHA bug: https://github.com/actions/checkout/issues/1471

- id: version
  uses: fabien-marty/github-next-semantic-version-action@v1
  with:
    github-token: ${{ github.token }} # Let's use the default value of the current workflow
    repository: ${{ github.repository }} # Let's use the default value of the current workflow
    repository-owner: ${{ github.repository_owner }} # Let's use the default value of the current workflow

- name: Use results
  run: |
    echo "Latest version is ${{ steps.version.outputs.latest-version }}"
    echo "Next version is ${{ steps.version.outputs.next-version }}"
```

### Outputs

- `latest-version`: the latest version/tag
- `next-version`: the (computed) next version (thanks to [github-next-semantic-version](https://github.com/fabien-marty/github-next-semantic-version) tool)

### Inputs

- `log-level`: Log Level (`DEBUG`, `INFO` or `WARNING`), default to `INFO`
- `github-token`: GitHub Token (in most cases, you can use `${{ github.token }}` as value)
- `repository`: Full repository name (example: `octocat/Hello-World`, in most cases, you want to use `${{ github.repository }}` as value)
- `repository-owner`: repository owner (example: `octocat`), in most cases, you want to use `${{ github.repository-owner }}` as value)
- `major-labels`: coma separated list of PR labels to search for determining a major release (default to: `major,breaking,Type: Major`)
- `minor-labels`: coma separated list of PR labels to search for determining a minor release (default to: `minor,Type: Minor, Type: Feature`)
- `ignore-labels`: coma separated list of PR labels to search for ignoring a PR (default to: `Type: Hidden`), can be useful with `dont-increment-if-no-pr` option
- `dont-increment-if-no-pr`: Do not increment if no PR found (or only ignored PRs), default to `false`, can be useful to determine automatically if a release is needed
- `consider-also-non-merged-prs`: If set to `true` (default to `false`), consider also "non merged" PRs to compute the next version
- `tag-regex`: If set, filter tags with the given regex
