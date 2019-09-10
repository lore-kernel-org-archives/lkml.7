Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	WEIRD_QUOTING autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8138BC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6452521019
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437145AbfIJR0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 13:26:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:41079 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437132AbfIJR0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 13:26:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2019 10:26:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="335986073"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga004.jf.intel.com with ESMTP; 10 Sep 2019 10:26:51 -0700
Subject: [PATCH 3/4] Documentation/process: soften language around conference talk dates
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, corbet@lwn.net,
        gregkh@linuxfoundation.org, sashal@kernel.org, ben@decadent.org.uk,
        tglx@linutronix.de, labbott@redhat.com, andrew.cooper3@citrix.com,
        tsoni@codeaurora.org, keescook@chromium.org, tony.luck@intel.com,
        linux-doc@vger.kernel.org, dan.j.williams@intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 10 Sep 2019 10:26:51 -0700
References: <20190910172644.4D2CDF0A@viggo.jf.intel.com>
In-Reply-To: <20190910172644.4D2CDF0A@viggo.jf.intel.com>
Message-Id: <20190910172651.D9F5C062@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Both hardware companies and the kernel community prefer coordinated
disclosure to the alternatives.  It is also obvious that sitting on
ready-to-go mitigations for months is not so nice for kernel
maintainers.

I want to ensure that the patched text can not be read as "the kernel
does not wait for conference dates".  I'm also fairly sure that, so
far, we *have* waited for a number of conference dates.

Change the text to make it clear that waiting for conference dates
is possible, but keep the grumbling about it being a burden.

While I think this is good for everyone, this patch represents my
personal opinion and not that of my employer.

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

 b/Documentation/process/embargoed-hardware-issues.rst |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff -puN Documentation/process/embargoed-hardware-issues.rst~hw-sec-1 Documentation/process/embargoed-hardware-issues.rst
--- a/Documentation/process/embargoed-hardware-issues.rst~hw-sec-1	2019-09-10 08:39:03.879488129 -0700
+++ b/Documentation/process/embargoed-hardware-issues.rst	2019-09-10 08:39:03.883488129 -0700
@@ -197,10 +197,9 @@ While we understand that hardware securi
 time, the embargo time should be constrained to the minimum time which is
 required for all involved parties to develop, test and prepare the
 mitigations. Extending embargo time artificially to meet conference talk
-dates or other non-technical reasons is creating more work and burden for
-the involved developers and response teams as the patches need to be kept
-up to date in order to follow the ongoing upstream kernel development,
-which might create conflicting changes.
+dates or other non-technical reasons is possible, but not preferred. These
+artificial extensions burden the response team with constant maintenance
+updating mitigations to follow upstream kernel development.
 
 CVE assignment
 """"""""""""""
_
