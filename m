Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C89AC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CD822C97
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="YymD+MoN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388257AbfGYO0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:26:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36223 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbfGYO0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:26:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PEPuWs1039798
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 07:25:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PEPuWs1039798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564064757;
        bh=tgOl5N4aEb+8XnWIB5jv+tEA6WZGbn7gWW30Ye2FDwk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=YymD+MoNIyXVpe32mLEpq7RSrESL/ROxvqTl3bS8vzxW0wftNM7ZqDtCA3/16ABD+
         6uFJpca7xkcJSzmNr/ExIx0RlLKyDr79T4ZnwTjk68kwLIBoJsGKa4TfRRCA9QJLHU
         zf07djvn+lFf1OMozsxgUSAr8tfSTsl6WIj6VY+Slp4iBsalE1zaViTSfVr6FfvTUw
         QmID13IdRTyMMsHSzri3AHLf8Nni8E4doLlLvdMHCWpZpmrum5hS/ese4hCrSYkWgP
         BYeYakpGI+UHwUjjq4N6snszHh1x4pJGhaq/3ke7wXevkYTosUwz0ZEnrgTnFwyfZJ
         OS2t6Ae/rql4A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PEPt9w1039795;
        Thu, 25 Jul 2019 07:25:55 -0700
Date:   Thu, 25 Jul 2019 07:25:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-ba77b2a02e0099ab0021bc3169b8f674c6be19f0@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
          peterz@infradead.org, mingo@kernel.org
In-Reply-To: <20190722105219.526508168@linutronix.de>
References: <20190722105219.526508168@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Move apic_flat_64 header into apic
 directory
Git-Commit-ID: ba77b2a02e0099ab0021bc3169b8f674c6be19f0
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ba77b2a02e0099ab0021bc3169b8f674c6be19f0
Gitweb:     https://git.kernel.org/tip/ba77b2a02e0099ab0021bc3169b8f674c6be19f0
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 22 Jul 2019 20:47:13 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Jul 2019 16:11:58 +0200

x86/apic: Move apic_flat_64 header into apic directory

Only used locally.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190722105219.526508168@linutronix.de

---
 arch/x86/kernel/apic/apic_flat_64.c                  | 2 +-
 arch/x86/{include/asm => kernel/apic}/apic_flat_64.h | 0
 arch/x86/kernel/apic/apic_numachip.c                 | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index a38b1ecc018d..cfee2e546531 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -13,9 +13,9 @@
 #include <linux/acpi.h>
 
 #include <asm/jailhouse_para.h>
-#include <asm/apic_flat_64.h>
 #include <asm/apic.h>
 
+#include "apic_flat_64.h"
 #include "ipi.h"
 
 static struct apic apic_physflat;
diff --git a/arch/x86/include/asm/apic_flat_64.h b/arch/x86/kernel/apic/apic_flat_64.h
similarity index 100%
rename from arch/x86/include/asm/apic_flat_64.h
rename to arch/x86/kernel/apic/apic_flat_64.h
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index 7d4c00f4e984..09ec9ffb268e 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -16,9 +16,9 @@
 #include <asm/numachip/numachip.h>
 #include <asm/numachip/numachip_csr.h>
 
-#include <asm/apic_flat_64.h>
 #include <asm/pgtable.h>
 
+#include "apic_flat_64.h"
 #include "ipi.h"
 
 u8 numachip_system __read_mostly;
