Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E5CC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2F220721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574306679;
	bh=89IjGbwB0gjkHcS+1oER2cFFDzTzslXVgJDvMKoYmNg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=bmhbje5E8Fq5+tZvOkOt8fsqO5j79BEu92YE4u/qO/S0h/vSAQBS1va8gB7Z7YElg
	 RRVDiGL5wpjRVytSXwPnHyOsORw4JS+66TJsbQ1uDR8SX93yeTUJ452rCLywsgsqxG
	 5NlQ7X6ECkQUddLVXkd/t4bbab0iGpzSw1jBLflU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfKUDYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 22:24:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:37236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfKUDYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:24:37 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB0F920721;
        Thu, 21 Nov 2019 03:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306676;
        bh=89IjGbwB0gjkHcS+1oER2cFFDzTzslXVgJDvMKoYmNg=;
        h=From:To:Cc:Subject:Date:From;
        b=RO7BkHV2hAfPUnQvXNSQoIwA6Wr6b80ynQDSVbe7nFH0V9eZYuzZSsIUiGxJyXlCo
         JwSDv5ytfL1IssVGdQVlhA73FyOW4ziH9N7xKNmZzEhIGsuO9uVtxIje7wtjwH6DnH
         8Ajx0F6Pcn1ZZu8g/ALWExQ0vTWFiiqT9ccPKI3k=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] init: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:24:30 +0100
Message-Id: <1574306670-30234-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix also 7-space and tab+1 space indentation issues.
---
 init/Kconfig | 76 ++++++++++++++++++++++++++++++------------------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index ff15a3c71176..c28cd305b496 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -146,13 +146,13 @@ config LOCALVERSION_AUTO
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
@@ -818,7 +818,7 @@ menuconfig CGROUPS
 if CGROUPS
 
 config PAGE_COUNTER
-       bool
+	bool
 
 config MEMCG
 	bool "Memory controller"
@@ -1311,9 +1311,9 @@ menuconfig EXPERT
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
@@ -1423,11 +1423,11 @@ config BUG
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
@@ -1443,8 +1443,8 @@ config PCSPKR_PLATFORM
 	select I8253_LOCK
 	default y
 	help
-          This option allows to disable the internal PC-Speaker
-          support, saving some memory.
+	  This option allows to disable the internal PC-Speaker
+	  support, saving some memory.
 
 config BASE_FULL
 	default y
@@ -1562,29 +1562,29 @@ config MEMBARRIER
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
@@ -1727,12 +1727,12 @@ config DEBUG_PERF_USE_VMALLOC
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
 
-- 
2.7.4

