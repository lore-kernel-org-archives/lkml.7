Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC01C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C748220727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfKNSTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:19:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:35738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727603AbfKNSS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:18:29 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C7D820898;
        Thu, 14 Nov 2019 18:18:29 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iVJhM-0001E5-8i; Thu, 14 Nov 2019 13:18:28 -0500
Message-Id: <20191114181828.152834791@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Nov 2019 13:18:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>
Subject: [for-next][PATCH 33/33] tracing: Remove stray tab in TRACE_EVAL_MAP_FILEs help text
References: <20191114181734.067922168@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

There was a stray tab in the help text of the aforementioned config
option which showed like this:

  The "print fmt" of the trace events will show the enum/sizeof names
  instead        of their values. This can cause problems for user space tools
  ...

in menuconfig. Remove it and end a sentence with a fullstop.

No functional changes.

Link: http://lkml.kernel.org/r/20191112174219.10933-1-bp@alien8.de

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index d25314bc7a1c..b872716bb2a0 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -771,7 +771,7 @@ config TRACE_EVAL_MAP_FILE
        depends on TRACING
        help
 	The "print fmt" of the trace events will show the enum/sizeof names
-	instead	of their values. This can cause problems for user space tools
+	instead of their values. This can cause problems for user space tools
 	that use this string to parse the raw data as user space does not know
 	how to convert the string to its value.
 
@@ -792,7 +792,7 @@ config TRACE_EVAL_MAP_FILE
 	they are needed for the "eval_map" file. Enabling this option will
 	increase the memory footprint of the running kernel.
 
-	If unsure, say N
+	If unsure, say N.
 
 config GCOV_PROFILE_FTRACE
 	bool "Enable GCOV profiling on ftrace subsystem"
-- 
2.23.0


