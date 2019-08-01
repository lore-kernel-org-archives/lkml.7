Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CEAC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF732171F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732077AbfHAPr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:47:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729173AbfHAPrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:47:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 61E7730C2E70;
        Thu,  1 Aug 2019 15:47:55 +0000 (UTC)
Received: from jsavitz.bos.com (dhcp-17-105.bos.redhat.com [10.18.17.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 306271001B09;
        Thu,  1 Aug 2019 15:47:54 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Yu Zhao <yuzhao@google.com>, trivial@kernel.org
Subject: [PATCH] mm: fix typo in comment
Date:   Thu,  1 Aug 2019 11:47:34 -0400
Message-Id: <1564674454-22469-1-git-send-email-jsavitz@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 01 Aug 2019 15:47:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spelling of successful (currently spelled successfull in kernel
source)

Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 include/linux/compaction.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 9569e7c786d3..4122df65eb44 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -38,12 +38,12 @@ enum compact_result {
 	COMPACT_CONTINUE,
 
 	/*
-	 * The full zone was compacted scanned but wasn't successfull to compact
+	 * The full zone was compacted scanned but wasn't successful to compact
 	 * suitable pages.
 	 */
 	COMPACT_COMPLETE,
 	/*
-	 * direct compaction has scanned part of the zone but wasn't successfull
+	 * direct compaction has scanned part of the zone but wasn't successful
 	 * to compact suitable pages.
 	 */
 	COMPACT_PARTIAL_SKIPPED,
-- 
2.18.1

