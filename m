Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E2BC43215
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 21:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 537452080D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 21:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfKXVOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 16:14:11 -0500
Received: from mga05.intel.com ([192.55.52.43]:6212 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbfKXVOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 16:14:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Nov 2019 13:14:09 -0800
X-IronPort-AV: E=Sophos;i="5.69,239,1571727600"; 
   d="scan'208";a="382612493"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Nov 2019 13:14:08 -0800
Subject: [PATCH v3 2/3] Maintainer Handbook: Maintainer Entry Profile
From:   Dan Williams <dan.j.williams@intel.com>
To:     corbet@lwn.net
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C. Harding" <me@tobin.cc>, Olof Johansson <olof@lixom.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Joe Perches <joe@perches.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        vishal.l.verma@intel.com, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-doc@vger.kernel.org
Date:   Sun, 24 Nov 2019 12:59:53 -0800
Message-ID: <157462919309.1729495.10585699280061787229.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157462918268.1729495.10257190766638995699.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157462918268.1729495.10257190766638995699.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As presented at the 2018 Linux Plumbers conference [1], the Maintainer
Entry Profile (formerly Subsystem Profile) is proposed as a way to reduce
friction between committers and maintainers and encourage conversations
amongst maintainers about common best practices. While coding-style,
submit-checklist, and submitting-drivers lay out some common expectations
there remain local customs and maintainer preferences that vary by
subsystem.

The profile contains documentation of some of the common policy
questions a contributor might have that are local to the subsystem /
device-driver, special considerations for the subsystem, or other
guidelines that are otherwise not covered by the top-level process
documents.

The initial and hopefully non-controversial headings in the profile are:

    Overview:
    General introduction to how the subsystem operates

    Submit Checklist Addendum:
    Mechanical items that gate submission staging, or other requirements
    that gate patch acceptance.

    Key Cycle Dates:
     - Last -rc for new feature submissions: Expected lead time for submissions
     - Last -rc to merge features: Deadline for merge decisions

    Resubmit Cadence: When and preferred method to follow up with the
    maintainer

Note that coding style guidelines are explicitly left out of this list.

See Documentation/maintainer/maintainer-entry-profile.rst for more details,
and a follow-on example profile for the libnvdimm subsystem.

[1]: https://linuxplumbersconf.org/event/2/contributions/59/

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Steve French <stfrench@microsoft.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tobin C. Harding <me@tobin.cc>
Cc: Olof Johansson <olof@lixom.net>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Joe Perches <joe@perches.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/maintainer/index.rst                 |    1 
 .../maintainer/maintainer-entry-profile.rst        |   87 ++++++++++++++++++++
 MAINTAINERS                                        |    4 +
 3 files changed, 92 insertions(+)
 create mode 100644 Documentation/maintainer/maintainer-entry-profile.rst

diff --git a/Documentation/maintainer/index.rst b/Documentation/maintainer/index.rst
index 56e2c09dfa39..d904e74e1159 100644
--- a/Documentation/maintainer/index.rst
+++ b/Documentation/maintainer/index.rst
@@ -12,4 +12,5 @@ additions to this manual.
    configure-git
    rebasing-and-merging
    pull-requests
+   maintainer-entry-profile
 
diff --git a/Documentation/maintainer/maintainer-entry-profile.rst b/Documentation/maintainer/maintainer-entry-profile.rst
new file mode 100644
index 000000000000..51de3b9e606d
--- /dev/null
+++ b/Documentation/maintainer/maintainer-entry-profile.rst
@@ -0,0 +1,87 @@
+.. _maintainerentryprofile:
+
+Maintainer Entry Profile
+========================
+
+The Maintainer Entry Profile supplements the top-level process documents
+(submitting-patches, submitting drivers...) with
+subsystem/device-driver-local customs as well as details about the patch
+submission life-cycle. A contributor uses this document to level set
+their expectations and avoid common mistakes, maintainers may use these
+profiles to look across subsystems for opportunities to converge on
+common practices.
+
+
+Overview
+--------
+Provide an introduction to how the subsystem operates. While MAINTAINERS
+tells the contributor where to send patches for which files, it does not
+convey other subsystem-local infrastructure and mechanisms that aid
+development.
+Example questions to consider:
+- Are there notifications when patches are applied to the local tree, or
+  merged upstream?
+- Does the subsystem have a patchwork instance? Are patchwork state
+  changes notified?
+- Any bots or CI infrastructure that watches the list, or automated
+  testing feedback that the subsystem gates acceptance?
+- Git branches that are pulled into -next?
+- What branch should contributors submit against?
+- Links to any other Maintainer Entry Profiles? For example a
+  device-driver may point to an entry for its parent subsystem. This makes
+  the contributor aware of obligations a maintainer may have have for
+  other maintainers in the submission chain.
+
+
+Submit Checklist Addendum
+-------------------------
+List mandatory and advisory criteria, beyond the common "submit-checklist",
+for a patch to be considered healthy enough for maintainer attention.
+For example: "pass checkpatch.pl with no errors, or warning. Pass the
+unit test detailed at $URI".
+
+The Submit Checklist Addendum can also include details about the status
+of related hardware specifications. For example, does the subsystem
+require published specifications at a certain revision before patches
+will be considered.
+
+
+Key Cycle Dates
+---------------
+One of the common misunderstandings of submitters is that patches can be
+sent at any time before the merge window closes and can still be
+considered for the next -rc1. The reality is that most patches need to
+be settled in soaking in linux-next in advance of the merge window
+opening. Clarify for the submitter the key dates (in terms rc release
+week) that patches might considered for merging and when patches need to
+wait for the next -rc. At a minimum:
+- Last -rc for new feature submissions:
+  New feature submissions targeting the next merge window should have
+  their first posting for consideration before this point. Patches that
+  are submitted after this point should be clear that they are targeting
+  the NEXT+1 merge window, or should come with sufficient justification
+  why they should be considered on an expedited schedule. A general
+  guideline is to set expectation with contributors that new feature
+  submissions should appear before -rc5.
+
+- Last -rc to merge features: Deadline for merge decisions
+  Indicate to contributors the point at which an as yet un-applied patch
+  set will need to wait for the NEXT+1 merge window. Of course there is no
+  obligation to ever except any given patchset, but if the review has not
+  concluded by this point the expectation the contributor should wait and
+  resubmit for the following merge window.
+
+Optional:
+- First -rc at which the development baseline branch, listed in the
+  overview section, should be considered ready for new submissions.
+
+
+Review Cadence
+--------------
+One of the largest sources of contributor angst is how soon to ping
+after a patchset has been posted without receiving any feedback. In
+addition to specifying how long to wait before a resubmission this
+section can also indicate a preferred style of update like, resend the
+full series, or privately send a reminder email. This section might also
+list how review works for this code area and methods to get feedback
+that are not directly from the maintainer.
diff --git a/MAINTAINERS b/MAINTAINERS
index 3f171339df53..e5d111a86e61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -98,6 +98,10 @@ Descriptions of section entries:
 	   Obsolete:	Old code. Something tagged obsolete generally means
 			it has been replaced by a better system and you
 			should be using that.
+	P: Subsystem Profile document for more details submitting
+	   patches to the given subsystem. This is either an in-tree file,
+	   or a URI. See Documentation/maintainer/maintainer-entry-profile.rst
+	   for details.
 	F: Files and directories with wildcard patterns.
 	   A trailing slash includes all files and subdirectory files.
 	   F:	drivers/net/	all files in and below drivers/net

