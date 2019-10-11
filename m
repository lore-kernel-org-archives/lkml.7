Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0B9C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA38321835
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824387;
	bh=BSSYs05uiMQ6xCMrfVu3XVC5J8pUxmr4IHLC+/LkhvY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Y2DVIT1ZN8QS3VYBVz4rNtqSxeAfZqONswzES9OixI6JE0Mq7dYexEKiQQGu16fXb
	 T+ymfsBIa3bp8Kd1s4zv4Le4WtSCVyktvoTQyAfY29TMbqf2cHoR820XMiQoJov9Ek
	 B73+UjXFIT/3mKawTN0pfk/NTX3wxux8XwYe2CY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbfJKUG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:06:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728799AbfJKUGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:06:25 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E62C6214E0;
        Fri, 11 Oct 2019 20:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824383;
        bh=BSSYs05uiMQ6xCMrfVu3XVC5J8pUxmr4IHLC+/LkhvY=;
        h=From:To:Cc:Subject:Date:From;
        b=nDZH96Zkq3oOlXkKMXIfVTkORNoVIh1lruv4QEM0OK916v5DUiaJLFCIId4LJwKwc
         eG4HmTTBVt7zO5ivf8277Fxvse7kehk/Eyhx71yMTI+yM4Px4d7YR2BN1nlkCEaOt3
         nrE/IywUO0UDLG/EDyzeWZQCfqYZ2uinvaw8eeAA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        KP Singh <kpsingh@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf/core improvements and fixes
Date:   Fri, 11 Oct 2019 17:04:50 -0300
Message-Id: <20191011200559.7156-1-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

	Please consider pulling,

