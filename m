Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476AFC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD0B208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="v4Bs36j8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfF0XpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:45:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39167 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfF0XpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:45:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RNikqc502623
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 16:44:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RNikqc502623
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561679087;
        bh=8BgcgsUoFPHcHKYAGcp/63nOLlhb5USpoi/Da8iac1c=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=v4Bs36j8cp7NIbiqbhUGJiRGP/rgM5ngOUyUl2OZ8tWBO+TrOeQrF2dQv5nvFHm3/
         o2smkFGYpxMrJp/FdL+tM6z3jgmf6k7t8Mb7uhrmiqsv5gjGEURXHZPIpZc62EQM1T
         sgS9eSIM4u2Gs4NO2aFH5HCdgNqqYv99QkpkgCFtKYBL5tYPQTr57fPJk65ZnU+n+w
         tARfJEJyIWF52P3Q7b518S2OYBxh19HVudimnBWWJupck3Pua8XDSXj4KXi53ygpzS
         6nH7L3qiMozxvp8708JY76fDy1X09Qi3aKL1UZaJw+iZ/Aikg6SWJiq1jDC9mt1PO9
         iUGxOr1ZOj/ew==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RNikuh502620;
        Thu, 27 Jun 2019 16:44:46 -0700
Date:   Thu, 27 Jun 2019 16:44:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-dfe36b573ed320ce311b2cb9251d2543be9e52ac@git.kernel.org>
Cc:     hpa@zytor.com, andi.kleen@intel.com, Suravee.Suthikulpanit@amd.com,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        tglx@linutronix.de, ravi.v.shankar@intel.com, eranian@google.com,
        mingo@kernel.org, ricardo.neri-calderon@linux.intel.com,
        peterz@infradead.org
Reply-To: peterz@infradead.org, ricardo.neri-calderon@linux.intel.com,
          mingo@kernel.org, tglx@linutronix.de, ravi.v.shankar@intel.com,
          eranian@google.com, ashok.raj@intel.com,
          Suravee.Suthikulpanit@amd.com, linux-kernel@vger.kernel.org,
          andi.kleen@intel.com, hpa@zytor.com
In-Reply-To: <20190623132435.545653922@linutronix.de>
References: <20190623132435.545653922@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/hpet: Clean up comments
Git-Commit-ID: dfe36b573ed320ce311b2cb9251d2543be9e52ac
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

Commit-ID:  dfe36b573ed320ce311b2cb9251d2543be9e52ac
Gitweb:     https://git.kernel.org/tip/dfe36b573ed320ce311b2cb9251d2543be9e52ac
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Sun, 23 Jun 2019 15:23:56 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:57:20 +0200

x86/hpet: Clean up comments

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
Link: https://lkml.kernel.org/r/20190623132435.545653922@linutronix.de

---
 arch/x86/kernel/hpet.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 823e8d32182a..1a389a2ff42a 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -266,8 +266,8 @@ static void hpet_legacy_clockevent_register(void)
 	hpet_enable_legacy_int();
 
 	/*
-	 * Start HPET with the boot cpu mask and make it
-	 * global after the IO_APIC has been initialized.
+	 * Start HPET with the boot CPU's cpumask and make it global after
+	 * the IO_APIC has been initialized.
 	 */
 	hpet_clockevent.cpumask = cpumask_of(boot_cpu_data.cpu_index);
 	clockevents_config_and_register(&hpet_clockevent, hpet_freq,
@@ -688,10 +688,10 @@ static inline void hpet_reserve_msi_timers(struct hpet_data *hd) { }
 /*
  * Reading the HPET counter is a very slow operation. If a large number of
  * CPUs are trying to access the HPET counter simultaneously, it can cause
- * massive delay and slow down system performance dramatically. This may
+ * massive delays and slow down system performance dramatically. This may
  * happen when HPET is the default clock source instead of TSC. For a
  * really large system with hundreds of CPUs, the slowdown may be so
- * severe that it may actually crash the system because of a NMI watchdog
+ * severe, that it can actually crash the system because of a NMI watchdog
  * soft lockup, for example.
  *
  * If multiple CPUs are trying to access the HPET counter at the same time,
@@ -700,8 +700,7 @@ static inline void hpet_reserve_msi_timers(struct hpet_data *hd) { }
  *
  * This special feature is only enabled on x86-64 systems. It is unlikely
  * that 32-bit x86 systems will have enough CPUs to require this feature
- * with its associated locking overhead. And we also need 64-bit atomic
- * read.
+ * with its associated locking overhead. We also need 64-bit atomic read.
  *
  * The lock and the HPET value are stored together and can be read in a
  * single atomic 64-bit read. It is explicitly assumed that arch_spinlock_t
@@ -1020,19 +1019,25 @@ void hpet_disable(void)
 
 #ifdef CONFIG_HPET_EMULATE_RTC
 
-/* HPET in LegacyReplacement Mode eats up RTC interrupt line. When, HPET
+/*
+ * HPET in LegacyReplacement mode eats up the RTC interrupt line. When HPET
  * is enabled, we support RTC interrupt functionality in software.
+ *
  * RTC has 3 kinds of interrupts:
- * 1) Update Interrupt - generate an interrupt, every sec, when RTC clock
- *    is updated
- * 2) Alarm Interrupt - generate an interrupt at a specific time of day
- * 3) Periodic Interrupt - generate periodic interrupt, with frequencies
- *    2Hz-8192Hz (2Hz-64Hz for non-root user) (all freqs in powers of 2)
- * (1) and (2) above are implemented using polling at a frequency of
- * 64 Hz. The exact frequency is a tradeoff between accuracy and interrupt
- * overhead. (DEFAULT_RTC_INT_FREQ)
- * For (3), we use interrupts at 64Hz or user specified periodic
- * frequency, whichever is higher.
+ *
+ *  1) Update Interrupt - generate an interrupt, every second, when the
+ *     RTC clock is updated
+ *  2) Alarm Interrupt - generate an interrupt at a specific time of day
+ *  3) Periodic Interrupt - generate periodic interrupt, with frequencies
+ *     2Hz-8192Hz (2Hz-64Hz for non-root user) (all frequencies in powers of 2)
+ *
+ * (1) and (2) above are implemented using polling at a frequency of 64 Hz:
+ * DEFAULT_RTC_INT_FREQ.
+ *
+ * The exact frequency is a tradeoff between accuracy and interrupt overhead.
+ *
+ * For (3), we use interrupts at 64 Hz, or the user specified periodic frequency,
+ * if it's higher.
  */
 #include <linux/mc146818rtc.h>
 #include <linux/rtc.h>
@@ -1053,7 +1058,7 @@ static unsigned long hpet_pie_limit;
 static rtc_irq_handler irq_handler;
 
 /*
- * Check that the HPET counter c1 is ahead of the c2
+ * Check that the HPET counter c1 is ahead of c2
  */
 static inline int hpet_cnt_ahead(u32 c1, u32 c2)
 {
