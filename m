Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA7EC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE8D2175B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 20:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfEHUZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 16:25:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728851AbfEHUYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 16:24:55 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF7BF217D6;
        Wed,  8 May 2019 20:24:54 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hOT7V-0007kg-VJ; Wed, 08 May 2019 16:24:53 -0400
Message-Id: <20190508202453.865843951@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 08 May 2019 16:24:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>
Subject: [for-next][PATCH 13/13] tracing: Fix documentation about disabling options using
 trace_options
References: <20190508202427.252736423@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>

To disable a tracing option using the trace_options file, the option
name needs to be prefixed with 'no', and not suffixed, as the README
states. Fix it.

Link: http://lkml.kernel.org/r/154872690031.47356.5739053380942044586.stgit@srivatsa-ubuntu

Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4269af5905e4..a3a6945a7732 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4755,7 +4755,7 @@ static const char readme_msg[] =
 	"  instances\t\t- Make sub-buffers with: mkdir instances/foo\n"
 	"\t\t\t  Remove sub-buffer with rmdir\n"
 	"  trace_options\t\t- Set format or modify how tracing happens\n"
-	"\t\t\t  Disable an option by adding a suffix 'no' to the\n"
+	"\t\t\t  Disable an option by prefixing 'no' to the\n"
 	"\t\t\t  option name\n"
 	"  saved_cmdlines_size\t- echo command number in here to store comm-pid list\n"
 #ifdef CONFIG_DYNAMIC_FTRACE
-- 
2.20.1


