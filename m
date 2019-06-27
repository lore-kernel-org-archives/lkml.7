Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CF6C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B6420644
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Wgmd4fN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfF0XsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:48:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46079 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfF0XsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:48:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RNi3GJ501016
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 16:44:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RNi3GJ501016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561679044;
        bh=ztcfVep4YgUzQuTwJAXyiT7pO61v+JVCeg5o0z8InNM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Wgmd4fN2RSJLtKYXy7VeX3nDJNT0v+tGbDYguzaKrs3sFn1/01Rtl9gK+/VosQv4B
         znCErsklAzn/25qNs4nqDbwnMR8YOhRXFpkeJ+1YYFVtmq2o+Nnm2Mv4l/x0w1XBDi
         qXct4pRtyh1KMuOaKJKOpWi4F0k718dmsEsF8XtX77HJ7DgaBQhPgke3sCHNsMseuD
         5aea1Ynhaoep/yKftItAPYzC9kYjHVI7Ig7BTEUn7bUWLo78EQ5U8ius/fih/76zcm
         3mjIpYxSFQq+B/9oyHpSOUSpShlu6OglKJk8PAZb5FncARalhYznYKjgkERFccLJbu
         pYQD9LlY42rHQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RNi2Ti500991;
        Thu, 27 Jun 2019 16:44:02 -0700
Date:   Thu, 27 Jun 2019 16:44:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-3fe50c34dc1fa8ae2c24ec202b9decbbef72921d@git.kernel.org>
Cc:     eranian@google.com, Suravee.Suthikulpanit@amd.com,
        linux-kernel@vger.kernel.org,
        ricardo.neri-calderon@linux.intel.com, mingo@kernel.org,
        andi.kleen@intel.com, hpa@zytor.com, ashok.raj@intel.com,
        tglx@linutronix.de, peterz@infradead.org, ravi.v.shankar@intel.com
Reply-To: tglx@linutronix.de, hpa@zytor.com, ashok.raj@intel.com,
          andi.kleen@intel.com, mingo@kernel.org, ravi.v.shankar@intel.com,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          eranian@google.com, Suravee.Suthikulpanit@amd.com,
          ricardo.neri-calderon@linux.intel.com
In-Reply-To: <20190623132435.454138339@linutronix.de>
References: <20190623132435.454138339@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/hpet: Make naming consistent
Git-Commit-ID: 3fe50c34dc1fa8ae2c24ec202b9decbbef72921d
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

Commit-ID:  3fe50c34dc1fa8ae2c24ec202b9decbbef72921d
Gitweb:     https://git.kernel.org/tip/3fe50c34dc1fa8ae2c24ec202b9decbbef72921d
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Sun, 23 Jun 2019 15:23:55 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:57:20 +0200

x86/hpet: Make naming consistent

Use 'evt' for clockevents pointers and capitalize HPET in comments.

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
Link: https://lkml.kernel.org/r/20190623132435.454138339@linutronix.de

---
 arch/x86/kernel/hpet.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 96daae404b29..823e8d32182a 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -121,7 +121,7 @@ static inline int is_hpet_capable(void)
 }
 
 /**
- * is_hpet_enabled - check whether the hpet timer interrupt is enabled
+ * is_hpet_enabled - Check whether the legacy HPET timer interrupt is enabled
  */
 int is_hpet_enabled(void)
 {
@@ -164,7 +164,7 @@ do {								\
 } while (0)
 
 /*
- * When the hpet driver (/dev/hpet) is enabled, we need to reserve
+ * When the HPET driver (/dev/hpet) is enabled, we need to reserve
  * timer 0 and timer 1 in case of RTC emulation.
  */
 #ifdef CONFIG_HPET
@@ -212,7 +212,7 @@ static void __init hpet_reserve_platform_timers(unsigned int id)
 static void hpet_reserve_platform_timers(unsigned int id) { }
 #endif
 
-/* Common hpet functions */
+/* Common HPET functions */
 static void hpet_stop_counter(void)
 {
 	u32 cfg = hpet_readl(HPET_CFG);
@@ -266,7 +266,7 @@ static void hpet_legacy_clockevent_register(void)
 	hpet_enable_legacy_int();
 
 	/*
-	 * Start hpet with the boot cpu mask and make it
+	 * Start HPET with the boot cpu mask and make it
 	 * global after the IO_APIC has been initialized.
 	 */
 	hpet_clockevent.cpumask = cpumask_of(boot_cpu_data.cpu_index);
@@ -399,7 +399,7 @@ static int hpet_legacy_next_event(unsigned long delta,
 }
 
 /*
- * The hpet clock event device
+ * The HPET clock event device
  */
 static struct clock_event_device hpet_clockevent = {
 	.name			= "hpet",
@@ -484,14 +484,14 @@ static int hpet_msi_next_event(unsigned long delta,
 static irqreturn_t hpet_interrupt_handler(int irq, void *data)
 {
 	struct hpet_dev *dev = data;
-	struct clock_event_device *hevt = &dev->evt;
+	struct clock_event_device *evt = &dev->evt;
 
-	if (!hevt->event_handler) {
+	if (!evt->event_handler) {
 		pr_info("Spurious interrupt HPET timer %d\n", dev->num);
 		return IRQ_HANDLED;
 	}
 
-	hevt->event_handler(hevt);
+	evt->event_handler(evt);
 	return IRQ_HANDLED;
 }
 
@@ -703,7 +703,7 @@ static inline void hpet_reserve_msi_timers(struct hpet_data *hd) { }
  * with its associated locking overhead. And we also need 64-bit atomic
  * read.
  *
- * The lock and the hpet value are stored together and can be read in a
+ * The lock and the HPET value are stored together and can be read in a
  * single atomic 64-bit read. It is explicitly assumed that arch_spinlock_t
  * is 32 bits in size.
  */
@@ -1053,7 +1053,7 @@ static unsigned long hpet_pie_limit;
 static rtc_irq_handler irq_handler;
 
 /*
- * Check that the hpet counter c1 is ahead of the c2
+ * Check that the HPET counter c1 is ahead of the c2
  */
 static inline int hpet_cnt_ahead(u32 c1, u32 c2)
 {
