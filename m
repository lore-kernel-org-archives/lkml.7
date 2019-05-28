Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1F6C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4072021019
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ItWNDl/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfE1VZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 17:25:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57859 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfE1VZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 17:25:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4SLPU2j2240168
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 28 May 2019 14:25:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4SLPU2j2240168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559078730;
        bh=BHFswm328hwysMDs/6CuLlvN4IAwBP17ftSZCSSjkBs=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=ItWNDl/LyMbrKwYJtbi4BobHPsFWyBXUQPP+pWtgkN6Sveollhg4yCOw2LN5tmbyy
         Qm5FD7A9BaWYkGik1Y9tFdCgiY0dZkzqwnPaiMHQkJ4lY3mMYbZqBLWEYCPb28iPGo
         ro4j5HHiwRTIH4WRDGFDJLG3LpLuOxgPg03hABntRhdG8kRZ1RR5Qsm6uCG86DV8LW
         +v2yR+BAhVvCk9K8nSrV/t/jhu97LVlq9IYEUBShfuOd7yg+LtvXjGEtQefz2M9uH5
         NfWB2UnGRd/vJlb+/LJXPJDselS7lmLKTnHM0ODrIAXl07VxrsEdQfUhqEdWldTfRh
         QxcpG7K5jRrUg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4SLPUnE2240165;
        Tue, 28 May 2019 14:25:30 -0700
Date:   Tue, 28 May 2019 14:25:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-at3uoqcvmqdkwaysmvbj1wpv@git.kernel.org>
Cc:     namhyung@kernel.org, acme@redhat.com, lclaudio@redhat.com,
        jolsa@kernel.org, brendan.d.gregg@gmail.com,
        torvalds@linux-foundation.org, amir73il@gmail.com,
        tglx@linutronix.de, adrian.hunter@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: namhyung@kernel.org, acme@redhat.com, lclaudio@redhat.com,
          jolsa@kernel.org, brendan.d.gregg@gmail.com, tglx@linutronix.de,
          torvalds@linux-foundation.org, amir73il@gmail.com,
          adrian.hunter@intel.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers UAPI: Sync linux/fs.h with the
 kernel
Git-Commit-ID: b5b999dca673bd7b2d4c267faf3478dca7baff7f
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

Commit-ID:  b5b999dca673bd7b2d4c267faf3478dca7baff7f
Gitweb:     https://git.kernel.org/tip/b5b999dca673bd7b2d4c267faf3478dca7baff7f
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 21 May 2019 17:07:20 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 09:49:03 -0300

tools headers UAPI: Sync linux/fs.h with the kernel

To pick up the changes in:

  c553ea4fdf27 ("fs/sync.c: sync_file_range(2) may use WB_SYNC_ALL writeback")

That should be used to beautify the 'sync_file_range' syscall 'flags'
arg.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/fs.h' differs from latest version at 'include/uapi/linux/fs.h'
  diff -u tools/include/uapi/linux/fs.h include/uapi/linux/fs.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-at3uoqcvmqdkwaysmvbj1wpv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/fs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
index 121e82ce296b..59c71fa8c553 100644
--- a/tools/include/uapi/linux/fs.h
+++ b/tools/include/uapi/linux/fs.h
@@ -320,6 +320,9 @@ struct fscrypt_key {
 #define SYNC_FILE_RANGE_WAIT_BEFORE	1
 #define SYNC_FILE_RANGE_WRITE		2
 #define SYNC_FILE_RANGE_WAIT_AFTER	4
+#define SYNC_FILE_RANGE_WRITE_AND_WAIT	(SYNC_FILE_RANGE_WRITE | \
+					 SYNC_FILE_RANGE_WAIT_BEFORE | \
+					 SYNC_FILE_RANGE_WAIT_AFTER)
 
 /*
  * Flags for preadv2/pwritev2:
