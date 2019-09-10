Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF51C49ED9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F61421019
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437131AbfIJR0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 13:26:51 -0400
Received: from mga05.intel.com ([192.55.52.43]:15950 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394139AbfIJR0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 13:26:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2019 10:26:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,490,1559545200"; 
   d="scan'208";a="268478926"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga001.jf.intel.com with ESMTP; 10 Sep 2019 10:26:49 -0700
Subject: [PATCH 2/4] Documentation/process: describe relaxing disclosing party NDAs
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, corbet@lwn.net,
        gregkh@linuxfoundation.org, sashal@kernel.org, ben@decadent.org.uk,
        tglx@linutronix.de, labbott@redhat.com, andrew.cooper3@citrix.com,
        tsoni@codeaurora.org, keescook@chromium.org, tony.luck@intel.com,
        linux-doc@vger.kernel.org, dan.j.williams@intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 10 Sep 2019 10:26:49 -0700
References: <20190910172644.4D2CDF0A@viggo.jf.intel.com>
In-Reply-To: <20190910172644.4D2CDF0A@viggo.jf.intel.com>
Message-Id: <20190910172649.74639177@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Hardware companies like Intel have lots of information which they
want to disclose to some folks but not others.  Non-disclosure
agreements are a tool of choice for helping to ensure that the
flow of information is controlled.

But, they have caused problems in mitigation development.  It
can be hard for individual developers employed by companies to
figure out how they can participate, especially if their
employer is under an NDA.

To make this easier for developers, make it clear to disclosing
parties that they are expected to give permission for individuals
to participate in mitigation efforts.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Ben Hutchings <ben@decadent.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Trilok Soni <tsoni@codeaurora.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Acked-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/Documentation/process/embargoed-hardware-issues.rst |    7 +++++++
 1 file changed, 7 insertions(+)

diff -puN Documentation/process/embargoed-hardware-issues.rst~hw-sec-0 Documentation/process/embargoed-hardware-issues.rst
--- a/Documentation/process/embargoed-hardware-issues.rst~hw-sec-0	2019-09-10 08:39:02.835488131 -0700
+++ b/Documentation/process/embargoed-hardware-issues.rst	2019-09-10 08:39:02.838488131 -0700
@@ -74,6 +74,13 @@ unable to enter into any non-disclosure
 is aware of the sensitive nature of such issues and offers a Memorandum of
 Understanding instead.
 
+Disclosing parties may have shared information about an issue under a
+non-disclosure agreement with third parties.  In order to ensure that
+these agreements do not interfere with the mitigation development
+process, the disclosing party must provide explicit permission to
+participate to any response team members affected by a non-disclosure
+agreement.  Disclosing parties must resolve requests to do so in a
+timely manner.
 
 Memorandum of Understanding
 ---------------------------
_
