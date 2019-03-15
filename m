Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9611C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E28218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfCOSpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 14:45:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbfCOSph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 14:45:37 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C40221871;
        Fri, 15 Mar 2019 18:45:37 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1h4rpo-00007v-99; Fri, 15 Mar 2019 14:45:36 -0400
Message-Id: <20190315184505.655928086@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 15 Mar 2019 14:45:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/8] [GIT PULL] tracing: Minor clean ups, fixes and error checking
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

This contains a series of last minute clean ups, small fixes and
error checks.

Please pull the latest trace-v5.1-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.1-2

Tag SHA1: de3d34862ab43473fb0ce9d774c09241b85c7c9c
Head SHA1: a039480e9e93896cadc5a91468964febb3c5d488


Douglas Anderson (1):
      tracing: kdb: Fix ftdump to not sleep

Masami Hiramatsu (5):
      tracing/probe: Check maxactive error cases
      tracing/probe: Check event name length correctly
      tracing/probe: Check the size of argument name and body
      tracing/probe: Check event/group naming rule at parsing
      tracing/probe: Verify alloc_trace_*probe() result

Valdis Kletnieks (2):
      tracing/probes: Make reserved_field_names static
      trace/probes: Remove kernel doc style from non kernel doc comment

----
 include/linux/ring_buffer.h |  2 +-
 kernel/trace/ring_buffer.c  |  5 +++--
 kernel/trace/trace.c        |  6 ++++--
 kernel/trace/trace_kdb.c    |  6 ++++--
 kernel/trace/trace_kprobe.c | 23 +++++++++++------------
 kernel/trace/trace_probe.c  | 20 ++++++++++++++++++--
 kernel/trace/trace_probe.h  |  1 +
 kernel/trace/trace_uprobe.c |  8 +++-----
 8 files changed, 45 insertions(+), 26 deletions(-)
