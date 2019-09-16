Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967E1C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 12:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E0A214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 12:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732672AbfIPMfZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 08:35:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:32750 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbfIPMfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 08:35:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 05:35:24 -0700
X-IronPort-AV: E=Sophos;i="5.64,512,1559545200"; 
   d="scan'208";a="361510713"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 05:35:20 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     vishal.l.verma@intel.com,
        ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-nvdimm@lists.01.org, Dmitry Vyukov <dvyukov@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [Ksummit-discuss] [PATCH v2 2/3] Maintainer Handbook: Maintainer Entry Profile
In-Reply-To: <156821693396.2951081.7340292149329436920.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com> <156821693396.2951081.7340292149329436920.stgit@dwillia2-desk3.amr.corp.intel.com>
Date:   Mon, 16 Sep 2019 15:35:17 +0300
Message-ID: <87sgowxvui.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Sep 2019, Dan Williams <dan.j.williams@intel.com> wrote:
> As presented at the 2018 Linux Plumbers conference [1], the Maintainer
> Entry Profile (formerly Subsystem Profile) is proposed as a way to reduce
> friction between committers and maintainers and encourage conversations
> amongst maintainers about common best practices. While coding-style,
> submit-checklist, and submitting-drivers lay out some common expectations
> there remain local customs and maintainer preferences that vary by
> subsystem.
>
> The profile contains short answers to some of the common policy questions a
> contributor might have that are local to the subsystem / device-driver, or
> otherwise not covered by the top-level process documents.
>
> Overview: General introduction to how the subsystem operates
> Submit Checklist Addendum: Mechanical items that gate submission staging
> Key Cycle Dates:
>  - Last -rc for new feature submissions: Expected lead time for submissions
>  - Last -rc to merge features: Deadline for merge decisions
> Coding Style Addendum: Clarifications of local style preferences
> Resubmit Cadence: When to ping the maintainer
> Checkpatch / Style Cleanups: Policy on pure cleanup patches
>
> See Documentation/maintainer/maintainer-entry-profile.rst for more details,
> and a follow-on example profile for the libnvdimm subsystem.
>
> [1]: https://linuxplumbersconf.org/event/2/contributions/59/
>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Steve French <stfrench@microsoft.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Tobin C. Harding <me@tobin.cc>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Joe Perches <joe@perches.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  Documentation/maintainer/index.rst                 |    1 
>  .../maintainer/maintainer-entry-profile.rst        |   99 ++++++++++++++++++++
>  MAINTAINERS                                        |    4 +
>  3 files changed, 104 insertions(+)
>  create mode 100644 Documentation/maintainer/maintainer-entry-profile.rst
>
> diff --git a/Documentation/maintainer/index.rst b/Documentation/maintainer/index.rst
> index 56e2c09dfa39..d904e74e1159 100644
> --- a/Documentation/maintainer/index.rst
> +++ b/Documentation/maintainer/index.rst
> @@ -12,4 +12,5 @@ additions to this manual.
>     configure-git
>     rebasing-and-merging
>     pull-requests
> +   maintainer-entry-profile
>  
> diff --git a/Documentation/maintainer/maintainer-entry-profile.rst b/Documentation/maintainer/maintainer-entry-profile.rst
> new file mode 100644
> index 000000000000..aaedf4d6dbf7
> --- /dev/null
> +++ b/Documentation/maintainer/maintainer-entry-profile.rst
> @@ -0,0 +1,99 @@
> +.. _maintainerentryprofile:
> +
> +Maintainer Entry Profile
> +========================
> +
> +The Maintainer Entry Profile supplements the top-level process documents
> +(coding-style, submitting-patches...) with subsystem/device-driver-local
> +customs as well as details about the patch submission lifecycle. A
> +contributor uses this document to level set their expectations and avoid
> +common mistakes, maintainers may use these profiles to look across
> +subsystems for opportunities to converge on common practices.

In general I think we're already pretty good at adding and accumulating
documentation, but not so much cleaning up existing and outright
throwing out obsolete documentation.

'wc -l Documentation/process/*' says we already have 11k lines of
generic process documentation.

I would much rather see a streamlined and friendly guide to contributing
to the kernel than more rules, and driver/subsystem specific rules at
that. I would much rather get the feeling from submissions that the long
tail of contributors have actually read and understood the most relevant
parts of Documentation/process.

I'm pretty sure *I* haven't read all of Documentation/process.

My fear is that the entry profiles will only be helpful to the
contributors that already "get it". It may be helpful to the maintainers
in the sense that they can reply to patches with a pointer to the
relevant hoops to jump through.

---

Even so, if this gets merged, I'll probably add something helpful for
drm and/or i915 contributors. But what's the buy-in across the kernel?
If my grep serves me right, there are something like 2000+ entries in
MAINTAINERS. If 10% of them adds a profile, that's a fairly serious
amount of documentation. But can you actually expect more than a handful
of subsystems/drivers to add a profile? Then what's the coverage?

