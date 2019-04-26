Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441D7C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1245C208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfDZPrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:47:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfDZPrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:47:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1C89208CA;
        Fri, 26 Apr 2019 15:47:01 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hK341-0002LK-0O; Fri, 26 Apr 2019 11:47:01 -0400
Message-Id: <20190426154622.183993476@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 26 Apr 2019 11:46:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/3]  tracing: Minor fixes that will be going to Linus shortly
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
ftrace/urgent

Head SHA1: d6097c9e4454adf1f8f2c9547c2fa6060d55d952


Jann Horn (1):
      tracing: Fix buffer_ref pipe ops

Peter Zijlstra (1):
      trace: Fix preempt_enable_no_resched() abuse

Wenwen Wang (1):
      tracing: Fix a memory leak by early error exit in trace_pid_write()

----
 fs/splice.c                |  4 ++--
 include/linux/pipe_fs_i.h  |  1 +
 kernel/trace/ring_buffer.c |  2 +-
 kernel/trace/trace.c       | 33 ++++++++++++++++++---------------
 4 files changed, 22 insertions(+), 18 deletions(-)
