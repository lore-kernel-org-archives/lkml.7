Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26574CA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 04:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05FB222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 04:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="iNxk/lYC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439278AbfJRE6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 00:58:46 -0400
Received: from condef-10.nifty.com ([202.248.20.75]:37434 "EHLO
        condef-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436473AbfJRE6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 00:58:45 -0400
Received: from conuserg-12.nifty.com ([10.126.8.75])by condef-10.nifty.com with ESMTP id x9I4pfCF007484;
        Fri, 18 Oct 2019 13:51:41 +0900
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x9I4otrw003608;
        Fri, 18 Oct 2019 13:50:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x9I4otrw003608
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1571374256;
        bh=g3k4SKCLKg1HVJs8XOHlrlk6IW7BWaci6zok4NIZI/U=;
        h=From:To:Cc:Subject:Date:From;
        b=iNxk/lYCnVuVic2I0bv+2ctP+0/Cm+8G76ozpRQGCQO5g3XRzPr9TkHwF8BSKrkYm
         g8P3uXWpjYBkOP6HvzlkeiDwU86Q3B19HJxlDXpFWjYdzInL18bqPT7t5IeX+R6pEJ
         1O49UlTxg+iTTDj0uP2oZ9xjxGwdYo9ADAiYE56NHaXfHAeXZnbIT6IuJE9lnM/gT7
         bOYH8fvd8jtQGvq4ho4m2MwNw4fKFOpZhk/PVXSuheZUkR+apM7kHj0+rOISyLGSa1
         AgKsq5asjwO/Jt7P1df5y2gGOisFbv8ZmvhtXTh1jVsZ5Im53Xdzpfc4rFR2lNLk6x
         kU6JqV2Ohvjig==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] export,module: add SPDX GPL-2.0 license identifier to headers with no license
Date:   Fri, 18 Oct 2019 13:50:53 +0900
Message-Id: <20191018045053.8424-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b24413180f56 ("License cleanup: add SPDX GPL-2.0 license
identifier to files with no license") took care of a lot of files
without any license information.

These headers were not processed by the tool perhaps because they
contain "GPL" in the code.

I do not see any license boilerplate in them, so they fall back to
GPL version 2 only, which is the project default.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/asm-generic/export.h | 1 +
 include/linux/export.h       | 1 +
 include/linux/license.h      | 1 +
 include/linux/module.h       | 7 +++++--
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index a3983e2ce0fd..afddc5442e92 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 #ifndef __ASM_GENERIC_EXPORT_H
 #define __ASM_GENERIC_EXPORT_H
 
diff --git a/include/linux/export.h b/include/linux/export.h
index 621158ecd2e2..f86ba7b11c1f 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 #ifndef _LINUX_EXPORT_H
 #define _LINUX_EXPORT_H
 
diff --git a/include/linux/license.h b/include/linux/license.h
index decdbf43cb5c..7cce390f120b 100644
--- a/include/linux/license.h
+++ b/include/linux/license.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 #ifndef __LICENSE_H
 #define __LICENSE_H
 
diff --git a/include/linux/module.h b/include/linux/module.h
index 6d20895e7739..bd165ba68617 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -1,11 +1,14 @@
-#ifndef _LINUX_MODULE_H
-#define _LINUX_MODULE_H
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Dynamic loading of modules into the kernel.
  *
  * Rewritten by Richard Henderson <rth@tamu.edu> Dec 1996
  * Rewritten again by Rusty Russell, 2002
  */
+
+#ifndef _LINUX_MODULE_H
+#define _LINUX_MODULE_H
+
 #include <linux/list.h>
 #include <linux/stat.h>
 #include <linux/compiler.h>
-- 
2.17.1

