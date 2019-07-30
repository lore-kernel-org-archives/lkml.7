Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9DEC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E9A206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="dC6oi+Se"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387640AbfG3R6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:58:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48833 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfG3R6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:58:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UHvs893321506
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 10:57:54 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UHvs893321506
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564509475;
        bh=r1oFe0NExRxDvbqoUQhui1nWy1esUsk2p5ObdgIFIFw=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=dC6oi+SeDjBhxtIsxeyzgTYUszRlXSa3jrv4AHuImvsJigxv4PjPnqQj8ivnVflhd
         Q62J9HhYoWQzxCBaooPv6SxlLjigdW9VRZW97MnSMIGzp6oS3OfX/fFm38HKPuT3/R
         hDwsdjP5K624GgqRzeNuOWq5Zqz4jaMKXnUAg7dcC49OJjXKaKFX6K4GBE3Os+XlO0
         qc9v4GhSkSeG6q6mNzyZ4kNoeLkTl2CdkY8jwvr7JEVNgdxWBbl6T8SoAld6BHp6Sg
         8FyqsC+c7VLja+eQzkoKE6HCbc3K47/H7aZ27p8vj1Luv2bBkF7M6/uXaiDAIE0cjA
         HCoEwY4mzR7Dg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UHvsmx3321503;
        Tue, 30 Jul 2019 10:57:54 -0700
Date:   Tue, 30 Jul 2019 10:57:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-bsexidtsn91ehdpzcd6n5fm9@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, lclaudio@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org, acme@redhat.com,
        hpa@zytor.com, jolsa@kernel.org, adrian.hunter@intel.com
Reply-To: hpa@zytor.com, jolsa@kernel.org, adrian.hunter@intel.com,
          mingo@kernel.org, tglx@linutronix.de, acme@redhat.com,
          namhyung@kernel.org, linux-kernel@vger.kernel.org,
          lclaudio@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf augmented_raw_syscalls: Rename
 augmented_args_filename to augmented_args_payload
Git-Commit-ID: 6f563674935e6dc9e2190ce798c1917f51af6eed
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

Commit-ID:  6f563674935e6dc9e2190ce798c1917f51af6eed
Gitweb:     https://git.kernel.org/tip/6f563674935e6dc9e2190ce798c1917f51af6eed
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 16 Jul 2019 15:33:20 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:41 -0300

perf augmented_raw_syscalls: Rename augmented_args_filename to augmented_args_payload

It'll get other stuff in there than just filenames, starting with
sockaddr for 'connect' and 'bind'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-bsexidtsn91ehdpzcd6n5fm9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index df52d92e1c69..77bb6a0edce3 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -67,13 +67,15 @@ struct augmented_filename {
 
 pid_filter(pids_filtered);
 
-struct augmented_args_filename {
+struct augmented_args_payload {
        struct syscall_enter_args args;
-       struct augmented_filename filename;
-       struct augmented_filename filename2;
+       struct {
+	       struct augmented_filename filename;
+	       struct augmented_filename filename2;
+       };
 };
 
-bpf_map(augmented_filename_map, PERCPU_ARRAY, int, struct augmented_args_filename, 1);
+bpf_map(augmented_args_tmp, PERCPU_ARRAY, int, struct augmented_args_payload, 1);
 
 static inline
 unsigned int augmented_filename__read(struct augmented_filename *augmented_filename,
@@ -111,7 +113,7 @@ int syscall_unaugmented(struct syscall_enter_args *args)
 
 /*
  * This will be tail_called from SEC("raw_syscalls:sys_enter"), so will find in
- * augmented_filename_map what was read by that raw_syscalls:sys_enter and go
+ * augmented_args_tmp what was read by that raw_syscalls:sys_enter and go
  * on from there, reading the first syscall arg as a string, i.e. open's
  * filename.
  */
@@ -119,7 +121,7 @@ SEC("!syscalls:sys_enter_open")
 int sys_enter_open(struct syscall_enter_args *args)
 {
 	int key = 0;
-	struct augmented_args_filename *augmented_args = bpf_map_lookup_elem(&augmented_filename_map, &key);
+	struct augmented_args_payload *augmented_args = bpf_map_lookup_elem(&augmented_args_tmp, &key);
 	const void *filename_arg = (const void *)args->args[0];
 	unsigned int len = sizeof(augmented_args->args);
 
@@ -136,7 +138,7 @@ SEC("!syscalls:sys_enter_openat")
 int sys_enter_openat(struct syscall_enter_args *args)
 {
 	int key = 0;
-	struct augmented_args_filename *augmented_args = bpf_map_lookup_elem(&augmented_filename_map, &key);
+	struct augmented_args_payload *augmented_args = bpf_map_lookup_elem(&augmented_args_tmp, &key);
 	const void *filename_arg = (const void *)args->args[1];
 	unsigned int len = sizeof(augmented_args->args);
 
@@ -153,7 +155,7 @@ SEC("!syscalls:sys_enter_renameat")
 int sys_enter_renameat(struct syscall_enter_args *args)
 {
 	int key = 0;
-	struct augmented_args_filename *augmented_args = bpf_map_lookup_elem(&augmented_filename_map, &key);
+	struct augmented_args_payload *augmented_args = bpf_map_lookup_elem(&augmented_args_tmp, &key);
 	const void *oldpath_arg = (const void *)args->args[1],
 		   *newpath_arg = (const void *)args->args[3];
 	unsigned int len = sizeof(augmented_args->args), oldpath_len;
@@ -171,7 +173,7 @@ int sys_enter_renameat(struct syscall_enter_args *args)
 SEC("raw_syscalls:sys_enter")
 int sys_enter(struct syscall_enter_args *args)
 {
-	struct augmented_args_filename *augmented_args;
+	struct augmented_args_payload *augmented_args;
 	/*
 	 * We start len, the amount of data that will be in the perf ring
 	 * buffer, if this is not filtered out by one of pid_filter__has(),
@@ -185,7 +187,7 @@ int sys_enter(struct syscall_enter_args *args)
 	struct syscall *syscall;
 	int key = 0;
 
-        augmented_args = bpf_map_lookup_elem(&augmented_filename_map, &key);
+        augmented_args = bpf_map_lookup_elem(&augmented_args_tmp, &key);
         if (augmented_args == NULL)
                 return 1;
 
