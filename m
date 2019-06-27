Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE0BC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B6B216FD
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 23:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="nHXMAZdV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfF0Xpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 19:45:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40993 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfF0Xpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:45:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RNjRvx502904
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 16:45:28 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RNjRvx502904
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561679128;
        bh=w77iUMJwFYizOzEiRHpKqAIZpTBQAMppfcbmZJO7WWY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=nHXMAZdVSw8fgHNG2OFhPffc/es6c+TiHJ5BVfLrpLYeParPhOOW+vIykviJ3sG3O
         cHWzDidS9wYVKXfG5yaXcwP8BqVyCycx5CVm2tPAES5ztFz5idSPaLNDnART7fotVz
         F7L4aaxdyTpnWE7jdGNyAi41JMG7jwD13xCOAYxROal5+W8BIK0fmT69Ohd8cvFkSc
         c84dpCobXNcvpOE/HTTByltAAv7/49pcLOuINGL1/UW5lnatP0t0z30Mu93LdS2Lk9
         eQFNMmqO7UPCKbNdMDHB4FqQ0VL38qWk0+tnNbnQZmUG9v7FdXa41TbMnojw14k4P9
         4bA7goMhVCCxA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RNjRuU502901;
        Thu, 27 Jun 2019 16:45:27 -0700
Date:   Thu, 27 Jun 2019 16:45:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-0b5c597de6aa30000480d6add2f37ef7de3f9312@git.kernel.org>
Cc:     ravi.v.shankar@intel.com, Suravee.Suthikulpanit@amd.com,
        tglx@linutronix.de, ricardo.neri-calderon@linux.intel.com,
        andi.kleen@intel.com, eranian@google.com,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        mingo@kernel.org, hpa@zytor.com, peterz@infradead.org
Reply-To: peterz@infradead.org, mingo@kernel.org, ashok.raj@intel.com,
          hpa@zytor.com, eranian@google.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, Suravee.Suthikulpanit@amd.com,
          ravi.v.shankar@intel.com, ricardo.neri-calderon@linux.intel.com,
          andi.kleen@intel.com
In-Reply-To: <20190623132435.637420368@linutronix.de>
References: <20190623132435.637420368@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/hpet: Coding style cleanup
Git-Commit-ID: 0b5c597de6aa30000480d6add2f37ef7de3f9312
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

Commit-ID:  0b5c597de6aa30000480d6add2f37ef7de3f9312
Gitweb:     https://git.kernel.org/tip/0b5c597de6aa30000480d6add2f37ef7de3f9312
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Sun, 23 Jun 2019 15:23:57 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:57:21 +0200

x86/hpet: Coding style cleanup

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
Link: https://lkml.kernel.org/r/20190623132435.637420368@linutronix.de

