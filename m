Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA51C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B28E2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="XuZiQBj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfKOOqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 09:46:08 -0500
Received: from m15-114.126.com ([220.181.15.114]:50931 "EHLO m15-114.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbfKOOqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 09:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=BVY/ZDObYzZ2ji2Kqa
        KXTAijZRtGn5e8CHHyokkdP88=; b=XuZiQBj9w6OlPjwtBq/zZXDnyntw4MK52A
        rUdb6u31TMEKguXCKazax0bzVAwf4qlWBcI4EXxdz54hNRMTvzTxrGYzSYmYd5IA
        IeLewOaSfq+nxzv96fa2sBZ/s8DTOBFI/MZgL+Qz1L1mTBmqmoM4CQ6Ixx8RFTVR
        1Hpd0NXSY=
Received: from 192.168.137.245 (unknown [112.10.84.253])
        by smtp7 (Coremail) with SMTP id DsmowAAXfxNDuc5d7jmoAg--.19411S3;
        Fri, 15 Nov 2019 22:42:13 +0800 (CST)
From:   Xianting Tian <xianting_tian@126.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Fix typo in function check_preempt_wakeup
Date:   Fri, 15 Nov 2019 09:42:13 -0500
Message-Id: <1573828933-24592-1-git-send-email-xianting_tian@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DsmowAAXfxNDuc5d7jmoAg--.19411S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wry8WFWfJF4fXw4UZw4rGrg_yoW3Wrg_Ka
        15Zr43tw48tr1IvFyrW3yxtr1xK3y0ga4xuw4Uua4UZrsYqasxXr95AFn3GrZ3XF4UuFZ5
        uws0gFn0vr1xCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0kb1UUUUUU==
X-Originating-IP: [112.10.84.253]
X-CM-SenderInfo: h0ld03plqjs3xldqqiyswou0bp/1tbi7RtupFpD9MVpUgAAsv
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the typo "prempt" to "preempt"

Signed-off-by: Xianting Tian <xianting_tian@126.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 682a754..9767eff 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6667,7 +6667,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 
 	/*
 	 * This is possible from callers such as attach_tasks(), in which we
-	 * unconditionally check_prempt_curr() after an enqueue (which may have
+	 * unconditionally check_preempt_curr() after an enqueue (which may have
 	 * lead to a throttle).  This both saves work and prevents false
 	 * next-buddy nomination below.
 	 */
-- 
1.8.3.1

