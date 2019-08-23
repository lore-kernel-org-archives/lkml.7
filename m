Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27F8C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0271233A0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391341AbfHWCo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 22:44:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33867 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391302AbfHWCoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:44:24 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i0zYn-0001NE-KE; Fri, 23 Aug 2019 04:44:17 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 20EC81C0890;
        Fri, 23 Aug 2019 04:44:17 +0200 (CEST)
Date:   Fri, 23 Aug 2019 02:44:17 -0000
From:   tip-bot2 for Arnaldo Carvalho de Melo <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] tools headers: Synchronize linux/bits.h with the
 kernel sources
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
In-Reply-To: <tip-1if3iga5r3di6oyddgxsr225@git.kernel.org>
References: <tip-1if3iga5r3di6oyddgxsr225@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156652825705.13156.18245800688508519303.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b658911731d41a91b9de5458d6f38d6e1c90a453
Gitweb:        https://git.kernel.org/tip/b658911731d41a91b9de5458d6f38d6e1c90a453
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 19 Aug 2019 11:14:28 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 20 Aug 2019 12:09:21 -03:00

tools headers: Synchronize linux/bits.h with the kernel sources

To pick up the changes in this cset:

  95b980d62d52 ("linux/bits.h: make BIT(), GENMASK(), and friends available in assembly")

To address this tools/perf build warning:

  Warning: Kernel ABI header at 'tools/include/linux/bits.h' differs from latest version at 'include/linux/bits.h'
  diff -u tools/include/linux/bits.h include/linux/bits.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-1if3iga5r3di6oyddgxsr225@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/bits.h | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/include/linux/bits.h b/tools/include/linux/bits.h
index 2b7b532..669d694 100644
--- a/tools/include/linux/bits.h
+++ b/tools/include/linux/bits.h
@@ -1,13 +1,15 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __LINUX_BITS_H
 #define __LINUX_BITS_H
+
+#include <linux/const.h>
 #include <asm/bitsperlong.h>
 
-#define BIT(nr)			(1UL << (nr))
-#define BIT_ULL(nr)		(1ULL << (nr))
-#define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
+#define BIT(nr)			(UL(1) << (nr))
+#define BIT_ULL(nr)		(ULL(1) << (nr))
+#define BIT_MASK(nr)		(UL(1) << ((nr) % BITS_PER_LONG))
 #define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
-#define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
+#define BIT_ULL_MASK(nr)	(ULL(1) << ((nr) % BITS_PER_LONG_LONG))
 #define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
 #define BITS_PER_BYTE		8
 
@@ -17,10 +19,11 @@
  * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
  */
 #define GENMASK(h, l) \
-	(((~0UL) - (1UL << (l)) + 1) & (~0UL >> (BITS_PER_LONG - 1 - (h))))
+	(((~UL(0)) - (UL(1) << (l)) + 1) & \
+	 (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
 
 #define GENMASK_ULL(h, l) \
-	(((~0ULL) - (1ULL << (l)) + 1) & \
-	 (~0ULL >> (BITS_PER_LONG_LONG - 1 - (h))))
+	(((~ULL(0)) - (ULL(1) << (l)) + 1) & \
+	 (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
 
 #endif	/* __LINUX_BITS_H */