---
 arch/x86/kernel/hpet.c | 43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index 1a389a2ff42a..ed2d556f2c96 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -131,26 +131,33 @@ EXPORT_SYMBOL_GPL(is_hpet_enabled);
 
 static void _hpet_print_config(const char *function, int line)
 {
-	u32 i, timers, l, h;
+	u32 i, id, period, cfg, status, channels, l, h;
+
 	pr_info("%s(%d):\n", function, line);
-	l = hpet_readl(HPET_ID);
-	h = hpet_readl(HPET_PERIOD);
-	timers = ((l & HPET_ID_NUMBER) >> HPET_ID_NUMBER_SHIFT) + 1;
-	pr_info("ID: 0x%x, PERIOD: 0x%x\n", l, h);
-	l = hpet_readl(HPET_CFG);
-	h = hpet_readl(HPET_STATUS);
-	pr_info("CFG: 0x%x, STATUS: 0x%x\n", l, h);
+
+	id = hpet_readl(HPET_ID);
+	period = hpet_readl(HPET_PERIOD);
+	pr_info("ID: 0x%x, PERIOD: 0x%x\n", id, period);
+
+	cfg = hpet_readl(HPET_CFG);
+	status = hpet_readl(HPET_STATUS);
+	pr_info("CFG: 0x%x, STATUS: 0x%x\n", cfg, status);
+
 	l = hpet_readl(HPET_COUNTER);
 	h = hpet_readl(HPET_COUNTER+4);
 	pr_info("COUNTER_l: 0x%x, COUNTER_h: 0x%x\n", l, h);
 
-	for (i = 0; i < timers; i++) {
+	channels = ((id & HPET_ID_NUMBER) >> HPET_ID_NUMBER_SHIFT) + 1;
+
+	for (i = 0; i < channels; i++) {
 		l = hpet_readl(HPET_Tn_CFG(i));
 		h = hpet_readl(HPET_Tn_CFG(i)+4);
 		pr_info("T%d: CFG_l: 0x%x, CFG_h: 0x%x\n", i, l, h);
+
 		l = hpet_readl(HPET_Tn_CMP(i));
 		h = hpet_readl(HPET_Tn_CMP(i)+4);
 		pr_info("T%d: CMP_l: 0x%x, CMP_h: 0x%x\n", i, l, h);
+
 		l = hpet_readl(HPET_Tn_ROUTE(i));
 		h = hpet_readl(HPET_Tn_ROUTE(i)+4);
 		pr_info("T%d ROUTE_l: 0x%x, ROUTE_h: 0x%x\n", i, l, h);
@@ -216,6 +223,7 @@ static void hpet_reserve_platform_timers(unsigned int id) { }
 static void hpet_stop_counter(void)
 {
 	u32 cfg = hpet_readl(HPET_CFG);
+
 	cfg &= ~HPET_CFG_ENABLE;
 	hpet_writel(cfg, HPET_CFG);
 }
@@ -229,6 +237,7 @@ static void hpet_reset_counter(void)
 static void hpet_start_counter(void)
 {
 	unsigned int cfg = hpet_readl(HPET_CFG);
+
 	cfg |= HPET_CFG_ENABLE;
 	hpet_writel(cfg, HPET_CFG);
 }
@@ -393,7 +402,7 @@ static int hpet_legacy_resume(struct clock_event_device *evt)
 }
 
 static int hpet_legacy_next_event(unsigned long delta,
-			struct clock_event_device *evt)
+				  struct clock_event_device *evt)
 {
 	return hpet_next_event(delta, 0);
 }
@@ -1142,6 +1151,7 @@ EXPORT_SYMBOL_GPL(hpet_rtc_timer_init);
 static void hpet_disable_rtc_channel(void)
 {
 	u32 cfg = hpet_readl(HPET_T1_CFG);
+
 	cfg &= ~HPET_TN_ENABLE;
 	hpet_writel(cfg, HPET_T1_CFG);
 }
@@ -1183,8 +1193,7 @@ int hpet_set_rtc_irq_bit(unsigned long bit_mask)
 }
 EXPORT_SYMBOL_GPL(hpet_set_rtc_irq_bit);
 
-int hpet_set_alarm_time(unsigned char hrs, unsigned char min,
-			unsigned char sec)
+int hpet_set_alarm_time(unsigned char hrs, unsigned char min, unsigned char sec)
 {
 	if (!is_hpet_enabled())
 		return 0;
@@ -1204,15 +1213,16 @@ int hpet_set_periodic_freq(unsigned long freq)
 	if (!is_hpet_enabled())
 		return 0;
 
-	if (freq <= DEFAULT_RTC_INT_FREQ)
+	if (freq <= DEFAULT_RTC_INT_FREQ) {
 		hpet_pie_limit = DEFAULT_RTC_INT_FREQ / freq;
-	else {
+	} else {
 		clc = (uint64_t) hpet_clockevent.mult * NSEC_PER_SEC;
 		do_div(clc, freq);
 		clc >>= hpet_clockevent.shift;
 		hpet_pie_delta = clc;
 		hpet_pie_limit = 0;
 	}
+
 	return 1;
 }
 EXPORT_SYMBOL_GPL(hpet_set_periodic_freq);
@@ -1272,8 +1282,7 @@ irqreturn_t hpet_rtc_interrupt(int irq, void *dev_id)
 		hpet_prev_update_sec = curr_time.tm_sec;
 	}
 
-	if (hpet_rtc_flags & RTC_PIE &&
-	    ++hpet_pie_count >= hpet_pie_limit) {
+	if (hpet_rtc_flags & RTC_PIE && ++hpet_pie_count >= hpet_pie_limit) {
 		rtc_int_flag |= RTC_PF;
 		hpet_pie_count = 0;
 	}
@@ -1282,7 +1291,7 @@ irqreturn_t hpet_rtc_interrupt(int irq, void *dev_id)
 	    (curr_time.tm_sec == hpet_alarm_time.tm_sec) &&
 	    (curr_time.tm_min == hpet_alarm_time.tm_min) &&
 	    (curr_time.tm_hour == hpet_alarm_time.tm_hour))
-			rtc_int_flag |= RTC_AF;
+		rtc_int_flag |= RTC_AF;
 
 	if (rtc_int_flag) {
 		rtc_int_flag |= (RTC_IRQF | (RTC_NUM_INTS << 8));
