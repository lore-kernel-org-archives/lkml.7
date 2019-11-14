Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4697BC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234DF2072C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfKNSTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:19:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:35854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbfKNSS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:18:28 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 545E120891;
        Thu, 14 Nov 2019 18:18:28 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iVJhL-0001Bf-ID; Thu, 14 Nov 2019 13:18:27 -0500
Message-Id: <20191114181827.441645366@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Nov 2019 13:18:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>
Subject: [for-next][PATCH 28/33] tracing/hwlat: Fix a few trivial nits
References: <20191114181734.067922168@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>

Update the source file name in the comments, and fix a grammatical
error.

Link: http://lkml.kernel.org/r/157073346821.17189.8946944856026592247.stgit@srivatsa-ubuntu

Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_hwlat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 63526670605a..6638d63f0921 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * trace_hwlatdetect.c - A simple Hardware Latency detector.
+ * trace_hwlat.c - A simple Hardware Latency detector.
  *
  * Use this tracer to detect large system latencies induced by the behavior of
  * certain underlying system hardware or firmware, independent of Linux itself.
@@ -279,7 +279,7 @@ static void move_to_next_cpu(void)
 		return;
 	/*
 	 * If for some reason the user modifies the CPU affinity
-	 * of this thread, than stop migrating for the duration
+	 * of this thread, then stop migrating for the duration
 	 * of the current test.
 	 */
 	if (!cpumask_equal(current_mask, current->cpus_ptr))
-- 
2.23.0


