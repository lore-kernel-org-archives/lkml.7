Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C851C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A262084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfCKNUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:20:02 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:35635 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbfCKNTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:39 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M4s8v-1h1y3k3JWJ-001z5A for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:35 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 062/114] init: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:14 +0100
Message-Id: <1552310346-7629-63-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:XQCao17Sg9mFUwQtNkZxdCNwQ+SsGECmraJlGB6NwQuzeQGAJOR
 GnarFvh2HGAo57DUzVI5rX3EIRfP0B/7YBsN5nbba9tezM1lO0cj8pJWdTu2m24Vl+btwJQ
 BBgT/KJ6wjYdFMkPyKKPPbIS/wAHCM9dgTXsLtqPX4JNYvgoQMNZ5DnALE9bkAHaR4/F314
 0iWXFMJqR8MRW3FgYweVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U6+WM5Xm6m0=:G00senfMfHGJEsFJ3Qoa8N
 Lcn9hGvYi4uI1ccQjZvLNr7dnDDrmM1YWBKwfVb4JBkI7KBlHCrPH8leRWEKHVnoTska/sMrE
 2P2v59jpyf0H7I1MVFddFhdfSGyD35k7WFdOp+ZShFt2eBV+SOT+uJ+Pt2KDutbvmplP1h0OE
 Us5kXecRQIXh9zH0usYQBT32duib8K7OYM5Db1l+6fHWZsFLoxP9L+do7b5/gDh5LGPV+9vDz
 d/Lkz+0baaJTA4AG4hzpzxbW2nZJcd0amG+sHP9vnF9EC/pNH7OkQvTUOEwKWt+1YYOScf/Om
 pcuEpCzfHThXdZ8ZW0nKk1mdlzfhmb5jVzjyOovCtn4KjHWIMg6BYA82H+aw+BHzaDba+q6gN
 ug3GnwNnxoPxFpXIvmaeJdDNmoL9G8MM57GdQL/qiN2XaoIDzUdbTy6DXuM6XIS2bfOl4ZvxL
 WfjD40P2Z86sTHS3qbYHGHskuNmMDaKA4wo2HDqkz/QMEU1k284PGQmMNEp7L3LzIOHFDWsaU
 kIaOKyj/H/3eeqRGHs3aOEUnFh2XsFo8jje3EVX3uboQoxo3d4J8h109mrTc78zfkkujX4c5p
 DMSqkT/J5bTWRhy6ZimdH4Y94+k7WdZlo4H9WpUZGRX4irZw33k7pM/mafGH+qCqMSHdMlWi6
 NbIbKXP4wgNFcuEScS7IHbUz00hgvd/cdf/5frg9oeyLX+/n+QgiyaI8yuzIA9nPXa8/5hFdV
 Td7OKk9qtybcRqYQiiIBMgvraCyIc1HjHyr8MQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 init/Kconfig | 103 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 51 insertions(+), 52 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 811641c..25dc75a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -39,7 +39,7 @@ config BUILDTIME_EXTABLE_SORT
 config THREAD_INFO_IN_TASK
 	bool
 	help
-	  Select this to move thread_info off the stack into task_struct.  To
+	  Select this to move thread_info off the stack into task_struct. To
 	  make this work, an arch will need to remove all thread_info fields
 	  except flags and fix any runtime bugs.
 
@@ -111,13 +111,13 @@ config LOCALVERSION_AUTO
 	  which is done within the script "scripts/setlocalversion".)
 
 config BUILD_SALT
-       string "Build ID Salt"
-       default ""
-       help
-          The build ID is used to link binaries and their debug info. Setting
-          this option will use the value in the calculation of the build id.
-          This is mostly useful for distributions which want to ensure the
-          build is unique between builds. It's safe to leave the default.
+	string "Build ID Salt"
+	default ""
+	help
+	  The build ID is used to link binaries and their debug info. Setting
+	  this option will use the value in the calculation of the build id.
+	  This is mostly useful for distributions which want to ensure the
+	  build is unique between builds. It's safe to leave the default.
 
 config HAVE_KERNEL_GZIP
 	bool
@@ -718,7 +718,7 @@ menuconfig CGROUPS
 if CGROUPS
 
 config PAGE_COUNTER
-       bool
+	bool
 
 config MEMCG
 	bool "Memory controller"
@@ -1193,9 +1193,9 @@ menuconfig EXPERT
 	select DEBUG_KERNEL
 	help
 	  This option allows certain base kernel options and settings
-          to be disabled or tweaked. This is for specialized
-          environments which can tolerate a "non-standard" kernel.
-          Only use this if you really know what you are doing.
+	  to be disabled or tweaked. This is for specialized
+	  environments which can tolerate a "non-standard" kernel.
+	  Only use this if you really know what you are doing.
 
 config UID16
 	bool "Enable 16-bit UID system calls" if EXPERT
@@ -1305,11 +1305,11 @@ config BUG
 	bool "BUG() support" if EXPERT
 	default y
 	help
-          Disabling this option eliminates support for BUG and WARN, reducing
-          the size of your kernel image and potentially quietly ignoring
-          numerous fatal conditions. You should only consider disabling this
-          option for embedded systems with no facilities for reporting errors.
-          Just say Y.
+	  Disabling this option eliminates support for BUG and WARN, reducing
+	  the size of your kernel image and potentially quietly ignoring
+	  numerous fatal conditions. You should only consider disabling this
+	  option for embedded systems with no facilities for reporting errors.
+	  Just say Y.
 
 config ELF_CORE
 	depends on COREDUMP
