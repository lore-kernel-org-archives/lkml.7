Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82451C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0D220815
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="0WhP1NS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfF0XtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:49:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45755 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfF0XtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:49:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RNn0vl503423
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 16:49:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RNn0vl503423
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561679341;
        bh=72MTXwqmz2exs8DUk8Urn0gxAnubLwtgfdQmE9JmzTw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=0WhP1NS+ZnR3HsqJWGtrh0kWv1fL5WbO8pzU9hW57aHFHaSXVsZ3gX5yklkunTt61
         HVSIJ09jfBunTAO5lPLyJwXaF8QhK/B9ALd19ch5s4n87enXwmY73wuHP/Q0xvuiZI
         9hpGj+tQXtr9wq0tr+f+DSNnjOUzebaJ4DTaaZfjmDRzdkgeOmZNuvVhez4BSnhNp1
         zxblD6Zv+Li/xAotfagBpTQL/gtAS1bPwfZYtLOzGL4/4vaQce4/0xtKKPHcnm/qZ1
         rX/QflpbeUA2gckc9C8T1W5S7CCfaX6tEeSuMsbT5+O5wH3UJE+U4bl+39DSvcFhJ9
         4HvmPFaYuc69A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RNn0n9503420;
        Thu, 27 Jun 2019 16:49:00 -0700
Date:   Thu, 27 Jun 2019 16:49:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-d415c7543140f77fe1d2d9d3942cbf51a9737993@git.kernel.org>
Cc:     hpa@zytor.com, ravi.v.shankar@intel.com,
        linux-kernel@vger.kernel.org, andi.kleen@intel.com,
        eranian@google.com, mingo@kernel.org,
        Suravee.Suthikulpanit@amd.com,
        ricardo.neri-calderon@linux.intel.com, peterz@infradead.org,
        tglx@linutronix.de, ashok.raj@intel.com
Reply-To: hpa@zytor.com, ricardo.neri-calderon@linux.intel.com,
          peterz@infradead.org, andi.kleen@intel.com,
          ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
          eranian@google.com, mingo@kernel.org, ashok.raj@intel.com,
          Suravee.Suthikulpanit@amd.com, tglx@linutronix.de
In-Reply-To: <20190623132436.093113681@linutronix.de>
References: <20190623132436.093113681@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/hpet: Rename variables to prepare for
 switching to channels
Git-Commit-ID: d415c7543140f77fe1d2d9d3942cbf51a9737993
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

Commit-ID:  d415c7543140f77fe1d2d9d3942cbf51a9737993
Gitweb:     https://git.kernel.org/tip/d415c7543140f77fe1d2d9d3942cbf51a9737993
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Sun, 23 Jun 2019 15:24:02 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:57:24 +0200

x86/hpet: Rename variables to prepare for switching to channels

struct hpet_dev is gone with the next change as the clockevent storage
moves into struct hpet_channel. So the variable name hdev will not make
sense anymore. Ditto for timer vs. channel and similar details.

Doing the rename in the change makes the patch harder to review. Doing it
afterward is problematic vs. tracking down issues.  Doing it upfront is the
easiest solution as it does not change functionality.

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
Link: https://lkml.kernel.org/r/20190623132436.093113681@linutronix.de

---
 arch/x86/kernel/hpet.c | 124 ++++++++++++++++++++++++-------------------------
 1 file changed, 62 insertions(+), 62 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 640ff75cc523..32f21b429881 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -315,7 +315,7 @@ static void hpet_legacy_clockevent_register(void)
 	pr_debug("Clockevent registered\n");
 }
 
