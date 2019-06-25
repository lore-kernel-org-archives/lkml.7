Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79310C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EBB52086D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 19:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732030AbfFYTPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 15:15:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730939AbfFYTPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 15:15:46 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 207152086D;
        Tue, 25 Jun 2019 19:15:46 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hfquu-0002He-SI; Tue, 25 Jun 2019 15:15:44 -0400
Message-Id: <20190625191510.599310671@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 25 Jun 2019 15:15:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/12] tracing: More updates for 5.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 730a95953b1f4816cc50793c2de1f339b4c2818c


Gustavo A. R. Silva (1):
      tracepoint: Use struct_size() in kmalloc()

Masami Hiramatsu (10):
      kprobes: Fix to init kprobes in subsys_initcall
      tracing/kprobe: Set print format right after parsed command
      tracing/uprobe: Set print format when parsing command
      tracing/probe: Add trace_probe init and free functions
      tracing/probe: Add trace_event_call register API for trace_probe
      tracing/probe: Add trace_event_file access APIs for trace_probe
      tracing/probe: Add trace flag access APIs for trace_probe
      tracing/probe: Add probe event name and group name accesses APIs
      tracing/probe: Add trace_event_call accesses APIs
      tracing/kprobe: Check registered state using kprobe

Steven Rostedt (VMware) (1):
      ring-buffer: Remove HAVE_64BIT_ALIGNED_ACCESS

----
 arch/Kconfig                |  16 ---
 kernel/kprobes.c            |   2 +-
 kernel/trace/ring_buffer.c  |  17 +--
 kernel/trace/trace_kprobe.c | 247 +++++++++++++++++---------------------------
 kernel/trace/trace_probe.c  | 105 ++++++++++++++++++-
 kernel/trace/trace_probe.h  |  74 ++++++++++---
 kernel/trace/trace_uprobe.c | 161 +++++++++--------------------
 kernel/tracepoint.c         |   4 +-
 8 files changed, 312 insertions(+), 314 deletions(-)