Best regards,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit f733c6b508bcaa3441ba1eacf16efb9abd47489f:

  perf/core: Fix inheritance of aux_output groups (2019-10-07 16:50:42 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.5-20191011

for you to fetch changes up to cebf7d51a6c3babc4d0589da7aec0de1af0a5691:

  perf diff: Report noisy for cycles diff (2019-10-11 10:57:00 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

perf trace:

  Arnaldo Carvalho de Melo:

  - Reuse the strace-like syscall_arg_fmt->scnprintf() beautification routines
    (convert integer arguments into strings, like open flags, etc) in tracepoint
    arguments.

    For now the type based scnprintf routines (pid_t, umode_t, etc) and the
    ones based in well known arg name based ("fd", etc) gets associated with
    tracepoint args of that type.

    A tracepoint only arg, "msr", for the msr:{write,read}_msr gets added as
    an initial step.

  - Introduce syscall_arg_fmt->strtoul() methods to be the reverse operation
    of ->scnprintf(), i.e. to go from a string to an integer.

  - Implement --filter, just like in 'perf record', that affects the tracepoint
    events specied thus far in the command line, use the ->strtoul() methods
    to allow strings in tables associated with beautifiers to the integers
    the in-kernel tracepoint (eBPF later) filters expect, e.g.:

     # perf trace --max-events 1 -e sched:*ipi --filter="cpu==1 || cpu==2"
      0.000 as/24630 sched:sched_wake_idle_without_ipi(cpu: 1)
     #

     # perf trace --max-events 1 --max-stack=32 -e msr:* --filter="msr==IA32_TSC_DEADLINE"
      207.000 cc1/19963 msr:write_msr(msr: IA32_TSC_DEADLINE, val: 5442316760822)
                                        do_trace_write_msr ([kernel.kallsyms])
                                        do_trace_write_msr ([kernel.kallsyms])
                                        lapic_next_deadline ([kernel.kallsyms])
                                        clockevents_program_event ([kernel.kallsyms])
                                        hrtimer_interrupt ([kernel.kallsyms])
                                        smp_apic_timer_interrupt ([kernel.kallsyms])
                                        apic_timer_interrupt ([kernel.kallsyms])
                                        [0x6ff66c] (/usr/lib/gcc-cross/alpha-linux-gnu/8/cc1)
                                        [0x7047c3] (/usr/lib/gcc-cross/alpha-linux-gnu/8/cc1)
                                        [0x707708] (/usr/lib/gcc-cross/alpha-linux-gnu/8/cc1)
                                        execute_one_pass (/usr/lib/gcc-cross/alpha-linux-gnu/8/cc1)
                                        [0x4f3d37] (/usr/lib/gcc-cross/alpha-linux-gnu/8/cc1)
                                        [0x4f3d49] (/usr/lib/gcc-cross/alpha-linux-gnu/8/cc1)
                                        execute_pass_list (/usr/lib/gcc-cross/alpha-linux-gnu/8/cc1)
                                        cgraph_node::expand (/usr/lib/gcc-cross/alpha-linux-gnu/8/cc1)
                                        [0x2625b4] (/usr/lib/gcc-cross/alpha-linux-gnu/8/cc1)
                                        symbol_table::finalize_compilation_unit (/usr/lib/gcc-cross/alpha-linux-gnu/8/cc1)
                                        [0x5ae8b9] (/usr/lib/gcc-cross/alpha-linux-gnu/8/cc1)
                                        toplev::main (/usr/lib/gcc-cross/alpha-linux-gnu/8/cc1)
                                        main (/usr/lib/gcc-cross/alpha-linux-gnu/8/cc1)
                                        [0x26b6a] (/usr/lib/x86_64-linux-gnu/libc-2.29.so)
     #
     # perf trace --max-events 8 -e msr:* --filter="msr==IA32_SPEC_CTRL"
         0.000 :13281/13281 msr:write_msr(msr: IA32_SPEC_CTRL, val: 6)
         0.063 migration/3/25 msr:write_msr(msr: IA32_SPEC_CTRL)
         0.217 kworker/u16:1-/4826 msr:write_msr(msr: IA32_SPEC_CTRL)
         0.687 rcu_sched/11 msr:write_msr(msr: IA32_SPEC_CTRL)
         0.696 :13280/13280 msr:write_msr(msr: IA32_SPEC_CTRL, val: 6)
         0.305 :13281/13281 msr:write_msr(msr: IA32_SPEC_CTRL, val: 6)
         0.355 :13274/13274 msr:write_msr(msr: IA32_SPEC_CTRL, val: 6)
         2.743 kworker/u16:0-/6711 msr:write_msr(msr: IA32_SPEC_CTRL)
     #
     # perf trace --max-events 8 --cpu 1 -e msr:* --filter="msr!=IA32_SPEC_CTRL && msr!=IA32_TSC_DEADLINE && msr != FS_BASE"
           0.000 mtr-packet/30819 msr:write_msr(msr: 0x830, val: 68719479037)
           0.096 :0/0 msr:read_msr(msr: IA32_TSC_ADJUST)
         238.925 mtr-packet/30819 msr:write_msr(msr: 0x830, val: 8589936893)
         511.010 :0/0 msr:write_msr(msr: 0x830, val: 68719479037)
        1005.052 :0/0 msr:read_msr(msr: IA32_TSC_ADJUST)
        1235.131 CPU 0/KVM/3750 msr:write_msr(msr: 0x830, val: 4294969595)
        1235.195 CPU 0/KVM/3750 msr:read_msr(msr: IA32_SYSENTER_ESP, val: -2199023037952)
        1235.201 CPU 0/KVM/3750 msr:read_msr(msr: IA32_APICBASE, val: 4276096000)
     #

  - Default to not using libtraceevent and its plugins for beautifying
    tracepoint arguments, since now we're reusing the strace-like beautifiers.
    Use --libtraceevent_print (using just --libtrace is unambiguous and can
    be used as a short hand) to go back to those beautifiers.

    This will help in the transition, as can be seen in some of the sched tracepoints
    that still need some work in the libbeauty based mode:

    # trace --no-inherit -e msr:*,*sleep,sched:* sleep 1
         0.000 (         ): sched:sched_waking(comm: "trace", pid: 3319 (trace), prio: 120, success: 1)
         0.006 (         ): sched:sched_wakeup(comm: "trace", pid: 3319 (trace), prio: 120, success: 1)
         0.348 (         ): sched:sched_process_exec(filename: 140212596720100, pid: 3319 (sleep), old_pid: 3319 (sleep))
         0.490 (         ): msr:write_msr(msr: FS_BASE, val: 139631189321088)
         0.670 (         ): nanosleep(rqtp: 0x7ffc52c23bc0)                                    ...
         0.674 (         ): sched:sched_stat_runtime(comm: "sleep", pid: 3319 (sleep), runtime: 659259, vruntime: 78942418342)
         0.675 (         ): sched:sched_switch(prev_comm: "sleep", prev_pid: 3319 (sleep), prev_prio: 120, prev_state: 1, next_comm: "swapper/0", next_prio: 120)
      1001.059 (         ): sched:sched_waking(comm: "sleep", pid: 3319 (sleep), prio: 120, success: 1)
      1001.098 (         ): sched:sched_wakeup(comm: "sleep", pid: 3319 (sleep), prio: 120, success: 1)
         0.670 (1000.504 ms):  ... [continued]: nanosleep())                                        = 0
      1001.456 (         ): sched:sched_process_exit(comm: "sleep", pid: 3319 (sleep), prio: 120)
    # trace --libtrace --no-inherit -e msr:*,*sleep,sched:* sleep 1
    # trace --libtrace --no-inherit -e msr:*,*sleep,sched:* sleep 1
         0.000 (         ): sched:sched_waking(comm=trace pid=3323 prio=120 target_cpu=000)
         0.007 (         ): sched:sched_wakeup(comm=trace pid=3323 prio=120 target_cpu=000)
         0.382 (         ): sched:sched_process_exec(filename=/usr/bin/sleep pid=3323 old_pid=3323)
         0.525 (         ): msr:write_msr(c0000100, value 7f5d508a0580)
         0.713 (         ): nanosleep(rqtp: 0x7fff487fb4a0)                                    ...
         0.717 (         ): sched:sched_stat_runtime(comm=sleep pid=3323 runtime=617722 [ns] vruntime=78957731636 [ns])
         0.719 (         ): sched:sched_switch(prev_comm=sleep prev_pid=3323 prev_prio=120 prev_state=S ==> next_comm=swapper/0 next_pid=0 next_prio=120)
      1001.117 (         ): sched:sched_waking(comm=sleep pid=3323 prio=120 target_cpu=000)
      1001.157 (         ): sched:sched_wakeup(comm=sleep pid=3323 prio=120 target_cpu=000)
         0.713 (1000.522 ms):  ... [continued]: nanosleep())                                        = 0
      1001.538 (         ): sched:sched_process_exit(comm=sleep pid=3323 prio=120)
    #

  - Make -v (verbose) mode be honoured for .perfconfig based trace.add_events,
    to help in diagnosing problems with building eBPF events (-e source.c).

  - When using eBPF syscall payload augmentation do not show strace-like
    syscalls when all the user specified was some tracepoint event, bringing
    the behaviour in line with that of when not using eBPF augmentation.

