# Contributing
##### Full credit given to the https://github.com/mezzio/.github/blob/master/CONTRIBUTING.md as the original source of this page

## Resources

If you wish to contribute to this project, please be sure to read the following resources:

- [Code of Conduct](CODE_OF_CONDUCT.md)

## Recommended Workflow for Contributions

Your first step is to establish a public repository from which we can pull your work into the canonical repository.
I recommend using [GitHub](https://github.com), as that is where the component is already hosted.

1. Setup a [GitHub account](https://github.com/join), if you haven't yet
1. Fork the repository using the "_Fork_" button at the top right of the repository landing page.
1. Clone the canonical repository locally.
   Use the "_Clone or download_" button above the code listing on the repository landing pages to obtain the URL and instructions.
1. Navigate to the directory where you have cloned the repository.
1. Add a remote to your fork; substitute your GitHub username and the repository name in the commands below.

   ```console
   $ git remote add fork git@github.com:{username}/{repository}.git
   $ git fetch fork
   ```

Alternately, you can use the [GitHub CLI tool](https://cli.github.com) to accomplish these steps:

```console
$ gh repo clone {org}/{repo}
$ cd {repo}
$ gh repo fork
```

### Keeping Up-to-Date

Periodically, you should update your fork or personal repository to match the canonical repository.
Assuming you have setup your local repository per the instructions above, you can do the following:

```console
$ git fetch origin
$ git switch {branch to update}
$ git pull --rebase --autostash
# OPTIONALLY, to keep your remote up-to-date -
$ git push fork {branch}:{branch}
```

If you're tracking other release branches, you'll want to do the same operations for each branch.

### Working on a Patch

I recommend you do each new feature or bug fix in a new branch.
This simplifies the task of code review as well as the task of merging your changes into the canonical repository.

A typical workflow will then consist of the following:

1. Create a new local branch based off the appropriate release branch.
2. Switch to your new local branch.
   (This step can be combined with the previous step with the use of `git switch -c {new branch} {original branch}`, or, if the original branch is the current one, `git switch -c {new branch}`.)
3. Do some work, commit, repeat as necessary.
4. Push the local branch to your remote repository.
5. Send a pull request.

The mechanics of this process are actually quite trivial.
Below, we will create a branch for fixing an issue in the tracker.

```console
$ git switch -c hotfix/9295
Switched to a new branch 'hotfix/9295'
```

... do some work ...

```console
$ git commit
```

... write your log message ...

```console
$ git push fork hotfix/9295:hotfix/9295
Counting objects: 38, done.
Delta compression using up to 2 threads.
Compression objects: 100% (18/18), done.
Writing objects: 100% (20/20), 8.19KiB, done.
Total 20 (delta 12), reused 0 (delta 0)
To ssh://git@github.com/{username}/short-docker-guide-for-php-developers.git
   b5583aa..4f51698  HEAD -> hotfix/9295
```

To send a pull request, you have several options.

If using GitHub, you can do the pull request from there.
Navigate to your repository, select the branch you just created, and then select the "_Pull Request_" button in the upper right.
Select the user/organization "settermjd" as the recipient.

You can also perform the same steps via the [GitHub CLI tool](https://cli.github.com).
Execute `gh pr create`, and step through the dialog to create the pull request.
If the branch you will submit against is not the default branch, use the `-B {branch}` option to specify the branch to create the patch against.

#### What Branch Should I Issue the Pull Request Against?

- For fixes against the stable release, issue the pull request against the release branch matching the minor release you want to fix.
- For new features, or fixes that introduce new elements to the public API (such as new public methods or properties), issue the pull request against the default branch.

### Branch Cleanup

- Local branch cleanup

  ```console
  $ git branch -d <branchname>
  ```

- Remote branch removal

  ```console
  $ git push fork :<branchname>
  ```
