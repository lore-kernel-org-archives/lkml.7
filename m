Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B68C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F6720409
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574343262;
	bh=zQna3HK+k+3OWi0D0L2LSMiho5b7q3wpjE1pUQENP0M=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Y6ImSlMTWv+xmBxD5WWerC2x43sMbUj0Nyv69UVPlCkdGbp0wGbtQshIFqqit1Ejq
	 9swlUW15ZOBsW6yGDl3rn5/NoQuzAbsH5PakiqRWEtVK9RYHe6WbuwuHlO0rawRjz7
	 8ArHivL73fbUvxeGNVCKj2Hf8r4wZSmEGjDrH9ek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfKUNeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 08:34:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:52906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfKUNeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:34:21 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC7912070B;
        Thu, 21 Nov 2019 13:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574343259;
        bh=zQna3HK+k+3OWi0D0L2LSMiho5b7q3wpjE1pUQENP0M=;
        h=From:To:Cc:Subject:Date:From;
        b=ChwgZ1BSVbB+oTxSXEvY1XQ66NkoRA1lPreqOYKQpvF0gYSpWdmbBGrp5YOPdhIky
         Z7Mzfew+PLhtJQgpZ41b8W7k0TZfo1TyyoUoKqOnqan8v0KmKMy5nIeuDy50sqbm+j
         afZIg4ueR9S9YRO2pswwYzHR8+2Ub6U2XzC4wZhk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] kernel: Fix Kconfig indentation
Date:   Thu, 21 Nov 2019 21:34:07 +0800
Message-Id: <20191121133407.29996-1-krzk@kernel.org>
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
 kernel/Kconfig.locks   |   8 +-
 kernel/Kconfig.preempt |   6 +-
 kernel/irq/Kconfig     |  26 +++----
 kernel/time/Kconfig    |  22 +++---
 kernel/trace/Kconfig   | 166 ++++++++++++++++++++---------------------
 5 files changed, 114 insertions(+), 114 deletions(-)

diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index e0852dc333ac..d8d7a0d571a7 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -229,12 +229,12 @@ config MUTEX_SPIN_ON_OWNER
 	depends on SMP && ARCH_SUPPORTS_ATOMIC_RMW
 
 config RWSEM_SPIN_ON_OWNER
-       def_bool y
-       depends on SMP && ARCH_SUPPORTS_ATOMIC_RMW
+	def_bool y
+	depends on SMP && ARCH_SUPPORTS_ATOMIC_RMW
 
 config LOCK_SPIN_ON_OWNER
-       def_bool y
-       depends on MUTEX_SPIN_ON_OWNER || RWSEM_SPIN_ON_OWNER
+	def_bool y
+	depends on MUTEX_SPIN_ON_OWNER || RWSEM_SPIN_ON_OWNER
 
 config ARCH_USE_QUEUED_SPINLOCKS
 	bool
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index bf82259cff96..4293e52c6cdf 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -75,8 +75,8 @@ config PREEMPT_RT
 endchoice
 
 config PREEMPT_COUNT
-       bool
+	bool
 
 config PREEMPTION
-       bool
-       select PREEMPT_COUNT
+	bool
+	select PREEMPT_COUNT
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index f92d9a687372..5621902c9921 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -4,11 +4,11 @@ menu "IRQ subsystem"
 
 # Make sparse irq Kconfig switch below available
 config MAY_HAVE_SPARSE_IRQ
-       bool
+	bool
 
 # Legacy support, required for itanic
 config GENERIC_IRQ_LEGACY
-       bool
+	bool
 
 # Enable the generic irq autoprobe mechanism
 config GENERIC_IRQ_PROBE
@@ -16,20 +16,20 @@ config GENERIC_IRQ_PROBE
 
 # Use the generic /proc/interrupts implementation
 config GENERIC_IRQ_SHOW
-       bool
+	bool
 
 # Print level/edge extra information
 config GENERIC_IRQ_SHOW_LEVEL
-       bool
+	bool
 
 # Supports effective affinity mask
 config GENERIC_IRQ_EFFECTIVE_AFF_MASK
-       bool
+	bool
 
 # Facility to allocate a hardware interrupt. This is legacy support
 # and should not be used in new code. Use irq domains instead.
 config GENERIC_IRQ_LEGACY_ALLOC_HWIRQ
-       bool
+	bool
 
 # Support for delayed migration from interrupt context
 config GENERIC_PENDING_IRQ
