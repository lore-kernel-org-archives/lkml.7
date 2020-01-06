Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E58C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1902146E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgAFVT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:19:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:56248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbgAFVT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 16:19:59 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95D102072C;
        Mon,  6 Jan 2020 21:19:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.3)
        (envelope-from <rostedt@goodmis.org>)
        id 1ioZn3-000MUV-NF; Mon, 06 Jan 2020 16:19:57 -0500
Message-Id: <20200106211901.293910946@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 06 Jan 2020 16:19:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/7] tracing: Fixes for 5.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin Ian King (1):
      tracing: Fix indentation issue

Joel Fernandes (Google) (1):
      tracing: Change offset type to s32 in preempt/irq tracepoints

Kaitao Cheng (1):
      kernel/trace: Fix do not unregister tracepoints when register sched_migrate_task fail

Steven Rostedt (VMware) (3):
      tracing: Initialize val to zero in parse_entry of inject code
      tracing: Define MCOUNT_INSN_SIZE when not defined without direct calls
      tracing: Have stack tracer compile when MCOUNT_INSN_SIZE is not defined

Wen Yang (1):
      ftrace: Avoid potential division by zero in function profiler

----
 include/trace/events/preemptirq.h  |  8 ++++----
 kernel/trace/fgraph.c              | 14 ++++++++++++++
 kernel/trace/ftrace.c              |  6 +++---
 kernel/trace/trace_events_inject.c |  2 +-
 kernel/trace/trace_sched_wakeup.c  |  4 +++-
 kernel/trace/trace_seq.c           |  2 +-
 kernel/trace/trace_stack.c         |  5 +++++
 7 files changed, 31 insertions(+), 10 deletions(-)
