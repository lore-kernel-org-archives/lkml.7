Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6905EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44513218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfCOSqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 14:46:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfCOSph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 14:45:37 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DD61218D8;
        Fri, 15 Mar 2019 18:45:37 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1h4rpo-00008w-J0; Fri, 15 Mar 2019 14:45:36 -0400
Message-Id: <20190315184536.475824995@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 15 Mar 2019 14:45:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>
Subject: [PATCH 2/8] trace/probes: Remove kernel doc style from non kernel doc comment
References: <20190315184505.655928086@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>

  CC      kernel/trace/trace_kprobe.o
kernel/trace/trace_kprobe.c:41: warning: cannot understand function prototype: 'struct trace_kprobe '

The real problem is that a comment looked like kerneldoc when it shouldn't be...

Link: http://lkml.kernel.org/r/2812.1552381112@turing-police

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_kprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index d5fb09ebba8b..ceafa0a2b1d1 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -35,7 +35,7 @@ static struct dyn_event_operations trace_kprobe_ops = {
 	.match = trace_kprobe_match,
 };
 
-/**
+/*
  * Kprobe event core functions
  */
 struct trace_kprobe {
-- 
2.20.1


