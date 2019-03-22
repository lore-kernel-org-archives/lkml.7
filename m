Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E6BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCA621971
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfCVWZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:25:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54625 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfCVWZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:25:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMOk3l752597
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:24:46 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMOjrj752594;
        Fri, 22 Mar 2019 15:24:45 -0700
Date:   Fri, 22 Mar 2019 15:24:45 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Changbin Du <tipbot@zytor.com>
Message-ID: <tip-af7a14a750b8eb3cdb26ec15344616ca170b06f2@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        peterz@infradead.org, rostedt@goodmis.org, jolsa@kernel.org,
        namhyung@kernel.org, acme@redhat.com, daniel@iogearbox.net,
        changbin.du@gmail.com, hpa@zytor.com, tglx@linutronix.de
Reply-To: mingo@kernel.org, ast@kernel.org, linux-kernel@vger.kernel.org,
          peterz@infradead.org, rostedt@goodmis.org, jolsa@kernel.org,
          namhyung@kernel.org, changbin.du@gmail.com, acme@redhat.com,
          daniel@iogearbox.net, hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <20190316080556.3075-2-changbin.du@gmail.com>
References: <20190316080556.3075-2-changbin.du@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Add doc about how to build perf with
 Asan and UBSan
Git-Commit-ID: af7a14a750b8eb3cdb26ec15344616ca170b06f2
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

Commit-ID:  af7a14a750b8eb3cdb26ec15344616ca170b06f2
Gitweb:     https://git.kernel.org/tip/af7a14a750b8eb3cdb26ec15344616ca170b06f2
Author:     Changbin Du <changbin.du@gmail.com>
AuthorDate: Sat, 16 Mar 2019 16:05:41 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Mar 2019 16:52:04 -0300

perf tools: Add doc about how to build perf with Asan and UBSan

AddressSanitizer (or ASan) and UndefinedBehaviorSanitizer (or UBSan) are
very useful tools to detect program bugs:

 - AddressSanitizer (or ASan) is a GCC feature that detects memory
   corruption bugs such as buffer overflows and memory leaks.

 - UndefinedBehaviorSanitizer (or UBSan) is a fast undefined behavior
   detector supported by GCC. UBSan detects undefined behaviors of programs
   at runtime.

This patch adds a document about how to use them on perf. Later patches will fix
some of the issues disclosed by them.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20190316080556.3075-2-changbin.du@gmail.com
[ Make some changes based on comments made by Jiri Olsa ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/Build.txt | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/perf/Documentation/Build.txt b/tools/perf/Documentation/Build.txt
index f6fc6507ba55..3766886c4bca 100644
--- a/tools/perf/Documentation/Build.txt
+++ b/tools/perf/Documentation/Build.txt
@@ -47,3 +47,27 @@ Those objects are then used in final linking:
 
 NOTE this description is omitting other libraries involved, only
      focusing on build framework outcomes
+
+3) Build with ASan or UBSan
+==========================
+  $ cd tools/perf
+  $ make DESTDIR=/usr
+  $ make DESTDIR=/usr install
+
+AddressSanitizer (or ASan) is a GCC feature that detects memory corruption bugs
+such as buffer overflows and memory leaks.
+
+  $ cd tools/perf
+  $ make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=address'
+  $ ASAN_OPTIONS=log_path=asan.log ./perf record -a
+
+ASan outputs all detected issues into a log file named 'asan.log.<pid>'.
+
+UndefinedBehaviorSanitizer (or UBSan) is a fast undefined behavior detector
+supported by GCC. UBSan detects undefined behaviors of programs at runtime.
+
+  $ cd tools/perf
+  $ make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=undefined'
+  $ UBSAN_OPTIONS=print_stacktrace=1 ./perf record -a
+
+If UBSan detects any problem at runtime, it outputs a “runtime error:” message.
