Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11031C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 06:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13CD2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 06:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfCTGod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 02:44:33 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:64798 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbfCTGod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 02:44:33 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id E9B41A9A67BCC69C4429;
        Wed, 20 Mar 2019 14:44:30 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x2K6iNuO073449;
        Wed, 20 Mar 2019 14:44:23 +0800 (GMT-8)
        (envelope-from yu.chen3@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019032014444469-5625813 ;
          Wed, 20 Mar 2019 14:44:44 +0800 
From:   Yu Chen <yu.chen3@zte.com.cn>
To:     davem@davemloft.net
Cc:     willemb@google.com, amritha.nambiar@intel.com,
        linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        Yu Chen <yu.chen3@zte.com.cn>
Subject: [PATCH] cpumask: cpumask_test_and_clear_cpu() comment correction
Date:   Wed, 20 Mar 2019 14:44:33 +0800
Message-Id: <1553064273-7755-1-git-send-email-yu.chen3@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-03-20 14:44:44,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-03-20 14:44:15,
        Serialize complete at 2019-03-20 14:44:15
X-MAIL: mse01.zte.com.cn x2K6iNuO073449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix code comment for cpumask_test_and_clear_cpu().

Signed-off-by: Yu Chen <yu.chen3@zte.com.cn>
---
 include/linux/cpumask.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 147bdec..73ca70d 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -363,7 +363,7 @@ static inline int cpumask_test_and_set_cpu(int cpu, struct cpumask *cpumask)
  * @cpu: cpu number (< nr_cpu_ids)
  * @cpumask: the cpumask pointer
  *
- * Returns 1 if @cpu is set in old bitmap of @cpumask, else returns 0
+ * Returns 1 if @cpu is clear in old bitmap of @cpumask, else returns 0
  *
  * test_and_clear_bit wrapper for cpumasks.
  */
-- 
2.17.1

