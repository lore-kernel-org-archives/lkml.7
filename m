Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02263C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF22122BED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="sdkkufIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388049AbfGYOZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:25:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44181 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfGYOZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:25:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PEPCk71039726
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 07:25:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PEPCk71039726
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564064713;
        bh=pJFBqu0KlzfcdyjUhP1o+3MD7G1jYiQMgHmknMA0PW4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=sdkkufIyt81jS9jSG7Fl4YtuP+IlWKyYKMPdIj49SKLJlBlYO9icI3rWio51y9oY9
         bvJH5YbBR7meSZarh2sndtkfAs8p9uVEJr1bHTgnGbXM54uxo2WuH+MILwSDtOQiT+
         s+6dmxWQJCJicxJNmuvX/kFDCwVKzP1HT5YTnNelU5Eu1PFJcHKxCOJFBwYOIBdAhK
         xWtQ34aLldaST4DojJp9EJgSBFjwxG0hZSXE7wF6UBfD9IcVCYZHrCxE9+mB7QReoI
         inYbXFfjAOCs5zNlZ0uGZs2rfq687tgg2cHQMjVtK0HFf9IwzNU99aTKv75IyyJNLR
         VYOt7kkYZYgKQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PEPC891039722;
        Thu, 25 Jul 2019 07:25:12 -0700
Date:   Thu, 25 Jul 2019 07:25:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-8b542da372875373db9688477671151df3418acb@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, peterz@infradead.org,
        tglx@linutronix.de, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com,
          peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <20190722105219.434738036@linutronix.de>
References: <20190722105219.434738036@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Move ipi header into apic directory
Git-Commit-ID: 8b542da372875373db9688477671151df3418acb
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

Commit-ID:  8b542da372875373db9688477671151df3418acb
Gitweb:     https://git.kernel.org/tip/8b542da372875373db9688477671151df3418acb
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 22 Jul 2019 20:47:12 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 25 Jul 2019 16:11:57 +0200

x86/apic: Move ipi header into apic directory

Only used locally.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190722105219.434738036@linutronix.de

---
 arch/x86/kernel/apic/apic_flat_64.c         | 3 ++-
 arch/x86/kernel/apic/apic_numachip.c        | 3 ++-
 arch/x86/kernel/apic/bigsmp_32.c            | 9 ++-------
 arch/x86/kernel/apic/ipi.c                  | 3 ++-
 arch/x86/{include/asm => kernel/apic}/ipi.h | 0
 arch/x86/kernel/apic/probe_32.c             | 3 ++-
 arch/x86/kernel/apic/probe_64.c             | 3 ++-
 arch/x86/kernel/apic/x2apic_phys.c          | 3 +--
 8 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index 8d7242df1fd6..a38b1ecc018d 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -15,7 +15,8 @@
 #include <asm/jailhouse_para.h>
 #include <asm/apic_flat_64.h>
 #include <asm/apic.h>
-#include <asm/ipi.h>
+
+#include "ipi.h"
 
 static struct apic apic_physflat;
 static struct apic apic_flat;
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index e071e8dcb097..7d4c00f4e984 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -18,7 +18,8 @@
 
 #include <asm/apic_flat_64.h>
 #include <asm/pgtable.h>
-#include <asm/ipi.h>
+
+#include "ipi.h"
 
 u8 numachip_system __read_mostly;
 static const struct apic apic_numachip1;
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index afee386ff711..2c031b75dfce 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -4,18 +4,13 @@
  *
  * Drives the local APIC in "clustered mode".
  */
-#include <linux/threads.h>
 #include <linux/cpumask.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/dmi.h>
 #include <linux/smp.h>
 
-#include <asm/apicdef.h>
-#include <asm/fixmap.h>
-#include <asm/mpspec.h>
 #include <asm/apic.h>
-#include <asm/ipi.h>
+
+#include "ipi.h"
 
 static unsigned bigsmp_get_apic_id(unsigned long x)
 {
diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index dad523bbe701..0f26141d479c 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -3,7 +3,8 @@
 #include <linux/cpumask.h>
 
 #include <asm/apic.h>
-#include <asm/ipi.h>
+
+#include "ipi.h"
 
 void __default_send_IPI_shortcut(unsigned int shortcut, int vector, unsigned int dest)
 {
diff --git a/arch/x86/include/asm/ipi.h b/arch/x86/kernel/apic/ipi.h
similarity index 100%
rename from arch/x86/include/asm/ipi.h
rename to arch/x86/kernel/apic/ipi.h
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 8f3c7f50b0a9..40b786e3427a 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -11,7 +11,8 @@
 
 #include <asm/apic.h>
 #include <asm/acpi.h>
-#include <asm/ipi.h>
+
+#include "ipi.h"
 
 #ifdef CONFIG_HOTPLUG_CPU
 #define DEFAULT_SEND_IPI	(1)
diff --git a/arch/x86/kernel/apic/probe_64.c b/arch/x86/kernel/apic/probe_64.c
index f7bd3f48deb2..6268c487f963 100644
--- a/arch/x86/kernel/apic/probe_64.c
+++ b/arch/x86/kernel/apic/probe_64.c
@@ -9,7 +9,8 @@
  * James Cleverdon.
  */
 #include <asm/apic.h>
-#include <asm/ipi.h>
+
+#include "ipi.h"
 
 /*
  * Check the APIC IDs in bios_cpu_apicid and choose the APIC mode.
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index e5289a0c595b..3bde4724c1c7 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -3,9 +3,8 @@
 #include <linux/cpumask.h>
 #include <linux/acpi.h>
 
-#include <asm/ipi.h>
-
 #include "x2apic.h"
+#include "ipi.h"
 
 int x2apic_phys;
 
