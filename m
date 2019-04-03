Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95778C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648E82084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfDCGza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 02:55:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6221 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725936AbfDCGz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 02:55:29 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [10.3.19.201])
        by Forcepoint Email with ESMTP id E32C3341DD76D07174F0;
        Wed,  3 Apr 2019 14:55:27 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Wed, 3 Apr 2019 14:55:20 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH] perf: Fix stale comment for struct perf_addr_filter
Date:   Wed, 3 Apr 2019 14:54:24 +0800
Message-ID: <1554274464-5739-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

inode has been removed after commit 9511bce9fe8e
("perf/core: Fix bad use of igrab()"), Let's fix the stale comment. 

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org> 
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
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
-- 
2.7.4

