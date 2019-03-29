Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1949C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 12:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B029E206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 12:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfC2M04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 08:26:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729384AbfC2M04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 08:26:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4FAC2307D914;
        Fri, 29 Mar 2019 12:26:56 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.117.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 44CC417991;
        Fri, 29 Mar 2019 12:26:50 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Konstantin Khlebnikov <koct9i@gmail.com>,
        Pankaj Gupta <pagupta@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v1] mm: balloon: drop unused function stubs
Date:   Fri, 29 Mar 2019 13:26:49 +0100
Message-Id: <20190329122649.28404-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 29 Mar 2019 12:26:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are leftovers from the pre-"general non-lru movable page" era.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/balloon_compaction.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index f111c780ef1d..f31521dcb09a 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -151,21 +151,6 @@ static inline void balloon_page_delete(struct page *page)
 	list_del(&page->lru);
 }
 
-static inline bool __is_movable_balloon_page(struct page *page)
-{
-	return false;
-}
-
-static inline bool balloon_page_movable(struct page *page)
-{
-	return false;
-}
-
-static inline bool isolated_balloon_page(struct page *page)
-{
-	return false;
-}
-
 static inline bool balloon_page_isolate(struct page *page)
 {
 	return false;
-- 
2.17.2

