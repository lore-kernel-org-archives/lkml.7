Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB1FC3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 10:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C1623426
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 10:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbfHaKyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 06:54:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727501AbfHaKyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 06:54:12 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9DA823407;
        Sat, 31 Aug 2019 10:54:11 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1i411G-0001Ly-U1; Sat, 31 Aug 2019 06:54:10 -0400
Message-Id: <20190831105410.815421323@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 31 Aug 2019 06:53:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [for-linus][PATCH 7/7] tracing: Correct kdoc formats
References: <20190831105329.122820332@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>

Fix the following kdoc warnings:

kernel/trace/trace.c:1579: warning: Function parameter or member 'tr' not described in 'update_max_tr_single'
kernel/trace/trace.c:1579: warning: Function parameter or member 'tsk' not described in 'update_max_tr_single'
kernel/trace/trace.c:1579: warning: Function parameter or member 'cpu' not described in 'update_max_tr_single'
kernel/trace/trace.c:1776: warning: Function parameter or member 'type' not described in 'register_tracer'
kernel/trace/trace.c:2239: warning: Function parameter or member 'task' not described in 'tracing_record_taskinfo'
kernel/trace/trace.c:2239: warning: Function parameter or member 'flags' not described in 'tracing_record_taskinfo'
kernel/trace/trace.c:2269: warning: Function parameter or member 'prev' not described in 'tracing_record_taskinfo_sched_switch'
kernel/trace/trace.c:2269: warning: Function parameter or member 'next' not described in 'tracing_record_taskinfo_sched_switch'
kernel/trace/trace.c:2269: warning: Function parameter or member 'flags' not described in 'tracing_record_taskinfo_sched_switch'
kernel/trace/trace.c:3078: warning: Function parameter or member 'ip' not described in 'trace_vbprintk'
kernel/trace/trace.c:3078: warning: Function parameter or member 'fmt' not described in 'trace_vbprintk'
kernel/trace/trace.c:3078: warning: Function parameter or member 'args' not described in 'trace_vbprintk'

Link: http://lkml.kernel.org/r/20190828052549.2472-2-jakub.kicinski@netronome.com

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 525a97fbbc60..563e80f9006a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1567,9 +1567,9 @@ update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu,
 
 /**
  * update_max_tr_single - only copy one trace over, and reset the rest
- * @tr - tracer
- * @tsk - task with the latency
- * @cpu - the cpu of the buffer to copy.
+ * @tr: tracer
+ * @tsk: task with the latency
+ * @cpu: the cpu of the buffer to copy.
  *
  * Flip the trace of a single CPU buffer between the @tr and the max_tr.
  */
@@ -1767,7 +1767,7 @@ static void __init apply_trace_boot_options(void);
 
 /**
  * register_tracer - register a tracer with the ftrace system.
- * @type - the plugin for the tracer
+ * @type: the plugin for the tracer
  *
  * Register a new plugin tracer.
  */
@@ -2230,9 +2230,9 @@ static bool tracing_record_taskinfo_skip(int flags)
 /**
  * tracing_record_taskinfo - record the task info of a task
  *
- * @task  - task to record
- * @flags - TRACE_RECORD_CMDLINE for recording comm
- *        - TRACE_RECORD_TGID for recording tgid
+ * @task:  task to record
+ * @flags: TRACE_RECORD_CMDLINE for recording comm
+ *         TRACE_RECORD_TGID for recording tgid
  */
 void tracing_record_taskinfo(struct task_struct *task, int flags)
 {
@@ -2258,10 +2258,10 @@ void tracing_record_taskinfo(struct task_struct *task, int flags)
 /**
  * tracing_record_taskinfo_sched_switch - record task info for sched_switch
  *
- * @prev - previous task during sched_switch
- * @next - next task during sched_switch
- * @flags - TRACE_RECORD_CMDLINE for recording comm
- *          TRACE_RECORD_TGID for recording tgid
+ * @prev: previous task during sched_switch
+ * @next: next task during sched_switch
+ * @flags: TRACE_RECORD_CMDLINE for recording comm
+ *         TRACE_RECORD_TGID for recording tgid
  */
 void tracing_record_taskinfo_sched_switch(struct task_struct *prev,
 					  struct task_struct *next, int flags)
@@ -3072,7 +3072,9 @@ static void trace_printk_start_stop_comm(int enabled)
 
 /**
  * trace_vbprintk - write binary msg to tracing buffer
- *
+ * @ip:    The address of the caller
+ * @fmt:   The string format to write to the buffer
+ * @args:  Arguments for @fmt
  */
 int trace_vbprintk(unsigned long ip, const char *fmt, va_list args)
 {
-- 
2.20.1


