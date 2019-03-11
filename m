Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B7CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8412084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbfCKN1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:27:35 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:39263 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbfCKNTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:36 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1McY0J-1gVfFQ1cKb-00cxnC for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:33 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 044/114] kernel: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:56 +0100
Message-Id: <1552310346-7629-45-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:bbTazX9iUvAf8+dbV+j0TWoRspk3bpLMhCajGJAtJ7YMMVFRjUY
 WnrSp/7FFZ1sXrZpwsptzTzcMWDiQoU6hUWywiQQB7etUIO8oPUTmmugA/0WrdgxzlU7Aih
 NOZZPmrc1xExwDu3+fwLe3qjVjVBbMw36/e3DYRVEPvJJ60o5C1KT9g7ECEwuDfVtZGbRAm
 ABDgHXeopVlys+9oQcAhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XgPFCmMFz3g=:BIoRt9qcKfSu5K/QDNZPR7
 BlE8R5frA9dcaYa+qGRjiryH2oJu/JWoTK2RpslHvawoLVodePmLynVXMt2zdBUWWzBxr3IC+
 EH00/GoyPvkQvh/Lc64f9GzspcYRfe22BMIMQIpEzMaFYPPFou251j3q0KNYD5xFihvtPNOfy
 QCr2MXmcQW8NC3VNn58ue5LMvNGFwUGpBA6tz+ow4aqyO2sSQqsZlVp791yecw6cogvE3LhyQ
 zUBhQmQml0uoCo+Z9DOsIQfvykikvQoM9Slnsme0nc+nkuiQgVt5SK/hvGc/7uZBo+D5c502B
 CEj1vY69EmI1BntpnQj4M2dDuKOIi6TStTGp01Q1bcTfMVUe8UVrHb/vkXcxtfvnv+5+YW4RJ
 Ly2Pz+FoOvxhrxhtfFoTmWlr2RM0K6FuVtqTzatOizpatYHaubMyF2fShHowBB1QblEKLAVxI
 8dw4TgQNIYhOkpd9ZOFoee88iPGXgXv4zTOGh74idWZVRoCO5nrdRnTYT7+xJKnriVigZF07k
 e+YGTy553NLrNv2OZGCjx7K/E20zDK6p4gkT3ikC7R+cqZCXT4ZSgS/czo/gmSReULR2Qt7Px
 utphm1jzfO/qObfdT7yAqscEl0/IWF3xRGd0QKb4tYDb9wG8iH70uHm5pRfMS/IQzfFRWQAAC
 v0PQ4RscbzHhu32UnM9CqXXvcgLkOJIllIduY6VXeIBE4LPREyoa0W2oLcq8PJnBfC1Ym+nRy
 RtrdxDS5mlBFLJHiR8IBZyIkwKfZSVKJPWrhVQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 kernel/irq/Kconfig   |  26 +++----
 kernel/power/Kconfig |  12 +--
 kernel/rcu/Kconfig   |   2 +-
 kernel/time/Kconfig  |  20 ++---
 kernel/trace/Kconfig | 205 +++++++++++++++++++++++++--------------------------
 5 files changed, 132 insertions(+), 133 deletions(-)

diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 5f3e2ba..c595a48 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -3,11 +3,11 @@ menu "IRQ subsystem"
 
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
@@ -15,20 +15,20 @@ config GENERIC_IRQ_PROBE
 
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
@@ -40,24 +40,24 @@ config GENERIC_IRQ_MIGRATION
 
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
@@ -105,7 +105,7 @@ config GENERIC_IRQ_RESERVATION_MODE
 
 # Support forced irq threading
 config IRQ_FORCED_THREADING
-       bool
+	bool
 
 config SPARSE_IRQ
 	bool "Support sparse irq numbering" if MAY_HAVE_SPARSE_IRQ
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index f8fe57d..a646337 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -85,20 +85,20 @@ config PM_STD_PARTITION
 	default ""
 	---help---
 	  The default resume partition is the partition that the suspend-
-	  to-disk implementation will look for a suspended disk image. 
+	  to-disk implementation will look for a suspended disk image.
 
-	  The partition specified here will be different for almost every user. 
+	  The partition specified here will be different for almost every user.
 	  It should be a valid swap partition (at least for now) that is turned
-	  on before suspending. 
+	  on before suspending.
 
 	  The partition specified can be overridden by specifying:
 
-		resume=/dev/<other device> 
+	        resume=/dev/<other device>
 
-	  which will set the resume partition to the device specified. 
+	  which will set the resume partition to the device specified.
 
 	  Note there is currently not a way to specify which device to save the
-	  suspended image to. It will simply pick the first available swap 
+	  suspended image to. It will simply pick the first available swap
 	  device.
 
 config PM_SLEEP
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 3730143..2f213fe 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -154,7 +154,7 @@ config RCU_FAST_NO_HZ
 	  for example, slowing down synchronize_rcu().
 
 	  Say Y if energy efficiency is critically important, and you
