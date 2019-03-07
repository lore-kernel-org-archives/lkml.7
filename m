Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05EBC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8D420684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfCGBNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 20:13:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfCGBNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 20:13:36 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D0055C04B939;
        Thu,  7 Mar 2019 01:13:36 +0000 (UTC)
Received: from jsavitz.bos.com (dhcp-17-166.bos.redhat.com [10.18.17.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A84760E3D;
        Thu,  7 Mar 2019 01:13:36 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, trivial@kernel.org
Subject: [PATCH] sched: fix spelling of active in comment on is_cpu_allowed()
Date:   Wed,  6 Mar 2019 20:13:33 -0500
Message-Id: <1551921213-813-1-git-send-email-jsavitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 07 Mar 2019 01:13:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trivial fix of documentation typo

Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ead464a..2e2e19b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -920,7 +920,7 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 }
 
 /*
- * Per-CPU kthreads are allowed to run on !actie && online CPUs, see
+ * Per-CPU kthreads are allowed to run on !active && online CPUs, see
  * __set_cpus_allowed_ptr() and select_fallback_rq().
  */
 static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
-- 
1.8.3.1

