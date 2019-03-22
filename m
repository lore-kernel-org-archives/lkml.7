Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124DDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDDD22190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfCVVLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 17:11:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:26211 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfCVVLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 17:11:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 14:11:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="329837771"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.181])
  by fmsmga006.fm.intel.com with ESMTP; 22 Mar 2019 14:11:37 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Tobin C . Harding" <me@tobin.cc>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: [PATCH v5 0/2] docs: checkpatch: improve handling of Co-developed-by
Date:   Fri, 22 Mar 2019 14:11:35 -0700
Message-Id: <20190322211137.18241-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recently introduced Co-developed-by: tag has seen a spate of
improper usage, likely because the tag is less intuitive and slightly
more complex than most other tags.  Rework the documentation to be more
explicit in how Co-developed-by: is intended to be used, add examples
in the docs, and add logic to checkpatch to reinforce proper usage.

v1: https://lkml.kernel.org/r/20190320151140.32432-1-sean.j.christopherson@intel.com
v2: https://lkml.kernel.org/r/20190321184316.8525-1-sean.j.christopherson@intel.com
    Rewrite the blurb to state standard sign-off procedure should be
    followed as opposed to dictating the original author's SOB be last.
v3: https://lkml.kernel.org/r/20190321200103.9333-1-sean.j.christopherson@intel.com
    Update a similar blurb in Documentation/process/5.Posting.rst
v4: https://lkml.kernel.org/r/20190322155735.13954-1-sean.j.christopherson@intel.com
    Rework the blurbs to avoid use of the word "original" [Tobin]
v5: Add checkpatch warnings [Joe]
    Fix a spelling error [Niklas]

Sean Christopherson (2):
  docs: Clarify the usage and sign-off requirements for Co-developed-by
  checkpatch: Warn on improper usage of Co-developed-by

 Documentation/process/5.Posting.rst          | 10 +++--
 Documentation/process/submitting-patches.rst | 40 +++++++++++++++++---
 scripts/checkpatch.pl                        | 18 +++++++++
 3 files changed, 59 insertions(+), 9 deletions(-)

-- 
2.21.0