Intel PT:

  exported-sql-viewer GUI:

  Adrian Hunter:

  - Add LookupModel, HBoxLayout, VBoxLayout, global time range calculations
    so as to add a time chart by CPU.

perf script:

  Andi Kleen:

  - Allow --time (to specify a time span of interest) with --reltime

perf diff:

  Jin Yao:

  - Report noise for cycles diff, i.e. a histogram + stddev.
    (timestamps relative to start).

perf annotate:

  Arnaldo Carvalho de Melo:

  - Initialize env->cpuid when running in live mode (perf top), as it
    is used in some of the per arch annotation init routines.

samples bpf:

  Björn Töpel:

  - Fixup fallout of using tools/perf/perf-sys. from outside tools/perf.

Core:

  Ian Rogers:

  - Avoid 'sample_reg_masks' being const + weak, as this breaks with some
    compilers that constant-propagate from the weak symbol.

libperf:

  - First part of moving the perf_mmap class from tools/perf to libperf.

  - Propagate CFLAGS to libperf from the tools/perf Makefile.

Vendor events:

  John Garry:

  - Add entry in MAINTAINERS with reviewers for the for perf tool arm64
    pmu-events files.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (6):
      perf scripts python: exported-sql-viewer.py: Add LookupModel()
      perf scripts python: exported-sql-viewer.py: Add HBoxLayout and VBoxLayout
      perf scripts python: exported-sql-viewer.py: Add global time range calculations
      perf scripts python: exported-sql-viewer.py: Tidy up Call tree call_time
      perf scripts python: exported-sql-viewer.py: Add ability for Call tree to open at a specified task and time
      perf scripts python: exported-sql-viewer.py: Add Time chart by CPU

Andi Kleen (1):
      perf script: Allow --time with --reltime

