Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16624C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755CA216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbfDYQ2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:28:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbfDYQ2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:28:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 333B02088F;
        Thu, 25 Apr 2019 16:28:45 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hJhEp-0005Jv-HF; Thu, 25 Apr 2019 12:28:43 -0400
Message-Id: <20190425162808.056301033@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 25 Apr 2019 12:28:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/5] tracing: function graph cleanups for the next merge window
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 070ea1a24f403b68e76d9763cedd061917f6e1c1


Steven Rostedt (VMware) (5):
      ftrace: Remove ASSIGN_OPS_HASH() macro from ftrace.c
      ftrace: Do not process STUB functions in ftrace_ops_list_func()
      function_graph: Have selftest also emulate tr->reset() as it did with tr->init()
      function_graph: Use a ftrace_graph_ret_stub() for return
      function_graph: Place ftrace_graph_entry_stub() prototype in include/linux/ftrace.h

----
 arch/nds32/kernel/ftrace.c    | 1 -
 arch/parisc/kernel/ftrace.c   | 1 -
 include/linux/ftrace.h        | 2 ++
 kernel/trace/fgraph.c         | 9 ++++++---
 kernel/trace/ftrace.c         | 7 +++----
 kernel/trace/trace_selftest.c | 5 ++++-
 6 files changed, 15 insertions(+), 10 deletions(-)
