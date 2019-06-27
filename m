Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B279EC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85923208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ZvqULss+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfF0Xog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:44:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51597 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfF0Xof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:44:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RNhKnP500905
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 16:43:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RNhKnP500905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561679000;
        bh=Mw2XHH+eq2wZb8BCbUt3O24HcIJwWyYtRQKupIjllo0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ZvqULss+dytTfB2r99e4agnmLsbzv9IVpM0E2GqNX4PhNIFvOUHT/YVjM23t7/Rs4
         IWGBWFT01EuqnuI03je6+d3MQHa5ho08tH6MscI6KJP4GnpmepkjS12yLrXaZCX22z
         zOcbt6iabZoSiY8xQVkFp5H3fyhZpTD/l7bvMcwJwf0X5+kg19rrO70cTzrPXQGEY4
         Hz7RMB6t/JDzcF4hy1rZl3SYtRTIxjMmDehMv54+5HyaH4hY3IO6hYJByp98d2SULS
         9CthSc0I7zvE8UdGAUNW5ke3wvnO5TKLDwRbDK6Y1K9Sw8XyBuKTB5wYVQusmK3pY/
         fLnD36VPQQkRQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RNhJGA500902;
        Thu, 27 Jun 2019 16:43:19 -0700
Date:   Thu, 27 Jun 2019 16:43:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-9bc9e1d4c139497553599a73839ea846dce63f72@git.kernel.org>
Cc:     ashok.raj@intel.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        tglx@linutronix.de, Suravee.Suthikulpanit@amd.com,
        eranian@google.com, andi.kleen@intel.com, mingo@kernel.org,
        peterz@infradead.org, ricardo.neri-calderon@linux.intel.com,
        ravi.v.shankar@intel.com
Reply-To: ravi.v.shankar@intel.com, ricardo.neri-calderon@linux.intel.com,
          peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
          hpa@zytor.com, linux-kernel@vger.kernel.org, ashok.raj@intel.com,
          andi.kleen@intel.com, eranian@google.com,
          Suravee.Suthikulpanit@amd.com
In-Reply-To: <20190623132435.348089155@linutronix.de>
References: <20190623132435.348089155@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/hpet: Remove not required includes
Git-Commit-ID: 9bc9e1d4c139497553599a73839ea846dce63f72
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

Commit-ID:  9bc9e1d4c139497553599a73839ea846dce63f72
Gitweb:     https://git.kernel.org/tip/9bc9e1d4c139497553599a73839ea846dce63f72
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Sun, 23 Jun 2019 15:23:54 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:57:20 +0200

x86/hpet: Remove not required includes

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Link: https://lkml.kernel.org/r/20190623132435.348089155@linutronix.de

---
 arch/x86/kernel/hpet.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 4cf93294bacc..96daae404b29 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -1,22 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#include <linux/clocksource.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
-#include <linux/irq.h>
 #include <linux/export.h>
 #include <linux/delay.h>
-#include <linux/errno.h>
-#include <linux/i8253.h>
-#include <linux/slab.h>
 #include <linux/hpet.h>
-#include <linux/init.h>
 #include <linux/cpu.h>
-#include <linux/pm.h>
-#include <linux/io.h>
+#include <linux/irq.h>
 
-#include <asm/cpufeature.h>
-#include <asm/irqdomain.h>
-#include <asm/fixmap.h>
 #include <asm/hpet.h>
 #include <asm/time.h>
 
