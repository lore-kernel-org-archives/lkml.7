Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034B8C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFEF20721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 03:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574306669;
	bh=7A4U/YUdzOb9u4gB3EqFDEwOe4mEVMCRR5zz4OrpPuE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1QXViX4AUn7wc8B+sd6w2KhfNLIdQYBGqr0JEvijlqNGkarN8z84TTghxcKANE8cV
	 /3FNKAOhzDR1oHeWLCBGFyfTVeXc9sf8l7ShY2aGv0qlKRCKYmM0BsCq4908jU/M8W
	 NPBAKamCVBdRHG+NbD60KZtbkS5/IJu4ZmusDg/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfKUDY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 22:24:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:37102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbfKUDY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 22:24:28 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C41220721;
        Thu, 21 Nov 2019 03:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574306666;
        bh=7A4U/YUdzOb9u4gB3EqFDEwOe4mEVMCRR5zz4OrpPuE=;
        h=From:To:Cc:Subject:Date:From;
        b=meWYwrnMFEEau1zZIWSMYUpeI989/SREHqOglGxwN/8pBTo2r5yfZyMtVh/LknWbS
         Ddxbc+9dCI9hrqF5iF6Lvt9Wfqmb96U89ILyuhcM+x6lisMkUjX8Od1NFac6rKVOpl
         uvyoa41NBax4vnW0a/P05XqilcjXEtHCs6wjYqRQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] lib: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 04:24:20 +0100
Message-Id: <1574306660-27099-1-git-send-email-krzk@kernel.org>
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
 lib/Kconfig       |  18 +++---
 lib/Kconfig.debug | 162 +++++++++++++++++++++++++++---------------------------
 lib/Kconfig.kgdb  |  16 +++---
 3 files changed, 98 insertions(+), 98 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 6d7c5877c9f1..4b022bb2cb5d 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -522,7 +522,7 @@ config NLATTR
 # Generic 64-bit atomic support is selected if needed
 #
 config GENERIC_ATOMIC64
-       bool
+	bool
 
 config LRU_CACHE
 	tristate
@@ -572,7 +572,7 @@ config OID_REGISTRY
 	  Enable fast lookup object identifier registry.
 
 config UCS2_STRING
-        tristate
+	tristate
 
 #
 # generic vdso
@@ -584,16 +584,16 @@ source "lib/fonts/Kconfig"
 config SG_SPLIT
 	def_bool n
 	help
-	 Provides a helper to split scatterlists into chunks, each chunk being
-	 a scatterlist. This should be selected by a driver or an API which
-	 whishes to split a scatterlist amongst multiple DMA channels.
+	  Provides a helper to split scatterlists into chunks, each chunk being
+	  a scatterlist. This should be selected by a driver or an API which
+	  whishes to split a scatterlist amongst multiple DMA channels.
 
 config SG_POOL
 	def_bool n
 	help
-	 Provides a helper to allocate chained scatterlists. This should be
-	 selected by a driver or an API which whishes to allocate chained
-	 scatterlist.
+	  Provides a helper to allocate chained scatterlists. This should be
+	  selected by a driver or an API which whishes to allocate chained
+	  scatterlist.
 
 #
 # sg chaining option
@@ -620,7 +620,7 @@ config ARCH_HAS_UACCESS_MCSAFE
 
 # Temporary. Goes away when all archs are cleaned up
 config ARCH_STACKWALK
-       bool
+	bool
 
 config STACKDEPOT
 	bool
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 4217bd26e220..d39046beed51 100644
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
 
@@ -1055,38 +1055,38 @@ config PROVE_LOCKING
 	select TRACE_IRQFLAGS
 	default n
 	help
