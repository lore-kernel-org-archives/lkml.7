Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E85C5AE59
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EFF216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 17:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437156AbfIJR0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 13:26:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:10672 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437143AbfIJR0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 13:26:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2019 10:26:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,490,1559545200"; 
   d="scan'208";a="189413869"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga006.jf.intel.com with ESMTP; 10 Sep 2019 10:26:53 -0700
Subject: [PATCH 4/4] Documentation/process: add transparency promise to list subscription
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, corbet@lwn.net,
        gregkh@linuxfoundation.org, sashal@kernel.org, ben@decadent.org.uk,
        tglx@linutronix.de, labbott@redhat.com, andrew.cooper3@citrix.com,
        tsoni@codeaurora.org, keescook@chromium.org, tony.luck@intel.com,
        linux-doc@vger.kernel.org, dan.j.williams@intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 10 Sep 2019 10:26:52 -0700
References: <20190910172644.4D2CDF0A@viggo.jf.intel.com>
In-Reply-To: <20190910172644.4D2CDF0A@viggo.jf.intel.com>
Message-Id: <20190910172652.4FFF6CA3@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

Transparency is good.  It it essential for everyone working under an
embargo to know who is involved and who else is a "knower".  Being
transparent allows everyone to always make informed decisions about
ongoing participating in a mitigation effort.

Add a step to the subscription process which will notify existing
subscribers when a new one is added.

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

 b/Documentation/process/embargoed-hardware-issues.rst |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff -puN Documentation/process/embargoed-hardware-issues.rst~hw-sec-2 Documentation/process/embargoed-hardware-issues.rst
--- a/Documentation/process/embargoed-hardware-issues.rst~hw-sec-2	2019-09-10 09:58:47.989476197 -0700
+++ b/Documentation/process/embargoed-hardware-issues.rst	2019-09-10 09:58:47.992476197 -0700
@@ -276,10 +276,11 @@ certificate. If a PGP key is used, it mu
 server and is ideally connected to the Linux kernel's PGP web of trust. See
 also: https://www.kernel.org/signature.html.
 
-The response team verifies that the subscriber request is valid and adds
-the subscriber to the list. After subscription the subscriber will receive
-email from the mailing-list which is signed either with the list's PGP key
-or the list's S/MIME certificate. The subscriber's email client can extract
-the PGP key or the S/MIME certificate from the signature so the subscriber
-can send encrypted email to the list.
+The response team verifies that the subscriber request is valid, adds the
+subscriber to the list, and notifies the existing list subscribers
+including the disclosing party. After subscription the subscriber will
+receive email from the mailing-list which is signed either with the list's
+PGP key or the list's S/MIME certificate. The subscriber's email client can
+extract the PGP key or the S/MIME certificate from the signature so the
+subscriber can send encrypted email to the list.
 
_
