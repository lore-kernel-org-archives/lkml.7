Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659DDC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390BE208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574306443;
	bh=Ws+h2XCB+4cYjoU6hb4miQHTjGVkwBMyL5AK0BvvSPI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=TFbMNlFLQXh4PiVd8cYatCne458+gELxHbUwC7fX9vL+XlMdKmrMkJQH7GBIqHArp
	 bFEMiw+2zfurR3FLs8rRYxZl+TLEzvQRu8oQSKIJG0FXu0fPLYui0SB2oVy9wGZFiX
	 mSSYtZJ0MebNK3EqgbYOG8X80b6P9fkezejbikB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfKUDUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 22:20:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:34438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727532AbfKUDUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:20:41 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 950CB208A3;
        Thu, 21 Nov 2019 03:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306440;
        bh=Ws+h2XCB+4cYjoU6hb4miQHTjGVkwBMyL5AK0BvvSPI=;
        h=From:To:Cc:Subject:Date:From;
        b=UgfmOavldxRPfdtooKkb9hrGUODSqqsfRixWGeqX+MrhWNlHQ2rpO4cxRWL/rJzMd
         g1h9XZuPr7J7ztsJZtbxq1G58GmJlHje1SKifay5OW9UZSS302sVntrj+iDvmrenAN
         iLraQptPIwhwM0oXK9S21hZoLQ1L8WFab843hwwA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH v2] mm: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:20:37 +0100
Message-Id: <1574306437-28837-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>

---

Changes since v1:
1. Fix also 7-space and tab+1 space indentation issues.
---
 mm/Kconfig | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index e38ff1d5968d..5a6cd8038b6d 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -122,9 +122,9 @@ config SPARSEMEM_VMEMMAP
 	depends on SPARSEMEM && SPARSEMEM_VMEMMAP_ENABLE
 	default y
 	help
-	 SPARSEMEM_VMEMMAP uses a virtually mapped memmap to optimise
-	 pfn_to_page and page_to_pfn operations.  This is the most
-	 efficient option when sufficient kernel resources are available.
+	  SPARSEMEM_VMEMMAP uses a virtually mapped memmap to optimise
+	  pfn_to_page and page_to_pfn operations.  This is the most
+	  efficient option when sufficient kernel resources are available.
 
 config HAVE_MEMBLOCK_NODE_MAP
 	bool
@@ -160,9 +160,9 @@ config MEMORY_HOTPLUG_SPARSE
 	depends on SPARSEMEM && MEMORY_HOTPLUG
 
 config MEMORY_HOTPLUG_DEFAULT_ONLINE
-        bool "Online the newly added memory blocks by default"
-        depends on MEMORY_HOTPLUG
-        help
+	bool "Online the newly added memory blocks by default"
+	depends on MEMORY_HOTPLUG
+	help
 	  This option sets the default policy setting for memory hotplug
 	  onlining policy (/sys/devices/system/memory/auto_online_blocks) which
 	  determines what happens to newly added memory regions. Policy setting
@@ -227,14 +227,14 @@ config COMPACTION
 	select MIGRATION
 	depends on MMU
 	help
-          Compaction is the only memory management component to form
-          high order (larger physically contiguous) memory blocks
-          reliably. The page allocator relies on compaction heavily and
-          the lack of the feature can lead to unexpected OOM killer
-          invocations for high order memory requests. You shouldn't
-          disable this option unless there really is a strong reason for
-          it and then we would be really interested to hear about that at
-          linux-mm@kvack.org.
+	  Compaction is the only memory management component to form
+	  high order (larger physically contiguous) memory blocks
+	  reliably. The page allocator relies on compaction heavily and
+	  the lack of the feature can lead to unexpected OOM killer
+	  invocations for high order memory requests. You shouldn't
+	  disable this option unless there really is a strong reason for
+	  it and then we would be really interested to hear about that at
+	  linux-mm@kvack.org.
 
 #
 # support for page migration
@@ -258,7 +258,7 @@ config ARCH_ENABLE_THP_MIGRATION
 	bool
 
 config CONTIG_ALLOC
-       def_bool (MEMORY_ISOLATION && COMPACTION) || CMA
+	def_bool (MEMORY_ISOLATION && COMPACTION) || CMA
 
 config PHYS_ADDR_T_64BIT
 	def_bool 64BIT
@@ -302,10 +302,10 @@ config KSM
 	  root has set /sys/kernel/mm/ksm/run to 1 (if CONFIG_SYSFS is set).
 
 config DEFAULT_MMAP_MIN_ADDR
-        int "Low address space to protect from user allocation"
+	int "Low address space to protect from user allocation"
 	depends on MMU
-        default 4096
-        help
+	default 4096
+	help
 	  This is the portion of low virtual memory which should be protected
 	  from userspace allocation.  Keeping a user from writing to low pages
 	  can help reduce the impact of kernel NULL pointer bugs.
@@ -408,7 +408,7 @@ choice
 endchoice
 
 config ARCH_WANTS_THP_SWAP
-       def_bool n
+	def_bool n
 
 config THP_SWAP
 	def_bool y
-- 
2.7.4

