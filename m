Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B41CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C862067B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 06:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfJUG1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 02:27:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33233 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfJUG05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 02:26:57 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMR9N-00025i-GO; Mon, 21 Oct 2019 08:26:41 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 201CC1C047B;
        Mon, 21 Oct 2019 08:26:41 +0200 (CEST)
Date:   Mon, 21 Oct 2019 06:26:40 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] tools headers UAPI: Sync sched.h with the kernel
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-xqruu8wohwlbc57udg1g0xzx@git.kernel.org>
References: <tip-xqruu8wohwlbc57udg1g0xzx@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157163920086.29376.11201291375139295425.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     5eca1379c0eb06e3908179665230a86d19bd2df7
Gitweb:        https://git.kernel.org/tip/5eca1379c0eb06e3908179665230a86d19bd2df7
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 15 Oct 2019 12:44:00 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 15 Oct 2019 12:44:00 -03:00

tools headers UAPI: Sync sched.h with the kernel

To get the changes in:

  78f6face5af3 ("sched: add kernel-doc for struct clone_args")
  f14c234b4bc5 ("clone3: switch to copy_struct_from_user()")

This file gets rebuilt, but no changes ensues:

   CC       /tmp/build/perf/trace/beauty/clone.o

This addresses this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/sched.h' differs from latest version at 'include/uapi/linux/sched.h'
  diff -u tools/include/uapi/linux/sched.h include/uapi/linux/sched.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-xqruu8wohwlbc57udg1g0xzx@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/sched.h | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
index b3105ac..99335e1 100644
--- a/tools/include/uapi/linux/sched.h
+++ b/tools/include/uapi/linux/sched.h
@@ -33,8 +33,31 @@
 #define CLONE_NEWNET		0x40000000	/* New network namespace */
 #define CLONE_IO		0x80000000	/* Clone io context */
 
-/*
- * Arguments for the clone3 syscall
+#ifndef __ASSEMBLY__
+/**
+ * struct clone_args - arguments for the clone3 syscall
+ * @flags:       Flags for the new process as listed above.
+ *               All flags are valid except for CSIGNAL and
+ *               CLONE_DETACHED.
+ * @pidfd:       If CLONE_PIDFD is set, a pidfd will be
+ *               returned in this argument.
+ * @child_tid:   If CLONE_CHILD_SETTID is set, the TID of the
+ *               child process will be returned in the child's
+ *               memory.
+ * @parent_tid:  If CLONE_PARENT_SETTID is set, the TID of
+ *               the child process will be returned in the
+ *               parent's memory.
+ * @exit_signal: The exit_signal the parent process will be
+ *               sent when the child exits.
+ * @stack:       Specify the location of the stack for the
+ *               child process.
+ * @stack_size:  The size of the stack for the child process.
+ * @tls:         If CLONE_SETTLS is set, the tls descriptor
+ *               is set to tls.
+ *
+ * The structure is versioned by size and thus extensible.
+ * New struct members must go at the end of the struct and
+ * must be properly 64bit aligned.
  */
 struct clone_args {
 	__aligned_u64 flags;
@@ -46,6 +69,9 @@ struct clone_args {
 	__aligned_u64 stack_size;
 	__aligned_u64 tls;
 };
+#endif
+
+#define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
 
 /*
  * Scheduling policies
