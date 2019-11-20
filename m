Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555CCC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295D42251E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257090;
	bh=bfeX1RCt/G8UUJqxagx1+I2XTNvZ7HFkaCu5K4RkPQ0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=UDXrNkSM2mwEnTZrDl+JD5yJ5udf/90ivZPOSv2zTCoOcwK6undTZEIOv1ptnc4Dn
	 trjyXPylW70StIoPhmkSJ19LZCf/SLRdDHNhku1YI5WW3KyI7m0rDQ1dixB+6wCsO6
	 lPq/zwXjSmM4P85NK6ExMQnF+yJrUWy0Cm4lPrBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbfKTNiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:38:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:45236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728276AbfKTNiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:38:08 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED254224D2;
        Wed, 20 Nov 2019 13:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257086;
        bh=bfeX1RCt/G8UUJqxagx1+I2XTNvZ7HFkaCu5K4RkPQ0=;
        h=From:To:Cc:Subject:Date:From;
        b=vVe1PFpfQ3JPNFL9kAPjkq9OBxIEB3YJ4g3Lrfks6Lpi7PpDtBmvSVrXW7qIUanAK
         /BQXufodJ8Zsq5yZJdWANlu9v0a15jLt9j3Y655/qeS2rR+bbSbTYYcQWeFOztfRGR
         zHNBHrV8Yh/NGGWWGhNh6U7NlAIBc9gv4cbbpITc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] lib: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:38:03 +0800
Message-Id: <20191120133803.12685-1-krzk@kernel.org>
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

