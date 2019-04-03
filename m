Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279D7C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFEB3206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfDCKkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:40:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43421 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfDCKkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:40:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x33Ae93W1812139
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Apr 2019 03:40:09 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x33Ae8rk1812136;
        Wed, 3 Apr 2019 03:40:08 -0700
Date:   Wed, 3 Apr 2019 03:40:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Shaokun Zhang <tipbot@zytor.com>
Message-ID: <tip-1279e41d535e28cc3b56fa4a09e71a709641cae6@git.kernel.org>
Cc:     vincent.weaver@maine.edu, jolsa@redhat.com, songliubraving@fb.com,
        torvalds@linux-foundation.org, acme@redhat.com, eranian@google.com,
        linux-kernel@vger.kernel.org, zhangshaokun@hisilicon.com,
        acme@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        hpa@zytor.com, alexander.shishkin@linux.intel.com, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          zhangshaokun@hisilicon.com, acme@kernel.org, acme@redhat.com,
          eranian@google.com, mingo@kernel.org,
          alexander.shishkin@linux.intel.com, hpa@zytor.com,
          peterz@infradead.org, vincent.weaver@maine.edu,
          torvalds@linux-foundation.org, songliubraving@fb.com,
          jolsa@redhat.com
In-Reply-To: <1554274464-5739-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1554274464-5739-1-git-send-email-zhangshaokun@hisilicon.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/headers: Fix stale comment for struct
 perf_addr_filter
Git-Commit-ID: 1279e41d535e28cc3b56fa4a09e71a709641cae6
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

Commit-ID:  1279e41d535e28cc3b56fa4a09e71a709641cae6
Gitweb:     https://git.kernel.org/tip/1279e41d535e28cc3b56fa4a09e71a709641cae6
Author:     Shaokun Zhang <zhangshaokun@hisilicon.com>
AuthorDate: Wed, 3 Apr 2019 14:54:24 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Apr 2019 11:40:02 +0200

perf/headers: Fix stale comment for struct perf_addr_filter

The @inode field has been removed after:

  9511bce9fe8e ("perf/core: Fix bad use of igrab()")

Update the description.

Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: https://lkml.kernel.org/r/1554274464-5739-1-git-send-email-zhangshaokun@hisilicon.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e47ef764f613..085a95e2582a 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -464,7 +464,7 @@ enum perf_addr_filter_action_t {
 /**
  * struct perf_addr_filter - address range filter definition
  * @entry:	event's filter list linkage
- * @inode:	object file's inode for file-based filters
+ * @path:	object file's path for file-based filters
  * @offset:	filter range offset
  * @size:	filter range size (size==0 means single address trigger)
  * @action:	filter/start/stop
