Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246FAC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 09:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E62207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 09:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfCIJFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 04:05:43 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:31290 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfCIJFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 04:05:43 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id A660571295D84B6B793D;
        Sat,  9 Mar 2019 17:05:38 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x29958p5011259;
        Sat, 9 Mar 2019 17:05:08 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019030917055521-4083774 ;
          Sat, 9 Mar 2019 17:05:55 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH]  x86/resctrl: remove unused variable
Date:   Sun, 10 Mar 2019 01:29:44 +0800
Message-Id: <1552152584-26087-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-03-09 17:05:55,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-03-09 17:04:48,
        Serialize complete at 2019-03-09 17:04:48
X-MAIL: mse01.zte.com.cn x29958p5011259
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable "struct rdt_resource *r" is set but not used. So remove it.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index f33f11f..1573a0a 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -501,11 +501,8 @@ void cqm_handle_limbo(struct work_struct *work)
 void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms)
 {
 	unsigned long delay = msecs_to_jiffies(delay_ms);
-	struct rdt_resource *r;
 	int cpu;
 
-	r = &rdt_resources_all[RDT_RESOURCE_L3];
-
 	cpu = cpumask_any(&dom->cpu_mask);
 	dom->cqm_work_cpu = cpu;
 
-- 
1.8.3.1

