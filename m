Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB9AC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC292208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574306462;
	bh=fYEsgRn0hBDZguWtn+q6jm1BrFuME7IOvzqGZBWwIhA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=k42vBwMOGtXK4Odnw64pvhG2xZtLrsbfplG6tOGyKOs7zKRvbTXp9OcYmTUWqrrly
	 CPmdjvxVXHYZN84uVPuA3n6SjB+LXfTia+Xmd1lJCKnM4f6j64xKL715F5HTu+XFV+
	 fRW67EWN5tTmWOK/Z9wSkqRc8M4q0NaA566zPWTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfKUDVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 22:21:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:34866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727509AbfKUDU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:20:57 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF38E208C3;
        Thu, 21 Nov 2019 03:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306457;
        bh=fYEsgRn0hBDZguWtn+q6jm1BrFuME7IOvzqGZBWwIhA=;
        h=From:To:Cc:Subject:Date:From;
        b=CJ/cnnVW8G1yboL8/OnS61tBzu9Gvg8MPGoHwzvywSisZnw9mzNZMMq51L7CE7Z20
         s8Bgz2ttOjUbQNGtLyDwWcmawznXmud/8Y+V02NuZyEHPBMw/Q6bsEf2eJmVrVbei2
         KuuBx6yHpYnEhi1XTxzjN2yeFOrrIpQavlj9+ias=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [PATCH v2] sh: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:20:53 +0100
Message-Id: <1574306454-4008-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix also 7-space and tab+1 space indentation issues.
---
 arch/sh/Kconfig        | 6 +++---
 arch/sh/boards/Kconfig | 2 +-
 arch/sh/mm/Kconfig     | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index f356ee674d89..39048ab92f73 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -229,9 +229,9 @@ config ARCH_SHMOBILE
 	select PM
 
 config CPU_HAS_PMU
-       depends on CPU_SH4 || CPU_SH4A
-       default y
-       bool
+	depends on CPU_SH4 || CPU_SH4A
+	default y
+	bool
 
 if SUPERH32
 
diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index cee24c308337..60a113114a76 100644
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -231,7 +231,7 @@ config SH_MIGOR
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
 	  Select Migo-R if configuring for the SH7722 Migo-R platform
-          by Renesas System Solutions Asia Pte. Ltd.
+	  by Renesas System Solutions Asia Pte. Ltd.
 
 config SH_AP325RXA
 	bool "AP-325RXA"
diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index 5c8a2ebfc720..130b2d235f0c 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -2,7 +2,7 @@
 menu "Memory management options"
 
 config MMU
-        bool "Support for memory management hardware"
+	bool "Support for memory management hardware"
 	depends on !CPU_SH2
 	default y
 	help
@@ -151,8 +151,8 @@ config ARCH_MEMORY_PROBE
 	depends on MEMORY_HOTPLUG
 
 config IOREMAP_FIXED
-       def_bool y
-       depends on X2TLB || SUPERH64
+	def_bool y
+	depends on X2TLB || SUPERH64
 
 config UNCACHED_MAPPING
 	bool
-- 
2.7.4

