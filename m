Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C23C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09BB720657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfCKNyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:54:10 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:36307 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfCKNyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:54:09 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Md6AP-1gU0pI0x6Z-00aCVB; Mon, 11 Mar 2019 14:54:07 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org
Subject: [PATCH] mm: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:54:04 +0100
Message-Id: <1552312444-24572-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:bafHJ2JVH9BUC2oLYNjgUVX5blGqKNn3Itah62vN4Gr3/ptUe0k
 qebJAoRDSi72UxJOCmkZ0bdFNiOzHftyMzvDSf2rtEx9IOqPfaxxU86mtKBPUrBuvIwCbTK
 g1P5kGyr7qFM8O0ba4ODc8aka8KlSRB00jY2ugGNHvrTBuwoOUs0uc87vPUOYzw+X2VrHNv
 ztsky/IjigjYYyC5RtM2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dXDytxCcq8A=:wx09j4PCzoyWeo3iJM25L/
 bohkfyPw61pjdGDM5coJ3n313KHY4mA9LUm1KbNoYx8sAiPI78yyztiVPhFSj6+P+T0yaCZdC
 7UEQ41BcKl4l31h5QIFWYjeSeuScLWkyzyx9wD6GkVgSzvpd6z8wEPs2XYHr/iw1zTxE8154v
 KAJq5DxznJSCLjHCGMagTwvXRHPghzGcAier7BZpn6xizdB4Z3FX458jdfkfwHVpXlfKIWecj
 /Mw7pEkAuu7jdTzFQ2rJbu/9nYdYvvobT3PZUn3EfIoI6GsXSag1hTjGb9y6AABuJFWo5OQem
 FOjtnPHX0oYQFiz8cjNxKaY0urh/d4EZFmmricao4DuVFYgifDUGCMAia7oMMZvMtHujIF4rM
 QqBFCyr8NkBaDMJGFmy5s5nERqaMzmwzq2tZ/TX+0zUORM+VBHL9pCUm46sdaVK7PeBT07OVS
 r7KkDuf4flatOKgzhcdm0YUH9BDFg2OPgNG+dhETANvZJUT6svATeF4oIvUh6YC+5FgHNfvDX
 rT6VLiSehx/lElhDsW5I2vnpwWY54PGqCIv87hJwlcDG+nTtkBEcPl3BrmBnxSbtx2H9qnHlZ
 8M9qlFHp2CVZH+y5BualavBCi+bLb0QOmUBpcOIB1woGOcnZkQF1DEoYYooVUIbfqetlIptTq
 6pldjBlXl1H0bMMpN5o4iSRLdK1uRsICMYLKyYPhEtZvotbmPV7xh30fG8psJ0d3s5XT16xSj
 qWar2KUMDSZhEoXQYU/AoJuzIGdE9l1hUHig+g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 mm/Kconfig | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 25c71eb..9181eb2 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -123,9 +123,9 @@ config SPARSEMEM_VMEMMAP
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
@@ -160,10 +160,10 @@ config MEMORY_HOTPLUG_SPARSE
 	depends on SPARSEMEM && MEMORY_HOTPLUG
 
 config MEMORY_HOTPLUG_DEFAULT_ONLINE
-        bool "Online the newly added memory blocks by default"
-        default n
-        depends on MEMORY_HOTPLUG
-        help
+	bool "Online the newly added memory blocks by default"
+	default n
+	depends on MEMORY_HOTPLUG
+	help
 	  This option sets the default policy setting for memory hotplug
 	  onlining policy (/sys/devices/system/memory/auto_online_blocks) which
 	  determines what happens to newly added memory regions. Policy setting
@@ -228,14 +228,14 @@ config COMPACTION
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
@@ -304,10 +304,10 @@ config KSM
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
@@ -400,7 +400,7 @@ choice
 	  benefit but it will work automatically for all applications.
 
 	config TRANSPARENT_HUGEPAGE_MADVISE
-		bool "madvise"
+	bool "madvise"
 	help
 	  Enabling Transparent Hugepage madvise, will only provide a
 	  performance improvement benefit to the applications using
@@ -410,7 +410,7 @@ choice
 endchoice
 
 config ARCH_WANTS_THP_SWAP
-       def_bool n
+	def_bool n
 
 config THP_SWAP
 	def_bool y
-- 
1.9.1

