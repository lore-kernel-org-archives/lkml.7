Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A621FC31E47
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 12:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9F22184B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 12:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfFOMnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 08:43:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfFOMnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 08:43:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FB2021841;
        Sat, 15 Jun 2019 12:43:13 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hc81Y-0006bf-I9; Sat, 15 Jun 2019 08:43:12 -0400
Message-Id: <20190615124216.188179157@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 15 Jun 2019 08:42:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/7] tracing: Fixes for 5.2-rc4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is the queue for my next pull request to Linus.

Eiichi Tsukata (3):
      tracing: Fix out-of-range read in trace_stack_print()
      tracing/uprobe: Fix NULL pointer dereference in trace_uprobe_create()
      tracing/uprobe: Fix obsolete comment on trace_uprobe_create()

Josh Poimboeuf (1):
      module: Fix livepatch/ftrace module text permissions race

Vasily Gorbik (1):
      tracing: avoid build warning with HAVE_NOP_MCOUNT

Wei Li (1):
      ftrace: Fix NULL pointer dereference in free_ftrace_func_mapper()

YueHaibing (1):
      tracing: Make two symbols static

----
 kernel/livepatch/core.c     |  6 ++++++
 kernel/trace/ftrace.c       | 22 ++++++++++++++++------
 kernel/trace/trace.c        |  4 ++--
 kernel/trace/trace_output.c |  2 +-
 kernel/trace/trace_uprobe.c | 15 ++++++++++-----
 5 files changed, 35 insertions(+), 14 deletions(-)