-	 This feature enables the kernel to prove that all locking
-	 that occurs in the kernel runtime is mathematically
-	 correct: that under no circumstance could an arbitrary (and
-	 not yet triggered) combination of observed locking
-	 sequences (on an arbitrary number of CPUs, running an
-	 arbitrary number of tasks and interrupt contexts) cause a
-	 deadlock.
-
-	 In short, this feature enables the kernel to report locking
-	 related deadlocks before they actually occur.
-
-	 The proof does not depend on how hard and complex a
-	 deadlock scenario would be to trigger: how many
-	 participant CPUs, tasks and irq-contexts would be needed
-	 for it to trigger. The proof also does not depend on
-	 timing: if a race and a resulting deadlock is possible
-	 theoretically (no matter how unlikely the race scenario
-	 is), it will be proven so and will immediately be
-	 reported by the kernel (once the event is observed that
-	 makes the deadlock theoretically possible).
-
-	 If a deadlock is impossible (i.e. the locking rules, as
-	 observed by the kernel, are mathematically correct), the
-	 kernel reports nothing.
-
-	 NOTE: this feature can also be enabled for rwlocks, mutexes
-	 and rwsems - in which case all dependencies between these
-	 different locking variants are observed and mapped too, and
-	 the proof of observed correctness is also maintained for an
-	 arbitrary combination of these separate locking variants.
-
-	 For more details, see Documentation/locking/lockdep-design.rst.
+	  This feature enables the kernel to prove that all locking
+	  that occurs in the kernel runtime is mathematically
+	  correct: that under no circumstance could an arbitrary (and
+	  not yet triggered) combination of observed locking
+	  sequences (on an arbitrary number of CPUs, running an
+	  arbitrary number of tasks and interrupt contexts) cause a
+	  deadlock.
+
+	  In short, this feature enables the kernel to report locking
+	  related deadlocks before they actually occur.
+
+	  The proof does not depend on how hard and complex a
+	  deadlock scenario would be to trigger: how many
+	  participant CPUs, tasks and irq-contexts would be needed
+	  for it to trigger. The proof also does not depend on
+	  timing: if a race and a resulting deadlock is possible
+	  theoretically (no matter how unlikely the race scenario
+	  is), it will be proven so and will immediately be
+	  reported by the kernel (once the event is observed that
+	  makes the deadlock theoretically possible).
+
+	  If a deadlock is impossible (i.e. the locking rules, as
+	  observed by the kernel, are mathematically correct), the
+	  kernel reports nothing.
+
+	  NOTE: this feature can also be enabled for rwlocks, mutexes
+	  and rwsems - in which case all dependencies between these
+	  different locking variants are observed and mapped too, and
+	  the proof of observed correctness is also maintained for an
+	  arbitrary combination of these separate locking variants.
+
+	  For more details, see Documentation/locking/lockdep-design.rst.
 
 config LOCK_STAT
 	bool "Lock usage statistics"
@@ -1098,24 +1098,24 @@ config LOCK_STAT
 	select DEBUG_LOCK_ALLOC
 	default n
 	help
-	 This feature enables tracking lock contention points
+	  This feature enables tracking lock contention points
 
-	 For more details, see Documentation/locking/lockstat.rst
+	  For more details, see Documentation/locking/lockstat.rst
 
-	 This also enables lock events required by "perf lock",
-	 subcommand of perf.
-	 If you want to use "perf lock", you also need to turn on
-	 CONFIG_EVENT_TRACING.
+	  This also enables lock events required by "perf lock",
+	  subcommand of perf.
+	  If you want to use "perf lock", you also need to turn on
+	  CONFIG_EVENT_TRACING.
 
-	 CONFIG_LOCK_STAT defines "contended" and "acquired" lock events.
-	 (CONFIG_LOCKDEP defines "acquire" and "release" events.)
+	  CONFIG_LOCK_STAT defines "contended" and "acquired" lock events.
+	  (CONFIG_LOCKDEP defines "acquire" and "release" events.)
 
 config DEBUG_RT_MUTEXES
 	bool "RT Mutex debugging, deadlock detection"
 	depends on DEBUG_KERNEL && RT_MUTEXES
 	help
-	 This allows rt mutex semantics violations and rt mutex related
-	 deadlocks (lockups) to be detected and reported automatically.
+	  This allows rt mutex semantics violations and rt mutex related
+	  deadlocks (lockups) to be detected and reported automatically.
 
 config DEBUG_SPINLOCK
 	bool "Spinlock and rw-lock debugging: basic checks"
@@ -1131,8 +1131,8 @@ config DEBUG_MUTEXES
 	bool "Mutex debugging: basic checks"
 	depends on DEBUG_KERNEL
 	help
-	 This feature allows mutex semantics violations to be detected and
-	 reported.
+	  This feature allows mutex semantics violations to be detected and
+	  reported.
 
 config DEBUG_WW_MUTEX_SLOWPATH
 	bool "Wait/wound mutex debugging: Slowpath testing"
@@ -1141,15 +1141,15 @@ config DEBUG_WW_MUTEX_SLOWPATH
 	select DEBUG_SPINLOCK
 	select DEBUG_MUTEXES
 	help