Arnaldo Carvalho de Melo (30):
      perf env: Add routine to read the env->cpuid from the running machine
      perf top: Initialize perf_env->cpuid, needed by the per arch annotation init routine
      perf evlist: Adopt __set_tracepoint_handlers method from perf_session
      perf trace: Make evlist__set_evsel_handler() affect just entries without a handler
      perf trace: Separate 'struct syscall_fmt' definition from syscall_fmts variable
      perf trace: Generalize the syscall_fmt find routines
      perf trace: Postpone parsing .perfconfig trace.add_events to after --verbose is processed
      perf trace augmented_syscalls: Do not show syscalls when none was asked for
      perf trace: Factor out the initialization of syscal_arg_fmt->scnprintf
      perf trace: Allocate an array of beautifiers for tracepoint args
      perf trace: Move some scnprintf methods from syscall to syscall_arg_fmt
      perf trace: Add the syscall_arg_fmt pointer to syscall_arg
      perf trace: Add array of chars scnprintf beautifier
      perf trace: Enclose all events argument lists with ()
      perf trace: Allow choosing how to augment the tracepoint arguments
      tools arch x86: Grab a copy of the file containing the MSR numbers
      perf beauty: Make strarray's offset be u64
      perf trace beauty: Add a x86 MSR cmd id->str table generator
      perf beauty: Hook up the x86 MSR table generator
      perf trace: Allow associating scnprintf routines with well known arg names
      perf trace beauty: Add the glue for the autogenerated MSR arrays
      perf trace: Associate the "msr" tracepoint arg name with x86_MSR__scnprintf()
      perf evlist: Factor out asprintf routine to build a tracepoint pid filter
      perf evlist: Introduce append_tp_filter() method
      perf evlist: Introduce append_tp_filter_pid() and append_tp_filter_pids()
      perf trace: Introduce --filter for tracepoint events
      perf trace: Add a strtoul() method to 'struct syscall_arg_fmt'
      perf trace: Introduce a strtoul() method for 'struct strarrays'
      perf trace: Expand strings in filters to integers
      perf beauty: Introduce strtoul() for x86 MSRs

Björn Töpel (2):
      perf tools: Make usage of test_attr__* optional for perf-sys.h
      samples/bpf: fix build by setting HAVE_ATTR_TEST to zero

Ian Rogers (1):
      perf tools: Avoid 'sample_reg_masks' being const + weak

Jin Yao (1):
      perf diff: Report noisy for cycles diff

Jiri Olsa (27):
      libperf: Add perf_mmap__init() function
      libperf: Add 'struct perf_mmap_param'
      libperf: Adopt perf_mmap__mmap_len() function from tools/perf
      libperf: Adopt perf_mmap__mmap() function from tools/perf
      libperf: Adopt perf_mmap__get() function from tools/perf
      libperf: Adopt perf_mmap__unmap() function from tools/perf
      libperf: Adopt perf_mmap__put() function from tools/perf
      perf tools: Use perf_mmap way to detect aux mmap
      libperf: Adopt perf_mmap__consume() function from tools/perf
      libperf: Adopt perf_mmap__read_init() from tools/perf
      libperf: Adopt perf_mmap__read_done() from tools/perf
      libperf: Adopt perf_mmap__read_event() from tools/perf
      libperf: Adopt perf_evlist__mmap()/munmap() from tools/perf
      libperf: Introduce perf_evlist__mmap_ops()
      libperf: Introduce perf_evlist_mmap_ops::idx callback
      libperf: Add perf_evlist_mmap_ops::get callback
      libperf: Introduce perf_evlist_mmap_ops::mmap callback
      perf tools: Introduce perf_evlist__mmap_cb_idx()
      perf evlist: Introduce perf_evlist__mmap_cb_get()
      perf evlist: Introduce perf_evlist__mmap_cb_mmap()
      perf evlist: Switch to libperf's mmap interface
      libperf: Centralize map refcnt setting
      libperf: Move the pollfd allocation from tools/perf to libperf
      libperf: Introduce perf_evlist__exit()
      libperf: Introduce perf_evlist__purge()
      libperf: Adopt perf_evlist__filter_pollfd() from tools/perf
      perf tools: Propagate CFLAGS to libperf

