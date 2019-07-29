Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E78C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087D121655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="L0y/MpgC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbfG2VdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:33:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53925 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388456AbfG2VdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:33:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6TLX4rw2941263
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Jul 2019 14:33:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6TLX4rw2941263
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564435984;
        bh=RxgWcWjCvogAMMGpY81mcbBrBjbvnNV5HfFJSOgJxs8=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=L0y/MpgCLewMKl1O2YYbPrVOhFNB0QLxXR2eB3YXfJG1CSikJahDkeB2eq9mup7nT
         AzYSaTCaBHQAh3FmhBjZcgmGaK16DwZQRunzUZW9QUFFvk0gbwcOJFt/vw5NFAy5Ia
         jilU48OJstxwmdwA5eT8cW4UhWE4IA2omGxTucqAw25AQjN2u2MY7WFrHbdLauvONX
         tdSsGPzIozHFhzgCSyuibps6TLopiaHqTR29LspE9TDnbQ+FBQBayqO8oFBoLF8kVM
         FGHKTMU0a6ds6wR/saeMZ9qwNfLCQlDGQqsCZiVSoV8IcWt2B+u2vA60muNhhiEkEP
         4BcaStENnR/cQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6TLX4HN2941258;
        Mon, 29 Jul 2019 14:33:04 -0700
Date:   Mon, 29 Jul 2019 14:33:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-mtrpsjrux5hgyr5uf8l1aa46@git.kernel.org>
Cc:     christian@brauner.io, jolsa@kernel.org, lclaudio@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        adrian.hunter@intel.com, acme@redhat.com, hpa@zytor.com,
        patrick.bellasi@arm.com, mingo@kernel.org, namhyung@kernel.org
Reply-To: lclaudio@redhat.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, christian@brauner.io,
          jolsa@kernel.org, mingo@kernel.org, patrick.bellasi@arm.com,
          namhyung@kernel.org, adrian.hunter@intel.com, acme@redhat.com,
          hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers UAPI: Sync sched.h with the kernel
Git-Commit-ID: c093de6bd3c50d3dd597ff9fa5cf7a30acbb3eb7
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c093de6bd3c50d3dd597ff9fa5cf7a30acbb3eb7
Gitweb:     https://git.kernel.org/tip/c093de6bd3c50d3dd597ff9fa5cf7a30acbb3eb7
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 26 Jul 2019 15:41:09 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 09:03:43 -0300

tools headers UAPI: Sync sched.h with the kernel

To get the changes in:

  a509a7cd7974 ("sched/uclamp: Extend sched_setattr() to support utilization clamping")
  1d6362fa0cfc ("sched/core: Allow sched_setattr() to use the current policy")
  7f192e3cd316 ("fork: add clone3")

And silence this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/sched.h' differs from latest version at 'include/uapi/linux/sched.h'
  diff -u tools/include/uapi/linux/sched.h include/uapi/linux/sched.h

No changes in tools/ due to the above.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christian Brauner <christian@brauner.io>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>
Link: https://lkml.kernel.org/n/tip-mtrpsjrux5hgyr5uf8l1aa46@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/sched.h | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
index ed4ee170bee2..b3105ac1381a 100644
--- a/tools/include/uapi/linux/sched.h
+++ b/tools/include/uapi/linux/sched.h
@@ -2,6 +2,8 @@
 #ifndef _UAPI_LINUX_SCHED_H
 #define _UAPI_LINUX_SCHED_H
 
+#include <linux/types.h>
+
 /*
  * cloning flags:
  */
@@ -31,6 +33,20 @@
 #define CLONE_NEWNET		0x40000000	/* New network namespace */
 #define CLONE_IO		0x80000000	/* Clone io context */
 
+/*
+ * Arguments for the clone3 syscall
+ */
+struct clone_args {
+	__aligned_u64 flags;
+	__aligned_u64 pidfd;
+	__aligned_u64 child_tid;
+	__aligned_u64 parent_tid;
+	__aligned_u64 exit_signal;
+	__aligned_u64 stack;
+	__aligned_u64 stack_size;
+	__aligned_u64 tls;
+};
+
 /*
  * Scheduling policies
  */
@@ -51,9 +67,21 @@
 #define SCHED_FLAG_RESET_ON_FORK	0x01
 #define SCHED_FLAG_RECLAIM		0x02
 #define SCHED_FLAG_DL_OVERRUN		0x04
+#define SCHED_FLAG_KEEP_POLICY		0x08
+#define SCHED_FLAG_KEEP_PARAMS		0x10
+#define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
+#define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
+
+#define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
+				 SCHED_FLAG_KEEP_PARAMS)
+
+#define SCHED_FLAG_UTIL_CLAMP	(SCHED_FLAG_UTIL_CLAMP_MIN | \
+				 SCHED_FLAG_UTIL_CLAMP_MAX)
 
 #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
 			 SCHED_FLAG_RECLAIM		| \
-			 SCHED_FLAG_DL_OVERRUN)
+			 SCHED_FLAG_DL_OVERRUN		| \
+			 SCHED_FLAG_KEEP_ALL		| \
+			 SCHED_FLAG_UTIL_CLAMP)
 
 #endif /* _UAPI_LINUX_SCHED_H */
