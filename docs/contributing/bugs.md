---
title: "🐞 Report Issues"
id: "bugs"
---

Team SIGHUP makes it a priority to respond and solve the bugs that are reported
about our tools and products.

Here at SIGHUP, we use GitHub issues to keep track of issues and requests that
can be picked up by the developers in a priority basis.

If you found an issue with any of our products, we recommend first to go through
the existing issues and pull requests in the repo itself to see if it has already
been reported or there is currently a work in progress regarding it.

In case there the issue has not been reported and there are no Pull Requests open,
we invite you to continue to the following sections to open a GitHub Issue Report.

## Bugs and Enhancements

Much like every community product, we thrive under constant feedback and error
reports. We apologise for the issue that you have faced in your Fury journey,
but we promise to get it fixed as soon as possible.

We provide some Issue templates in GitHub to ease the process of reporting and
resolving issues. Once you have a clear idea of the nature of the issue, you can
head over to the component's repository, for example, if you found an issue in
the [logging module](../../modules/logging), you can open an issue in its
[GitHub repository](https://github.com/sighupio/fury-kubernetes-logging/issues)
and in this way we will be notified and get back to you.

You can click on `New Issue` option in the issues section of the repo, and you
will be offered with a couple of templates for the issue in hand. You can chose
either a `Bug Report` or a `Enhancement Request` based on your issue. You can
follow the guidelines that will be offered to you and complete the filing process.

If you lack a GitHub account or prefer to not use it, you can write to our
engineering team an e-mail at `engineering@sighup.io`. We recommend you follow
the following structure to help us investingate the issue:

```text
Subject: [BUG] Fury Kubernetes {logging,networking,monitoring,disaster-recovery...}
To: engineering@sighup.io
Content:
  - Describe the issue in a couple of lines
  - Give us a quick description about the environment
  - Describe here how to reproduce the issue
    - Would be awesome if is reproducible also locally
  - How is the impact in you cluster
```

### Security

If you found a security problem, please notify SIGHUP's Security team as soon as possible.

Security-related issues get more priority than other kinds of bugs. We run a lot of tests to ensure every component
runs as expected (as our third parties do) but sometimes it is impossible to cover all scenarios.

You can create an issue exactly like before but choosing the option `Security
Reports` among the issue creation templates. To escalate the issue you can
always send us an e-mail, with the following format:

```text
Subject: [Security Risk] Fury Kubernetes {logging,networking,monitoring,disaster-recovery...}
To: security+engineering@sighup.io
Content:
  - Describe the issue in a couple of lines
  - Give us a quick description about the environment
  - Describe here how to reproduce the issue
    - Would be awesome if is reproducible also locally
  - How is the impact in you cluster
```

Even if you are not sure about the possible security risk, don't hesitate to get in touch with us [via e-mail or via Slack](index.md#get-in-touch-with-us).

## Questions or queries

If you are having trouble with the setup, we recommend you to join our [Slack
channel](index.md#get-in-touch-with-us), and ask our engineers directly there.

If your question is not time intensive, you can open a `Question` issue over at
GitHub. Follow the same procedure as above, but choose `Question` template
from the list that follows. Give as much information as possible to make the
process a bit easier for us to understand.