@@ -41,24 +41,24 @@ config GENERIC_IRQ_MIGRATION
 
 # Alpha specific irq affinity mechanism
 config AUTO_IRQ_AFFINITY
-       bool
+	bool
 
 # Tasklet based software resend for pending interrupts on enable_irq()
 config HARDIRQS_SW_RESEND
-       bool
+	bool
 
 # Preflow handler support for fasteoi (sparc64)
 config IRQ_PREFLOW_FASTEOI
-       bool
+	bool
 
 # Edge style eoi based handler (cell)
 config IRQ_EDGE_EOI_HANDLER
-       bool
+	bool
 
 # Generic configurable interrupt chip implementation
 config GENERIC_IRQ_CHIP
-       bool
-       select IRQ_DOMAIN
+	bool
+	select IRQ_DOMAIN
 
 # Generic irq_domain hw <--> linux irq number translation
 config IRQ_DOMAIN
@@ -109,7 +109,7 @@ config GENERIC_IRQ_RESERVATION_MODE
 
 # Support forced irq threading
 config IRQ_FORCED_THREADING
-       bool
+	bool
 
 config SPARSE_IRQ
 	bool "Support sparse irq numbering" if MAY_HAVE_SPARSE_IRQ
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index fcc42353f125..610d56ccb4da 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -102,24 +102,24 @@ config NO_HZ_FULL
 	select IRQ_WORK
 	select CPU_ISOLATION
 	help
-	 Adaptively try to shutdown the tick whenever possible, even when
-	 the CPU is running tasks. Typically this requires running a single
-	 task on the CPU. Chances for running tickless are maximized when
-	 the task mostly runs in userspace and has few kernel activity.
+	  Adaptively try to shutdown the tick whenever possible, even when
+	  the CPU is running tasks. Typically this requires running a single
+	  task on the CPU. Chances for running tickless are maximized when
+	  the task mostly runs in userspace and has few kernel activity.
 
-	 You need to fill up the nohz_full boot parameter with the
-	 desired range of dynticks CPUs.
+	  You need to fill up the nohz_full boot parameter with the
+	  desired range of dynticks CPUs.
 
-	 This is implemented at the expense of some overhead in user <-> kernel
-	 transitions: syscalls, exceptions and interrupts. Even when it's
-	 dynamically off.
+	  This is implemented at the expense of some overhead in user <-> kernel
+	  transitions: syscalls, exceptions and interrupts. Even when it's
+	  dynamically off.
 
-	 Say N.
+	  Say N.
 
 endchoice
 
 config CONTEXT_TRACKING
-       bool
+	bool
 
 config CONTEXT_TRACKING_FORCE
 	bool "Force context tracking"
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index f67620499faa..dbcee0257416 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -73,9 +73,9 @@ config RING_BUFFER
 	select IRQ_WORK
 
 config FTRACE_NMI_ENTER
-       bool
-       depends on HAVE_FTRACE_NMI_ENTER
-       default y
+	bool
+	depends on HAVE_FTRACE_NMI_ENTER
+	default y
 
 config EVENT_TRACING
 	select CONTEXT_SWITCH_TRACER
@@ -88,8 +88,8 @@ config CONTEXT_SWITCH_TRACER
 config RING_BUFFER_ALLOW_SWAP
 	bool
 	help
-	 Allow the use of ring_buffer_swap_cpu.
-	 Adds a very slight overhead to tracing when enabled.
+	  Allow the use of ring_buffer_swap_cpu.
+	  Adds a very slight overhead to tracing when enabled.
 
 config PREEMPTIRQ_TRACEPOINTS
 	bool
@@ -252,36 +252,36 @@ config HWLAT_TRACER
 	bool "Tracer to detect hardware latencies (like SMIs)"
 	select GENERIC_TRACER
 	help
-	 This tracer, when enabled will create one or more kernel threads,
-	 depending on what the cpumask file is set to, which each thread
-	 spinning in a loop looking for interruptions caused by
-	 something other than the kernel. For example, if a
-	 System Management Interrupt (SMI) takes a noticeable amount of
-	 time, this tracer will detect it. This is useful for testing
-	 if a system is reliable for Real Time tasks.
+	  This tracer, when enabled will create one or more kernel threads,
+	  depending on what the cpumask file is set to, which each thread
+	  spinning in a loop looking for interruptions caused by
+	  something other than the kernel. For example, if a
+	  System Management Interrupt (SMI) takes a noticeable amount of
+	  time, this tracer will detect it. This is useful for testing
+	  if a system is reliable for Real Time tasks.
 
