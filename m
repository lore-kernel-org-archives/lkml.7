Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF7DC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4890F224C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574258509;
	bh=bfeX1RCt/G8UUJqxagx1+I2XTNvZ7HFkaCu5K4RkPQ0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=g/lSJ1FhlzRl/tWIdJY5IGVmP91kPesPkgKUdx64q5CHouFx8X2AAaMNTcTCk4j1/
	 rbYXgncS2cu/escCjg+DJsQ9JCy2qQP8MfKYflqaS7zKOzTh87ELRpRLBL1GZ5xDV1
	 GRfexWnPOD/TU5q8iDAQ+cu3UYL6CA7fsl64udqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731599AbfKTOBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:01:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:59632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727988AbfKTOBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:01:48 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41F362235D;
        Wed, 20 Nov 2019 14:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574258506;
        bh=bfeX1RCt/G8UUJqxagx1+I2XTNvZ7HFkaCu5K4RkPQ0=;
        h=From:To:Cc:Subject:Date:From;
        b=YP8C1m8j715xrksISxz+xcCz6Mmmh9/3T3IBuNwVg2x0cAQysu074PXUUFkwznA4l
         CcPJlchnRl5DyrLxT6KuiY2WianzxgKJcGPvhHmPuodduc8MDC9bnf7BmGUqJc4Oz8
         Vy70LWNVT5e7HPL02q6Ygl5+QjSq9iASQa3FWpSM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND PATCH] lib: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 22:01:40 +0800
Message-Id: <20191120140140.19148-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 lib/Kconfig       |  2 +-
 lib/Kconfig.debug | 36 ++++++++++++++++++------------------
 lib/Kconfig.kgdb  |  8 ++++----
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 6d7c5877c9f1..6e790dc55c5b 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -572,7 +572,7 @@ config OID_REGISTRY
 	  Enable fast lookup object identifier registry.
 
 config UCS2_STRING
-        tristate
+	tristate
 
 #
 # generic vdso
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 4217bd26e220..bfc65c6d5fdc 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -128,8 +128,8 @@ config DYNAMIC_DEBUG
 	  lineno : line number of the debug statement
 	  module : module that contains the debug statement
 	  function : function that contains the debug statement
-          flags : '=p' means the line is turned 'on' for printing
-          format : the format used for the debug statement
+	  flags : '=p' means the line is turned 'on' for printing
+	  format : the format used for the debug statement
 
 	  From a live system:
 
@@ -190,7 +190,7 @@ config DEBUG_INFO
 	bool "Compile the kernel with debug info"
 	depends on DEBUG_KERNEL && !COMPILE_TEST
 	help
-          If you say Y here the resulting kernel image will include
+	  If you say Y here the resulting kernel image will include
 	  debugging info resulting in a larger kernel image.
 	  This adds debug symbols to the kernel and modules (gcc -g), and
 	  is needed if you intend to use kernel crashdump or binary object
@@ -287,13 +287,13 @@ config STRIP_ASM_SYMS
 	  get_wchan() and suchlike.
 
 config READABLE_ASM
-        bool "Generate readable assembler code"
-        depends on DEBUG_KERNEL
-        help
-          Disable some compiler optimizations that tend to generate human unreadable
-          assembler output. This may make the kernel slightly slower, but it helps
-          to keep kernel developers who have to stare a lot at assembler listings
-          sane.
+	bool "Generate readable assembler code"
+	depends on DEBUG_KERNEL
+	help
+	  Disable some compiler optimizations that tend to generate human unreadable
+	  assembler output. This may make the kernel slightly slower, but it helps
+	  to keep kernel developers who have to stare a lot at assembler listings
+	  sane.
 
 config HEADERS_INSTALL
 	bool "Install uapi headers to usr/include"
@@ -525,11 +525,11 @@ config DEBUG_OBJECTS_PERCPU_COUNTER
 
 config DEBUG_OBJECTS_ENABLE_DEFAULT
 	int "debug_objects bootup default value (0-1)"
-        range 0 1
-        default "1"
-        depends on DEBUG_OBJECTS
-        help
-          Debug objects boot parameter default value
+	range 0 1
+	default "1"
+	depends on DEBUG_OBJECTS
+	help
+	  Debug objects boot parameter default value
 
 config DEBUG_SLAB
 	bool "Debug slab memory allocations"
@@ -660,7 +660,7 @@ config DEBUG_VM
 	depends on DEBUG_KERNEL
 	help
 	  Enable this to turn on extended checks in the virtual-memory system
-          that may impact performance.
+	  that may impact performance.
 
 	  If unsure, say N.
 
@@ -1400,7 +1400,7 @@ config DEBUG_WQ_FORCE_RR_CPU
 	  be impacted.
 
 config DEBUG_BLOCK_EXT_DEVT
-        bool "Force extended block device numbers and spread them"
+	bool "Force extended block device numbers and spread them"
 	depends on DEBUG_KERNEL
 	depends on BLOCK
 	default n
@@ -1532,7 +1532,7 @@ config DEBUG_AID_FOR_SYZBOT
        bool "Additional debug code for syzbot"
        default n
        help
-         This option is intended for testing by syzbot.
+	 This option is intended for testing by syzbot.
 
 menu "$(SRCARCH) Debugging"
 
diff --git a/lib/Kconfig.kgdb b/lib/Kconfig.kgdb
index bbe397df04a3..933680b59e2d 100644
--- a/lib/Kconfig.kgdb
+++ b/lib/Kconfig.kgdb
@@ -64,9 +64,9 @@ config KGDB_LOW_LEVEL_TRAP
        depends on X86 || MIPS
        default n
        help
-         This will add an extra call back to kgdb for the breakpoint
-         exception handler which will allow kgdb to step through a
-         notify handler.
+	 This will add an extra call back to kgdb for the breakpoint
+	 exception handler which will allow kgdb to step through a
+	 notify handler.
 
 config KGDB_KDB
 	bool "KGDB_KDB: include kdb frontend for kgdb"
@@ -96,7 +96,7 @@ config KDB_DEFAULT_ENABLE
 
 	  The config option merely sets the default at boot time. Both
 	  issuing 'echo X > /sys/module/kdb/parameters/cmd_enable' or
-          setting with kdb.cmd_enable=X kernel command line option will
+	  setting with kdb.cmd_enable=X kernel command line option will
 	  override the default settings.
 
 config KDB_KEYBOARD
-- 
2.17.1

