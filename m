Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B11C47404
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 12:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAC9206CD
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 12:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731656AbfILMcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 08:32:11 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:62304 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731283AbfILMcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 08:32:10 -0400
X-IronPort-AV: E=Sophos;i="5.64,495,1559491200"; 
   d="scan'208";a="75376858"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 12 Sep 2019 20:32:07 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 5C6DB4CE030A;
        Thu, 12 Sep 2019 20:31:55 +0800 (CST)
Received: from TSAO.g08.fujitsu.local (10.167.226.60) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Thu, 12 Sep 2019 20:32:13 +0800
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <rppt@linux.ibm.com>
Subject: [PATCH] mm/memblock: cleanup doc
Date:   Thu, 12 Sep 2019 20:31:27 +0800
Message-ID: <20190912123127.8694-1-caoj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: 5C6DB4CE030A.A8C2F
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix typos for:
    elaboarte -> elaborate
    architecure -> architecture
    compltes -> completes

And, convert the markup :c:func:`foo` to foo() as kernel documentation
toolchain can recognize foo() as a function.

Suggested-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 mm/memblock.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 7d4f61ae666a..c23b370cc49e 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -57,42 +57,38 @@
  * at build time. The region arrays for the "memory" and "reserved"
  * types are initially sized to %INIT_MEMBLOCK_REGIONS and for the
  * "physmap" type to %INIT_PHYSMEM_REGIONS.
- * The :c:func:`memblock_allow_resize` enables automatic resizing of
- * the region arrays during addition of new regions. This feature
- * should be used with care so that memory allocated for the region
- * array will not overlap with areas that should be reserved, for
- * example initrd.
+ * The memblock_allow_resize() enables automatic resizing of the region
+ * arrays during addition of new regions. This feature should be used
+ * with care so that memory allocated for the region array will not
+ * overlap with areas that should be reserved, for example initrd.
  *
  * The early architecture setup should tell memblock what the physical
- * memory layout is by using :c:func:`memblock_add` or
- * :c:func:`memblock_add_node` functions. The first function does not
- * assign the region to a NUMA node and it is appropriate for UMA
- * systems. Yet, it is possible to use it on NUMA systems as well and
- * assign the region to a NUMA node later in the setup process using
- * :c:func:`memblock_set_node`. The :c:func:`memblock_add_node`
- * performs such an assignment directly.
+ * memory layout is by using memblock_add() or memblock_add_node()
+ * functions. The first function does not assign the region to a NUMA
+ * node and it is appropriate for UMA systems. Yet, it is possible to
+ * use it on NUMA systems as well and assign the region to a NUMA node
+ * later in the setup process using memblock_set_node(). The
+ * memblock_add_node() performs such an assignment directly.
  *
  * Once memblock is setup the memory can be allocated using one of the
  * API variants:
  *
- * * :c:func:`memblock_phys_alloc*` - these functions return the
- *   **physical** address of the allocated memory
- * * :c:func:`memblock_alloc*` - these functions return the **virtual**
- *   address of the allocated memory.
+ * * memblock_phys_alloc*() - these functions return the **physical**
+ *   address of the allocated memory
+ * * memblock_alloc*() - these functions return the **virtual** address
+ *   of the allocated memory.
  *
  * Note, that both API variants use implict assumptions about allowed
  * memory ranges and the fallback methods. Consult the documentation
- * of :c:func:`memblock_alloc_internal` and
- * :c:func:`memblock_alloc_range_nid` functions for more elaboarte
- * description.
+ * of memblock_alloc_internal() and memblock_alloc_range_nid()
+ * functions for more elaborate description.
  *
- * As the system boot progresses, the architecture specific
- * :c:func:`mem_init` function frees all the memory to the buddy page
- * allocator.
+ * As the system boot progresses, the architecture specific mem_init()
+ * function frees all the memory to the buddy page allocator.
  *
- * Unless an architecure enables %CONFIG_ARCH_KEEP_MEMBLOCK, the
+ * Unless an architecture enables %CONFIG_ARCH_KEEP_MEMBLOCK, the
  * memblock data structures will be discarded after the system
- * initialization compltes.
+ * initialization completes.
  */
 
 #ifndef CONFIG_NEED_MULTIPLE_NODES
-- 
2.21.0



