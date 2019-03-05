Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553A0C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F62B2087C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfCENwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:52:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:37626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbfCENwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 08:52:47 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96A652082C;
        Tue,  5 Mar 2019 13:52:46 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92-RC5)
        (envelope-from <rostedt@goodmis.org>)
        id 1h1AUv-0002yl-Lo; Tue, 05 Mar 2019 08:52:45 -0500
Message-Id: <20190305135223.360347148@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 05 Mar 2019 08:52:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/6] tracing: Last minute updates
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 9f0bbf3115ca9f91f43b7c74e9ac7d79f47fc6c2


Colin Ian King (1):
      tracing: Fix spelling mistake: "analagous" -> "analogous"

Jann Horn (1):
      tracing/perf: Use strndup_user() instead of buggy open-coded version

Srikar Dronamraju (1):
      doc: trace: Fix documentation for uprobe_profile

Steven Rostedt (VMware) (1):
      x86/ftrace: Fix warning and considate ftrace_jmp_replace() and ftrace_call_replace()

Tom Zanussi (2):
      tracing: Use str_has_prefix() in synth_event_create()
      tracing: Use strncpy instead of memcpy for string keys in hist triggers

----
 Documentation/trace/uprobetracer.rst |  7 +++---
 arch/x86/kernel/ftrace.c             | 42 +++++++++++++++---------------------
 kernel/trace/trace.c                 |  2 +-
 kernel/trace/trace_event_perf.c      | 16 ++++++--------
 kernel/trace/trace_events_hist.c     |  9 ++++----
 5 files changed, 33 insertions(+), 43 deletions(-)