-	 Some files are created in the tracing directory when this
-	 is enabled:
+	  Some files are created in the tracing directory when this
+	  is enabled:
 
-	   hwlat_detector/width   - time in usecs for how long to spin for
-	   hwlat_detector/window  - time in usecs between the start of each
+	    hwlat_detector/width   - time in usecs for how long to spin for
+	    hwlat_detector/window  - time in usecs between the start of each
 				     iteration
 
-	 A kernel thread is created that will spin with interrupts disabled
-	 for "width" microseconds in every "window" cycle. It will not spin
-	 for "window - width" microseconds, where the system can
-	 continue to operate.
+	  A kernel thread is created that will spin with interrupts disabled
+	  for "width" microseconds in every "window" cycle. It will not spin
+	  for "window - width" microseconds, where the system can
+	  continue to operate.
 
-	 The output will appear in the trace and trace_pipe files.
+	  The output will appear in the trace and trace_pipe files.
 
-	 When the tracer is not running, it has no affect on the system,
-	 but when it is running, it can cause the system to be
-	 periodically non responsive. Do not run this tracer on a
-	 production system.
+	  When the tracer is not running, it has no affect on the system,
+	  but when it is running, it can cause the system to be
+	  periodically non responsive. Do not run this tracer on a
+	  production system.
 
-	 To enable this tracer, echo in "hwlat" into the current_tracer
-	 file. Every time a latency is greater than tracing_thresh, it will
-	 be recorded into the ring buffer.
+	  To enable this tracer, echo in "hwlat" into the current_tracer
+	  file. Every time a latency is greater than tracing_thresh, it will
+	  be recorded into the ring buffer.
 
 config ENABLE_DEFAULT_TRACERS
 	bool "Trace process context switches and events"
@@ -339,18 +339,18 @@ choice
 	prompt "Branch Profiling"
 	default BRANCH_PROFILE_NONE
 	help
-	 The branch profiling is a software profiler. It will add hooks
-	 into the C conditionals to test which path a branch takes.
+	  The branch profiling is a software profiler. It will add hooks
+	  into the C conditionals to test which path a branch takes.
 
-	 The likely/unlikely profiler only looks at the conditions that
-	 are annotated with a likely or unlikely macro.
+	  The likely/unlikely profiler only looks at the conditions that
+	  are annotated with a likely or unlikely macro.
 
-	 The "all branch" profiler will profile every if-statement in the
-	 kernel. This profiler will also enable the likely/unlikely
-	 profiler.
+	  The "all branch" profiler will profile every if-statement in the
+	  kernel. This profiler will also enable the likely/unlikely
+	  profiler.
 
-	 Either of the above profilers adds a bit of overhead to the system.
-	 If unsure, choose "No branch profiling".
+	  Either of the above profilers adds a bit of overhead to the system.
+	  If unsure, choose "No branch profiling".
 
 config BRANCH_PROFILE_NONE
 	bool "No branch profiling"
@@ -585,8 +585,8 @@ config BPF_KPROBE_OVERRIDE
 	depends on FUNCTION_ERROR_INJECTION
 	default n
 	help
-	 Allows BPF to override the execution of a probed function and
-	 set a different return value.  This is used for error injection.
+	  Allows BPF to override the execution of a probed function and
+	  set a different return value.  This is used for error injection.
 
 config FTRACE_MCOUNT_RECORD
 	def_bool y
@@ -620,13 +620,13 @@ config EVENT_TRACE_TEST_SYSCALLS
 	bool "Run selftest on syscall events"
 	depends on EVENT_TRACE_STARTUP_TEST
 	help
-	 This option will also enable testing every syscall event.
-	 It only enables the event and disables it and runs various loads
-	 with the event enabled. This adds a bit more time for kernel boot
-	 up since it runs this on every system call defined.
+	  This option will also enable testing every syscall event.
+	  It only enables the event and disables it and runs various loads
+	  with the event enabled. This adds a bit more time for kernel boot
+	  up since it runs this on every system call defined.
 
-	 TBD - enable a way to actually call the syscalls as we test their
-	       events
+	  TBD - enable a way to actually call the syscalls as we test their
+	        events
 
 config MMIOTRACE
 	bool "Memory mapped IO tracing"