For reference, I've added or promoted adding the B: and C: entries to
MAINTAINERS. Various subsystems and drivers are really picky about where
and how they want bugs reported; in particular some folks only accept
email. Yet networking is the only one to indicate the email preference
in MAINTAINERS. And adding that is a one line change. (There are 19 B:
entries and 7 C: entries in total.)


BR,
Jani.


> +
> +
> +Overview
> +--------
> +Provide an introduction to how the subsystem operates. While MAINTAINERS
> +tells the contributor where to send patches for which files, it does not
> +convey other subsystem-local infrastructure and mechanisms that aid
> +development.
> +Example questions to consider:
> +- Are there notifications when patches are applied to the local tree, or
> +  merged upstream?
> +- Does the subsystem have a patchwork instance?
> +- Any bots or CI infrastructure that watches the list?
> +- Git branches that are pulled into -next?
> +- What branch should contributors submit against?
> +- Links to any other Maintainer Entry Profiles? For example a
> +  device-driver may point to an entry for its parent subsystem. This makes
> +  the contributor aware of obligations a maintainer may have have for
> +  other maintainers in the submission chain.
> +
> +
> +Submit Checklist Addendum
> +-------------------------
> +List mandatory and advisory criteria, beyond the common "submit-checklist",
> +for a patch to be considered healthy enough for maintainer attention.
> +For example: "pass checkpatch.pl with no errors, or warning. Pass the
> +unit test detailed at $URI".
> +
> +
> +Key Cycle Dates
> +---------------
> +One of the common misunderstandings of submitters is that patches can be
> +sent at any time before the merge window closes and can still be
> +considered for the next -rc1. The reality is that most patches need to
> +be settled in soaking in linux-next in advance of the merge window
> +opening. Clarify for the submitter the key dates (in terms rc release
> +week) that patches might considered for merging and when patches need to
> +wait for the next -rc. At a minimum:
> +- Last -rc for new feature submissions:
> +  New feature submissions targeting the next merge window should have
> +  their first posting for consideration before this point. Patches that
> +  are submitted after this point should be clear that they are targeting
> +  the NEXT+1 merge window, or should come with sufficient justification
> +  why they should be considered on an expedited schedule. A general
> +  guideline is to set expectation with contributors that new feature
> +  submissions should appear before -rc5.
> +
> +- Last -rc to merge features: Deadline for merge decisions
> +  Indicate to contributors the point at which an as yet un-applied patch
> +  set will need to wait for the NEXT+1 merge window. Of course there is no
> +  obligation to ever except any given patchset, but if the review has not
> +  concluded by this point the expectation the contributor should wait and
> +  resubmit for the following merge window.
> +
> +Optional:
> +- First -rc at which the development baseline branch, listed in the
> +  overview section, should be considered ready for new submissions.
> +
> +
> +Coding Style Addendum
> +---------------------
> +While the top-level "coding-style" document covers most style
> +considerations there are still discrepancies and local preferences
> +across subsystems. If a submitter should be aware of incremental / local
> +style guidelines like x-mas tree variable declarations, indentation
> +for multi line statements, function definition style, etc., list them
> +here.
> +
> +
> +Review Cadence
> +--------------
> +One of the largest sources of contributor angst is how soon to ping
> +after a patchset has been posted without receiving any feedback. In
> +addition to specifying how long to wait before a resubmission this
> +section can also indicate a preferred style of update like, resend the
> +full series, or privately send a reminder email. This section might also
> +list how review works for this code area and methods to get feedback
> +that are not directly from the maintainer.
> +
> +
> +Style Cleanup Patches
> +---------------------
> +For subsystems with long standing code bases it is reasonable to decline
> +to accept pure coding-style fixup patches. This is where you can let
> +contributors know "Standalone style-cleanups are welcome",
> +"Style-cleanups to existing code only welcome with other feature
> +changes", or “Standalone style-cleanups to existing code are not
> +welcome".
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3f171339df53..e5d111a86e61 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -98,6 +98,10 @@ Descriptions of section entries:
>  	   Obsolete:	Old code. Something tagged obsolete generally means
>  			it has been replaced by a better system and you
>  			should be using that.
> +	P: Subsystem Profile document for more details submitting
> +	   patches to the given subsystem. This is either an in-tree file,
> +	   or a URI. See Documentation/maintainer/maintainer-entry-profile.rst
> +	   for details.
>  	F: Files and directories with wildcard patterns.
>  	   A trailing slash includes all files and subdirectory files.
>  	   F:	drivers/net/	all files in and below drivers/net
>
> _______________________________________________
> Ksummit-discuss mailing list
> Ksummit-discuss@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss

-- 
Jani Nikula, Intel Open Source Graphics Center
