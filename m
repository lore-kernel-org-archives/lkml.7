Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D8BC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E227216F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfEHRDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 13:03:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:26495 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728925AbfEHRDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 13:03:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 10:03:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,446,1549958400"; 
   d="scan'208";a="169697559"
Received: from chang-linux-3.sc.intel.com ([172.25.66.171])
  by fmsmga002.fm.intel.com with ESMTP; 08 May 2019 10:03:02 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v7 04/18] kbuild: Raise the minimum required binutils version to 2.21
Date:   Wed,  8 May 2019 03:02:19 -0700
Message-Id: <1557309753-24073-5-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557309753-24073-1-git-send-email-chang.seok.bae@intel.com>
References: <1557309753-24073-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It helps to use some new instructions directly in assembly code.

Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linux Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
---
 Documentation/process/changes.rst | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 18735dc..0a18075 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -31,7 +31,7 @@ you probably needn't concern yourself with isdn4k-utils.
 ====================== ===============  ========================================
 GNU C                  4.6              gcc --version
 GNU make               3.81             make --version
-binutils               2.20             ld -v
+binutils               2.21             ld -v
 flex                   2.5.35           flex --version
 bison                  2.0              bison --version
 util-linux             2.10o            fdformat --version
@@ -77,9 +77,7 @@ You will need GNU make 3.81 or later to build the kernel.
 Binutils
 --------
 
-The build system has, as of 4.13, switched to using thin archives (`ar T`)
-rather than incremental linking (`ld -r`) for built-in.a intermediate steps.
-This requires binutils 2.20 or newer.
+Binutils 2.21 or newer is needed to build the kernel.
 
 pkg-config
 ----------
-- 
2.7.4