@@ -1318,15 +1318,14 @@ config ELF_CORE
 	help
 	  Enable support for generating core dumps. Disabling saves about 4k.
 
-
 config PCSPKR_PLATFORM
 	bool "Enable PC-Speaker support" if EXPERT
 	depends on HAVE_PCSPKR_PLATFORM
 	select I8253_LOCK
 	default y
 	help
-          This option allows to disable the internal PC-Speaker
-          support, saving some memory.
+	  This option allows to disable the internal PC-Speaker
+	  support, saving some memory.
 
 config BASE_FULL
 	default y
@@ -1447,29 +1446,29 @@ config MEMBARRIER
 	  If unsure, say Y.
 
 config KALLSYMS
-	 bool "Load all symbols for debugging/ksymoops" if EXPERT
-	 default y
-	 help
-	   Say Y here to let the kernel print out symbolic crash information and
-	   symbolic stack backtraces. This increases the size of the kernel
-	   somewhat, as all symbols have to be loaded into the kernel image.
+	bool "Load all symbols for debugging/ksymoops" if EXPERT
+	default y
+	help
+	  Say Y here to let the kernel print out symbolic crash information and
+	  symbolic stack backtraces. This increases the size of the kernel
+	  somewhat, as all symbols have to be loaded into the kernel image.
 
 config KALLSYMS_ALL
 	bool "Include all symbols in kallsyms"
 	depends on DEBUG_KERNEL && KALLSYMS
 	help
-	   Normally kallsyms only contains the symbols of functions for nicer
-	   OOPS messages and backtraces (i.e., symbols from the text and inittext
-	   sections). This is sufficient for most cases. And only in very rare
-	   cases (e.g., when a debugger is used) all symbols are required (e.g.,
-	   names of variables from the data sections, etc).
+	  Normally kallsyms only contains the symbols of functions for nicer
+	  OOPS messages and backtraces (i.e., symbols from the text and inittext
+	  sections). This is sufficient for most cases. And only in very rare
+	  cases (e.g., when a debugger is used) all symbols are required (e.g.,
+	  names of variables from the data sections, etc).
 
-	   This option makes sure that all symbols are loaded into the kernel
-	   image (i.e., symbols from all sections) in cost of increased kernel
-	   size (depending on the kernel configuration, it may be 300KiB or
-	   something like this).
+	  This option makes sure that all symbols are loaded into the kernel
+	  image (i.e., symbols from all sections) in cost of increased kernel
+	  size (depending on the kernel configuration, it may be 300KiB or
+	  something like this).
 
-	   Say N unless you really need all symbols.
+	  Say N unless you really need all symbols.
 
 config KALLSYMS_ABSOLUTE_PERCPU
 	bool
@@ -1615,12 +1614,12 @@ config DEBUG_PERF_USE_VMALLOC
 	depends on PERF_EVENTS && DEBUG_KERNEL && !PPC
 	select PERF_USE_VMALLOC
 	help
-	 Use vmalloc memory to back perf mmap() buffers.
+	  Use vmalloc memory to back perf mmap() buffers.
 
-	 Mostly useful for debugging the vmalloc code on platforms
-	 that don't require it.
+	  Mostly useful for debugging the vmalloc code on platforms
+	  that don't require it.
 
-	 Say N if unsure.
+	  Say N if unsure.
 
 endmenu
 
@@ -1673,7 +1672,7 @@ choice
 	prompt "Choose SLAB allocator"
 	default SLUB
 	help
-	   This option allows to select a slab allocator.
+	  This option allows to select a slab allocator.
 
 config SLAB
 	bool "SLAB"
@@ -1687,20 +1686,20 @@ config SLUB
 	bool "SLUB (Unqueued Allocator)"
 	select HAVE_HARDENED_USERCOPY_ALLOCATOR
 	help
-	   SLUB is a slab allocator that minimizes cache line usage
-	   instead of managing queues of cached objects (SLAB approach).
-	   Per cpu caching is realized using slabs of objects instead
-	   of queues of objects. SLUB can use memory efficiently
-	   and has enhanced diagnostics. SLUB is the default choice for
-	   a slab allocator.
+	  SLUB is a slab allocator that minimizes cache line usage
+	  instead of managing queues of cached objects (SLAB approach).
+	  Per cpu caching is realized using slabs of objects instead
+	  of queues of objects. SLUB can use memory efficiently
+	  and has enhanced diagnostics. SLUB is the default choice for
+	  a slab allocator.
 
 config SLOB
 	depends on EXPERT
 	bool "SLOB (Simple Allocator)"
 	help
-	   SLOB replaces the stock allocator with a drastically simpler
-	   allocator. SLOB is generally more space efficient but
-	   does not perform as well on large systems.
+	  SLOB replaces the stock allocator with a drastically simpler
+	  allocator. SLOB is generally more space efficient but
+	  does not perform as well on large systems.
 
 endchoice
 
@@ -1800,7 +1799,7 @@ config PROFILING
 config TRACEPOINTS
 	bool
 
-endmenu		# General setup
+endmenu # General setup
 
 source "arch/Kconfig"
 
@@ -1880,7 +1879,7 @@ config MODULE_SRCVERSION_ALL
 	help
 	  Modules which contain a MODULE_VERSION get an extra "srcversion"
 	  field inserted into their modinfo section, which contains a
-    	  sum of the source files which made it.  This helps maintainers
+	  sum of the source files which made it.  This helps maintainers
 	  see exactly which source was used to build a module (since
 	  others sometimes change the module source without updating
 	  the version).  With this option, such a "srcversion" field
-- 
1.9.1

