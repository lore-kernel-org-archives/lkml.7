Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C09C432C3
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 21:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04EB5207DD
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 21:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKXVOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 16:14:00 -0500
Received: from mga09.intel.com ([134.134.136.24]:55980 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbfKXVN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 16:13:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Nov 2019 13:13:58 -0800
X-IronPort-AV: E=Sophos;i="5.69,239,1571727600"; 
   d="scan'208";a="198233077"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Nov 2019 13:13:58 -0800
Subject: [PATCH v3 0/3] Maintainer Entry Profiles
From:   Dan Williams <dan.j.williams@intel.com>
To:     corbet@lwn.net
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joe Perches <joe@perches.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steve French <stfrench@microsoft.com>,
        Olof Johansson <olof@lixom.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-doc@vger.kernel.org
Date:   Sun, 24 Nov 2019 12:59:42 -0800
Message-ID: <157462918268.1729495.10257190766638995699.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2 [1]:
- Drop any consideration for coding style concerns in the profile. It
  was a minor aspect of the proposal that generated the bulk of the
  feedback on v2. Lets make progress on the rest.

- Clarify that the "Submit Checklist Addendum" can also include details
  that submitters need to take into account before even beginning to
  craft a patch. This is in response to the RISC-V use case of
  declaring specification readiness as a patch gate, and is now also used
  by the libnvdimm subsystem to clarify details about ACPI NVDIMM Device
  Specific Method specifications. (Paul)

- Non-change from v2: Kees had asked for a common directory for all
  profiles to live, but Mauro noted that this could be handled later
  with some scripting to post-process the MAINTAINERS file, or otherwise
  converting MAINTAINERS to ReST.

- Clarify the cover letter to focus on the contributor focused
  Maintainer Entry Profiles, and defer discussion of a maintainer
  focused Handbook.

[1]: https://lore.kernel.org/ksummit-discuss/156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com/

---

At last years Plumbers Conference I proposed the Maintainer Entry
Profile as a document that a maintainer can provide to set contributor
expectations and provide fodder for a discussion between maintainers
about the merits of different maintainer policies.

For those that did not attend, the goal of the Maintainer Entry Profile
is to provide contributors documentation of patch submission
considerations that may vary by subsystem. The session introduction was:

    The first rule of kernel maintenance is that there are no hard and
    fast rules. That state of affairs is both a blessing and a curse. It
    has served the community well to be adaptable to the different
    people and different problem spaces that inhabit the kernel
    community. However, that variability also leads to inconsistent
    experiences for contributors, little to no guidance for new
    contributors, and unnecessary stress on current maintainers.

To be clear, the proposed document does not impose or suggest new rules.
Instead it provides an outlet to document the existing unwritten
policies in effect for a given subsystem.  Over time the hope is that
some of this variability can be up-levelled to new global process
policy, but in the meantime it provides relief for communicating the
guidelines that are being imposed on contributors.

---

Dan Williams (3):
      MAINTAINERS: Reclaim the P: tag for Maintainer Entry Profile
      Maintainer Handbook: Maintainer Entry Profile
      libnvdimm, MAINTAINERS: Maintainer Entry Profile


 Documentation/maintainer/index.rst                 |    1 
 .../maintainer/maintainer-entry-profile.rst        |   87 ++++++++++++++++++++
 Documentation/nvdimm/maintainer-entry-profile.rst  |   59 ++++++++++++++
 MAINTAINERS                                        |   20 +++--
 4 files changed, 158 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/maintainer/maintainer-entry-profile.rst
 create mode 100644 Documentation/nvdimm/maintainer-entry-profile.rst
