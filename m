Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC06C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 02:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7E521A4A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 02:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391639AbfIZCh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 22:37:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:43690 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391561AbfIZCh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 22:37:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2019 19:37:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,550,1559545200"; 
   d="scan'208";a="193985960"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga006.jf.intel.com with ESMTP; 25 Sep 2019 19:37:25 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     akpm@linux-foundation.org, willy@infradead.org, jglisse@redhat.com,
        rcampbell@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH] mm: fix typo in the comment when calling function __SetPageUptodate()
Date:   Thu, 26 Sep 2019 10:37:05 +0800
Message-Id: <20190926023705.7226-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several places emphasise the effect of __SetPageUptodate(),
while the comment seems to have a typo in two places.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/memory.c      | 2 +-
 mm/userfaultfd.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index b1ca51a079f2..3ac2803d49b8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3009,7 +3009,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 
 	/*
 	 * The memory barrier inside __SetPageUptodate makes sure that
-	 * preceeding stores to the page contents become visible before
+	 * preceding stores to the page contents become visible before
 	 * the set_pte_at() write.
 	 */
 	__SetPageUptodate(page);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 80834c644692..c153344774c7 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -90,7 +90,7 @@ static int mcopy_atomic_pte(struct mm_struct *dst_mm,
 
 	/*
 	 * The memory barrier inside __SetPageUptodate makes sure that
-	 * preceeding stores to the page contents become visible before
+	 * preceding stores to the page contents become visible before
 	 * the set_pte_at() write.
 	 */
 	__SetPageUptodate(page);
-- 
2.17.1