@@ -685,22 +685,22 @@ config MMIOTRACE_TEST
 config TRACEPOINT_BENCHMARK
 	bool "Add tracepoint that benchmarks tracepoints"
 	help
-	 This option creates the tracepoint "benchmark:benchmark_event".
-	 When the tracepoint is enabled, it kicks off a kernel thread that
-	 goes into an infinite loop (calling cond_sched() to let other tasks
-	 run), and calls the tracepoint. Each iteration will record the time
-	 it took to write to the tracepoint and the next iteration that
-	 data will be passed to the tracepoint itself. That is, the tracepoint
-	 will report the time it took to do the previous tracepoint.
-	 The string written to the tracepoint is a static string of 128 bytes
-	 to keep the time the same. The initial string is simply a write of
-	 "START". The second string records the cold cache time of the first
-	 write which is not added to the rest of the calculations.
+	  This option creates the tracepoint "benchmark:benchmark_event".
+	  When the tracepoint is enabled, it kicks off a kernel thread that
+	  goes into an infinite loop (calling cond_sched() to let other tasks
+	  run), and calls the tracepoint. Each iteration will record the time
+	  it took to write to the tracepoint and the next iteration that
+	  data will be passed to the tracepoint itself. That is, the tracepoint
+	  will report the time it took to do the previous tracepoint.
+	  The string written to the tracepoint is a static string of 128 bytes
+	  to keep the time the same. The initial string is simply a write of
+	  "START". The second string records the cold cache time of the first
+	  write which is not added to the rest of the calculations.
 
-	 As it is a tight loop, it benchmarks as hot cache. That's fine because
-	 we care most about hot paths that are probably in cache already.
+	  As it is a tight loop, it benchmarks as hot cache. That's fine because
+	  we care most about hot paths that are probably in cache already.
 
-	 An example of the output:
+	  An example of the output:
 
 	      START
 	      first=3672 [COLD CACHED]
@@ -729,27 +729,27 @@ config RING_BUFFER_BENCHMARK
 	  If unsure, say N.
 
 config RING_BUFFER_STARTUP_TEST
-       bool "Ring buffer startup self test"
-       depends on RING_BUFFER
-       help
-	 Run a simple self test on the ring buffer on boot up. Late in the
-	 kernel boot sequence, the test will start that kicks off
-	 a thread per cpu. Each thread will write various size events
-	 into the ring buffer. Another thread is created to send IPIs
-	 to each of the threads, where the IPI handler will also write
-	 to the ring buffer, to test/stress the nesting ability.
-	 If any anomalies are discovered, a warning will be displayed
-	 and all ring buffers will be disabled.
-
-	 The test runs for 10 seconds. This will slow your boot time
-	 by at least 10 more seconds.
-
-	 At the end of the test, statics and more checks are done.
-	 It will output the stats of each per cpu buffer. What
-	 was written, the sizes, what was read, what was lost, and
-	 other similar details.
-
-	 If unsure, say N
+	bool "Ring buffer startup self test"
+	depends on RING_BUFFER
+	help
+	  Run a simple self test on the ring buffer on boot up. Late in the
+	  kernel boot sequence, the test will start that kicks off
+	  a thread per cpu. Each thread will write various size events
+	  into the ring buffer. Another thread is created to send IPIs
+	  to each of the threads, where the IPI handler will also write
+	  to the ring buffer, to test/stress the nesting ability.
+	  If any anomalies are discovered, a warning will be displayed
+	  and all ring buffers will be disabled.
+
+	  The test runs for 10 seconds. This will slow your boot time
+	  by at least 10 more seconds.
+
+	  At the end of the test, statics and more checks are done.
+	  It will output the stats of each per cpu buffer. What
+	  was written, the sizes, what was read, what was lost, and
+	  other similar details.
+
+	  If unsure, say N
 
 config PREEMPTIRQ_DELAY_TEST
 	tristate "Preempt / IRQ disable delay thread to test latency tracers"
@@ -767,9 +767,9 @@ config PREEMPTIRQ_DELAY_TEST
 	  If unsure, say N
 
 config TRACE_EVAL_MAP_FILE
-       bool "Show eval mappings for trace events"
-       depends on TRACING
-       help
+	bool "Show eval mappings for trace events"
+	depends on TRACING
+	help
 	The "print fmt" of the trace events will show the enum/sizeof names
 	instead of their values. This can cause problems for user space tools
 	that use this string to parse the raw data as user space does not know
-- 
2.17.1

