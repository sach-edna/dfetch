Feature: Patch after fetching from git repo

    Sometimes a patch needs to be applied after fetching. *DFetch* makes it
    possible to specify a patch file.

    @wip
    Scenario: A patch file is applied after fetching
        Given the manifest 'dfetch.yaml'
            """
            manifest:
                version: '0.0'

                remotes:
                - name: github-com-dfetch-org
                  url-base: https://github.com/dfetch-org/test-repo

                projects:
                - name: ext/test-repo-tag
                  tag: v2.0
                  dst: ext/test-repo-tag
                  patch: diff.patch
            """
        And the patch file 'diff.patch'
            """
            diff --git a/README.md b/README.md
            index 32d9fad..62248b7 100644
            --- a/README.md
            +++ b/README.md
            @@ -1,2 +1,2 @@
             # Test-repo
            -A test repo for testing dfetch.
            +A test repo for testing patch.
            """
        When I run "dfetch update"
        Then the resulting file after patching should be 'ext/test-repo-tag/README.md'
            """
            # Test-repo
            A test repo for testing patch.
            """