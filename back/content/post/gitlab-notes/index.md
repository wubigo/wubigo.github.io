+++
title = "Gitlab Notes"
date = 2016-04-28T17:08:07+08:00
tags = ["SHELL", "GIT"]
draft = false

# Tags and categories
# For example, use `tags = []` for no tags, or the form `tags = ["A Tag", "Another Tag"]` for one or more tags.

categories = []

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder. 
[image]
  # Caption (optional)
  caption = ""

  # Focal point (optional)
  # Options: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight
  focal_point = ""
+++


# push  to a mirror repository

push to github at same time when a commit is pushed to gitlab

# Protected Branches

By default, protected branches are designed to:

- prevent their creation, if not already created, from everybody except Maintainers
- prevent pushes from everybody except Maintainers
- prevent anyone from force pushing to the branch
- prevent anyone from deleting the branch



# Project members permissions

NOTE:

**In GitLab 11.0, the Master role was renamed to Maintainer**
The following table depicts the various user permission levels in a project.



Action
Guest
Reporter
Developer
Maintainer
Owner




Create new issue
✓ 
✓
✓
✓
✓


Create confidential issue
✓ 
✓
✓
✓
✓


View confidential issues
(✓) 
✓
✓
✓
✓


Leave comments
✓ 
✓
✓
✓
✓


See related issues
✓
✓
✓
✓
✓


See a list of jobs
✓ 
✓
✓
✓
✓


See a job log
✓ 
✓
✓
✓
✓


Download and browse job artifacts
✓ 
✓
✓
✓
✓


View wiki pages
✓ 
✓
✓
✓
✓


Pull project code

✓
✓
✓
✓


Download project

✓
✓
✓
✓


Assign issues

✓
✓
✓
✓


Assign merge requests


✓
✓
✓


Label issues and merge requests

✓
✓
✓
✓


Create code snippets

✓
✓
✓
✓


Manage issue tracker

✓
✓
✓
✓


Manage labels

✓
✓
✓
✓


See a commit status

✓
✓
✓
✓


See a container registry

✓
✓
✓
✓


See environments

✓
✓
✓
✓


See a list of merge requests

✓
✓
✓
✓


Manage related issues [STARTER]


✓
✓
✓
✓


Lock issue discussions

✓
✓
✓
✓


Lock merge request discussions


✓
✓
✓


Create new environments


✓
✓
✓


Stop environments


✓
✓
✓


Manage/Accept merge requests


✓
✓
✓


Create new merge request


✓
✓
✓


Create new branches


✓
✓
✓


Push to non-protected branches


✓
✓
✓


Force push to non-protected branches


✓
✓
✓


Remove non-protected branches


✓
✓
✓


Add tags


✓
✓
✓


Write a wiki


✓
✓
✓


Cancel and retry jobs


✓
✓
✓


Create or update commit status


✓
✓
✓


Update a container registry


✓
✓
✓


Remove a container registry image


✓
✓
✓


Create/edit/delete project milestones


✓
✓
✓


Use environment terminals



✓
✓


Add new team members



✓
✓


Push to protected branches



✓
✓


Enable/disable branch protection



✓
✓


Turn on/off protected branch push for devs



✓
✓


Enable/disable tag protections



✓
✓


Rewrite/remove Git tags



✓
✓


Edit project



✓
✓


Add deploy keys to project



✓
✓


Configure project hooks



✓
✓


Manage Runners



✓
✓


Manage job triggers



✓
✓


Manage variables



✓
✓


Manage GitLab Pages



✓
✓


Manage GitLab Pages domains and certificates



✓
✓


Remove GitLab Pages




✓


Manage clusters



✓
✓


Edit comments (posted by any user)



✓
✓


Switch visibility level




✓


Transfer project to another namespace




✓


Remove project




✓


Delete issues




✓


Remove pages




✓


Force push to protected branches 







Remove protected branches 







View project Audit Events



✓
✓




Project features permissions