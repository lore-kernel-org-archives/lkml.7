Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F60C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 21:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8C120989
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 21:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfCXVQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 17:16:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44447 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfCXVQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 17:16:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2OLG5aX1635410
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 24 Mar 2019 14:16:05 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2OLG4RM1635407;
        Sun, 24 Mar 2019 14:16:04 -0700
Date:   Sun, 24 Mar 2019 14:16:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peng Hao <tipbot@zytor.com>
Message-ID: <tip-7f2daa96759b0700ad28579133aa91bc663632a7@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, peng.hao2@zte.com.cn,
        tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          peng.hao2@zte.com.cn, linux-kernel@vger.kernel.org
In-Reply-To: <1552152584-26087-1-git-send-email-peng.hao2@zte.com.cn>
References: <1552152584-26087-1-git-send-email-peng.hao2@zte.com.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/resctrl: Remove unused variable
Git-Commit-ID: 7f2daa96759b0700ad28579133aa91bc663632a7
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

Commit-ID:  7f2daa96759b0700ad28579133aa91bc663632a7
Gitweb:     https://git.kernel.org/tip/7f2daa96759b0700ad28579133aa91bc663632a7
Author:     Peng Hao <peng.hao2@zte.com.cn>
AuthorDate: Sun, 10 Mar 2019 01:29:44 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 24 Mar 2019 22:09:27 +0100

x86/resctrl: Remove unused variable

Variable "struct rdt_resource *r" is set but not used. So remove it.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1552152584-26087-1-git-send-email-peng.hao2@zte.com.cn

---
 arch/x86/kernel/cpu/resctrl/monitor.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index f33f11f69078..1573a0a6b525 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -501,11 +501,8 @@ out_unlock:
 void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms)
 {
 	unsigned long delay = msecs_to_jiffies(delay_ms);
-	struct rdt_resource *r;
 	int cpu;
 
-	r = &rdt_resources_all[RDT_RESOURCE_L3];
-
 	cpu = cpumask_any(&dom->cpu_mask);
 	dom->cqm_work_cpu = cpu;
 
