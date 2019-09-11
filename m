Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE133ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 16:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5D4208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 16:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbfIKQDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 12:03:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:26157 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728819AbfIKQDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 12:03:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2019 09:03:00 -0700
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="268788464"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2019 09:03:00 -0700
Subject: [PATCH v2 0/3] Maintainer Entry Profiles
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joe Perches <joe@perches.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steve French <stfrench@microsoft.com>,
        Olof Johansson <olof@lixom.net>, linux-nvdimm@lists.01.org,
        ksummit-discuss@lists.linuxfoundation.org
Date:   Wed, 11 Sep 2019 08:48:42 -0700
Message-ID: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1 [1]:
- Simplify the profile to a hopefully non-controversial set of
  attributes that address the most common sources of contributor
  confusion, or maintainer frustration.
- Rename "Subsystem Profile" to "Maintainer Entry Profile". Not every
  entry in MAINTAINERS represents a full subsystem. There may be driver
  local considerations to communicate to a submitter in addition to wider
  subsystem guidelines. 
- Delete the old P: tag in MAINTAINERS rather than convert to a new E:
  tag (Joe Perches).
[1]:  http://lore.kernel.org/r/154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com

---

At last years Plumbers Conference I proposed the Maintainer Entry
Profile as a document that a maintainer can provide to set contributor
expectations and provide fodder for a discussion between maintainers
about the merits of different maintainer policies.

For those that did not attend, the goal of the Maintainer Entry Profile,
and the Maintainer Handbook more generally, is to provide a desk
reference for maintainers both new and experienced. The session
introduction was:

    The first rule of kernel maintenance is that there are no hard and
    fast rules. That state of affairs is both a blessing and a curse. It
    has served the community well to be adaptable to the different
    people and different problem spaces that inhabit the kernel
    community. However, that variability also leads to inconsistent
    experiences for contributors, little to no guidance for new
    contributors, and unnecessary stress on current maintainers. There
    are quite a few of people who have been around long enough to make
    enough mistakes that they have gained some hard earned proficiency.
    However if the kernel community expects to keep growing it needs to
    be able both scale the maintainers it has and ramp new ones without
    necessarily let them make a decades worth of mistakes to learn the
    ropes. 

To be clear, the proposed document does not impose or suggest new
rules. Instead it provides an outlet to document the unwritten rules
and policies in effect for each subsystem, and that each subsystem
might decide differently for whatever reason.


---

Dan Williams (3):
      MAINTAINERS: Reclaim the P: tag for Maintainer Entry Profile
      Maintainer Handbook: Maintainer Entry Profile
      libnvdimm, MAINTAINERS: Maintainer Entry Profile


 Documentation/maintainer/index.rst                 |    1 
 .../maintainer/maintainer-entry-profile.rst        |   99 ++++++++++++++++++++
 Documentation/nvdimm/maintainer-entry-profile.rst  |   64 +++++++++++++
 MAINTAINERS                                        |   20 ++--
 4 files changed, 175 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/maintainer/maintainer-entry-profile.rst
 create mode 100644 Documentation/nvdimm/maintainer-entry-profile.rst