-	 This feature enables slowpath testing for w/w mutex users by
-	 injecting additional -EDEADLK wound/backoff cases. Together with
-	 the full mutex checks enabled with (CONFIG_PROVE_LOCKING) this
-	 will test all possible w/w mutex interface abuse with the
-	 exception of simply not acquiring all the required locks.
-	 Note that this feature can introduce significant overhead, so
-	 it really should not be enabled in a production or distro kernel,
-	 even a debug kernel.  If you are a driver writer, enable it.  If
-	 you are a distro, do not.
+	  This feature enables slowpath testing for w/w mutex users by
+	  injecting additional -EDEADLK wound/backoff cases. Together with
+	  the full mutex checks enabled with (CONFIG_PROVE_LOCKING) this
+	  will test all possible w/w mutex interface abuse with the
+	  exception of simply not acquiring all the required locks.
+	  Note that this feature can introduce significant overhead, so
+	  it really should not be enabled in a production or distro kernel,
+	  even a debug kernel.  If you are a driver writer, enable it.  If
+	  you are a distro, do not.
 
 config DEBUG_RWSEMS
 	bool "RW Semaphore debugging: basic checks"
@@ -1166,12 +1166,12 @@ config DEBUG_LOCK_ALLOC
 	select DEBUG_RT_MUTEXES if RT_MUTEXES
 	select LOCKDEP
 	help
-	 This feature will check whether any held lock (spinlock, rwlock,
-	 mutex or rwsem) is incorrectly freed by the kernel, via any of the
-	 memory-freeing routines (kfree(), kmem_cache_free(), free_pages(),
-	 vfree(), etc.), whether a live lock is incorrectly reinitialized via
-	 spin_lock_init()/mutex_init()/etc., or whether there is any lock
-	 held during task exit.
+	  This feature will check whether any held lock (spinlock, rwlock,
+	  mutex or rwsem) is incorrectly freed by the kernel, via any of the
+	  memory-freeing routines (kfree(), kmem_cache_free(), free_pages(),
+	  vfree(), etc.), whether a live lock is incorrectly reinitialized via
+	  spin_lock_init()/mutex_init()/etc., or whether there is any lock
+	  held during task exit.
 
 config LOCKDEP
 	bool
@@ -1400,7 +1400,7 @@ config DEBUG_WQ_FORCE_RR_CPU
 	  be impacted.
 
 config DEBUG_BLOCK_EXT_DEVT
-        bool "Force extended block device numbers and spread them"
+	bool "Force extended block device numbers and spread them"
 	depends on DEBUG_KERNEL
 	depends on BLOCK
 	default n
@@ -1529,10 +1529,10 @@ config IO_STRICT_DEVMEM
 	  If in doubt, say Y.
 
 config DEBUG_AID_FOR_SYZBOT
-       bool "Additional debug code for syzbot"
-       default n
-       help
-         This option is intended for testing by syzbot.
+	bool "Additional debug code for syzbot"
+	default n
+	help
+	  This option is intended for testing by syzbot.
 
 menu "$(SRCARCH) Debugging"
 
@@ -1800,7 +1800,7 @@ config TEST_LKM
 config TEST_VMALLOC
 	tristate "Test module for stress/performance analysis of vmalloc allocator"
 	default n
-       depends on MMU
+	depends on MMU
 	depends on m
 	help
 	  This builds the "test_vmalloc" module that should be used for
diff --git a/lib/Kconfig.kgdb b/lib/Kconfig.kgdb
index bbe397df04a3..b91dfded57f1 100644
--- a/lib/Kconfig.kgdb
+++ b/lib/Kconfig.kgdb
@@ -60,13 +60,13 @@ config KGDB_TESTS_BOOT_STRING
 	  default of V1F100.
 
 config KGDB_LOW_LEVEL_TRAP
-       bool "KGDB: Allow debugging with traps in notifiers"
-       depends on X86 || MIPS
-       default n
-       help
-         This will add an extra call back to kgdb for the breakpoint
-         exception handler which will allow kgdb to step through a
-         notify handler.
+	bool "KGDB: Allow debugging with traps in notifiers"
+	depends on X86 || MIPS
+	default n
+	help
+	  This will add an extra call back to kgdb for the breakpoint
+	  exception handler which will allow kgdb to step through a
+	  notify handler.
 
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
2.7.4