-	  	don't care about increased grace-period durations.
+	  don't care about increased grace-period durations.
 
 	  Say N if you are unsure.
 
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index e2c038d..8e8e263 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -101,19 +101,19 @@ config NO_HZ_FULL
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
 
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index fa8b1fe..05f29e2 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -69,13 +69,13 @@ config RING_BUFFER
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
-        select GLOB
+	select GLOB
 	bool
 
 config CONTEXT_SWITCH_TRACER
@@ -84,8 +84,8 @@ config CONTEXT_SWITCH_TRACER
 config RING_BUFFER_ALLOW_SWAP
 	bool
 	help
-	 Allow the use of ring_buffer_swap_cpu.
-	 Adds a very slight overhead to tracing when enabled.
+	  Allow the use of ring_buffer_swap_cpu.
+	  Adds a very slight overhead to tracing when enabled.
 
 config PREEMPTIRQ_TRACEPOINTS
 	bool
@@ -248,36 +248,36 @@ config HWLAT_TRACER
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
 
 	   hwlat_detector/width   - time in usecs for how long to spin for
 	   hwlat_detector/window  - time in usecs between the start of each
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
@@ -307,7 +307,7 @@ config TRACER_SNAPSHOT
 	      cat snapshot
 
 config TRACER_SNAPSHOT_PER_CPU_SWAP
-        bool "Allow snapshot to swap per CPU"
+	bool "Allow snapshot to swap per CPU"
 	depends on TRACER_SNAPSHOT
 	select RING_BUFFER_ALLOW_SWAP
 	help
@@ -335,18 +335,18 @@ choice
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
@@ -574,8 +574,8 @@ config BPF_KPROBE_OVERRIDE
 	depends on FUNCTION_ERROR_INJECTION
 	default n
 	help
-	 Allows BPF to override the execution of a probed function and
-	 set a different return value.  This is used for error injection.
+	  Allows BPF to override the execution of a probed function and
+	  set a different return value.  This is used for error injection.
 
 config FTRACE_MCOUNT_RECORD
 	def_bool y
@@ -599,13 +599,13 @@ config EVENT_TRACE_TEST_SYSCALLS
 	bool "Run selftest on syscall events"
 	depends on FTRACE_STARTUP_TEST
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
@@ -662,24 +662,24 @@ config MMIOTRACE_TEST
 	  Say N, unless you absolutely know what you are doing.
 
 config TRACEPOINT_BENCHMARK
-        bool "Add tracepoint that benchmarks tracepoints"
+	bool "Add tracepoint that benchmarks tracepoints"
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
@@ -708,27 +708,27 @@ config RING_BUFFER_BENCHMARK
 	  If unsure, say N.
 
 config RING_BUFFER_STARTUP_TEST
-       bool "Ring buffer startup self test"
-       depends on RING_BUFFER
-       help
-         Run a simple self test on the ring buffer on boot up. Late in the
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
@@ -746,32 +746,32 @@ config PREEMPTIRQ_DELAY_TEST
 	  If unsure, say N
 
 config TRACE_EVAL_MAP_FILE
-       bool "Show eval mappings for trace events"
-       depends on TRACING
-       help
-	The "print fmt" of the trace events will show the enum/sizeof names
-	instead	of their values. This can cause problems for user space tools
-	that use this string to parse the raw data as user space does not know
-	how to convert the string to its value.
+	bool "Show eval mappings for trace events"
+	depends on TRACING
+	help
+	  The "print fmt" of the trace events will show the enum/sizeof names
+	  instead of their values. This can cause problems for user space tools
+	  that use this string to parse the raw data as user space does not know
+	  how to convert the string to its value.
 
-	To fix this, there's a special macro in the kernel that can be used
-	to convert an enum/sizeof into its value. If this macro is used, then
-	the print fmt strings will be converted to their values.
+	  To fix this, there's a special macro in the kernel that can be used
+	  to convert an enum/sizeof into its value. If this macro is used, then
+	  the print fmt strings will be converted to their values.
 
-	If something does not get converted properly, this option can be
-	used to show what enums/sizeof the kernel tried to convert.
+	  If something does not get converted properly, this option can be
+	  used to show what enums/sizeof the kernel tried to convert.
 
-	This option is for debugging the conversions. A file is created
-	in the tracing directory called "eval_map" that will show the
-	names matched with their values and what trace event system they
-	belong too.
+	  This option is for debugging the conversions. A file is created
+	  in the tracing directory called "eval_map" that will show the
+	  names matched with their values and what trace event system they
+	  belong too.
 
-	Normally, the mapping of the strings to values will be freed after
-	boot up or module load. With this option, they will not be freed, as
-	they are needed for the "eval_map" file. Enabling this option will
-	increase the memory footprint of the running kernel.
+	  Normally, the mapping of the strings to values will be freed after
+	  boot up or module load. With this option, they will not be freed, as
+	  they are needed for the "eval_map" file. Enabling this option will
+	  increase the memory footprint of the running kernel.
 
-	If unsure, say N
+	  If unsure, say N
 
 config TRACING_EVENTS_GPIO
 	bool "Trace gpio events"
@@ -795,4 +795,3 @@ config GCOV_PROFILE_FTRACE
 endif # FTRACE
 
 endif # TRACING_SUPPORT
-
-- 
1.9.1

