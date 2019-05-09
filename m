Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C974C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 10:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF1021744
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 10:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="A9lhl4yd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfEIKfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 06:35:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40405 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfEIKfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 06:35:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x49AYkN01505233
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 9 May 2019 03:34:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x49AYkN01505233
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1557398087;
        bh=4h8sonMNFC6y1O6N2fhevK1zMv2CXseXnnpSknCSmQ0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=A9lhl4ydOQXwFRN42hx54tuQ37V9yT5tSyb86hPA7hfmcr90w1TNhPVgt9o+EPG1w
         45ReQA+ezdzNVQODuZST895gkD+2P/919jINaPZb1h6aqGQR4rcMbeaVMqR2vgY5cP
         wyf7FAdhtTH2gp7FHX8GjHsFiw296j2VAiisL7b8zWCV6xiSla5gmFl/NJkqAyKNZb
         lbNNWy/Dm7wH9W/8C5mYMY7B8EvO4wU0szc8dcrZRSEx6r92LHnkKEYiHoBa2VkcN9
         8f8rEFxybHQ/FS6Pex8IEEjQoUz5t7SnRPBU8yiEOlOfbMX3iVhDVUDW6fBr6SYq8S
         Bblic+1hU7YgQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x49AYktB1505230;
        Thu, 9 May 2019 03:34:46 -0700
Date:   Thu, 9 May 2019 03:34:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Daniel Drake <tipbot@zytor.com>
Message-ID: <tip-52ae346bd26c7a8b17ea82e9a09671e98c5402b7@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, drake@endlessm.com,
        torvalds@linux-foundation.org, bp@alien8.de, peterz@infradead.org,
        tglx@linutronix.de, luto@kernel.org, mingo@kernel.org
Reply-To: mingo@kernel.org, luto@kernel.org, tglx@linutronix.de,
          bp@alien8.de, peterz@infradead.org,
          torvalds@linux-foundation.org, drake@endlessm.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20190509055417.13152-2-drake@endlessm.com>
References: <20190509055417.13152-2-drake@endlessm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Rename 'lapic_timer_frequency' to
 'lapic_timer_period'
Git-Commit-ID: 52ae346bd26c7a8b17ea82e9a09671e98c5402b7
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

Commit-ID:  52ae346bd26c7a8b17ea82e9a09671e98c5402b7
Gitweb:     https://git.kernel.org/tip/52ae346bd26c7a8b17ea82e9a09671e98c5402b7
Author:     Daniel Drake <drake@endlessm.com>
AuthorDate: Thu, 9 May 2019 13:54:16 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 9 May 2019 11:06:49 +0200

x86/apic: Rename 'lapic_timer_frequency' to 'lapic_timer_period'

This variable is a period unit (number of clock cycles per jiffy),
not a frequency (which is number of cycles per second).

Give it a more appropriate name.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: len.brown@intel.com
Cc: linux@endlessm.com
Cc: rafael.j.wysocki@intel.com
Link: http://lkml.kernel.org/r/20190509055417.13152-2-drake@endlessm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/apic.h    |  2 +-
 arch/x86/kernel/apic/apic.c    | 20 ++++++++++----------
 arch/x86/kernel/cpu/mshyperv.c |  4 ++--
 arch/x86/kernel/cpu/vmware.c   |  2 +-
 arch/x86/kernel/jailhouse.c    |  2 +-
 arch/x86/kernel/tsc_msr.c      |  4 ++--
 6 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 130e81e10fc7..fc505a84aa93 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -52,7 +52,7 @@ extern unsigned int apic_verbosity;
 extern int local_apic_timer_c2_ok;
 
 extern int disable_apic;
-extern unsigned int lapic_timer_frequency;
+extern unsigned int lapic_timer_period;
 
 extern enum apic_intr_mode_id apic_intr_mode;
 enum apic_intr_mode_id {
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index ab6af775f06c..93de7862eef8 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -194,7 +194,7 @@ static struct resource lapic_resource = {
 	.flags = IORESOURCE_MEM | IORESOURCE_BUSY,
 };
 
-unsigned int lapic_timer_frequency = 0;
+unsigned int lapic_timer_period = 0;
 
 static void apic_pm_activate(void);
 
@@ -500,7 +500,7 @@ lapic_timer_set_periodic_oneshot(struct clock_event_device *evt, bool oneshot)
 	if (evt->features & CLOCK_EVT_FEAT_DUMMY)
 		return 0;
 
-	__setup_APIC_LVTT(lapic_timer_frequency, oneshot, 1);
+	__setup_APIC_LVTT(lapic_timer_period, oneshot, 1);
 	return 0;
 }
 
