Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E84AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A72A218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfCOSpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 14:45:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726431AbfCOSph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 14:45:37 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3948A218D3;
        Fri, 15 Mar 2019 18:45:37 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1h4rpo-00008R-EQ; Fri, 15 Mar 2019 14:45:36 -0400
Message-Id: <20190315184536.337893671@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 15 Mar 2019 14:45:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>
Subject: [PATCH 1/8] tracing/probes: Make reserved_field_names static
References: <20190315184505.655928086@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>

sparse complains:
  CHECK   kernel/trace/trace_probe.c
kernel/trace/trace_probe.c:16:12: warning: symbol 'reserved_field_names' was not declared. Should it be static?

Yes, it should be static.

Link: http://lkml.kernel.org/r/2478.1552380778@turing-police

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 89da34b326e3..cfcf77e6fb19 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -13,7 +13,7 @@
 
 #include "trace_probe.h"
 
-const char *reserved_field_names[] = {
+static const char *reserved_field_names[] = {
 	"common_type",
 	"common_flags",
 	"common_preempt_count",
-- 
2.20.1


