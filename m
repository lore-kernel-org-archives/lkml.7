Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B758DC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA4521019
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="daml5CCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfE1VZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 17:25:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56851 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfE1VZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 17:25:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4SLOnI92240051
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 28 May 2019 14:24:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4SLOnI92240051
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559078690;
        bh=wd+1Q2iEBloh7OhyhelN1hT7unVWc1UJhsdZzNauNys=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=daml5CCo++JssjCaIvjoZfByeIiuFOpwUmGqXOBc2kAgbC0eNnBV1G8dxwDqjHHKp
         o7kbAacqYx7tUIbfZzqWjjOQmfPzPaCK2hxp3tdjq2feV7dykdmnTQF+N+FawH2GtK
         GOzBfu772yEEk2QOYFKaxRMCNezJpDE7Sz9tWWjx3ALCZeFMbYMbxSxNlXZtmp0bXd
         NYbKiSfHqi4fpHOjhupZj6HfS91EqJYi3CG7VgWgUOqu4x64/tWhhu5LmR1dJ7r6En
         E2UmG36WDFlJN7h0ayYPGMBsJ/9bHAiSl3HgsBN7yOYuxhJdYkpvDwOG99tsrUH/Ng
         7bB0VYLD+4rMg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4SLOmLZ2240048;
        Tue, 28 May 2019 14:24:48 -0700
Date:   Tue, 28 May 2019 14:24:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-lenja6gmy26dkt0ybk747qgq@git.kernel.org>
Cc:     brendan.d.gregg@gmail.com, jolsa@kernel.org, tglx@linutronix.de,
        namhyung@kernel.org, hpa@zytor.com, adrian.hunter@intel.com,
        christian@brauner.io, acme@redhat.com,
        linux-kernel@vger.kernel.org, lclaudio@redhat.com, mingo@kernel.org
Reply-To: namhyung@kernel.org, brendan.d.gregg@gmail.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          jolsa@kernel.org, lclaudio@redhat.com, mingo@kernel.org,
          christian@brauner.io, adrian.hunter@intel.com, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers UAPI: Sync linux/sched.h with the
 kernel
Git-Commit-ID: c27de2b8911db7624be9bde1b5d58067dd58371d
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

Commit-ID:  c27de2b8911db7624be9bde1b5d58067dd58371d
Gitweb:     https://git.kernel.org/tip/c27de2b8911db7624be9bde1b5d58067dd58371d
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 21 May 2019 16:43:32 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 09:49:03 -0300

tools headers UAPI: Sync linux/sched.h with the kernel

To pick up the change in:

  b3e583825266 ("clone: add CLONE_PIDFD")

This requires changes in the 'perf trace' beautification routines for
the 'clone' syscall args, which is done in a followup patch.

This silences the following perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/sched.h' differs from latest version at 'include/uapi/linux/sched.h'
  diff -u tools/include/uapi/linux/sched.h include/uapi/linux/sched.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Christian Brauner <christian@brauner.io>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-lenja6gmy26dkt0ybk747qgq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/sched.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
index 22627f80063e..ed4ee170bee2 100644
--- a/tools/include/uapi/linux/sched.h
+++ b/tools/include/uapi/linux/sched.h
@@ -10,6 +10,7 @@
 #define CLONE_FS	0x00000200	/* set if fs info shared between processes */
 #define CLONE_FILES	0x00000400	/* set if open files shared between processes */
 #define CLONE_SIGHAND	0x00000800	/* set if signal handlers and blocked signals shared */
+#define CLONE_PIDFD	0x00001000	/* set if a pidfd should be placed in parent */
 #define CLONE_PTRACE	0x00002000	/* set if we want to let tracing continue on the child too */
 #define CLONE_VFORK	0x00004000	/* set if the parent wants the child to wake it up on mm_release */
 #define CLONE_PARENT	0x00008000	/* set if we want to have the same parent as the cloner */