-static int hpet_set_periodic(struct clock_event_device *evt, int timer)
+static int hpet_set_periodic(struct clock_event_device *evt, int channel)
 {
 	unsigned int cfg, cmp, now;
 	uint64_t delta;
@@ -325,11 +325,11 @@ static int hpet_set_periodic(struct clock_event_device *evt, int timer)
 	delta >>= evt->shift;
 	now = hpet_readl(HPET_COUNTER);
 	cmp = now + (unsigned int)delta;
-	cfg = hpet_readl(HPET_Tn_CFG(timer));
+	cfg = hpet_readl(HPET_Tn_CFG(channel));
 	cfg |= HPET_TN_ENABLE | HPET_TN_PERIODIC | HPET_TN_SETVAL |
 	       HPET_TN_32BIT;
-	hpet_writel(cfg, HPET_Tn_CFG(timer));
-	hpet_writel(cmp, HPET_Tn_CMP(timer));
+	hpet_writel(cfg, HPET_Tn_CFG(channel));
+	hpet_writel(cmp, HPET_Tn_CMP(channel));
 	udelay(1);
 	/*
 	 * HPET on AMD 81xx needs a second write (with HPET_TN_SETVAL
@@ -338,32 +338,32 @@ static int hpet_set_periodic(struct clock_event_device *evt, int timer)
 	 * (See AMD-8111 HyperTransport I/O Hub Data Sheet,
 	 * Publication # 24674)
 	 */
-	hpet_writel((unsigned int)delta, HPET_Tn_CMP(timer));
+	hpet_writel((unsigned int)delta, HPET_Tn_CMP(channel));
 	hpet_start_counter();
 	hpet_print_config();
 
 	return 0;
 }
 
-static int hpet_set_oneshot(struct clock_event_device *evt, int timer)
+static int hpet_set_oneshot(struct clock_event_device *evt, int channel)
 {
 	unsigned int cfg;
 
-	cfg = hpet_readl(HPET_Tn_CFG(timer));
+	cfg = hpet_readl(HPET_Tn_CFG(channel));
 	cfg &= ~HPET_TN_PERIODIC;
 	cfg |= HPET_TN_ENABLE | HPET_TN_32BIT;
-	hpet_writel(cfg, HPET_Tn_CFG(timer));
+	hpet_writel(cfg, HPET_Tn_CFG(channel));
 
 	return 0;
 }
 
-static int hpet_shutdown(struct clock_event_device *evt, int timer)
+static int hpet_shutdown(struct clock_event_device *evt, int channel)
 {
 	unsigned int cfg;
 
-	cfg = hpet_readl(HPET_Tn_CFG(timer));
+	cfg = hpet_readl(HPET_Tn_CFG(channel));
 	cfg &= ~HPET_TN_ENABLE;
-	hpet_writel(cfg, HPET_Tn_CFG(timer));
+	hpet_writel(cfg, HPET_Tn_CFG(channel));
 
 	return 0;
 }
