Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3493C10F03
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 21:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FCE20850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 21:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfCAV5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 16:57:34 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35275 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCAV5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 16:57:33 -0500
Received: by mail-pf1-f194.google.com with SMTP id j5so12041744pfa.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 13:57:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AcgQ18Ic5LU/QOwCvJwo6zZhPffoF3yVwCP1/xwIH9A=;
        b=aB2b92+ybK2hYqwID73joZi1hjRls7PMQnxKUZEWG7vVupj8FYQ6sTByFGUyPegvkK
         P7hWXZHWyIEI4Wca+E1I24Q0oaqxJDFkPEUJb9bqy67fLkxv4C7G90/GBfKn7Gjtspzm
         vIetTeveHUEbc6j+IWZodXrC/akuJnzOrBxStKZQLKIPMWi9C0UGNpLQSvQoeAt66tD8
         NRae4miuwerBymouEecF8hA8ABk3Nzz2jku/u4BLC24KUdY0t118OVl5CgDC9IlyZelb
         o3kKsLAOrSKtjS1CBEf2B5mrojtRc1vKGIffbyfu6RmeMAW0r8nAgY0GLN7OB1NhiKrQ
         QV2A==
X-Gm-Message-State: APjAAAWiDpRg1bNvhfVIimR/tnC9QDlrBzx6W4Evmr2x6xwKUgycfXtx
        xMvkbKlTmSHKEly1mjCmh9U=
X-Google-Smtp-Source: APXvYqwITqrJfe+5rXESJ2GFGMvn6bSLdpmhy83HVafIEENDFfIsO+qIYWRje06N6CIVKQytPjIKlQ==
X-Received: by 2002:a63:584e:: with SMTP id i14mr7080123pgm.68.1551477452650;
        Fri, 01 Mar 2019 13:57:32 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 1sm49380134pfy.68.2019.03.01.13.57.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 13:57:31 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH] workqueue: Fix spelling in source code comments
Date:   Fri,  1 Mar 2019 13:57:25 -0800
Message-Id: <20190301215725.135432-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change "execuing" into "executing" and "guarnateed" into "guaranteed".

Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/workqueue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index fc5d23d752a5..57ad76486a9a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1341,7 +1341,7 @@ static bool is_chained_work(struct workqueue_struct *wq)
 
 	worker = current_wq_worker();
 	/*
-	 * Return %true iff I'm a worker execuing a work item on @wq.  If
+	 * Return %true iff I'm a worker executing a work item on @wq.  If
 	 * I'm @worker, it's safe to dereference it without locking.
 	 */
 	return worker && worker->current_pwq->wq == wq;
@@ -1639,7 +1639,7 @@ static void rcu_work_rcufn(struct rcu_head *rcu)
  *
  * Return: %false if @rwork was already pending, %true otherwise.  Note
  * that a full RCU grace period is guaranteed only after a %true return.
- * While @rwork is guarnateed to be executed after a %false return, the
+ * While @rwork is guaranteed to be executed after a %false return, the
  * execution may happen before a full RCU grace period has passed.
  */
 bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork)
-- 
2.21.0

