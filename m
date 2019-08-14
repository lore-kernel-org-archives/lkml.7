Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442BCC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 23:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F456206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 23:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbfHNXkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 19:40:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:11922 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbfHNXkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 19:40:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 16:40:31 -0700
X-IronPort-AV: E=Sophos;i="5.64,387,1559545200"; 
   d="scan'208";a="167584999"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 16:40:30 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS, x86/CPU: Tony Luck will maintain asm/intel-family.h
Date:   Wed, 14 Aug 2019 16:40:30 -0700
Message-Id: <20190814234030.30817-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few different subsystems in the kernel that depend on
model specific behaviour (perf, EDAC, power, ...). Easier for just
one person to have the task to get new model numbers included instead
of having these groups trip over each other to do it.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e81e60bd7c26..29d58ad7f4f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8064,6 +8064,12 @@ T:	git git://git.code.sf.net/p/intel-sas/isci
 S:	Supported
 F:	drivers/scsi/isci/
 
+INTEL Cpu family model numbers
+M:	Tony Luck <tony.luck@intel.com>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	arch/x86/include/asm/intel-family.h
+
 INTEL DRM DRIVERS (excluding Poulsbo, Moorestown and derivative chipsets)
 M:	Jani Nikula <jani.nikula@linux.intel.com>
 M:	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
-- 
2.20.1