@@ -804,11 +804,11 @@ calibrate_by_pmtimer(long deltapm, long *delta, long *deltatsc)
 
 static int __init lapic_init_clockevent(void)
 {
-	if (!lapic_timer_frequency)
+	if (!lapic_timer_period)
 		return -1;
 
 	/* Calculate the scaled math multiplication factor */
-	lapic_clockevent.mult = div_sc(lapic_timer_frequency/APIC_DIVISOR,
+	lapic_clockevent.mult = div_sc(lapic_timer_period/APIC_DIVISOR,
 					TICK_NSEC, lapic_clockevent.shift);
 	lapic_clockevent.max_delta_ns =
 		clockevent_delta2ns(0x7FFFFFFF, &lapic_clockevent);
@@ -838,7 +838,7 @@ static int __init calibrate_APIC_clock(void)
 	 */
 	if (!lapic_init_clockevent()) {
 		apic_printk(APIC_VERBOSE, "lapic timer already calibrated %d\n",
-			    lapic_timer_frequency);
+			    lapic_timer_period);
 		/*
 		 * Direct calibration methods must have an always running
 		 * local APIC timer, no need for broadcast timer.
@@ -883,13 +883,13 @@ static int __init calibrate_APIC_clock(void)
 	pm_referenced = !calibrate_by_pmtimer(lapic_cal_pm2 - lapic_cal_pm1,
 					&delta, &deltatsc);
 
-	lapic_timer_frequency = (delta * APIC_DIVISOR) / LAPIC_CAL_LOOPS;
+	lapic_timer_period = (delta * APIC_DIVISOR) / LAPIC_CAL_LOOPS;
 	lapic_init_clockevent();
 
 	apic_printk(APIC_VERBOSE, "..... delta %ld\n", delta);
 	apic_printk(APIC_VERBOSE, "..... mult: %u\n", lapic_clockevent.mult);
 	apic_printk(APIC_VERBOSE, "..... calibration result: %u\n",
-		    lapic_timer_frequency);
+		    lapic_timer_period);
 
 	if (boot_cpu_has(X86_FEATURE_TSC)) {
 		apic_printk(APIC_VERBOSE, "..... CPU clock speed is "
@@ -900,13 +900,13 @@ static int __init calibrate_APIC_clock(void)
 
 	apic_printk(APIC_VERBOSE, "..... host bus clock speed is "
 		    "%u.%04u MHz.\n",
-		    lapic_timer_frequency / (1000000 / HZ),
-		    lapic_timer_frequency % (1000000 / HZ));
+		    lapic_timer_period / (1000000 / HZ),
+		    lapic_timer_period % (1000000 / HZ));
 
 	/*
 	 * Do a sanity check on the APIC calibration result
 	 */
-	if (lapic_timer_frequency < (1000000 / HZ)) {
+	if (lapic_timer_period < (1000000 / HZ)) {
 		local_irq_enable();
 		pr_warning("APIC frequency too slow, disabling apic timer\n");
 		return -1;
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 3fa238a137d2..faae6115ddef 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -270,9 +270,9 @@ static void __init ms_hyperv_init_platform(void)
 
 		rdmsrl(HV_X64_MSR_APIC_FREQUENCY, hv_lapic_frequency);
 		hv_lapic_frequency = div_u64(hv_lapic_frequency, HZ);
-		lapic_timer_frequency = hv_lapic_frequency;
+		lapic_timer_period = hv_lapic_frequency;
 		pr_info("Hyper-V: LAPIC Timer Frequency: %#x\n",
-			lapic_timer_frequency);
+			lapic_timer_period);
 	}
 
 	register_nmi_handler(NMI_UNKNOWN, hv_nmi_unknown, NMI_FLAG_FIRST,
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 0eda91f8eeac..3c648476d4fb 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -157,7 +157,7 @@ static void __init vmware_platform_setup(void)
 
 #ifdef CONFIG_X86_LOCAL_APIC
 		/* Skip lapic calibration since we know the bus frequency. */
-		lapic_timer_frequency = ecx / HZ;
+		lapic_timer_period = ecx / HZ;
 		pr_info("Host bus clock speed read from hypervisor : %u Hz\n",
 			ecx);
 #endif
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index 1b2ee55a2dfb..ba95bc70460d 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -45,7 +45,7 @@ static void jailhouse_get_wallclock(struct timespec64 *now)
 
 static void __init jailhouse_timer_init(void)
 {
-	lapic_timer_frequency = setup_data.apic_khz * (1000 / HZ);
+	lapic_timer_period = setup_data.apic_khz * (1000 / HZ);
 }
 
 static unsigned long jailhouse_get_tsc(void)
diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
index 3d0e9aeea7c8..067858fe4db8 100644
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -71,7 +71,7 @@ static const struct x86_cpu_id tsc_msr_cpu_ids[] = {
 /*
  * MSR-based CPU/TSC frequency discovery for certain CPUs.
  *
- * Set global "lapic_timer_frequency" to bus_clock_cycles/jiffy
+ * Set global "lapic_timer_period" to bus_clock_cycles/jiffy
  * Return processor base frequency in KHz, or 0 on failure.
  */
 unsigned long cpu_khz_from_msr(void)
@@ -104,7 +104,7 @@ unsigned long cpu_khz_from_msr(void)
 	res = freq * ratio;
 
 #ifdef CONFIG_X86_LOCAL_APIC
-	lapic_timer_frequency = (freq * 1000) / HZ;
+	lapic_timer_period = (freq * 1000) / HZ;
 #endif
 
 	/*