@@ -460,30 +460,30 @@ static struct clock_event_device hpet_clockevent = {
 
 void hpet_msi_unmask(struct irq_data *data)
 {
-	struct hpet_dev *hdev = irq_data_get_irq_handler_data(data);
+	struct hpet_dev *hc = irq_data_get_irq_handler_data(data);
 	unsigned int cfg;
 
 	/* unmask it */
-	cfg = hpet_readl(HPET_Tn_CFG(hdev->num));
+	cfg = hpet_readl(HPET_Tn_CFG(hc->num));
 	cfg |= HPET_TN_ENABLE | HPET_TN_FSB;
-	hpet_writel(cfg, HPET_Tn_CFG(hdev->num));
+	hpet_writel(cfg, HPET_Tn_CFG(hc->num));
 }
 
 void hpet_msi_mask(struct irq_data *data)
 {
-	struct hpet_dev *hdev = irq_data_get_irq_handler_data(data);
+	struct hpet_dev *hc = irq_data_get_irq_handler_data(data);
 	unsigned int cfg;
 
 	/* mask it */
-	cfg = hpet_readl(HPET_Tn_CFG(hdev->num));
+	cfg = hpet_readl(HPET_Tn_CFG(hc->num));
 	cfg &= ~(HPET_TN_ENABLE | HPET_TN_FSB);
-	hpet_writel(cfg, HPET_Tn_CFG(hdev->num));
+	hpet_writel(cfg, HPET_Tn_CFG(hc->num));
 }
 
-void hpet_msi_write(struct hpet_dev *hdev, struct msi_msg *msg)
+void hpet_msi_write(struct hpet_dev *hc, struct msi_msg *msg)
 {
-	hpet_writel(msg->data, HPET_Tn_ROUTE(hdev->num));
-	hpet_writel(msg->address_lo, HPET_Tn_ROUTE(hdev->num) + 4);
+	hpet_writel(msg->data, HPET_Tn_ROUTE(hc->num));
+	hpet_writel(msg->address_lo, HPET_Tn_ROUTE(hc->num) + 4);
 }
 
 static int hpet_msi_shutdown(struct clock_event_device *evt)
@@ -503,13 +503,13 @@ static int hpet_msi_set_periodic(struct clock_event_device *evt)
 
 static int hpet_msi_resume(struct clock_event_device *evt)
 {
-	struct hpet_dev *hdev = clockevent_to_channel(evt);
-	struct irq_data *data = irq_get_irq_data(hdev->irq);
+	struct hpet_dev *hc = clockevent_to_channel(evt);
+	struct irq_data *data = irq_get_irq_data(hc->irq);
 	struct msi_msg msg;
 
 	/* Restore the MSI msg and unmask the interrupt */
 	irq_chip_compose_msi_msg(data, &msg);
-	hpet_msi_write(hdev, &msg);
+	hpet_msi_write(hc, &msg);
 	hpet_msi_unmask(data);
 	return 0;
 }
@@ -522,11 +522,11 @@ static int hpet_msi_next_event(unsigned long delta,
 
 static irqreturn_t hpet_interrupt_handler(int irq, void *data)
 {
-	struct hpet_dev *dev = data;
-	struct clock_event_device *evt = &dev->evt;
+	struct hpet_dev *hc = data;
+	struct clock_event_device *evt = &hc->evt;
 
 	if (!evt->event_handler) {
-		pr_info("Spurious interrupt HPET timer %d\n", dev->num);
+		pr_info("Spurious interrupt HPET channel %d\n", hc->num);
 		return IRQ_HANDLED;
 	}
 
@@ -551,22 +551,22 @@ static int hpet_setup_irq(struct hpet_dev *dev)
 	return 0;
 }
 
-static void init_one_hpet_msi_clockevent(struct hpet_dev *hdev, int cpu)
+static void init_one_hpet_msi_clockevent(struct hpet_dev *hc, int cpu)
 {
-	struct clock_event_device *evt = &hdev->evt;
+	struct clock_event_device *evt = &hc->evt;
 
-	if (!(hdev->flags & HPET_DEV_VALID))
+	if (!(hc->flags & HPET_DEV_VALID))
 		return;
 
-	hdev->cpu = cpu;
-	per_cpu(cpu_hpet_dev, cpu) = hdev;
-	evt->name = hdev->name;
-	hpet_setup_irq(hdev);
-	evt->irq = hdev->irq;
+	hc->cpu = cpu;
+	per_cpu(cpu_hpet_dev, cpu) = hc;
+	evt->name = hc->name;
+	hpet_setup_irq(hc);
+	evt->irq = hc->irq;
 
 	evt->rating = 110;
 	evt->features = CLOCK_EVT_FEAT_ONESHOT;
-	if (hdev->flags & HPET_DEV_PERI_CAP) {
+	if (hc->flags & HPET_DEV_PERI_CAP) {
 		evt->features |= CLOCK_EVT_FEAT_PERIODIC;
 		evt->set_state_periodic = hpet_msi_set_periodic;
 	}
@@ -575,7 +575,7 @@ static void init_one_hpet_msi_clockevent(struct hpet_dev *hdev, int cpu)
 	evt->set_state_oneshot = hpet_msi_set_oneshot;
 	evt->tick_resume = hpet_msi_resume;
 	evt->set_next_event = hpet_msi_next_event;
-	evt->cpumask = cpumask_of(hdev->cpu);
+	evt->cpumask = cpumask_of(hc->cpu);
 
 	clockevents_config_and_register(evt, hpet_freq, HPET_MIN_PROG_DELTA,
 					0x7FFFFFFF);
@@ -589,35 +589,35 @@ static struct hpet_dev *hpet_get_unused_timer(void)
 		return NULL;
 
 	for (i = 0; i < hpet_base.nr_channels; i++) {
-		struct hpet_dev *hdev = &hpet_devs[i];
+		struct hpet_dev *hc = &hpet_devs[i];
 
-		if (!(hdev->flags & HPET_DEV_VALID))
+		if (!(hc->flags & HPET_DEV_VALID))
 			continue;
 		if (test_and_set_bit(HPET_DEV_USED_BIT,
-			(unsigned long *)&hdev->flags))
+			(unsigned long *)&hc->flags))
 			continue;
-		return hdev;
+		return hc;
 	}
 	return NULL;
 }
 
 static int hpet_cpuhp_online(unsigned int cpu)
 {
-	struct hpet_dev *hdev = hpet_get_unused_timer();
+	struct hpet_dev *hc = hpet_get_unused_timer();
 
-	if (hdev)
-		init_one_hpet_msi_clockevent(hdev, cpu);
+	if (hc)
+		init_one_hpet_msi_clockevent(hc, cpu);
 	return 0;
 }
 
 static int hpet_cpuhp_dead(unsigned int cpu)
 {
-	struct hpet_dev *hdev = per_cpu(cpu_hpet_dev, cpu);
+	struct hpet_dev *hc = per_cpu(cpu_hpet_dev, cpu);
 
-	if (!hdev)
+	if (!hc)
 		return 0;
-	free_irq(hdev->irq, hdev);
-	hdev->flags &= ~HPET_DEV_USED;
+	free_irq(hc->irq, hc);
+	hc->flags &= ~HPET_DEV_USED;
 	per_cpu(cpu_hpet_dev, cpu) = NULL;
 	return 0;
 }
@@ -653,26 +653,26 @@ static void __init hpet_msi_capability_lookup(unsigned int start_timer)
 		return;
 
 	for (i = start_timer; i < num_timers - RESERVE_TIMERS; i++) {
-		struct hpet_dev *hdev = &hpet_devs[num_timers_used];
+		struct hpet_dev *hc = &hpet_devs[num_timers_used];
 		unsigned int cfg = hpet_base.channels[i].boot_cfg;
 
 		/* Only consider HPET timer with MSI support */
 		if (!(cfg & HPET_TN_FSB_CAP))
 			continue;
 
-		hdev->flags = 0;
+		hc->flags = 0;
 		if (cfg & HPET_TN_PERIODIC_CAP)
-			hdev->flags |= HPET_DEV_PERI_CAP;
-		sprintf(hdev->name, "hpet%d", i);
-		hdev->num = i;
+			hc->flags |= HPET_DEV_PERI_CAP;
+		sprintf(hc->name, "hpet%d", i);
+		hc->num = i;
 
-		irq = hpet_assign_irq(hpet_domain, hdev, hdev->num);
+		irq = hpet_assign_irq(hpet_domain, hc, hc->num);
 		if (irq <= 0)
 			continue;
 
-		hdev->irq = irq;
-		hdev->flags |= HPET_DEV_FSB_CAP;
-		hdev->flags |= HPET_DEV_VALID;
+		hc->irq = irq;
+		hc->flags |= HPET_DEV_FSB_CAP;
+		hc->flags |= HPET_DEV_VALID;
 		num_timers_used++;
 		if (num_timers_used == num_possible_cpus())
 			break;
@@ -691,13 +691,13 @@ static void __init hpet_reserve_msi_timers(struct hpet_data *hd)
 		return;
 
 	for (i = 0; i < hpet_base.nr_channels; i++) {
-		struct hpet_dev *hdev = &hpet_devs[i];
+		struct hpet_dev *hc = &hpet_devs[i];
 
-		if (!(hdev->flags & HPET_DEV_VALID))
+		if (!(hc->flags & HPET_DEV_VALID))
 			continue;
 
-		hd->hd_irq[hdev->num] = hdev->irq;
-		hpet_reserve_timer(hd, hdev->num);
+		hd->hd_irq[hc->num] = hc->irq;
+		hpet_reserve_timer(hd, hc->num);
 	}
 }
 #endif
@@ -1138,8 +1138,8 @@ void hpet_unregister_irq_handler(rtc_irq_handler handler)
 EXPORT_SYMBOL_GPL(hpet_unregister_irq_handler);
 
 /*
- * Timer 1 for RTC emulation. We use one shot mode, as periodic mode
- * is not supported by all HPET implementations for timer 1.
+ * Channel 1 for RTC emulation. We use one shot mode, as periodic mode
+ * is not supported by all HPET implementations for channel 1.
  *
  * hpet_rtc_timer_init() is called when the rtc is initialized.
  */
