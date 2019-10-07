Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE75C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D779721479
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbfJGOvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:51:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44477 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbfJGOtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:49:41 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iHUKM-0006Cc-ON; Mon, 07 Oct 2019 16:49:34 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3A25E1C032F;
        Mon,  7 Oct 2019 16:49:32 +0200 (CEST)
Date:   Mon, 07 Oct 2019 14:49:32 -0000
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Return UV Hubless System Type
Cc:     Mike Travis <mike.travis@hpe.com>, Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hedi Berriche <hedi.berriche@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20190910145839.814880843@stormcage.eag.rdlabs.hpecorp.net>
References: <20190910145839.814880843@stormcage.eag.rdlabs.hpecorp.net>
MIME-Version: 1.0
Message-ID: <157045977216.9978.15019848455992775260.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     0959f8256ada0431c1470d89e5a2811ff2305c88
Gitweb:        https://git.kernel.org/tip/0959f8256ada0431c1470d89e5a2811ff2305c88
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Tue, 10 Sep 2019 09:58:41 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 07 Oct 2019 13:42:10 +02:00

x86/platform/uv: Return UV Hubless System Type

Return the type of UV hubless system for UV specific code that depends
on that.  Add a function to convert UV system type to bit pattern needed
for is_uv_hubless().

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Hedi Berriche <hedi.berriche@hpe.com>
Cc: Justin Ernst <justin.ernst@hpe.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russ Anderson <russ.anderson@hpe.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190910145839.814880843@stormcage.eag.rdlabs.hpecorp.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/uv/uv.h       | 12 ++++++++++--
 arch/x86/kernel/apic/x2apic_uv_x.c | 27 ++++++++++++++++++---------
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv.h b/arch/x86/include/asm/uv/uv.h
index 6bc6d89..792faab 100644
--- a/arch/x86/include/asm/uv/uv.h
+++ b/arch/x86/include/asm/uv/uv.h
@@ -12,6 +12,14 @@ struct mm_struct;
 #ifdef CONFIG_X86_UV
 #include <linux/efi.h>
 
+static inline int uv(int uvtype)
+{
+	/* uv(0) is "any" */
+	if (uvtype >= 0 && uvtype <= 30)
+		return 1 << uvtype;
+	return 1;
+}
+
 extern unsigned long uv_systab_phys;
 
 extern enum uv_system_type get_uv_system_type(void);
@@ -20,7 +28,7 @@ static inline bool is_early_uv_system(void)
 	return uv_systab_phys && uv_systab_phys != EFI_INVALID_TABLE_ADDR;
 }
 extern int is_uv_system(void);
-extern int is_uv_hubless(void);
+extern int is_uv_hubless(int uvtype);
 extern void uv_cpu_init(void);
 extern void uv_nmi_init(void);
 extern void uv_system_init(void);
@@ -32,7 +40,7 @@ extern const struct cpumask *uv_flush_tlb_others(const struct cpumask *cpumask,
 static inline enum uv_system_type get_uv_system_type(void) { return UV_NONE; }
 static inline bool is_early_uv_system(void)	{ return 0; }
 static inline int is_uv_system(void)	{ return 0; }
-static inline int is_uv_hubless(void)	{ return 0; }
+static inline int is_uv_hubless(int uv) { return 0; }
 static inline void uv_cpu_init(void)	{ }
 static inline void uv_system_init(void)	{ }
 static inline const struct cpumask *
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 66b38a6..43fad61 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -26,7 +26,7 @@
 static DEFINE_PER_CPU(int, x2apic_extra_bits);
 
 static enum uv_system_type	uv_system_type;
-static bool			uv_hubless_system;
+static int			uv_hubless_system;
 static u64			gru_start_paddr, gru_end_paddr;
 static u64			gru_dist_base, gru_first_node_paddr = -1LL, gru_last_node_paddr;
 static u64			gru_dist_lmask, gru_dist_umask;
@@ -268,11 +268,20 @@ static int __init uv_acpi_madt_oem_check(char *_oem_id, char *_oem_table_id)
 	uv_stringify(sizeof(oem_table_id), oem_table_id, _oem_table_id);
 
 	if (strncmp(oem_id, "SGI", 3) != 0) {
-		if (strncmp(oem_id, "NSGI", 4) == 0) {
-			uv_hubless_system = true;
-			pr_info("UV: OEM IDs %s/%s, HUBLESS\n",
-				oem_id, oem_table_id);
-		}
+		if (strncmp(oem_id, "NSGI", 4) != 0)
+			return 0;
+
+		/* UV4 Hubless, CH, (0x11:UV4+Any) */
+		if (strncmp(oem_id, "NSGI4", 5) == 0)
+			uv_hubless_system = 0x11;
+
+		/* UV3 Hubless, UV300/MC990X w/o hub (0x9:UV3+Any) */
+		else
+			uv_hubless_system = 0x9;
+
+		pr_info("UV: OEM IDs %s/%s, HUBLESS(0x%x)\n",
+			oem_id, oem_table_id, uv_hubless_system);
+
 		return 0;
 	}
 
@@ -350,9 +359,9 @@ int is_uv_system(void)
 }
 EXPORT_SYMBOL_GPL(is_uv_system);
 
-int is_uv_hubless(void)
+int is_uv_hubless(int uvtype)
 {
-	return uv_hubless_system;
+	return (uv_hubless_system & uvtype);
 }
 EXPORT_SYMBOL_GPL(is_uv_hubless);
 
@@ -1592,7 +1601,7 @@ static void __init uv_system_init_hub(void)
  */
 void __init uv_system_init(void)
 {
-	if (likely(!is_uv_system() && !is_uv_hubless()))
+	if (likely(!is_uv_system() && !is_uv_hubless(1)))
 		return;
 
 	if (is_uv_system())