John Garry (1):
      MAINTAINERS: Add entry for perf tool arm64 pmu-events files

 MAINTAINERS                                      |    7 +
 samples/bpf/Makefile                             |    1 +
 tools/arch/x86/include/asm/msr-index.h           |  857 ++++++++++++
 tools/perf/Documentation/perf-config.txt         |    5 +
 tools/perf/Documentation/perf-diff.txt           |    5 +
 tools/perf/Documentation/perf-trace.txt          |   10 +
 tools/perf/Makefile.config                       |   28 +-
 tools/perf/Makefile.perf                         |   11 +-
 tools/perf/arch/arm/util/Build                   |    2 +
 tools/perf/arch/arm/util/perf_regs.c             |    6 +
 tools/perf/arch/arm64/util/Build                 |    1 +
 tools/perf/arch/arm64/util/perf_regs.c           |    6 +
 tools/perf/arch/csky/util/Build                  |    2 +
 tools/perf/arch/csky/util/perf_regs.c            |    6 +
 tools/perf/arch/riscv/util/Build                 |    2 +
 tools/perf/arch/riscv/util/perf_regs.c           |    6 +
 tools/perf/arch/s390/util/Build                  |    1 +
 tools/perf/arch/s390/util/perf_regs.c            |    6 +
 tools/perf/arch/x86/tests/perf-time-to-tsc.c     |    9 +-
 tools/perf/builtin-diff.c                        |  143 ++
 tools/perf/builtin-kvm.c                         |   11 +-
 tools/perf/builtin-record.c                      |   10 +-
 tools/perf/builtin-script.c                      |    5 -
 tools/perf/builtin-top.c                         |   20 +-
 tools/perf/builtin-trace.c                       |  593 +++++++--
 tools/perf/check-headers.sh                      |    1 +
 tools/perf/lib/Build                             |    1 +
 tools/perf/lib/Makefile                          |    5 +-
 tools/perf/lib/core.c                            |    3 +-
 tools/perf/lib/evlist.c                          |  324 +++++
 tools/perf/lib/include/internal/evlist.h         |   40 +
 tools/perf/lib/include/internal/mmap.h           |   44 +-
 tools/perf/lib/include/perf/core.h               |    2 +
 tools/perf/lib/include/perf/evlist.h             |    5 +
 tools/perf/lib/include/perf/mmap.h               |   15 +
 tools/perf/lib/internal.h                        |    2 +
 tools/perf/lib/libperf.map                       |    7 +
 tools/perf/lib/mmap.c                            |  273 ++++
 tools/perf/perf-sys.h                            |    6 +-
 tools/perf/scripts/python/exported-sql-viewer.py | 1555 +++++++++++++++++++++-
 tools/perf/tests/backward-ring-buffer.c          |    7 +-
 tools/perf/tests/bpf.c                           |    7 +-
 tools/perf/tests/code-reading.c                  |    9 +-
 tools/perf/tests/keep-tracking.c                 |    9 +-
 tools/perf/tests/mmap-basic.c                    |    9 +-
 tools/perf/tests/openat-syscall-tp-fields.c      |    9 +-
 tools/perf/tests/perf-record.c                   |    9 +-
 tools/perf/tests/sw-clock.c                      |    9 +-
 tools/perf/tests/switch-tracking.c               |    9 +-
 tools/perf/tests/task-exit.c                     |    9 +-
 tools/perf/trace/beauty/Build                    |    1 +
 tools/perf/trace/beauty/beauty.h                 |   16 +-
 tools/perf/trace/beauty/tracepoints/Build        |    1 +
 tools/perf/trace/beauty/tracepoints/x86_msr.c    |   39 +
 tools/perf/trace/beauty/tracepoints/x86_msr.sh   |   40 +
 tools/perf/util/Build                            |    1 +
 tools/perf/util/annotate.c                       |    4 +
 tools/perf/util/annotate.h                       |    2 +
 tools/perf/util/env.c                            |   16 +
 tools/perf/util/env.h                            |    1 +
 tools/perf/util/evlist.c                         |  322 ++---
 tools/perf/util/evlist.h                         |   12 +
 tools/perf/util/mmap.c                           |  260 +---
 tools/perf/util/mmap.h                           |   28 +-
 tools/perf/util/parse-regs-options.c             |    8 +-
 tools/perf/util/perf_regs.c                      |    4 -
 tools/perf/util/perf_regs.h                      |    4 +-
 tools/perf/util/python.c                         |    7 +-
 tools/perf/util/session.c                        |   29 -
 tools/perf/util/session.h                        |    6 +-
 tools/perf/util/sort.h                           |    4 +
 tools/perf/util/spark.c                          |   34 +
 tools/perf/util/spark.h                          |    8 +
 tools/perf/util/symbol.h                         |    2 +
 74 files changed, 4266 insertions(+), 705 deletions(-)
 create mode 100644 tools/arch/x86/include/asm/msr-index.h
 create mode 100644 tools/perf/arch/arm/util/perf_regs.c
 create mode 100644 tools/perf/arch/arm64/util/perf_regs.c
 create mode 100644 tools/perf/arch/csky/util/perf_regs.c
 create mode 100644 tools/perf/arch/riscv/util/perf_regs.c
 create mode 100644 tools/perf/arch/s390/util/perf_regs.c
 create mode 100644 tools/perf/lib/include/perf/mmap.h
 create mode 100644 tools/perf/lib/mmap.c
 create mode 100644 tools/perf/trace/beauty/tracepoints/Build
 create mode 100644 tools/perf/trace/beauty/tracepoints/x86_msr.c
 create mode 100755 tools/perf/trace/beauty/tracepoints/x86_msr.sh
 create mode 100644 tools/perf/util/spark.c
 create mode 100644 tools/perf/util/spark.h

