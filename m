Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17E9C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA41206D3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="EJKfcKjY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfKPPGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:06:50 -0500
Received: from m15-114.126.com ([220.181.15.114]:47103 "EHLO m15-114.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbfKPPGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=WibAdv8bRBg8ZUCmNx
        wqH7NhVbPF3qVfqDsxxKRk5Po=; b=EJKfcKjYSCo3yblHb8LcptduONf+grxsqh
        l8eF4SuxIyiXVtNnVLcjrwneBslM9klILWXn/YjU1cWaXINT8S8BeawLsFGHPHpi
        8fYdDxDKUPSD683BO3DHXqxBhOoLOREoG009I/z6wIVEHIxWdw8j2hnp4kpxFiXd
        WdQwLvmB0=
Received: from 192.168.137.246 (unknown [112.10.84.253])
        by smtp7 (Coremail) with SMTP id DsmowACX_F1QENBdjoD3Ag--.40398S3;
        Sat, 16 Nov 2019 23:05:54 +0800 (CST)
From:   Xianting Tian <xianting_tian@126.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ring-buffer: Fix typos in function ring_buffer_producer
Date:   Sat, 16 Nov 2019 10:05:55 -0500
Message-Id: <1573916755-32478-1-git-send-email-xianting_tian@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DsmowACX_F1QENBdjoD3Ag--.40398S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF1kCFWDJFWDuFWfCr15urg_yoWfJFc_Ca
        ykuFWkKw1UCF9F9w1UArsxZFnFka4YqF97Ww47tFW5GF1Uuwn8twn8tF1rGrZ8Wr9Y9FZ5
        u343Canak34SkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8WE_tUUUUU==
X-Originating-IP: [112.10.84.253]
X-CM-SenderInfo: h0ld03plqjs3xldqqiyswou0bp/1tbi5hJvpFpD9H5qtAAAsy
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spelling and other typos

Signed-off-by: Xianting Tian <xianting_tian@126.com>
---
 kernel/trace/ring_buffer_benchmark.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer_benchmark.c b/kernel/trace/ring_buffer_benchmark.c
index 09b0b49..32149e4 100644
--- a/kernel/trace/ring_buffer_benchmark.c
+++ b/kernel/trace/ring_buffer_benchmark.c
@@ -269,10 +269,10 @@ static void ring_buffer_producer(void)
 
 #ifndef CONFIG_PREEMPTION
 		/*
-		 * If we are a non preempt kernel, the 10 second run will
+		 * If we are a non preempt kernel, the 10 seconds run will
 		 * stop everything while it runs. Instead, we will call
 		 * cond_resched and also add any time that was lost by a
-		 * rescedule.
+		 * reschedule.
 		 *
 		 * Do a cond resched at the same frequency we would wake up
 		 * the reader.
-- 
1.8.3.1

