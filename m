Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEB8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416D720811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FtUfKgVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfC1TPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:15:14 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:65096 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfC1TPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1553800513; x=1585336513;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=BMovtFduC4lfrbOuzCW01vH9HInwsDmp0zbBYLbz72M=;
  b=FtUfKgVd7ztDi7x1NXkbVJ2oZCUFB2lZ66CzmIVuxprsePymy6I1/4+t
   AkIYmir9UAjqetQPi9iUmEn27lRhH1ltpOxw3YxzQjs5fa6/8wEOcYdfD
   TNZZ8xN2b353XBcIuymIHeNNQJKRXjjIHVMaAH4FKi5WzC7b0a609L1P1
   0=;
X-IronPort-AV: E=Sophos;i="5.60,281,1549929600"; 
   d="scan'208";a="724783896"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 Mar 2019 19:15:12 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x2SJFB17047055
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 28 Mar 2019 19:15:11 GMT
Received: from EX13D19EUA003.ant.amazon.com (10.43.165.175) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 28 Mar 2019 19:15:11 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D19EUA003.ant.amazon.com (10.43.165.175) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 28 Mar 2019 19:15:10 +0000
Received: from galpress-VirtualBox.hfa13.amazon.com (10.95.85.147) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 28 Mar 2019 19:15:08 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Gal Pressman <galpress@amazon.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH] lib/scatterlist: Remove leftover from sg_page_iter comment
Date:   Thu, 28 Mar 2019 21:14:51 +0200
Message-ID: <1553800491-28583-1-git-send-email-galpress@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d901b2760dc6 ("lib/scatterlist: Provide a DMA page iterator")
added the sg DMA iterator but a leftover remained in the sg_page_iter
documentation, remove it.

Cc: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 include/linux/scatterlist.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index b4be960c7e5d..30a9a55c28ba 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -340,11 +340,11 @@ int sg_alloc_table_chained(struct sg_table *table, int nents,
  * sg page iterator
  *
  * Iterates over sg entries page-by-page.  On each successful iteration, you
- * can call sg_page_iter_page(@piter) to get the current page and its dma
- * address. @piter->sg will point to the sg holding this page and
- * @piter->sg_pgoffset to the page's page offset within the sg. The iteration
- * will stop either when a maximum number of sg entries was reached or a
- * terminating sg (sg_last(sg) == true) was reached.
+ * can call sg_page_iter_page(@piter) to get the current page.
+ * @piter->sg will point to the sg holding this page and @piter->sg_pgoffset to
+ * the page's page offset within the sg. The iteration will stop either when a
+ * maximum number of sg entries was reached or a terminating sg
+ * (sg_last(sg) == true) was reached.
  */
 struct sg_page_iter {
 	struct scatterlist	*sg;		/* sg holding the page */
-- 
2.7.4

