Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA51C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B3621871
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="qj4M62X/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfGCOlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:41:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42403 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCOlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:41:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x63Ef2Dn3329448
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Jul 2019 07:41:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x63Ef2Dn3329448
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562164862;
        bh=oKWuq/1GncuYuX6VMCCK1T8qAbAvmX+trRhCiFyGqwo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=qj4M62X/np61HPMsSkQGwHlu8wb5ftZ0/ovkjSkbK9Zy7D56Lnz8QnpetEnMhWDjm
         Zr+uWeLtb10ajK/ZqdlCSEFsmxJ3XODRN4gAqe1QZhIBOSuL/8O30d8W9dTsQsb3FT
         BM6KTSwBYWQHechpVM0o/egfL1BMyG7SAUB9KbIrxF5qczYMCJL65BIthG5t78XiIo
         yr8L8tkWNI9W1HrOkeNzaWZdagvr+OIreVgZej8Jf003jnPY5g7dMfDyY2KcBgcU1b
         S3n7hnqROHCeS5H56GvcfMdn9dFMDvsrRhjxdUNHjZwdKXdd7cq1lcqZ2/6GymC+7f
         4V+KrSahOONow==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x63Ef1kr3329444;
        Wed, 3 Jul 2019 07:41:01 -0700
Date:   Wed, 3 Jul 2019 07:41:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-734ac47e23aee12e1c16a4dd52d7c1cb893eaf6c@git.kernel.org>
Cc:     mingo@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, ak@linux.intel.com, jolsa@kernel.org,
        tglx@linutronix.de
Reply-To: mingo@kernel.org, ak@linux.intel.com, acme@redhat.com,
          jolsa@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190628220900.13741-1-andi@firstfloor.org>
References: <20190628220900.13741-1-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Fix typos / broken sentences
Git-Commit-ID: 734ac47e23aee12e1c16a4dd52d7c1cb893eaf6c
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

Commit-ID:  734ac47e23aee12e1c16a4dd52d7c1cb893eaf6c
Gitweb:     https://git.kernel.org/tip/734ac47e23aee12e1c16a4dd52d7c1cb893eaf6c
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Fri, 28 Jun 2019 15:09:00 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 2 Jul 2019 16:08:16 -0300

perf tools: Fix typos / broken sentences

- Fix a typo in the man page
- Fix a tip that doesn't make any sense.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190628220900.13741-1-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt | 2 +-
 tools/perf/Documentation/tips.txt        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 8c4372819e11..987261d158d4 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -89,7 +89,7 @@ OPTIONS
 	- socket: processor socket number the task ran at the time of sample
 	- srcline: filename and line number executed at the time of sample.  The
 	DWARF debugging info must be provided.
-	- srcfile: file name of the source file of the same. Requires dwarf
+	- srcfile: file name of the source file of the samples. Requires dwarf
 	information.
 	- weight: Event specific weight, e.g. memory latency or transaction
 	abort cost. This is the global weight.
diff --git a/tools/perf/Documentation/tips.txt b/tools/perf/Documentation/tips.txt
index 869965d629ce..825745a645c1 100644
--- a/tools/perf/Documentation/tips.txt
+++ b/tools/perf/Documentation/tips.txt
@@ -38,6 +38,6 @@ To report cacheline events from previous recording: perf c2c report
 To browse sample contexts use perf report --sample 10 and select in context menu
 To separate samples by time use perf report --sort time,overhead,sym
 To set sample time separation other than 100ms with --sort time use --time-quantum
-Add -I to perf report to sample register values visible in perf report context.
+Add -I to perf record to sample register values, which will be visible in perf report sample context.
 To show IPC for sampling periods use perf record -e '{cycles,instructions}:S' and then browse context
 To show context switches in perf report sample context add --switch-events to perf record.
