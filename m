Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E950C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B552206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="e4XFp9v0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbfFQS6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 14:58:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56001 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfFQS6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:58:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HIvmZA3553858
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 11:57:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HIvmZA3553858
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560797869;
        bh=2FgM6ClHpz1bdgPSC+oQQCglJgLIa1A4ZpLRyZZv8n8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=e4XFp9v0Jb01TkWFbO48nt5oo+i/oAWq4Y/LAI7Mncordi9L9dzrmwp9Xm3vgXGtu
         1Z7pJCtpumYRXpKELo6rnNhzbPLGqlPTlHNlVYKPjbh/vixoMa2hzXxZYTlcXrXcbq
         EoRpC9mHP2IrYUJM3i5UwT53sqZGIt+RBf84+RD3Q8wjS6pCyqgq2d3QUQvuSP+cuR
         ZvWRpUdGdUYNM6RZ1c8BLmzcnkt54tz3xyWrgT0BWXY4rEZtLh8aerSmgL0a7+XXl1
         grS6gk2zC+ayDTVMsrJ4oNMFen5wBzgHQ2xqbVYFF0usKnSJ5GmRGRhE5OwwR4Mgsm
         /g1AdiwN53d7Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HIvmMD3553855;
        Mon, 17 Jun 2019 11:57:48 -0700
Date:   Mon, 17 Jun 2019 11:57:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-e5f177a578edf4501d0758bfa922cd0b0f9d0e9d@git.kernel.org>
Cc:     namhyung@kernel.org, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
        jolsa@redhat.com
Reply-To: tglx@linutronix.de, alexander.shishkin@linux.intel.com,
          mingo@kernel.org, hpa@zytor.com, jolsa@redhat.com,
          peterz@infradead.org, namhyung@kernel.org, leo.yan@linaro.org,
          linux-kernel@vger.kernel.org, acme@redhat.com
In-Reply-To: <20190530093801.20510-1-leo.yan@linaro.org>
References: <20190530093801.20510-1-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf symbols: Remove unused variable 'err'
Git-Commit-ID: e5f177a578edf4501d0758bfa922cd0b0f9d0e9d
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

Commit-ID:  e5f177a578edf4501d0758bfa922cd0b0f9d0e9d
Gitweb:     https://git.kernel.org/tip/e5f177a578edf4501d0758bfa922cd0b0f9d0e9d
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Thu, 30 May 2019 17:38:01 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 5 Jun 2019 09:47:54 -0300

perf symbols: Remove unused variable 'err'

Variable 'err' is defined but never used in function symsrc__init(),
remove it and directly return -1 at the end of the function.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190530093801.20510-1-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 4ad106a5f2c0..fdc5bd7dbb90 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -699,7 +699,6 @@ bool __weak elf__needs_adjust_symbols(GElf_Ehdr ehdr)
 int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 		 enum dso_binary_type type)
 {
-	int err = -1;
 	GElf_Ehdr ehdr;
 	Elf *elf;
 	int fd;
@@ -793,7 +792,7 @@ out_elf_end:
 	elf_end(elf);
 out_close:
 	close(fd);
-	return err;
+	return -1;
 }
 
 /**
