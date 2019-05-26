Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA73C282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8FB216FD
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfEZTTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 15:19:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbfEZTSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 15:18:49 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B92F02177B;
        Sun, 26 May 2019 19:18:48 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hUyfP-0004bW-Tl; Sun, 26 May 2019 15:18:47 -0400
Message-Id: <20190526191847.814650270@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 26 May 2019 15:18:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [for-next][PATCH 09/16] tracing: Use correct function name in trace_filter_add_remove_task()
 comment
References: <20190526191828.466305460@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Kaehlcke <mka@chromium.org>

The comment of trace_filter_add_remove_task() refers to the function as
'trace_pid_filter_add_remove_task', use the correct name.

Link: http://lkml.kernel.org/r/20190523192628.134406-1-mka@chromium.org

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6b3b5b0495a8..77b9c4ca5faa 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -366,7 +366,7 @@ trace_ignore_this_task(struct trace_pid_list *filtered_pids, struct task_struct
 }
 
 /**
- * trace_pid_filter_add_remove_task - Add or remove a task from a pid_list
+ * trace_filter_add_remove_task - Add or remove a task from a pid_list
  * @pid_list: The list to modify
  * @self: The current task for fork or NULL for exit
  * @task: The task to add or remove
-- 
2.20.1


