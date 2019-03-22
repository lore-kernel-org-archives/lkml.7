Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF6DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631D62190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfCVWKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:10:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52015 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbfCVWKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:10:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMATLO748465
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:10:29 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMAS8Y748462;
        Fri, 22 Mar 2019 15:10:28 -0700
Date:   Fri, 22 Mar 2019 15:10:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-mqpvshayeqidlulx5qpioa59@git.kernel.org>
Cc:     namhyung@kernel.org, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, adrian.hunter@intel.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, acme@redhat.com, arnd@arndb.de
Reply-To: mingo@kernel.org, namhyung@kernel.org, hpa@zytor.com,
          tglx@linutronix.de, adrian.hunter@intel.com, acme@redhat.com,
          linux-kernel@vger.kernel.org, jolsa@kernel.org, arnd@arndb.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Update x86's syscall_64.tbl, no
 change in tools/perf behaviour
Git-Commit-ID: df94bb44b518b1d0c9f4b2e5127441cec13ab75c
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

Commit-ID:  df94bb44b518b1d0c9f4b2e5127441cec13ab75c
Gitweb:     https://git.kernel.org/tip/df94bb44b518b1d0c9f4b2e5127441cec13ab75c
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 11 Mar 2019 13:20:25 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 11 Mar 2019 16:13:04 -0300

perf tools: Update x86's syscall_64.tbl, no change in tools/perf behaviour

To pick the changes in 7948450d4556 ("x86/x32: use time64 versions of
sigtimedwait and recvmmsg"), that doesn't cause any change in behaviour
in tools/perf/ as it deals just with the x32 entries.

This silences this tools/perf build warning:

  Warning: Kernel ABI header at 'tools/perf/arch/x86/entry/syscalls/syscall_64.tbl' differs from latest version at 'arch/x86/entry/syscalls/syscall_64.tbl'
  diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-mqpvshayeqidlulx5qpioa59@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index f0b1709a5ffb..2ae92fddb6d5 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -343,6 +343,8 @@
 332	common	statx			__x64_sys_statx
 333	common	io_pgetevents		__x64_sys_io_pgetevents
 334	common	rseq			__x64_sys_rseq
+# don't use numbers 387 through 423, add new calls after the last
+# 'common' entry
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
@@ -361,7 +363,7 @@
 520	x32	execve			__x32_compat_sys_execve/ptregs
 521	x32	ptrace			__x32_compat_sys_ptrace
 522	x32	rt_sigpending		__x32_compat_sys_rt_sigpending
-523	x32	rt_sigtimedwait		__x32_compat_sys_rt_sigtimedwait
+523	x32	rt_sigtimedwait		__x32_compat_sys_rt_sigtimedwait_time64
 524	x32	rt_sigqueueinfo		__x32_compat_sys_rt_sigqueueinfo
 525	x32	sigaltstack		__x32_compat_sys_sigaltstack
 526	x32	timer_create		__x32_compat_sys_timer_create
@@ -375,7 +377,7 @@
 534	x32	preadv			__x32_compat_sys_preadv64
 535	x32	pwritev			__x32_compat_sys_pwritev64
 536	x32	rt_tgsigqueueinfo	__x32_compat_sys_rt_tgsigqueueinfo
-537	x32	recvmmsg		__x32_compat_sys_recvmmsg
+537	x32	recvmmsg		__x32_compat_sys_recvmmsg_time64
 538	x32	sendmmsg		__x32_compat_sys_sendmmsg
 539	x32	process_vm_readv	__x32_compat_sys_process_vm_readv
 540	x32	process_vm_writev	__x32_compat_sys_process_vm_writev