Test results:

The first ones are container based builds of tools/perf with and without libelf
support.  Where clang is available, it is also used to build perf with/without
libelf, and building with LIBCLANGLLVM=1 (built-in clang) with gcc and clang
when clang and its devel libraries are installed.

The objtool and samples/bpf/ builds are disabled now that I'm switching from
using the sources in a local volume to fetching them from a http server to
build it inside the container, to make it easier to build in a container cluster.
Those will come back later.

Several are cross builds, the ones with -x-ARCH and the android one, and those
may not have all the features built, due to lack of multi-arch devel packages,
available and being used so far on just a few, like
debian:experimental-x-{arm64,mipsel}.

The 'perf test' one will perform a variety of tests exercising
tools/perf/util/, tools/lib/{bpf,traceevent,etc}, as well as run perf commands
with a variety of command line event specifications to then intercept the
sys_perf_event syscall to check that the perf_event_attr fields are set up as
expected, among a variety of other unit tests.

Then there is the 'make -C tools/perf build-test' ones, that build tools/perf/
with a variety of feature sets, exercising the build with an incomplete set of
features as well as with a complete one. It is planned to have it run on each
of the containers mentioned above, using some container orchestration
infrastructure. Get in contact if interested in helping having this in place.

Clearlinux is failing when building with libpython, but that is not a perf
regression, will try to remove one compiler warning that is causing the problem
when building some of the glue code files in the python files, outside perf.

  # export PERF_TARBALL=http://192.168.124.1/perf/perf-5.4.0-rc2.tar.xz
  # dm 
   1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0, clang version 3.8.0 (tags/RELEASE_380/final)
   2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822, clang version 3.8.1 (tags/RELEASE_381/final)
   3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0, clang version 4.0.0 (tags/RELEASE_400/final)
   4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
   5 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
   6 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
   7 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
   8 alpine:edge                   : Ok   gcc (Alpine 9.2.0) 9.2.0, Alpine clang version 8.0.1 (tags/RELEASE_801/final) (based on LLVM 8.0.1)
   9 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2), clang version 3.6.2 (tags/RELEASE_362/final)
  10 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180303 (Red Hat 7.3.1-5), clang version 7.0.1 (Amazon Linux 2 7.0.1-1.amzn2.0.2)
  11 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  12 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  13 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  14 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  15 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
  16 centos:8                      : Ok   gcc (GCC) 8.2.1 20180905 (Red Hat 8.2.1-3), clang version 7.0.1 (tags/RELEASE_701/final)
  17 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 9.2.1 20190930 gcc-9-branch@276275, clang version 8.0.0 (tags/RELEASE_800/final)
  18 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2, Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
  19 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516, clang version 3.8.1-24 (tags/RELEASE_381/final)
  20 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0, clang version 7.0.1-8 (tags/RELEASE_701/final)
  21 debian:experimental           : Ok   gcc (Debian 9.2.1-8) 9.2.1 20190909, clang version 8.0.1-3+b1 (tags/RELEASE_801/final)
  22 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.3.0-19) 8.3.0
  23 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.3.0-19) 8.3.0
  24 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 8.3.0-19) 8.3.0
  25 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 8.3.0-19) 8.3.0
  26 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
  27 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6), clang version 3.5.0 (tags/RELEASE_350/final)
  28 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6), clang version 3.7.0 (tags/RELEASE_370/final)
  29 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1), clang version 3.8.1 (tags/RELEASE_381/final)
  30 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  31 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1), clang version 3.9.1 (tags/RELEASE_391/final)
  32 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2), clang version 4.0.1 (tags/RELEASE_401/final)
  33 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6), clang version 5.0.2 (tags/RELEASE_502/final)
  34 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 6.0.1 (tags/RELEASE_601/final)
  35 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 7.0.1 (Fedora 7.0.1-6.fc29)
  36 fedora:30                     : Ok   gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1), clang version 8.0.0 (Fedora 8.0.0-3.fc30)
  37 fedora:30-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225
  38 fedora:30-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225
  39 fedora:31                     : Ok   gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1), clang version 9.0.0 (Fedora 9.0.0-1.fc31)
  40 fedora:rawhide                : Ok   gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1), clang version 9.0.0 (Fedora 9.0.0-1.fc32)
  41 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 8.3.0-r1 p1.1) 8.3.0
  42 mageia:5                      : Ok   gcc (GCC) 4.9.2, clang version 3.5.2 (tags/RELEASE_352/final)
  43 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0, clang version 3.9.1 (tags/RELEASE_391/final)
  44 mageia:7                      : Ok   gcc (Mageia 8.3.1-0.20190524.1.mga7) 8.3.1 20190524, clang version 8.0.0 (Mageia 8.0.0-1.mga7)
  45 manjaro:latest                : Ok   gcc (GCC) 9.2.0, clang version 8.0.1 (tags/RELEASE_801/final)
  46 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190424 [gcc-7-branch revision 270538], clang version 5.0.1 (tags/RELEASE_501/final 312548)
  47 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.4.1 20190424 [gcc-7-branch revision 270538], clang version 7.0.1 (tags/RELEASE_701/final 349238)
  48 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5, clang version 3.8.0 (tags/RELEASE_380/final 262553)
  49 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 9.2.1 20190903 [gcc-9-branch revision 275330], clang version 8.0.1 (tags/RELEASE_801/final 366581)
  50 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  51 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39.0.1), clang version 3.4.2 (tags/RELEASE_34/dot2-final)
  52 oraclelinux:8                 : Ok   gcc (GCC) 8.2.1 20180905 (Red Hat 8.2.1-3.0.1), clang version 7.0.1 (tags/RELEASE_701/final)
  53 ubuntu:12.04                  : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3, Ubuntu clang version 3.0-6ubuntu3 (tags/RELEASE_30/final) (based on LLVM 3.0)
  54 ubuntu:14.04                  : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4, Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)
  55 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.11) 5.4.0 20160609, clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
  56 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  57 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  58 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  59 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  60 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  61 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  62 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0, clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  63 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1) 7.4.0
  64 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1) 7.4.0
  65 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  66 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  67 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  68 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  69 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  70 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  71 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  72 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  73 ubuntu:18.10                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1~18.10.1) 8.3.0, clang version 7.0.0-3 (tags/RELEASE_700/final)
  74 ubuntu:19.04                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0, clang version 8.0.0-3 (tags/RELEASE_800/final)
  75 ubuntu:19.04-x-alpha          : Ok   alpha-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  76 ubuntu:19.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 8.3.0-6ubuntu1) 8.3.0
  77 ubuntu:19.04-x-hppa           : Ok   hppa-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  78 ubuntu:19.10                  : Ok   gcc (Ubuntu 9.2.1-8ubuntu1) 9.2.1 20190909, clang version 9.0.0-+rc5-1~exp1 (tags/RELEASE_900/rc5)
  # 

  # uname -a
  Linux quaco 5.2.17-200.fc30.x86_64 #1 SMP Mon Sep 23 13:42:32 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  cebf7d51a6c3 perf diff: Report noisy for cycles diff
  # perf version --build-options
  perf version 5.4.rc2.g32fdc2ca7e2a
                   dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
      dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                   glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
                    gtk2: [ on  ]  # HAVE_GTK2_SUPPORT
           syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                  libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
                  libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
                 libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
  numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
                 libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
               libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
                libslang: [ on  ]  # HAVE_SLANG_SUPPORT
               libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
               libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
      libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                    zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                    lzma: [ on  ]  # HAVE_LZMA_SUPPORT
               get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                     bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                     aio: [ on  ]  # HAVE_AIO_SUPPORT
                    zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
  # perf test
   1: vmlinux symtab matches kallsyms                       : Ok
   2: Detect openat syscall event                           : Ok
   3: Detect openat syscall event on all cpus               : Ok
   4: Read samples using the mmap interface                 : Ok
   5: Test data source output                               : Ok
   6: Parse event definition strings                        : Ok
   7: Simple expression parser                              : Ok
   8: PERF_RECORD_* events & perf_sample fields             : Ok
   9: Parse perf pmu format                                 : Ok
  10: DSO data read                                         : Ok
  11: DSO data cache                                        : Ok
  12: DSO data reopen                                       : Ok
  13: Roundtrip evsel->name                                 : Ok
  14: Parse sched tracepoints fields                        : Ok
  15: syscalls:sys_enter_openat event fields                : Ok
  16: Setup struct perf_event_attr                          : Ok
  17: Match and link multiple hists                         : Ok
  18: 'import perf' in python                               : Ok
  19: Breakpoint overflow signal handler                    : Ok
  20: Breakpoint overflow sampling                          : Ok
  21: Breakpoint accounting                                 : Ok
  22: Watchpoint                                            :
  22.1: Read Only Watchpoint                                : Skip
  22.2: Write Only Watchpoint                               : Ok
  22.3: Read / Write Watchpoint                             : Ok
  22.4: Modify Watchpoint                                   : Ok
  23: Number of exit events of a simple workload            : Ok
  24: Software clock events period values                   : Ok
  25: Object code reading                                   : Ok
  26: Sample parsing                                        : Ok
  27: Use a dummy software event to keep tracking           : Ok
  28: Parse with no sample_id_all bit set                   : Ok
  29: Filter hist entries                                   : Ok
  30: Lookup mmap thread                                    : Ok
  31: Share thread mg                                       : Ok
  32: Sort output of hist entries                           : Ok
  33: Cumulate child hist entries                           : Ok
  34: Track with sched_switch                               : Ok
  35: Filter fds with revents mask in a fdarray             : Ok
  36: Add fd to a fdarray, making it autogrow               : Ok
  37: kmod_path__parse                                      : Ok
  38: Thread map                                            : Ok
  39: LLVM search and compile                               :
  39.1: Basic BPF llvm compile                              : Ok
  39.2: kbuild searching                                    : Ok
  39.3: Compile source for BPF prologue generation          : Ok
  39.4: Compile source for BPF relocation                   : Ok
  40: Session topology                                      : Ok
  41: BPF filter                                            :
  41.1: Basic BPF filtering                                 : Ok
  41.2: BPF pinning                                         : Ok
  41.3: BPF prologue generation                             : Ok
  41.4: BPF relocation checker                              : Ok
  42: Synthesize thread map                                 : Ok
  43: Remove thread map                                     : Ok
  44: Synthesize cpu map                                    : Ok
  45: Synthesize stat config                                : Ok
  46: Synthesize stat                                       : Ok
  47: Synthesize stat round                                 : Ok
  48: Synthesize attr update                                : Ok
  49: Event times                                           : Ok
  50: Read backward ring buffer                             : Ok
  51: Print cpu map                                         : Ok
  52: Probe SDT events                                      : Ok
  53: is_printable_array                                    : Ok
  54: Print bitmap                                          : Ok
  55: perf hooks                                            : Ok
  56: builtin clang support                                 : Skip (not compiled in)
  57: unit_number__scnprintf                                : Ok
  58: mem2node                                              : Ok
  59: time utils                                            : Ok
  60: map_groups__merge_in                                  : Ok
  61: x86 rdpmc                                             : Ok
  62: Convert perf time to TSC                              : Ok
  63: DWARF unwind                                          : Ok
  64: x86 instruction decoder - new instructions            : Ok
  65: Intel PT packet decoder                               : Ok
  66: x86 bp modify                                         : Ok
  67: probe libc's inet_pton & backtrace it with ping       : Ok
  68: Use vfs_getname probe to get syscall args filenames   : Ok
  69: Add vfs_getname probe to get syscall args filenames   : Ok
  70: Check open filename arg using perf trace + vfs_getname: Ok
  71: Zstd perf.data compression/decompression              : Ok
  #

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                  make_debug_O: make DEBUG=1
           make_no_libpython_O: make NO_LIBPYTHON=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
                make_no_newt_O: make NO_NEWT=1
                   make_help_O: make help
              make_no_libbpf_O: make NO_LIBBPF=1
            make_no_demangle_O: make NO_DEMANGLE=1
                 make_perf_o_O: make perf.o
                   make_pure_O: make
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
              make_no_libelf_O: make NO_LIBELF=1
             make_no_libnuma_O: make NO_LIBNUMA=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
             make_util_map_o_O: make util/map.o
            make_no_auxtrace_O: make NO_AUXTRACE=1
                 make_cscope_O: make cscope
                    make_doc_O: make doc
            make_install_bin_O: make install-bin
             make_no_libperl_O: make NO_LIBPERL=1
                 make_static_O: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1
                make_install_O: make install
                   make_tags_O: make tags
               make_no_slang_O: make NO_SLANG=1
           make_no_backtrace_O: make NO_BACKTRACE=1
                make_no_gtk2_O: make NO_GTK2=1
              make_clean_all_O: make clean all
        make_with_babeltrace_O: make LIBBABELTRACE=1
         make_install_prefix_O: make install prefix=/tmp/krava
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
