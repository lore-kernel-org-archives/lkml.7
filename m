Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CFEC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01B7214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 15:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="TKzxJkwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfKKPdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 10:33:24 -0500
Received: from m15-113.126.com ([220.181.15.113]:54731 "EHLO m15-113.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbfKKPdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 10:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=qqgR4erttvSYHaqDtp
        mtVFpbTZvuyXg6U4zdPq3Zc/w=; b=TKzxJkwTHHTCC3YnmIXAnQCE0xE0sehgew
        rNbCamoX9C2DrbiM/Oc/AanQmR6Q39s5p0HCgxYyCV/qKzMJs/4GDqMeLnmnA/qQ
        OJkF6D4hvV5FDCg+jSqq7GvnfdIAvTnEwlO7PgqW8ZnU9Y3T+h+mVxxGTddOzAJm
        SVbnlgFYU=
Received: from 192.168.137.243 (unknown [112.10.84.216])
        by smtp3 (Coremail) with SMTP id DcmowAC3hvL5fsldLkiyAQ--.26737S3;
        Mon, 11 Nov 2019 23:32:11 +0800 (CST)
From:   Xianting Tian <xianting_tian@126.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/vmscan.c: Fix typo in comment
Date:   Mon, 11 Nov 2019 10:32:07 -0500
Message-Id: <1573486327-9591-1-git-send-email-xianting_tian@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DcmowAC3hvL5fsldLkiyAQ--.26737S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr45Zw1Uuw1rJw1DZrWfAFb_yoW3ZFbE9a
        y09F42g3ykZF97Cw15AayftF10grs09FyUGw1Fqa1aqay8Z395XFySyFyavr4UWa12kF95
        u3ZFvFW8Cr1xWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8WE_tUUUUU==
X-Originating-IP: [112.10.84.216]
X-CM-SenderInfo: h0ld03plqjs3xldqqiyswou0bp/1tbi9AVppFpD9EeVYAABsi
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the typo "resheduled" -> "rescheduled" in comment

Signed-off-by: Xianting Tian <xianting_tian@126.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index ee4eecc..ece8dbc 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1820,7 +1820,7 @@ int isolate_lru_page(struct page *page)
 
 /*
  * A direct reclaimer may isolate SWAP_CLUSTER_MAX pages from the LRU list and
- * then get resheduled. When there are massive number of tasks doing page
+ * then get rescheduled. When there are massive number of tasks doing page
  * allocation, such sleeping direct reclaimers may keep piling up on each CPU,
  * the LRU list will go small and be scanned faster than necessary, leading to
  * unnecessary swapping, thrashing and OOM.
-- 
1.8.3.1

