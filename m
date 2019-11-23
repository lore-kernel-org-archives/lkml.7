Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33744C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 18:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3EB2067D
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 18:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfKWSNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 13:13:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:40192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbfKWSMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 13:12:42 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B5692073B;
        Sat, 23 Nov 2019 18:12:42 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1iYZth-000EzJ-Gk; Sat, 23 Nov 2019 13:12:41 -0500
Message-Id: <20191123181241.394403643@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 23 Nov 2019 13:12:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xianting Tian <xianting_tian@126.com>
Subject: [for-next][PATCH 05/10] ring-buffer: Fix typos in function ring_buffer_producer
References: <20191123181157.851427201@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xianting Tian <xianting_tian@126.com>

Fix spelling and other typos

Link: http://lkml.kernel.org/r/1573916755-32478-1-git-send-email-xianting_tian@126.com

Signed-off-by: Xianting Tian <xianting_tian@126.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer_benchmark.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer_benchmark.c b/kernel/trace/ring_buffer_benchmark.c
index 09b0b49f346e..32149e46551c 100644
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
2.24.0


