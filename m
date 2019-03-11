Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBA8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AFF21908
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbfCKN3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:29:39 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:55367 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbfCKNTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:33 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N336J-1gvxWg4Aer-013Ocw for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:32 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 033/114] mm: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:45 +0100
Message-Id: <1552310346-7629-34-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:pCmdmFx09pMMTz8kGkzd8rSKgflAJNGd0bL/sw2WqRRhKo9hGG1
 hN1ckhpD3Asj71VfNnJBO/0CEUD4DCqw2JPXnloqPVHaAfS2ZmUfZSu/WajCIp0++6Fsmng
 Q9PhbANkqwz7A78/fOpdQiBHmWN4Bo9fUiiu7URMzMHOrVwMPffMRHEwcD8b7k9oXEbNgpq
 THSSJhYjA27eoLkaUlgrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1G7AAfFVfFc=:mUvpoXwiCHqxaa/s36Um6R
 bZN2SwZKcE6IXNDlH2OOzh9fcbZKs2LhvDr3THSjBOER8OwG+AV0z+Jyc8WKPW8LszijfVqLO
 OLBKG/ove6jfOjY8m4IvYCzLG2TFwZMbM2kyaiyLwrP5U4gH2qxCNbbOPEnLTlnpQjP4eCviQ
 qGa1LBWiCwFejmOsylbVmqD5nQCzV5X13PMuXG9UiqjjAL7TrtQhcRAbidrmOXNY3SFmF3cdh
 azIayezItu3uD2w86Z6NZOM1vhUvi0E38KUqHGdBE1HiGBTqQRCiD6bdnKYDckm3GpnasUbtG
 JN1Cb/+YjmxGV8ReXtggI0qIVSlbs8LdtJCCo63Gr4+VCUO4OJisPJFfYP0WmmPTRccCL46Cp
 kMIqc97xqhnnm9Kttdz43EvNnZdeD7PFoFfY0EiSjnXB8CGEW97TuVf6mNI322YLrs/k203qP
 86PHJdFIZH606LyyGyiY3ow9II13aUxe+h6jtse7ykeyvAxsAJJ+5Zeq2PBvLFs3bwUuZ1Sz1
 Sv3NH/qyneKAUSI4nlyCgmLezke7/OQCc6bPmadDPaXQxYdVQctWcKJlM8oObRRR08Y5NISjE
 aw4PkJs+wj6xgya7zgnvN1GuVpEkpYqt2LrlA1FxUqOSn8/5zJ3lh6tq66xYUpZB6j7d9H3KM
 Pplui8tSmlm5g6qj3l17pV3BJ1Te6Hloz7rsL3wAvPQWbgpRvYLFsrMicFC/ECdjmyimFHqI1
 neSZQEKvdwwplBqw0gsTToA98WWMiSaJT+vkUw==
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

