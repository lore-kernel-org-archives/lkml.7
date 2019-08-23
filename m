Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8EDC3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB8523402
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389806AbfHWCMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 22:12:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33734 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389411AbfHWCMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:12:34 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i0z43-0000z0-Qp; Fri, 23 Aug 2019 04:12:31 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7072B1C07E4;
        Fri, 23 Aug 2019 04:12:31 +0200 (CEST)
Date:   Fri, 23 Aug 2019 02:12:30 -0000
From:   tip-bot2 for Cao jin <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/fixmap: Cleanup outdated comments
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Cao jin <caoj.fnst@cn.fujitsu.com>
In-Reply-To: <20190809114612.2569-1-caoj.fnst@cn.fujitsu.com>
References: <20190809114612.2569-1-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Message-ID: <156652635085.11767.14762210847598346368.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     c84b82dd3e593db217f23c60f7edae02c76a3c4c
Gitweb:        https://git.kernel.org/tip/c84b82dd3e593db217f23c60f7edae02c76a3c4c
Author:        Cao jin <caoj.fnst@cn.fujitsu.com>
AuthorDate:    Fri, 09 Aug 2019 19:46:12 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Aug 2019 21:50:19 +02:00

x86/fixmap: Cleanup outdated comments

Remove stale comments and fix the not longer valid pagetable entry
reference.

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190809114612.2569-1-caoj.fnst@cn.fujitsu.com

---
 arch/x86/include/asm/fixmap.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index 9da8ccc..0c47aa8 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -42,8 +42,7 @@
  * Because of this, FIXADDR_TOP x86 integration was left as later work.
  */
 #ifdef CONFIG_X86_32
-/* used by vmalloc.c, vsyscall.lds.S.
- *
+/*
  * Leave one empty page between vmalloc'ed areas and
  * the start of the fixmap.
  */
@@ -120,7 +119,7 @@ enum fixed_addresses {
 	 * before ioremap() is functional.
 	 *
 	 * If necessary we round it up to the next 512 pages boundary so
-	 * that we can have a single pgd entry and a single pte table:
+	 * that we can have a single pmd entry and a single pte table:
 	 */
 #define NR_FIX_BTMAPS		64
 #define FIX_BTMAPS_SLOTS	8
