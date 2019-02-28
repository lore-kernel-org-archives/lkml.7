Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAD1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840E42183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbfB1KxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:53:20 -0500
Received: from michel.telenet-ops.be ([195.130.137.88]:52904 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfB1KxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:53:20 -0500
Received: from ramsan ([84.194.111.163])
        by michel.telenet-ops.be with bizsmtp
        id iAtH1z00R3XaVaC06AtHtD; Thu, 28 Feb 2019 11:53:18 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gzJJV-0007OX-Gq; Thu, 28 Feb 2019 11:53:17 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gzJJV-0000Ck-Et; Thu, 28 Feb 2019 11:53:17 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH resend] lib/vsprintf: Remove %pCr remnant in comment
Date:   Thu, 28 Feb 2019 11:53:15 +0100
Message-Id: <20190228105315.744-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for "%pCr" was removed, but a reference in a comment was
forgotten.

Fixes: 666902e42fd8344b ("lib/vsprintf: Remove atomic-unsafe support for %pCr")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 lib/vsprintf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3add92329bae3d90..c87bfef6035b0ec0 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1930,7 +1930,6 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
  *       (legacy clock framework) of the clock
  * - 'Cn' For a clock, it prints the name (Common Clock Framework) or address
  *        (legacy clock framework) of the clock
- * - 'Cr' For a clock, it prints the current rate of the clock
  * - 'G' For flags to be printed as a collection of symbolic strings that would
  *       construct the specific value. Supported flags given by option:
  *       p page flags (see struct page) given as pointer to unsigned long
-- 
2.17.1

