Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D0DC282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 10:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D16A2133D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 10:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfEYKjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 06:39:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:35345 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726484AbfEYKjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 06:39:07 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 May 2019 03:39:02 -0700
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 25 May 2019 03:38:59 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hUU4o-0007RU-LE; Sat, 25 May 2019 18:38:58 +0800
Date:   Sat, 25 May 2019 18:38:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qian Cai <cai@lca.pw>
Cc:     LKP <lkp@01.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, philip.li@intel.com
Subject: 8d2bd61bd8 ("sched/core: Clean up sched_init() a bit"):  BUG:
 unable to handle page fault for address: 00ba0396
Message-ID: <5ce91b39.Txl3DDmbeNsPYyrE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_5ce91b39.uW0cMqn9vfRPpK06muQiAvNX+6hIRsMtzvEBdoLoDwOpVoKY"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_5ce91b39.uW0cMqn9vfRPpK06muQiAvNX+6hIRsMtzvEBdoLoDwOpVoKY
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core

commit 8d2bd61bd89260d5da5eaef7cf264587f19a7e0d
Author:     Qian Cai <cai@lca.pw>
AuthorDate: Wed May 22 14:20:06 2019 -0400
Commit:     Ingo Molnar <mingo@kernel.org>
CommitDate: Fri May 24 08:57:29 2019 +0200

    sched/core: Clean up sched_init() a bit
    
    Compiling a kernel with both FAIR_GROUP_SCHED=n and RT_GROUP_SCHED=n
    will generate a warning using W=1:
    
      kernel/sched/core.c: In function 'sched_init':
      kernel/sched/core.c:5906:32: warning: variable 'ptr' set but not used
    
    Use this opportunity to tidy up a code a bit by removing unnecssary
    indentations and lines.
    
    Signed-off-by: Qian Cai <cai@lca.pw>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Link: http://lkml.kernel.org/r/1558549206-13031-1-git-send-email-cai@lca.pw
    [ Also remove some of the unnecessary #endif comments. ]
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

54dee40637  Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
8d2bd61bd8  sched/core: Clean up sched_init() a bit
7668c966e0  Merge branch 'linus'
+-------------------------------------------------------+------------+------------+------------+
|                                                       | 54dee40637 | 8d2bd61bd8 | 7668c966e0 |
+-------------------------------------------------------+------------+------------+------------+
| boot_successes                                        | 49         | 0          | 0          |
| boot_failures                                         | 0          | 16         | 13         |
| BUG:kernel_hang_in_boot_stage                         | 0          | 3          |            |
| BUG:unable_to_handle_page_fault_for_address           | 0          | 2          | 1          |
| Oops:#[##]                                            | 0          | 13         | 13         |
| EIP:rq_online_rt                                      | 0          | 2          | 1          |
| Kernel_panic-not_syncing:Fatal_exception              | 0          | 4          | 6          |
| BUG:kernel_NULL_pointer_dereference,address           | 0          | 11         | 12         |
| EIP:sched_rt_period_timer                             | 0          | 9          | 7          |
| Kernel_panic-not_syncing:Fatal_exception_in_interrupt | 0          | 9          | 7          |
| EIP:enqueue_rt_entity                                 | 0          | 2          | 5          |
+-------------------------------------------------------+------------+------------+------------+

If you fix the issue, kindly add following tag
Reported-by: kernel test robot <lkp@intel.com>

[    0.029282] Initializing CPU#1
[    0.032615] kvm-clock: cpu 1, msr 20e6041, secondary cpu clock
[    0.032615] masked ExtINT on CPU#1
[    0.193558] KVM setup async PF for cpu 1
[    0.193558] kvm-stealtime: cpu 1, msr 1e54d8c0
[    0.193558] BUG: unable to handle page fault for address: 00ba0396
[    0.193558] #PF: supervisor read access in kernel mode
[    0.193558] #PF: error_code(0x0000) - not-present page
[    0.193558] *pde = 00000000 
[    0.193558] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC
[    0.193558] CPU: 1 PID: 14 Comm: cpuhp/1 Tainted: G                T 5.2.0-rc1-00166-g8d2bd61 #177
[    0.193558] EIP: rq_online_rt+0x6d/0xf5
[    0.193558] Code: 93 d0 06 00 00 05 c4 00 00 00 e8 4f 5b 00 00 83 c4 0c 5b 5e 5f 5d c3 8b 93 d0 06 00 00 8b 80 c8 00 00 00 8b 34 90 85 f6 74 c9 <8b> 8e 94 03 00 00 8d 81 cc 00 00 00 89 4d e8 89 45 f0 e8 97 0f 9a
[    0.193558] EAX: 40093140 EBX: 5e555600 ECX: 14c073f2 EDX: 00000001
[    0.193558] ESI: 00ba0002 EDI: 420e9200 EBP: 4005fef8 ESP: 4005fee0
[    0.193558] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010002
[    0.193558] CR0: 80050033 CR2: 00ba0396 CR3: 020d8000 CR4: 00000690
[    0.193558] Call Trace:
[    0.193558]  ? cpudl_set_freecpu+0x13/0x17
[    0.193558]  ? set_rq_online+0x42/0x4a
[    0.193558]  ? sched_cpu_activate+0xc5/0xdd
[    0.193558]  ? cpuhp_invoke_callback+0x8c/0x13a
[    0.193558]  ? cpuhp_thread_fun+0xcf/0x11e
[    0.193558]  ? smpboot_thread_fn+0x17b/0x18f
[    0.193558]  ? kthread+0xd3/0xd5
[    0.193558]  ? smpboot_destroy_threads+0x65/0x65
[    0.193558]  ? __list_del_entry+0x1e/0x1e
[    0.193558]  ? ret_from_fork+0x1e/0x28
[    0.193558] CR2: 0000000000ba0396
[    0.193558] random: get_random_bytes called from init_oops_id+0x23/0x3a with crng_init=0
[    0.193558] ---[ end trace ceabaa41d6971a28 ]---
[    0.193558] EIP: rq_online_rt+0x6d/0xf5

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start 7668c966e0f348d25e72f1328dd26341922db815 4dde821e4296e156d133b98ddc4c45861935a4fb --
git bisect good 01360de1d7b5b45251ec97307190c87a5588a5fc  # 17:38  G     11     0    0   0  Merge branch 'x86/asm'
git bisect  bad 25e083f9d3e0223945de0fa9682f94b404a0d704  # 17:42  B      0    11   27   2  Merge branch 'perf/urgent'
git bisect good 11f0e441c61714ecdec83290323cc7922883e06b  # 17:47  G     10     0    2   2  Merge branch 'x86/apic'
git bisect  bad 4a1021adac53483be80dcfea2032ce031b225783  # 18:01  B      0    10   24   0  Merge branch 'sched/core'
git bisect  bad 8d2bd61bd89260d5da5eaef7cf264587f19a7e0d  # 18:06  B      0    10   26   2  sched/core: Clean up sched_init() a bit
# first bad commit: [8d2bd61bd89260d5da5eaef7cf264587f19a7e0d] sched/core: Clean up sched_init() a bit
git bisect good 54dee406374ce8adb352c48e175176247cb8db7c  # 18:13  G     31     0    2   2  Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
# extra tests with debug options
git bisect  bad 8d2bd61bd89260d5da5eaef7cf264587f19a7e0d  # 18:17  B      0    11   25   0  sched/core: Clean up sched_init() a bit
# extra tests on HEAD of tip/master
git bisect  bad 7668c966e0f348d25e72f1328dd26341922db815  # 18:17  B      0    13   30   0  Merge branch 'linus'
# extra tests on tree/branch tip/sched/core
git bisect  bad 8d2bd61bd89260d5da5eaef7cf264587f19a7e0d  # 18:22  B      0    13   30   3  sched/core: Clean up sched_init() a bit
# extra tests with first bad commit reverted
git bisect good 8dad6492e10fe44e39e1296fe727fe9a0bb41135  # 18:37  G     10     0    0   0  Revert "sched/core: Clean up sched_init() a bit"
# extra tests on tree/branch tip/master
git bisect  bad 7668c966e0f348d25e72f1328dd26341922db815  # 18:38  B      0    13   30   0  Merge branch 'linus'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--=_5ce91b39.uW0cMqn9vfRPpK06muQiAvNX+6hIRsMtzvEBdoLoDwOpVoKY
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-quantal-vm-quantal-615:20190525180546:i386-randconfig-m0-201920:5.2.0-rc1-00166-g8d2bd61:177.gz"

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
YFywVTpIAAA=

--=_5ce91b39.uW0cMqn9vfRPpK06muQiAvNX+6hIRsMtzvEBdoLoDwOpVoKY
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-yocto-vm-yocto-749:20190525181023:i386-randconfig-m0-201920:5.2.0-rc1-00165-g54dee40:178.gz"

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

--=_5ce91b39.uW0cMqn9vfRPpK06muQiAvNX+6hIRsMtzvEBdoLoDwOpVoKY
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="reproduce-quantal-vm-quantal-615:20190525180546:i386-randconfig-m0-201920:5.2.0-rc1-00166-g8d2bd61:177"

#!/bin/bash

kernel=$1

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu kvm64
	-kernel $kernel
	-m 512
	-smp 2
	-device e1000,netdev=net0
	-netdev user,id=net0
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	root=/dev/ram0
	hung_task_panic=1
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	console=tty0
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	vga=normal
	rw
	drbd.minor_count=8
	rcuperf.shutdown=0
)

"${kvm[@]}" -append "${append[*]}"

--=_5ce91b39.uW0cMqn9vfRPpK06muQiAvNX+6hIRsMtzvEBdoLoDwOpVoKY
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="config-5.2.0-rc1-00166-g8d2bd61"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 5.2.0-rc1 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70300
CONFIG_CLANG_VERSION=0
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
CONFIG_CC_DISABLE_WARN_MAYBE_UNINITIALIZED=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
CONFIG_KERNEL_LZO=y
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
CONFIG_PSI=y
CONFIG_PSI_DEFAULT_DISABLED=y
# end of CPU/Task time and stats accounting

# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS_PROC is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
# CONFIG_CGROUP_PIDS is not set
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
# CONFIG_CGROUP_HUGETLB is not set
# CONFIG_CPUSETS is not set
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
CONFIG_CGROUP_DEBUG=y
# CONFIG_NAMESPACES is not set
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
# CONFIG_PCSPKR_PLATFORM is not set
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
# CONFIG_IO_URING is not set
# CONFIG_ADVISE_SYSCALLS is not set
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# end of Kernel Performance Events And Counters

# CONFIG_VM_EVENT_COUNTERS is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
# CONFIG_SLUB is not set
CONFIG_SLOB=y
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_PROFILING=y
# end of General setup

CONFIG_X86_32=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/i386_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_X86_32_SMP=y
CONFIG_X86_32_LAZY_GS=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_ZONE_DMA is not set
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_MPPARSE is not set
CONFIG_GOLDFISH=y
# CONFIG_RETPOLINE is not set
# CONFIG_X86_CPU_RESCTRL is not set
# CONFIG_X86_BIGSMP is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
# CONFIG_X86_INTEL_QUARK is not set
# CONFIG_X86_INTEL_LPSS is not set
CONFIG_X86_AMD_PLATFORM_DEVICE=y
# CONFIG_IOSF_MBI is not set
CONFIG_X86_RDC321X=y
# CONFIG_X86_32_NON_STANDARD is not set
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
CONFIG_KVM_GUEST=y
# CONFIG_PVH is not set
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_CYRIX_32=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
# CONFIG_CPU_SUP_UMC_32 is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_DMI is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=8
CONFIG_NR_CPUS_DEFAULT=8
CONFIG_NR_CPUS=8
CONFIG_SCHED_SMT=y
# CONFIG_SCHED_MC is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=y
# end of Performance monitoring

CONFIG_X86_LEGACY_VM86=y
CONFIG_VM86=y
CONFIG_TOSHIBA=y
CONFIG_I8K=y
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
# CONFIG_MICROCODE_OLD_INTERFACE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
# CONFIG_VMSPLIT_3G is not set
# CONFIG_VMSPLIT_3G_OPT is not set
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
CONFIG_VMSPLIT_1G=y
CONFIG_PAGE_OFFSET=0x40000000
CONFIG_HIGHMEM=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_HIGHPTE is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
# CONFIG_X86_PAT is not set
# CONFIG_ARCH_RANDOM is not set
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
CONFIG_EFI=y
# CONFIG_EFI_STUB is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
CONFIG_SCHED_HRTICK=y
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
CONFIG_DEBUG_HOTPLUG_CPU0=y
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
# end of Processor type and features

CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_DEBUGGER=y
CONFIG_ACPI_DEBUGGER_USER=y
# CONFIG_ACPI_SPCR_TABLE is not set
# CONFIG_ACPI_PROCFS_POWER is not set
# CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
CONFIG_ACPI_EC_DEBUGFS=y
CONFIG_ACPI_AC=y
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_PROCESSOR_CSTATE=y
# CONFIG_ACPI_PROCESSOR is not set
CONFIG_ACPI_IPMI=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_TABLE_UPGRADE is not set
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_BGRT is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_EINJ=y
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_DPTF_POWER is not set
CONFIG_ACPI_WATCHDOG=y
# CONFIG_PMIC_OPREGION is not set
CONFIG_ACPI_CONFIGFS=y
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# end of CPU Frequency scaling

#
# CPU Idle
#
# CONFIG_CPU_IDLE is not set
# end of CPU Idle
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_SCx200 is not set
# CONFIG_OLPC is not set
# CONFIG_ALIX is not set
CONFIG_NET5501=y
CONFIG_AMD_NB=y
CONFIG_X86_SYSFB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
# end of Binary Emulations

CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_HAVE_GENERIC_GUP=y

#
# Firmware Drivers
#
CONFIG_EDD=y
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=y
CONFIG_FW_CFG_SYSFS_CMDLINE=y
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
# CONFIG_EFI_VARS_PSTORE is not set
CONFIG_EFI_FAKE_MEMMAP=y
CONFIG_EFI_MAX_FAKE_MEM=8
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_BOOTLOADER_CONTROL=y
CONFIG_EFI_CAPSULE_LOADER=y
CONFIG_EFI_CAPSULE_QUIRK_QUARK_CSH=y
CONFIG_EFI_TEST=y
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_KVM is not set
# CONFIG_VHOST_NET is not set
CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y

#
# General architecture-dependent options
#
CONFIG_HOTPLUG_SMT=y
CONFIG_OPROFILE=y
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_JUMP_LABEL is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_64BIT_TIME=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
CONFIG_REFCOUNT_FULL=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y

#
# GCC plugins
#
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
CONFIG_GCC_PLUGIN_RANDSTRUCT=y
# CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE is not set
# end of GCC plugins
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
# CONFIG_MODULES is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
# CONFIG_BLK_DEV_INTEGRITY is not set
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_CMDLINE_PARSER=y
# CONFIG_BLK_WBT is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
# CONFIG_ACORN_PARTITION_CUMANA is not set
# CONFIG_ACORN_PARTITION_EESOX is not set
CONFIG_ACORN_PARTITION_ICS=y
# CONFIG_ACORN_PARTITION_ADFS is not set
# CONFIG_ACORN_PARTITION_POWERTEC is not set
# CONFIG_ACORN_PARTITION_RISCIX is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
# CONFIG_AMIGA_PARTITION is not set
CONFIG_ATARI_PARTITION=y
CONFIG_MAC_PARTITION=y
# CONFIG_MSDOS_PARTITION is not set
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
# CONFIG_EFI_PARTITION is not set
CONFIG_SYSV68_PARTITION=y
CONFIG_CMDLINE_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_COREDUMP is not set
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_MEMORY_ISOLATION=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
# CONFIG_BOUNCE is not set
CONFIG_VIRT_TO_BUS=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
# CONFIG_CLEANCACHE is not set
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
CONFIG_CMA_DEBUGFS=y
CONFIG_CMA_AREAS=7
# CONFIG_ZPOOL is not set
CONFIG_ZBUD=y
# CONFIG_ZSMALLOC is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_IDLE_PAGE_TRACKING is not set
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
# CONFIG_FAILOVER is not set
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_HOST is not set
# end of Cadence PCIe controllers support

# CONFIG_PCI_FTPCI100 is not set
# CONFIG_PCI_HOST_GENERIC is not set
# CONFIG_PCIE_XILINX is not set

#
# DesignWare PCI Core Support
#
# end of DesignWare PCI Core Support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

CONFIG_PCCARD=y
CONFIG_PCMCIA=y
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
# CONFIG_I82365 is not set
CONFIG_TCIC=y
CONFIG_PCMCIA_PROBE=y
CONFIG_PCCARD_NONSTATIC=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_SIMPLE_PM_BUS=y
# end of Bus devices

# CONFIG_CONNECTOR is not set
CONFIG_GNSS=y
CONFIG_GNSS_SERIAL=y
CONFIG_GNSS_MTK_SERIAL=y
# CONFIG_GNSS_SIRF_SERIAL is not set
CONFIG_GNSS_UBX_SERIAL=y
CONFIG_MTD=y
CONFIG_MTD_CMDLINE_PARTS=y
CONFIG_MTD_OF_PARTS=y
CONFIG_MTD_AR7_PARTS=y

#
# Partition parsers
#
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
# CONFIG_MTD_BLOCK is not set
# CONFIG_MTD_BLOCK_RO is not set
CONFIG_FTL=y
# CONFIG_NFTL is not set
CONFIG_INFTL=y
CONFIG_RFD_FTL=y
# CONFIG_SSFDC is not set
CONFIG_SM_FTL=y
CONFIG_MTD_OOPS=y
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
CONFIG_MTD_ROM=y
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
CONFIG_MTD_PHYSMAP=y
# CONFIG_MTD_PHYSMAP_COMPAT is not set
# CONFIG_MTD_PHYSMAP_OF is not set
CONFIG_MTD_AMD76XROM=y
CONFIG_MTD_ICHXROM=y
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
# CONFIG_MTD_L440GX is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=y
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_SLRAM=y
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
CONFIG_MTD_BLOCK2MTD=y

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# end of Self-contained MTD device drivers

CONFIG_MTD_NAND_CORE=y
CONFIG_MTD_ONENAND=y
# CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
CONFIG_MTD_ONENAND_GENERIC=y
CONFIG_MTD_ONENAND_OTP=y
# CONFIG_MTD_ONENAND_2X_PROGRAM is not set
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC is not set
CONFIG_MTD_RAW_NAND=y
CONFIG_MTD_NAND_ECC_SW_BCH=y

#
# Raw/parallel NAND flash controllers
#
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_DENALI_DT is not set
# CONFIG_MTD_NAND_CAFE is not set
CONFIG_MTD_NAND_CS553X=y
# CONFIG_MTD_NAND_GPIO is not set
# CONFIG_MTD_NAND_PLATFORM is not set

#
# Misc
#
CONFIG_MTD_NAND_NANDSIM=y
# CONFIG_MTD_NAND_RICOH is not set
# CONFIG_MTD_NAND_DISKONCHIP is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_SPI_NOR=y
# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
# CONFIG_SPI_MTK_QUADSPI is not set
# CONFIG_SPI_INTEL_SPI_PCI is not set
# CONFIG_SPI_INTEL_SPI_PLATFORM is not set
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
CONFIG_MTD_UBI_GLUEBI=y
# CONFIG_MTD_UBI_BLOCK is not set
CONFIG_DTC=y
CONFIG_OF=y
CONFIG_OF_UNITTEST=y
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_RESERVED_MEM=y
CONFIG_OF_RESOLVE=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
# CONFIG_PNPBIOS_PROC_FS is not set
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_MULTIPATH is not set
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
CONFIG_NVME_TARGET=y
CONFIG_NVME_TARGET_LOOP=y
CONFIG_NVME_TARGET_FC=y
# CONFIG_NVME_TARGET_FCLOOP is not set
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
# CONFIG_AD525X_DPOT_I2C is not set
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=y
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
CONFIG_DS1682=y
# CONFIG_PCH_PHUB is not set
CONFIG_USB_SWITCH_FSA9480=y
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_MISC_RTSX=y
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
CONFIG_EEPROM_LEGACY=y
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
# CONFIG_EEPROM_IDT_89HPESX is not set
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=y
CONFIG_ALTERA_STAPL=y
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#

#
# SCIF Bus Driver
#

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# end of Intel MIC & related support

CONFIG_ECHO=y
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=y
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
CONFIG_IDE=y

#
# Please see Documentation/ide/ide.txt for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=y
CONFIG_IDE_TIMINGS=y
CONFIG_IDE_ATAPI=y
CONFIG_IDE_LEGACY=y
CONFIG_BLK_DEV_IDE_SATA=y
# CONFIG_IDE_GD is not set
# CONFIG_BLK_DEV_IDECS is not set
# CONFIG_BLK_DEV_DELKIN is not set
# CONFIG_BLK_DEV_IDECD is not set
CONFIG_BLK_DEV_IDETAPE=y
# CONFIG_BLK_DEV_IDEACPI is not set
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_PROC_FS=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_PLATFORM is not set
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_CMD640_ENHANCED=y
# CONFIG_BLK_DEV_IDEPNP is not set

#
# PCI IDE chipsets support
#
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_CS5535 is not set
# CONFIG_BLK_DEV_CS5536 is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT8172 is not set
# CONFIG_BLK_DEV_IT8213 is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_BLK_DEV_TC86C001 is not set

#
# Other IDE chipsets support
#

#
# Note: most of these also require special kernel boot parameters
#
# CONFIG_BLK_DEV_4DRIVES is not set
# CONFIG_BLK_DEV_ALI14XX is not set
CONFIG_BLK_DEV_DTC2278=y
# CONFIG_BLK_DEV_HT6560B is not set
# CONFIG_BLK_DEV_QD65XX is not set
CONFIG_BLK_DEV_UMC8672=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
CONFIG_CHR_DEV_OSST=y
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set
# CONFIG_SCSI_ENCLOSURE is not set
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
CONFIG_SCSI_SRP_ATTRS=y
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
CONFIG_ISCSI_BOOT_SYSFS=y
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
CONFIG_SCSI_AHA1542=y
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
CONFIG_SCSI_ADVANSYS=y
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_MPT3SAS is not set
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_ISCI is not set
CONFIG_SCSI_GENERIC_NCR5380=y
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
CONFIG_SCSI_QLOGIC_FAS=y
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=y
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
CONFIG_SCSI_VIRTIO=y
CONFIG_SCSI_LOWLEVEL_PCMCIA=y
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
# CONFIG_SCSI_DH_HP_SW is not set
CONFIG_SCSI_DH_EMC=y
# CONFIG_SCSI_DH_ALUA is not set
# end of SCSI device support

# CONFIG_ATA is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_AUTODETECT is not set
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID10=y
CONFIG_MD_RAID456=y
CONFIG_MD_MULTIPATH=y
CONFIG_MD_FAULTY=y
# CONFIG_BCACHE is not set
# CONFIG_BLK_DEV_DM is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_LANCE is not set
# CONFIG_PCNET32 is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_NI65 is not set
# CONFIG_AMD_XGBE is not set
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CIRRUS=y
# CONFIG_CS89x0 is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2000 is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
# CONFIG_ULTRA is not set
# CONFIG_WD80x3 is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_PCH_GBE is not set
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_QLGE is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_UART is not set
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_SMC9194 is not set
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_LL_TEMAC is not set
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_PHYLIB is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_IPHETH is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_PCMCIA_RAYCS is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=y
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
# CONFIG_MOUSE_PS2_SYNAPTICS is not set
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
# CONFIG_MOUSE_PS2_CYPRESS is not set
CONFIG_MOUSE_PS2_TRACKPOINT=y
# CONFIG_MOUSE_PS2_ELANTECH is not set
# CONFIG_MOUSE_PS2_SENTELIC is not set
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
# CONFIG_MOUSE_PS2_VMMOUSE is not set
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=y
CONFIG_MOUSE_APPLETOUCH=y
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=y
CONFIG_MOUSE_ELAN_I2C=y
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
# CONFIG_MOUSE_INPORT is not set
CONFIG_MOUSE_LOGIBM=y
# CONFIG_MOUSE_PC110PAD is not set
CONFIG_MOUSE_VSXXXAA=y
CONFIG_MOUSE_GPIO=y
CONFIG_MOUSE_SYNAPTICS_I2C=y
CONFIG_MOUSE_SYNAPTICS_USB=y
CONFIG_INPUT_JOYSTICK=y
# CONFIG_JOYSTICK_ANALOG is not set
CONFIG_JOYSTICK_A3D=y
CONFIG_JOYSTICK_ADI=y
CONFIG_JOYSTICK_COBRA=y
CONFIG_JOYSTICK_GF2K=y
CONFIG_JOYSTICK_GRIP=y
# CONFIG_JOYSTICK_GRIP_MP is not set
# CONFIG_JOYSTICK_GUILLEMOT is not set
# CONFIG_JOYSTICK_INTERACT is not set
# CONFIG_JOYSTICK_SIDEWINDER is not set
# CONFIG_JOYSTICK_TMDC is not set
CONFIG_JOYSTICK_IFORCE=y
# CONFIG_JOYSTICK_IFORCE_USB is not set
# CONFIG_JOYSTICK_IFORCE_232 is not set
CONFIG_JOYSTICK_WARRIOR=y
# CONFIG_JOYSTICK_MAGELLAN is not set
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
# CONFIG_JOYSTICK_STINGER is not set
CONFIG_JOYSTICK_TWIDJOY=y
CONFIG_JOYSTICK_ZHENHUA=y
CONFIG_JOYSTICK_AS5011=y
# CONFIG_JOYSTICK_JOYDUMP is not set
CONFIG_JOYSTICK_XPAD=y
CONFIG_JOYSTICK_XPAD_FF=y
# CONFIG_JOYSTICK_XPAD_LEDS is not set
CONFIG_JOYSTICK_PXRC=y
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=y
CONFIG_TABLET_USB_AIPTEK=y
CONFIG_TABLET_USB_GTCO=y
CONFIG_TABLET_USB_HANWANG=y
CONFIG_TABLET_USB_KBTAB=y
# CONFIG_TABLET_USB_PEGASUS is not set
CONFIG_TABLET_SERIAL_WACOM4=y
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM860X_ONKEY=y
CONFIG_INPUT_88PM80X_ONKEY=y
CONFIG_INPUT_AD714X=y
CONFIG_INPUT_AD714X_I2C=y
CONFIG_INPUT_ATMEL_CAPTOUCH=y
CONFIG_INPUT_BMA150=y
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_MSM_VIBRATOR=y
CONFIG_INPUT_MAX77650_ONKEY=y
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=y
CONFIG_INPUT_GP2A=y
# CONFIG_INPUT_GPIO_BEEPER is not set
CONFIG_INPUT_GPIO_DECODER=y
CONFIG_INPUT_GPIO_VIBRA=y
CONFIG_INPUT_WISTRON_BTNS=y
CONFIG_INPUT_ATLAS_BTNS=y
CONFIG_INPUT_ATI_REMOTE2=y
CONFIG_INPUT_KEYSPAN_REMOTE=y
CONFIG_INPUT_KXTJ9=y
# CONFIG_INPUT_KXTJ9_POLLED_MODE is not set
# CONFIG_INPUT_POWERMATE is not set
CONFIG_INPUT_YEALINK=y
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_REGULATOR_HAPTIC=y
CONFIG_INPUT_TPS65218_PWRBUTTON=y
CONFIG_INPUT_AXP20X_PEK=y
CONFIG_INPUT_UINPUT=y
CONFIG_INPUT_PCF8574=y
CONFIG_INPUT_RK805_PWRKEY=y
CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
CONFIG_INPUT_DA9052_ONKEY=y
CONFIG_INPUT_DA9055_ONKEY=y
CONFIG_INPUT_DA9063_ONKEY=y
CONFIG_INPUT_ADXL34X=y
CONFIG_INPUT_ADXL34X_I2C=y
CONFIG_INPUT_IMS_PCU=y
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
CONFIG_INPUT_DRV260X_HAPTICS=y
CONFIG_INPUT_DRV2665_HAPTICS=y
CONFIG_INPUT_DRV2667_HAPTICS=y
# CONFIG_INPUT_RAVE_SP_PWRBUTTON is not set
# CONFIG_INPUT_STPMIC1_ONKEY is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_APBPS2=y
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=y
CONFIG_GAMEPORT_L4=y
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
CONFIG_MOXA_INTELLIO=y
CONFIG_MOXA_SMARTIO=y
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_SYNCLINK_GT is not set
# CONFIG_NOZOMI is not set
# CONFIG_ISI is not set
CONFIG_N_HDLC=y
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
CONFIG_NULL_TTY=y
# CONFIG_GOLDFISH_TTY is not set
# CONFIG_LDISC_AUTOLOAD is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
# CONFIG_SERIAL_8250_DMA is not set
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
CONFIG_SERIAL_8250_ASPEED_VUART=y
CONFIG_SERIAL_8250_DW=y
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set
CONFIG_SERIAL_OF_PLATFORM=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_UARTLITE=y
CONFIG_SERIAL_UARTLITE_CONSOLE=y
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_SIFIVE=y
# CONFIG_SERIAL_SIFIVE_CONSOLE is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
CONFIG_SERIAL_TIMBERDALE=y
CONFIG_SERIAL_ALTERA_JTAGUART=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE is not set
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
CONFIG_SERIAL_ALTERA_UART_CONSOLE=y
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=y
# CONFIG_SERIAL_FSL_LPUART_CONSOLE is not set
CONFIG_SERIAL_CONEXANT_DIGICOLOR=y
# CONFIG_SERIAL_CONEXANT_DIGICOLOR_CONSOLE is not set
CONFIG_SERIAL_MEN_Z135=y
# end of Serial drivers

CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
# CONFIG_TTY_PRINTK is not set
CONFIG_HVC_DRIVER=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
CONFIG_IPMI_WATCHDOG=y
# CONFIG_IPMI_POWEROFF is not set
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=y
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_GEODE=y
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=y
# CONFIG_DTLK is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# PCMCIA character devices
#
# CONFIG_SYNCLINK_CS is not set
CONFIG_CARDMAN_4000=y
CONFIG_CARDMAN_4040=y
# CONFIG_SCR24X is not set
# CONFIG_IPWIRELESS is not set
# end of PCMCIA character devices

# CONFIG_MWAVE is not set
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=256
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set
CONFIG_TCG_TPM=y
# CONFIG_HW_RANDOM_TPM is not set
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_I2C_ATMEL=y
# CONFIG_TCG_TIS_I2C_INFINEON is not set
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
CONFIG_TCG_NSC=y
# CONFIG_TCG_ATMEL is not set
CONFIG_TCG_INFINEON=y
CONFIG_TCG_CRB=y
CONFIG_TCG_VTPM_PROXY=y
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=y
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_OF=y
# end of Character devices

CONFIG_RANDOM_TRUST_CPU=y

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
CONFIG_I2C_MUX_GPIO=y
CONFIG_I2C_MUX_GPMUX=y
CONFIG_I2C_MUX_LTC4306=y
CONFIG_I2C_MUX_PCA9541=y
CONFIG_I2C_MUX_PCA954x=y
CONFIG_I2C_MUX_PINCTRL=y
CONFIG_I2C_MUX_REG=y
CONFIG_I2C_DEMUX_PINCTRL=y
CONFIG_I2C_MUX_MLXCPLD=y
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=y
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_PXA is not set
CONFIG_I2C_RK3X=y
CONFIG_I2C_SIMTEC=y
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
CONFIG_I2C_TAOS_EVM=y
# CONFIG_I2C_TINY_USB is not set
CONFIG_I2C_VIPERBOARD=y

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_PCA_ISA=y
CONFIG_I2C_CROS_EC_TUNNEL=y
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_FSI=y
# end of I2C Hardware Bus support

CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
CONFIG_CDNS_I3C_MASTER=y
# CONFIG_DW_I3C_MASTER is not set
# CONFIG_SPI is not set
CONFIG_SPMI=y
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=y
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
CONFIG_NTP_PPS=y

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
CONFIG_PPS_CLIENT_LDISC=y
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# CONFIG_PTP_1588_CLOCK_PCH is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AS3722 is not set
CONFIG_PINCTRL_AXP209=y
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_MCP23S08=y
CONFIG_PINCTRL_SINGLE=y
CONFIG_PINCTRL_SX150X=y
CONFIG_PINCTRL_STMFX=y
# CONFIG_PINCTRL_RK805 is not set
# CONFIG_PINCTRL_OCELOT is not set
# CONFIG_PINCTRL_BAYTRAIL is not set
CONFIG_PINCTRL_CHERRYVIEW=y
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
CONFIG_PINCTRL_CEDARFORK=y
CONFIG_PINCTRL_DENVERTON=y
CONFIG_PINCTRL_GEMINILAKE=y
CONFIG_PINCTRL_ICELAKE=y
CONFIG_PINCTRL_LEWISBURG=y
CONFIG_PINCTRL_SUNRISEPOINT=y
CONFIG_PINCTRL_LOCHNAGAR=y
CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L90=y
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
# CONFIG_GPIO_SYSFS is not set
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
CONFIG_GPIO_ALTERA=y
CONFIG_GPIO_AMDPT=y
CONFIG_GPIO_CADENCE=y
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_FTGPIO010 is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_GRGPIO=y
CONFIG_GPIO_HLWD=y
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=y
# CONFIG_GPIO_SAMA5D2_PIOBU is not set
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_XILINX=y
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_104_DIO_48E is not set
CONFIG_GPIO_104_IDIO_16=y
CONFIG_GPIO_104_IDI_48=y
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_GPIO_MM=y
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=y
# CONFIG_GPIO_ADP5588_IRQ is not set
CONFIG_GPIO_ADNP=y
# CONFIG_GPIO_GW_PLD is not set
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_BD9571MWV=y
# CONFIG_GPIO_DA9052 is not set
CONFIG_GPIO_DA9055=y
CONFIG_GPIO_LP3943=y
CONFIG_GPIO_LP873X=y
# CONFIG_GPIO_LP87565 is not set
# CONFIG_GPIO_MADERA is not set
CONFIG_GPIO_MAX77650=y
CONFIG_GPIO_RC5T583=y
CONFIG_GPIO_TPS65086=y
CONFIG_GPIO_TPS65218=y
# CONFIG_GPIO_WM8350 is not set
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set
# end of PCI GPIO expanders

#
# USB GPIO expanders
#
# CONFIG_GPIO_VIPERBOARD is not set
# end of USB GPIO expanders

CONFIG_GPIO_MOCKUP=y
CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
# CONFIG_W1_MASTER_DS2490 is not set
# CONFIG_W1_MASTER_DS2482 is not set
# CONFIG_W1_MASTER_DS1WM is not set
# CONFIG_W1_MASTER_GPIO is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
CONFIG_W1_SLAVE_SMEM=y
# CONFIG_W1_SLAVE_DS2405 is not set
# CONFIG_W1_SLAVE_DS2408 is not set
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
# CONFIG_W1_SLAVE_DS2431 is not set
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS2780=y
# CONFIG_W1_SLAVE_DS2781 is not set
CONFIG_W1_SLAVE_DS28E04=y
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

CONFIG_POWER_AVS=y
CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_AS3722=y
# CONFIG_POWER_RESET_GPIO is not set
# CONFIG_POWER_RESET_GPIO_RESTART is not set
CONFIG_POWER_RESET_LTC2952=y
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_RESET_SYSCON=y
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
# CONFIG_SYSCON_REBOOT_MODE is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
CONFIG_WM8350_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=y
CONFIG_CHARGER_ADP5061=y
CONFIG_BATTERY_ACT8945A=y
# CONFIG_BATTERY_DS2760 is not set
CONFIG_BATTERY_DS2780=y
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_LEGO_EV3=y
CONFIG_BATTERY_SBS=y
# CONFIG_CHARGER_SBS is not set
CONFIG_MANAGER_SBS=y
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_DA9052 is not set
CONFIG_CHARGER_AXP20X=y
# CONFIG_BATTERY_AXP20X is not set
CONFIG_AXP20X_POWER=y
CONFIG_AXP288_CHARGER=y
# CONFIG_AXP288_FUEL_GAUGE is not set
CONFIG_BATTERY_MAX17040=y
# CONFIG_BATTERY_MAX17042 is not set
CONFIG_BATTERY_MAX1721X=y
# CONFIG_CHARGER_88PM860X is not set
CONFIG_CHARGER_ISP1704=y
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LT3651=y
# CONFIG_CHARGER_DETECTOR_MAX14656 is not set
# CONFIG_CHARGER_MAX77650 is not set
CONFIG_CHARGER_MAX77693=y
# CONFIG_CHARGER_BQ2415X is not set
CONFIG_CHARGER_BQ24190=y
# CONFIG_CHARGER_BQ24257 is not set
CONFIG_CHARGER_BQ24735=y
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=y
CONFIG_CHARGER_TPS65217=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_CHARGER_CROS_USBPD=y
CONFIG_CHARGER_UCS1002=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_AD7414=y
CONFIG_SENSORS_AD7418=y
# CONFIG_SENSORS_ADM1021 is not set
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
CONFIG_SENSORS_ADM9240=y
# CONFIG_SENSORS_ADT7410 is not set
CONFIG_SENSORS_ADT7411=y
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=y
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_ASC7621=y
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ASPEED=y
# CONFIG_SENSORS_ATXP1 is not set
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_DA9052_ADC is not set
CONFIG_SENSORS_DA9055=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
# CONFIG_SENSORS_FSCHMD is not set
CONFIG_SENSORS_FTSTEUTATES=y
# CONFIG_SENSORS_GL518SM is not set
CONFIG_SENSORS_GL520SM=y
CONFIG_SENSORS_G760A=y
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_GPIO_FAN is not set
CONFIG_SENSORS_HIH6130=y
# CONFIG_SENSORS_IBMAEM is not set
CONFIG_SENSORS_IBMPEX=y
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=y
# CONFIG_SENSORS_POWR1220 is not set
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LOCHNAGAR=y
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2990=y
CONFIG_SENSORS_LTC4151=y
# CONFIG_SENSORS_LTC4215 is not set
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_MAX16065 is not set
CONFIG_SENSORS_MAX1619=y
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6642=y
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
CONFIG_SENSORS_MENF21BMC_HWMON=y
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM73 is not set
# CONFIG_SENSORS_LM75 is not set
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_LM87=y
CONFIG_SENSORS_LM90=y
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=y
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=y
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775=y
# CONFIG_SENSORS_NCT7802 is not set
CONFIG_SENSORS_NCT7904=y
CONFIG_SENSORS_NPCM7XX=y
CONFIG_SENSORS_PCF8591=y
# CONFIG_PMBUS is not set
CONFIG_SENSORS_SHT15=y
# CONFIG_SENSORS_SHT21 is not set
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
CONFIG_SENSORS_EMC1403=y
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=y
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
# CONFIG_SENSORS_SCH5636 is not set
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=y
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS1015=y
# CONFIG_SENSORS_ADS7828 is not set
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_INA3221=y
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=y
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP103 is not set
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
CONFIG_SENSORS_VIA_CPUTEMP=y
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=y
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
CONFIG_SENSORS_W83795=y
CONFIG_SENSORS_W83795_FANCTRL=y
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y
CONFIG_SENSORS_WM8350=y

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
CONFIG_SENSORS_ATK0110=y
CONFIG_THERMAL=y
CONFIG_THERMAL_STATISTICS=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
# CONFIG_THERMAL_OF is not set
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_GOV_STEP_WISE is not set
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
CONFIG_CLOCK_THERMAL=y
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
CONFIG_THERMAL_MMIO=y

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

CONFIG_GENERIC_ADC_THERMAL=y
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
CONFIG_DA9052_WATCHDOG=y
# CONFIG_DA9055_WATCHDOG is not set
CONFIG_DA9063_WATCHDOG=y
CONFIG_GPIO_WATCHDOG=y
# CONFIG_GPIO_WATCHDOG_ARCH_INITCALL is not set
CONFIG_MENF21BMC_WATCHDOG=y
CONFIG_MENZ069_WATCHDOG=y
CONFIG_WDAT_WDT=y
CONFIG_WM8350_WATCHDOG=y
# CONFIG_XILINX_WATCHDOG is not set
CONFIG_ZIIRAVE_WATCHDOG=y
CONFIG_RAVE_SP_WATCHDOG=y
CONFIG_CADENCE_WATCHDOG=y
CONFIG_DW_WATCHDOG=y
# CONFIG_RN5T618_WATCHDOG is not set
CONFIG_MAX63XX_WATCHDOG=y
CONFIG_STPMIC1_WATCHDOG=y
CONFIG_ACQUIRE_WDT=y
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
CONFIG_EBC_C384_WDT=y
CONFIG_F71808E_WDT=y
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=y
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
CONFIG_IBMASR=y
CONFIG_WAFER_WDT=y
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=y
# CONFIG_IT87_WDT is not set
# CONFIG_HP_WATCHDOG is not set
# CONFIG_SC1200_WDT is not set
CONFIG_PC87413_WDT=y
# CONFIG_NV_TCO is not set
# CONFIG_RDC321X_WDT is not set
CONFIG_60XX_WDT=y
# CONFIG_SBC8360_WDT is not set
CONFIG_SBC7240_WDT=y
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=y
CONFIG_SMSC37B787_WDT=y
# CONFIG_TQMX86_WDT is not set
# CONFIG_VIA_WDT is not set
CONFIG_W83627HF_WDT=y
CONFIG_W83877F_WDT=y
# CONFIG_W83977F_WDT is not set
# CONFIG_MACHZ_WDT is not set
CONFIG_SBC_EPX_C3_WATCHDOG=y
CONFIG_NI903X_WDT=y
CONFIG_NIC7018_WDT=y
# CONFIG_MEN_A21_WDT is not set

#
# ISA-based Watchdog Cards
#
CONFIG_PCWATCHDOG=y
CONFIG_MIXCOMWD=y
# CONFIG_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
CONFIG_MFD_ACT8945A=y
# CONFIG_MFD_AS3711 is not set
CONFIG_MFD_AS3722=y
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_ATMEL_FLEXCOM is not set
# CONFIG_MFD_ATMEL_HLCDC is not set
# CONFIG_MFD_BCM590XX is not set
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_CROS_EC=y
# CONFIG_MFD_CROS_EC_CHARDEV is not set
CONFIG_MFD_MADERA=y
CONFIG_MFD_MADERA_I2C=y
# CONFIG_MFD_CS47L35 is not set
# CONFIG_MFD_CS47L85 is not set
CONFIG_MFD_CS47L90=y
# CONFIG_PMIC_DA903X is not set
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
# CONFIG_MFD_DA9062 is not set
CONFIG_MFD_DA9063=y
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_I2C is not set
CONFIG_MFD_HI6421_PMIC=y
CONFIG_HTC_PASIC3=y
CONFIG_HTC_I2CPLD=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
CONFIG_INTEL_SOC_PMIC_CHTDC_TI=y
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
CONFIG_MFD_88PM860X=y
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77620 is not set
CONFIG_MFD_MAX77650=y
CONFIG_MFD_MAX77686=y
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
CONFIG_MFD_VIPERBOARD=y
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT5033=y
CONFIG_MFD_RC5T583=y
CONFIG_MFD_RK808=y
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
CONFIG_AB3100_OTP=y
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=y
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TI_LP87565=y
CONFIG_MFD_TPS65218=y
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TIMBERDALE is not set
# CONFIG_MFD_TC3589X is not set
# CONFIG_MFD_TQMX86 is not set
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_LOCHNAGAR=y
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
# CONFIG_MFD_WM8994 is not set
CONFIG_MFD_ROHM_BD718XX=y
CONFIG_MFD_STPMIC1=y
CONFIG_MFD_STMFX=y
CONFIG_RAVE_SP_CORE=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=y
# CONFIG_REGULATOR_88PM800 is not set
CONFIG_REGULATOR_88PM8607=y
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_ACT8945A=y
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_ANATOP=y
CONFIG_REGULATOR_AB3100=y
# CONFIG_REGULATOR_AS3722 is not set
# CONFIG_REGULATOR_AXP20X is not set
# CONFIG_REGULATOR_BD718XX is not set
CONFIG_REGULATOR_BD9571MWV=y
CONFIG_REGULATOR_DA9052=y
CONFIG_REGULATOR_DA9055=y
CONFIG_REGULATOR_DA9063=y
# CONFIG_REGULATOR_DA9210 is not set
# CONFIG_REGULATOR_DA9211 is not set
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=y
# CONFIG_REGULATOR_HI6421 is not set
CONFIG_REGULATOR_HI6421V530=y
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=y
CONFIG_REGULATOR_LM363X=y
# CONFIG_REGULATOR_LOCHNAGAR is not set
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
# CONFIG_REGULATOR_LP872X is not set
CONFIG_REGULATOR_LP873X=y
CONFIG_REGULATOR_LP8755=y
# CONFIG_REGULATOR_LP87565 is not set
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=y
# CONFIG_REGULATOR_MAX1586 is not set
CONFIG_REGULATOR_MAX77650=y
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8907=y
# CONFIG_REGULATOR_MAX8952 is not set
# CONFIG_REGULATOR_MAX8997 is not set
CONFIG_REGULATOR_MAX77686=y
CONFIG_REGULATOR_MAX77693=y
CONFIG_REGULATOR_MAX77802=y
CONFIG_REGULATOR_MCP16502=y
# CONFIG_REGULATOR_MT6311 is not set
# CONFIG_REGULATOR_MT6323 is not set
CONFIG_REGULATOR_MT6397=y
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_QCOM_SPMI=y
# CONFIG_REGULATOR_RC5T583 is not set
# CONFIG_REGULATOR_RK808 is not set
CONFIG_REGULATOR_RN5T618=y
CONFIG_REGULATOR_RT5033=y
CONFIG_REGULATOR_S2MPA01=y
CONFIG_REGULATOR_S2MPS11=y
CONFIG_REGULATOR_S5M8767=y
CONFIG_REGULATOR_STPMIC1=y
CONFIG_REGULATOR_SY8106A=y
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=y
CONFIG_REGULATOR_TPS62360=y
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=y
CONFIG_REGULATOR_TPS65086=y
CONFIG_REGULATOR_TPS65132=y
CONFIG_REGULATOR_TPS65217=y
CONFIG_REGULATOR_TPS65218=y
CONFIG_REGULATOR_VCTRL=y
# CONFIG_REGULATOR_WM8350 is not set
CONFIG_RC_CORE=y
# CONFIG_RC_MAP is not set
# CONFIG_LIRC is not set
# CONFIG_RC_DECODERS is not set
# CONFIG_RC_DEVICES is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set
# CONFIG_DRM_DP_CEC is not set

#
# ARM devices
#
# end of ARM devices

#
# ACP (Audio CoProcessor) Configuration
#
# end of ACP (Audio CoProcessor) Configuration

#
# Frame buffer Devices
#
# CONFIG_FB is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
# CONFIG_BACKLIGHT_CLASS_DEVICE is not set
# end of Backlight & LCD device support
# end of Graphics support

CONFIG_SOUND=y
# CONFIG_SND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
# CONFIG_HID_GENERIC is not set

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=y
CONFIG_HID_ACRUX_FF=y
# CONFIG_HID_APPLE is not set
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=y
CONFIG_HID_AUREAL=y
CONFIG_HID_BELKIN=y
CONFIG_HID_BETOP_FF=y
CONFIG_HID_BIGBEN_FF=y
CONFIG_HID_CHERRY=y
# CONFIG_HID_CHICONY is not set
CONFIG_HID_CORSAIR=y
# CONFIG_HID_COUGAR is not set
CONFIG_HID_MACALLY=y
CONFIG_HID_CMEDIA=y
CONFIG_HID_CP2112=y
CONFIG_HID_CYPRESS=y
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
# CONFIG_HID_ELECOM is not set
CONFIG_HID_ELO=y
CONFIG_HID_EZKEY=y
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=y
CONFIG_HID_HOLTEK=y
# CONFIG_HOLTEK_FF is not set
CONFIG_HID_GOOGLE_HAMMER=y
CONFIG_HID_GT683R=y
CONFIG_HID_KEYTOUCH=y
CONFIG_HID_KYE=y
CONFIG_HID_UCLOGIC=y
# CONFIG_HID_WALTOP is not set
CONFIG_HID_VIEWSONIC=y
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=y
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=y
CONFIG_HID_LOGITECH_HIDPP=y
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
CONFIG_LOGIG940_FF=y
CONFIG_LOGIWHEELS_FF=y
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MALTRON=y
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=y
CONFIG_HID_NTI=y
CONFIG_HID_NTRIG=y
# CONFIG_HID_ORTEK is not set
CONFIG_HID_PANTHERLORD=y
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
# CONFIG_HID_PLANTRONICS is not set
CONFIG_HID_PRIMAX=y
CONFIG_HID_RETRODE=y
CONFIG_HID_ROCCAT=y
CONFIG_HID_SAITEK=y
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=y
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
CONFIG_GREENASIA_FF=y
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=y
CONFIG_HID_THINGM=y
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_U2FZERO=y
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=y
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
CONFIG_HID_ALPS=y
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=y
# end of I2C HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_OTG=y
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
CONFIG_USB_OTG_FSM=y
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
# CONFIG_USB_MON is not set
CONFIG_USB_WUSB=y
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_XHCI_DBGCAP=y
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PLATFORM=y
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_OXU210HP_HCD=y
CONFIG_USB_ISP116X_HCD=y
# CONFIG_USB_FOTG210_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
CONFIG_USB_OHCI_HCD_PLATFORM=y
# CONFIG_USB_UHCI_HCD is not set
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
CONFIG_USB_R8A66597_HCD=y
# CONFIG_USB_WHCI_HCD is not set
# CONFIG_USB_HWA_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
CONFIG_USB_HCD_TEST_MODE=y

#
# USB Device Class drivers
#
CONFIG_USB_ACM=y
# CONFIG_USB_PRINTER is not set
CONFIG_USB_WDM=y
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
# CONFIG_USB_STORAGE_ISD200 is not set
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=y
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
CONFIG_USB_STORAGE_ONETOUCH=y
CONFIG_USB_STORAGE_KARMA=y
CONFIG_USB_STORAGE_CYPRESS_ATACB=y
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
CONFIG_USB_UAS=y

#
# USB Imaging devices
#
CONFIG_USB_MDC800=y
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
CONFIG_USB_MUSB_HDRC=y
# CONFIG_USB_MUSB_HOST is not set
# CONFIG_USB_MUSB_GADGET is not set
CONFIG_USB_MUSB_DUAL_ROLE=y

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_SIMPLE=y
CONFIG_USB_SERIAL_AIRCABLE=y
CONFIG_USB_SERIAL_ARK3116=y
CONFIG_USB_SERIAL_BELKIN=y
CONFIG_USB_SERIAL_CH341=y
CONFIG_USB_SERIAL_WHITEHEAT=y
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=y
CONFIG_USB_SERIAL_CP210X=y
CONFIG_USB_SERIAL_CYPRESS_M8=y
# CONFIG_USB_SERIAL_EMPEG is not set
CONFIG_USB_SERIAL_FTDI_SIO=y
CONFIG_USB_SERIAL_VISOR=y
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
CONFIG_USB_SERIAL_EDGEPORT_TI=y
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
CONFIG_USB_SERIAL_IPW=y
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
CONFIG_USB_SERIAL_KEYSPAN=y
# CONFIG_USB_SERIAL_KLSI is not set
CONFIG_USB_SERIAL_KOBIL_SCT=y
CONFIG_USB_SERIAL_MCT_U232=y
CONFIG_USB_SERIAL_METRO=y
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
CONFIG_USB_SERIAL_MXUPORT=y
CONFIG_USB_SERIAL_NAVMAN=y
CONFIG_USB_SERIAL_PL2303=y
CONFIG_USB_SERIAL_OTI6858=y
CONFIG_USB_SERIAL_QCAUX=y
# CONFIG_USB_SERIAL_QUALCOMM is not set
CONFIG_USB_SERIAL_SPCP8X5=y
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=y
# CONFIG_USB_SERIAL_XIRCOM is not set
CONFIG_USB_SERIAL_WWAN=y
CONFIG_USB_SERIAL_OPTION=y
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
CONFIG_USB_SERIAL_XSENS_MT=y
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=y
CONFIG_USB_SERIAL_QT2=y
CONFIG_USB_SERIAL_UPD78F0730=y
CONFIG_USB_SERIAL_DEBUG=y

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
CONFIG_USB_EMI26=y
CONFIG_USB_ADUTUX=y
CONFIG_USB_SEVSEG=y
# CONFIG_USB_RIO500 is not set
CONFIG_USB_LEGOTOWER=y
CONFIG_USB_LCD=y
CONFIG_USB_CYPRESS_CY7C63=y
CONFIG_USB_CYTHERM=y
CONFIG_USB_IDMOUSE=y
CONFIG_USB_FTDI_ELAN=y
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
CONFIG_USB_TRANCEVIBRATOR=y
CONFIG_USB_IOWARRIOR=y
# CONFIG_USB_TEST is not set
CONFIG_USB_EHSET_TEST_FIXTURE=y
CONFIG_USB_ISIGHTFW=y
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=y
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=y
# CONFIG_USB_HSIC_USB4604 is not set
CONFIG_USB_LINK_LAYER_TEST=y
CONFIG_USB_CHAOSKEY=y

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_NOP_USB_XCEIV is not set
CONFIG_USB_GPIO_VBUS=y
CONFIG_USB_ISP1301=y
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=y
CONFIG_USB_GADGET_DEBUG=y
# CONFIG_USB_GADGET_VERBOSE is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
CONFIG_U_SERIAL_CONSOLE=y

#
# USB Peripheral Controller
#
CONFIG_USB_FUSB300=y
CONFIG_USB_FOTG210_UDC=y
CONFIG_USB_GR_UDC=y
# CONFIG_USB_R8A66597 is not set
CONFIG_USB_PXA27X=y
# CONFIG_USB_MV_UDC is not set
# CONFIG_USB_MV_U3D is not set
CONFIG_USB_SNP_CORE=y
CONFIG_USB_SNP_UDC_PLAT=y
CONFIG_USB_M66592=y
# CONFIG_USB_BDC_UDC is not set
# CONFIG_USB_AMD5536UDC is not set
# CONFIG_USB_NET2272 is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
CONFIG_USB_GADGET_XILINX=y
CONFIG_USB_DUMMY_HCD=y
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=y
CONFIG_USB_F_SS_LB=y
CONFIG_USB_U_SERIAL=y
CONFIG_USB_F_SERIAL=y
CONFIG_USB_F_OBEX=y
CONFIG_USB_F_HID=y
CONFIG_USB_CONFIGFS=y
CONFIG_USB_CONFIGFS_SERIAL=y
# CONFIG_USB_CONFIGFS_ACM is not set
CONFIG_USB_CONFIGFS_OBEX=y
# CONFIG_USB_CONFIGFS_NCM is not set
# CONFIG_USB_CONFIGFS_ECM is not set
# CONFIG_USB_CONFIGFS_ECM_SUBSET is not set
# CONFIG_USB_CONFIGFS_RNDIS is not set
# CONFIG_USB_CONFIGFS_EEM is not set
# CONFIG_USB_CONFIGFS_MASS_STORAGE is not set
CONFIG_USB_CONFIGFS_F_LB_SS=y
# CONFIG_USB_CONFIGFS_F_FS is not set
CONFIG_USB_CONFIGFS_F_HID=y
# CONFIG_USB_CONFIGFS_F_PRINTER is not set
# CONFIG_TYPEC is not set
CONFIG_USB_ROLE_SWITCH=y
# CONFIG_USB_ROLES_INTEL_XHCI is not set
CONFIG_USB_LED_TRIG=y
CONFIG_USB_ULPI_BUS=y
CONFIG_UWB=y
# CONFIG_UWB_HWA is not set
# CONFIG_UWB_WHCI is not set
# CONFIG_MMC is not set
CONFIG_MEMSTICK=y
CONFIG_MEMSTICK_DEBUG=y

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
# CONFIG_MSPRO_BLOCK is not set
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_MEMSTICK_REALTEK_USB=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_88PM860X=y
CONFIG_LEDS_AAT1290=y
# CONFIG_LEDS_AN30259A is not set
# CONFIG_LEDS_AS3645A is not set
# CONFIG_LEDS_BCM6328 is not set
CONFIG_LEDS_BCM6358=y
CONFIG_LEDS_LM3530=y
# CONFIG_LEDS_LM3532 is not set
CONFIG_LEDS_LM3533=y
CONFIG_LEDS_LM3642=y
CONFIG_LEDS_LM3692X=y
# CONFIG_LEDS_LM3601X is not set
CONFIG_LEDS_MT6323=y
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=y
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
CONFIG_LEDS_LP8860=y
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_WM8350 is not set
CONFIG_LEDS_DA9052=y
CONFIG_LEDS_REGULATOR=y
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_TCA6507=y
# CONFIG_LEDS_TLC591XX is not set
CONFIG_LEDS_MAX77650=y
# CONFIG_LEDS_MAX77693 is not set
CONFIG_LEDS_MAX8997=y
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_OT200=y
CONFIG_LEDS_MENF21BMC=y
# CONFIG_LEDS_KTD2692 is not set
# CONFIG_LEDS_IS31FL319X is not set
CONFIG_LEDS_IS31FL32XX=y

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_SYSCON is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
CONFIG_LEDS_NIC78BX=y

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
# CONFIG_LEDS_TRIGGER_ONESHOT is not set
CONFIG_LEDS_TRIGGER_MTD=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
CONFIG_LEDS_TRIGGER_CPU=y
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
# CONFIG_LEDS_TRIGGER_CAMERA is not set
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=y
CONFIG_ACCESSIBILITY=y
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_GHES=y
# CONFIG_EDAC_AMD76X is not set
# CONFIG_EDAC_E7XXX is not set
# CONFIG_EDAC_E752X is not set
# CONFIG_EDAC_I82875P is not set
# CONFIG_EDAC_I82975X is not set
# CONFIG_EDAC_I3000 is not set
# CONFIG_EDAC_I3200 is not set
# CONFIG_EDAC_IE31200 is not set
# CONFIG_EDAC_X38 is not set
# CONFIG_EDAC_I5400 is not set
# CONFIG_EDAC_I82860 is not set
# CONFIG_EDAC_R82600 is not set
# CONFIG_EDAC_I5000 is not set
# CONFIG_EDAC_I5100 is not set
# CONFIG_EDAC_I7300 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
CONFIG_RTC_DEBUG=y
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
# CONFIG_RTC_INTF_DEV is not set
CONFIG_RTC_DRV_TEST=y

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM860X=y
CONFIG_RTC_DRV_88PM80X=y
CONFIG_RTC_DRV_ABB5ZES3=y
# CONFIG_RTC_DRV_ABEOZ9 is not set
CONFIG_RTC_DRV_ABX80X=y
CONFIG_RTC_DRV_AS3722=y
# CONFIG_RTC_DRV_DS1307 is not set
CONFIG_RTC_DRV_DS1374=y
CONFIG_RTC_DRV_DS1374_WDT=y
CONFIG_RTC_DRV_DS1672=y
CONFIG_RTC_DRV_HYM8563=y
CONFIG_RTC_DRV_MAX6900=y
# CONFIG_RTC_DRV_MAX8907 is not set
# CONFIG_RTC_DRV_MAX8997 is not set
# CONFIG_RTC_DRV_MAX77686 is not set
# CONFIG_RTC_DRV_RK808 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
CONFIG_RTC_DRV_ISL1208=y
CONFIG_RTC_DRV_ISL12022=y
# CONFIG_RTC_DRV_ISL12026 is not set
CONFIG_RTC_DRV_X1205=y
# CONFIG_RTC_DRV_PCF8523 is not set
CONFIG_RTC_DRV_PCF85063=y
CONFIG_RTC_DRV_PCF85363=y
CONFIG_RTC_DRV_PCF8563=y
CONFIG_RTC_DRV_PCF8583=y
# CONFIG_RTC_DRV_M41T80 is not set
CONFIG_RTC_DRV_BQ32K=y
CONFIG_RTC_DRV_RC5T583=y
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=y
CONFIG_RTC_DRV_RX8025=y
CONFIG_RTC_DRV_EM3027=y
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV8803 is not set
CONFIG_RTC_DRV_S5M=y
CONFIG_RTC_DRV_SD3078=y

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
CONFIG_RTC_DRV_PCF2127=y
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=y
CONFIG_RTC_DRV_DS1511=y
CONFIG_RTC_DRV_DS1553=y
CONFIG_RTC_DRV_DS1685_FAMILY=y
# CONFIG_RTC_DRV_DS1685 is not set
# CONFIG_RTC_DRV_DS1689 is not set
CONFIG_RTC_DRV_DS17285=y
# CONFIG_RTC_DRV_DS17485 is not set
# CONFIG_RTC_DRV_DS17885 is not set
# CONFIG_RTC_DRV_DS1742 is not set
CONFIG_RTC_DRV_DS2404=y
# CONFIG_RTC_DRV_DA9052 is not set
CONFIG_RTC_DRV_DA9055=y
CONFIG_RTC_DRV_DA9063=y
CONFIG_RTC_DRV_STK17TA8=y
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=y
CONFIG_RTC_DRV_M48T59=y
CONFIG_RTC_DRV_MSM6242=y
CONFIG_RTC_DRV_BQ4802=y
CONFIG_RTC_DRV_RP5C01=y
# CONFIG_RTC_DRV_V3020 is not set
CONFIG_RTC_DRV_WM8350=y
CONFIG_RTC_DRV_AB3100=y
CONFIG_RTC_DRV_ZYNQMP=y
CONFIG_RTC_DRV_CROS_EC=y

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_CADENCE is not set
CONFIG_RTC_DRV_FTRTC010=y
# CONFIG_RTC_DRV_SNVS is not set
CONFIG_RTC_DRV_MT6397=y
# CONFIG_RTC_DRV_R7301 is not set

#
# HID Sensor RTC drivers
#
CONFIG_RTC_DRV_HID_SENSOR_TIME=y
CONFIG_RTC_DRV_GOLDFISH=y
CONFIG_RTC_DRV_WILCO_EC=y
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
CONFIG_DMADEVICES_VDEBUG=y

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=y
CONFIG_DW_AXI_DMAC=y
# CONFIG_FSL_EDMA is not set
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_PCH_DMA is not set
CONFIG_QCOM_HIDMA_MGMT=y
CONFIG_QCOM_HIDMA=y
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=y
# CONFIG_DW_DMAC_PCI is not set

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
CONFIG_DMATEST=y
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_HD44780=y
CONFIG_IMG_ASCII_LCD=y
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
CONFIG_CHARLCD=y
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=y
# CONFIG_UIO_DMEM_GENIRQ is not set
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=y
# CONFIG_UIO_MF624 is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

CONFIG_STAGING=y
# CONFIG_COMEDI is not set
# CONFIG_R8712U is not set
# CONFIG_RTS5208 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# end of Accelerometers

#
# Analog to digital converters
#
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=y
# CONFIG_ADT7316_I2C is not set
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
CONFIG_AD7150=y
CONFIG_AD7746=y
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=y
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
CONFIG_ADE7854=y
CONFIG_ADE7854_I2C=y
# end of Active energy metering IC

#
# Resolver to digital converters
#
# end of Resolver to digital converters
# end of IIO staging drivers

#
# Speakup console speech
#
# end of Speakup console speech

CONFIG_STAGING_MEDIA=y

#
# Android
#
# end of Android

# CONFIG_STAGING_BOARD is not set
CONFIG_GOLDFISH_AUDIO=y
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
CONFIG_COMMON_CLK_XLNX_CLKWZRD=y
# CONFIG_MOST is not set
# CONFIG_GREYBUS is not set

#
# Gasket devices
#
# end of Gasket devices

CONFIG_XIL_AXIS_FIFO=y
CONFIG_EROFS_FS=y
# CONFIG_EROFS_FS_DEBUG is not set
CONFIG_EROFS_FS_XATTR=y
CONFIG_EROFS_FS_POSIX_ACL=y
# CONFIG_EROFS_FS_SECURITY is not set
# CONFIG_EROFS_FS_USE_VM_MAP_RAM is not set
CONFIG_EROFS_FAULT_INJECTION=y
CONFIG_EROFS_FS_IO_MAX_RETRIES=5
CONFIG_EROFS_FS_ZIP=y
CONFIG_EROFS_FS_CLUSTER_PAGE_LIMIT=1
# CONFIG_EROFS_FS_ZIP_NO_CACHE is not set
# CONFIG_EROFS_FS_ZIP_CACHE_UNIPOLAR is not set
CONFIG_EROFS_FS_ZIP_CACHE_BIPOLAR=y
CONFIG_FIELDBUS_DEV=y
# CONFIG_HMS_ANYBUSS_BUS is not set
# CONFIG_KPC2000 is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WIRELESS=y
# CONFIG_ACERHDF is not set
CONFIG_DCDBAS=y
# CONFIG_DELL_SMBIOS is not set
CONFIG_DELL_SMO8800=y
CONFIG_DELL_RBU=y
CONFIG_FUJITSU_TABLET=y
CONFIG_GPD_POCKET_FAN=y
CONFIG_HP_ACCEL=y
CONFIG_HP_WIRELESS=y
# CONFIG_SENSORS_HDAPS is not set
CONFIG_ASUS_WIRELESS=y
# CONFIG_ACPI_WMI is not set
CONFIG_TOPSTAR_LAPTOP=y
CONFIG_TOSHIBA_BT_RFKILL=y
CONFIG_TOSHIBA_HAPS=y
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_HID_EVENT is not set
CONFIG_INTEL_VBTN=y
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_PMC_CORE is not set
# CONFIG_IBM_RTL is not set
# CONFIG_INTEL_RST is not set
CONFIG_INTEL_SMARTCONNECT=y
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_INTEL_PUNIT_IPC=y
CONFIG_MLX_PLATFORM=y
CONFIG_INTEL_CHTDC_TI_PWRBTN=y
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_PCENGINES_APU2 is not set
CONFIG_PMC_ATOM=y
# CONFIG_GOLDFISH_PIPE is not set
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_PSTORE is not set
CONFIG_CHROMEOS_TBMC=y
CONFIG_CROS_EC_I2C=y
CONFIG_CROS_EC_RPMSG=y
CONFIG_CROS_EC_LPC=y
CONFIG_CROS_EC_LPC_MEC=y
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_CROS_USBPD_LOGGER=y
CONFIG_WILCO_EC=y
CONFIG_WILCO_EC_DEBUGFS=y
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_CLK_HSDK=y
CONFIG_COMMON_CLK_MAX77686=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_RK808 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
CONFIG_COMMON_CLK_SI514=y
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_SI570=y
CONFIG_COMMON_CLK_CDCE706=y
CONFIG_COMMON_CLK_CDCE925=y
CONFIG_COMMON_CLK_CS2000_CP=y
CONFIG_COMMON_CLK_S2MPS11=y
CONFIG_COMMON_CLK_LOCHNAGAR=y
CONFIG_COMMON_CLK_VC5=y
CONFIG_COMMON_CLK_BD718XX=y
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
CONFIG_CLK_SIFIVE=y
# CONFIG_CLK_SIFIVE_FU540_PRCI is not set
# end of Common Clock Framework

# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=y
# CONFIG_PCC is not set
# CONFIG_ALTERA_MBOX is not set
CONFIG_MAILBOX_TEST=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_QCOM_GLINK_NATIVE=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
CONFIG_RPMSG_VIRTIO=y
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# IXP4xx SoC drivers
#
CONFIG_IXP4XX_QMGR=y
# CONFIG_IXP4XX_NPE is not set
# end of IXP4xx SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
CONFIG_EXTCON_AXP288=y
CONFIG_EXTCON_GPIO=y
CONFIG_EXTCON_INTEL_INT3496=y
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX77693=y
# CONFIG_EXTCON_MAX77843 is not set
CONFIG_EXTCON_MAX8997=y
CONFIG_EXTCON_PTN5150=y
# CONFIG_EXTCON_RT8973A is not set
CONFIG_EXTCON_SM5502=y
# CONFIG_EXTCON_USB_GPIO is not set
CONFIG_EXTCON_USBC_CROS_EC=y
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
CONFIG_IIO_SW_DEVICE=y
# CONFIG_IIO_SW_TRIGGER is not set

#
# Accelerometers
#
# CONFIG_ADXL372_I2C is not set
# CONFIG_BMA180 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
CONFIG_DA311=y
CONFIG_DMARD06=y
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
CONFIG_HID_SENSOR_ACCEL_3D=y
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=y
CONFIG_KXSD9=y
CONFIG_KXSD9_I2C=y
CONFIG_KXCJK1013=y
CONFIG_MC3230=y
CONFIG_MMA7455=y
CONFIG_MMA7455_I2C=y
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
# CONFIG_MMA9553 is not set
CONFIG_MXC4005=y
# CONFIG_MXC6255 is not set
# CONFIG_STK8312 is not set
CONFIG_STK8BA50=y
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD7291=y
CONFIG_AD7606=y
CONFIG_AD7606_IFACE_PARALLEL=y
CONFIG_AD799X=y
CONFIG_AXP20X_ADC=y
# CONFIG_AXP288_ADC is not set
# CONFIG_CC10001_ADC is not set
# CONFIG_ENVELOPE_DETECTOR is not set
CONFIG_HX711=y
# CONFIG_LTC2471 is not set
CONFIG_LTC2485=y
CONFIG_LTC2497=y
CONFIG_MAX1363=y
CONFIG_MAX9611=y
# CONFIG_MCP3422 is not set
CONFIG_MEN_Z188_ADC=y
CONFIG_NAU7802=y
CONFIG_QCOM_VADC_COMMON=y
CONFIG_QCOM_SPMI_IADC=y
CONFIG_QCOM_SPMI_VADC=y
CONFIG_QCOM_SPMI_ADC5=y
CONFIG_SD_ADC_MODULATOR=y
CONFIG_STX104=y
CONFIG_TI_ADC081C=y
CONFIG_TI_AM335X_ADC=y
CONFIG_VF610_ADC=y
CONFIG_VIPERBOARD_ADC=y
# end of Analog to digital converters

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=y
# end of Analog Front Ends

#
# Amplifiers
#
# end of Amplifiers

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
CONFIG_BME680=y
CONFIG_BME680_I2C=y
# CONFIG_CCS811 is not set
# CONFIG_IAQCORE is not set
# CONFIG_PMS7003 is not set
CONFIG_SENSIRION_SGP30=y
CONFIG_SPS30=y
CONFIG_VZ89X=y
# end of Chemical Sensors

CONFIG_IIO_CROS_EC_SENSORS_CORE=y
CONFIG_IIO_CROS_EC_SENSORS=y

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=y
CONFIG_HID_SENSOR_IIO_TRIGGER=y
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
CONFIG_AD5064=y
CONFIG_AD5380=y
CONFIG_AD5446=y
CONFIG_AD5592R_BASE=y
CONFIG_AD5593R=y
# CONFIG_AD5696_I2C is not set
# CONFIG_CIO_DAC is not set
CONFIG_DPOT_DAC=y
# CONFIG_DS4424 is not set
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
CONFIG_MAX5821=y
CONFIG_MCP4725=y
CONFIG_TI_DAC5571=y
# CONFIG_VF610_DAC is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
# CONFIG_IIO_SIMPLE_DUMMY is not set
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
CONFIG_HID_SENSOR_GYRO_3D=y
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4404=y
CONFIG_MAX30100=y
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=y
CONFIG_DHT11=y
CONFIG_HDC100X=y
CONFIG_HID_SENSOR_HUMIDITY=y
CONFIG_HTS221=y
CONFIG_HTS221_I2C=y
# CONFIG_HTU21 is not set
CONFIG_SI7005=y
CONFIG_SI7020=y
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_BMI160=y
CONFIG_BMI160_I2C=y
# CONFIG_KMX61 is not set
CONFIG_INV_MPU6050_IIO=y
CONFIG_INV_MPU6050_I2C=y
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
CONFIG_AL3320A=y
# CONFIG_APDS9300 is not set
CONFIG_APDS9960=y
CONFIG_BH1750=y
# CONFIG_BH1780 is not set
# CONFIG_CM32181 is not set
CONFIG_CM3232=y
# CONFIG_CM3323 is not set
# CONFIG_CM3605 is not set
CONFIG_CM36651=y
# CONFIG_IIO_CROS_EC_LIGHT_PROX is not set
CONFIG_GP2AP020A00F=y
CONFIG_SENSORS_ISL29018=y
CONFIG_SENSORS_ISL29028=y
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=y
CONFIG_HID_SENSOR_PROX=y
CONFIG_JSA1212=y
# CONFIG_RPR0521 is not set
# CONFIG_SENSORS_LM3533 is not set
# CONFIG_LTR501 is not set
CONFIG_LV0104CS=y
CONFIG_MAX44000=y
# CONFIG_MAX44009 is not set
CONFIG_OPT3001=y
# CONFIG_PA12203001 is not set
CONFIG_SI1133=y
CONFIG_SI1145=y
CONFIG_STK3310=y
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
# CONFIG_TCS3414 is not set
CONFIG_TCS3472=y
# CONFIG_SENSORS_TSL2563 is not set
CONFIG_TSL2583=y
# CONFIG_TSL2772 is not set
CONFIG_TSL4531=y
CONFIG_US5182D=y
CONFIG_VCNL4000=y
CONFIG_VCNL4035=y
CONFIG_VEML6070=y
CONFIG_VL6180=y
CONFIG_ZOPT2201=y
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8974=y
CONFIG_AK8975=y
CONFIG_AK09911=y
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=y
CONFIG_MMC35240=y
# CONFIG_IIO_ST_MAGN_3AXIS is not set
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y
CONFIG_SENSORS_RM3100=y
CONFIG_SENSORS_RM3100_I2C=y
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=y
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=y
# CONFIG_HID_SENSOR_DEVICE_ROTATION is not set
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_INTERRUPT_TRIGGER=y
CONFIG_IIO_SYSFS_TRIGGER=y
# end of Triggers - standalone

#
# Digital potentiometers
#
CONFIG_AD5272=y
CONFIG_DS1803=y
CONFIG_MCP4018=y
# CONFIG_MCP4531 is not set
CONFIG_TPL0102=y
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=y
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
# CONFIG_IIO_CROS_EC_BARO is not set
CONFIG_HID_SENSOR_PRESS=y
CONFIG_HP03=y
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
CONFIG_MPL3115=y
CONFIG_MS5611=y
CONFIG_MS5611_I2C=y
# CONFIG_MS5637 is not set
CONFIG_IIO_ST_PRESS=y
CONFIG_IIO_ST_PRESS_I2C=y
CONFIG_T5403=y
# CONFIG_HP206C is not set
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y
# end of Pressure sensors

#
# Lightning sensors
#
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
CONFIG_LIDAR_LITE_V2=y
CONFIG_MB1232=y
CONFIG_RFD77402=y
CONFIG_SRF04=y
CONFIG_SX9500=y
# CONFIG_SRF08 is not set
CONFIG_VL53L0X_I2C=y
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_HID_SENSOR_TEMP is not set
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
CONFIG_TMP006=y
# CONFIG_TMP007 is not set
CONFIG_TSYS01=y
# CONFIG_TSYS02D is not set
# end of Temperature sensors

# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
CONFIG_MADERA_IRQ=y
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_TI_SYSCON=y
CONFIG_FMC=y
# CONFIG_FMC_FAKEDEV is not set
CONFIG_FMC_TRIVIAL=y
# CONFIG_FMC_WRITE_EEPROM is not set
CONFIG_FMC_CHARDEV=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_CADENCE_DP is not set
CONFIG_PHY_CADENCE_DPHY=y
# CONFIG_PHY_CADENCE_SIERRA is not set
# CONFIG_PHY_FSL_IMX8MQ_USB is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_PHY_CPCAP_USB=y
CONFIG_PHY_MAPPHONE_MDM6600=y
CONFIG_PHY_OCELOT_SERDES=y
CONFIG_PHY_QCOM_USB_HS=y
CONFIG_PHY_QCOM_USB_HSIC=y
CONFIG_PHY_TUSB1210=y
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_DAX=y
CONFIG_DEV_DAX=y
CONFIG_NVMEM=y
# CONFIG_NVMEM_SYSFS is not set
CONFIG_RAVE_SP_EEPROM=y

#
# HW tracing support
#
CONFIG_STM=y
CONFIG_STM_PROTO_BASIC=y
CONFIG_STM_PROTO_SYS_T=y
CONFIG_STM_DUMMY=y
CONFIG_STM_SOURCE_CONSOLE=y
CONFIG_STM_SOURCE_HEARTBEAT=y
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
CONFIG_INTEL_TH_ACPI=y
CONFIG_INTEL_TH_GTH=y
CONFIG_INTEL_TH_STH=y
CONFIG_INTEL_TH_MSU=y
# CONFIG_INTEL_TH_PTI is not set
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_FSI=y
CONFIG_FSI_NEW_DEV_NODE=y
CONFIG_FSI_MASTER_GPIO=y
CONFIG_FSI_MASTER_HUB=y
CONFIG_FSI_SCOM=y
CONFIG_FSI_SBEFIFO=y
CONFIG_FSI_OCC=y
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
# CONFIG_MUX_GPIO is not set
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
# CONFIG_SIOX is not set
CONFIG_SLIMBUS=y
# CONFIG_SLIM_QCOM_CTRL is not set
CONFIG_INTERCONNECT=y
CONFIG_COUNTER=y
# CONFIG_104_QUAD_8 is not set
CONFIG_FTM_QUADDEC=y
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT4_FS=y
# CONFIG_EXT4_USE_FOR_EXT2 is not set
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
# CONFIG_REISERFS_FS_POSIX_ACL is not set
# CONFIG_REISERFS_FS_SECURITY is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_QUOTA is not set
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
# CONFIG_BTRFS_FS_POSIX_ACL is not set
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
CONFIG_BTRFS_ASSERT=y
CONFIG_BTRFS_FS_REF_VERIFY=y
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=y
# CONFIG_F2FS_STAT_FS is not set
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
CONFIG_F2FS_CHECK_FS=y
CONFIG_F2FS_FAULT_INJECTION=y
CONFIG_FS_DAX=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_FSCACHE=y
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
CONFIG_FSCACHE_DEBUG=y
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=y
CONFIG_CACHEFILES_DEBUG=y
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
CONFIG_ZISOFS=y
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_FAT_DEFAULT_UTF8=y
CONFIG_NTFS_FS=y
CONFIG_NTFS_DEBUG=y
CONFIG_NTFS_RW=y
# end of DOS/FAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
# CONFIG_EFIVAR_FS is not set
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
CONFIG_ADFS_FS=y
# CONFIG_ADFS_FS_RW is not set
CONFIG_AFFS_FS=y
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
CONFIG_HFSPLUS_FS=y
# CONFIG_BEFS_FS is not set
CONFIG_BFS_FS=y
CONFIG_EFS_FS=y
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
CONFIG_JFFS2_SUMMARY=y
# CONFIG_JFFS2_FS_XATTR is not set
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_RTIME=y
CONFIG_UBIFS_FS=y
CONFIG_UBIFS_FS_ADVANCED_COMPR=y
# CONFIG_UBIFS_FS_LZO is not set
# CONFIG_UBIFS_FS_ZLIB is not set
CONFIG_UBIFS_ATIME_SUPPORT=y
CONFIG_UBIFS_FS_XATTR=y
# CONFIG_UBIFS_FS_SECURITY is not set
# CONFIG_UBIFS_FS_AUTHENTICATION is not set
CONFIG_CRAMFS=y
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_CRAMFS_MTD=y
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
# CONFIG_SQUASHFS_XATTR is not set
CONFIG_SQUASHFS_ZLIB=y
CONFIG_SQUASHFS_LZ4=y
CONFIG_SQUASHFS_LZO=y
# CONFIG_SQUASHFS_XZ is not set
CONFIG_SQUASHFS_ZSTD=y
CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=y
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
CONFIG_HPFS_FS=y
CONFIG_QNX4FS_FS=y
CONFIG_QNX6FS_FS=y
CONFIG_QNX6FS_DEBUG=y
CONFIG_ROMFS_FS=y
CONFIG_ROMFS_BACKED_BY_BLOCK=y
# CONFIG_ROMFS_BACKED_BY_MTD is not set
# CONFIG_ROMFS_BACKED_BY_BOTH is not set
CONFIG_ROMFS_ON_BLOCK=y
CONFIG_PSTORE=y
# CONFIG_PSTORE_DEFLATE_COMPRESS is not set
# CONFIG_PSTORE_LZO_COMPRESS is not set
CONFIG_PSTORE_LZ4_COMPRESS=y
CONFIG_PSTORE_LZ4HC_COMPRESS=y
CONFIG_PSTORE_842_COMPRESS=y
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT=y
# CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_842_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_COMPRESS_DEFAULT="lz4"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_RAM is not set
CONFIG_SYSV_FS=y
CONFIG_UFS_FS=y
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_UFS_DEBUG is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=y
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_FSCACHE is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=y
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=y
# CONFIG_NLS_ISO8859_5 is not set
CONFIG_NLS_ISO8859_6=y
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=y
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
CONFIG_NLS_MAC_CROATIAN=y
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=y
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
CONFIG_UNICODE=y
CONFIG_UNICODE_NORMALIZATION_SELFTEST=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
# CONFIG_TRUSTED_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="yama,loadpin,safesetid,integrity"

#
# Kernel hardening options
#
CONFIG_GCC_PLUGIN_STRUCTLEAK=y

#
# Memory initialization
#
# CONFIG_INIT_STACK_NONE is not set
CONFIG_GCC_PLUGIN_STRUCTLEAK_USER=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE is not set
CONFIG_GCC_PLUGIN_STACKLEAK=y
CONFIG_STACKLEAK_TRACK_MIN_SIZE=100
# CONFIG_STACKLEAK_METRICS is not set
CONFIG_STACKLEAK_RUNTIME_DISABLE=y
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_ASYNC_CORE=y
CONFIG_ASYNC_MEMCPY=y
CONFIG_ASYNC_XOR=y
CONFIG_ASYNC_PQ=y
CONFIG_ASYNC_RAID6_RECOV=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECRDSA=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_AEGIS128L=y
CONFIG_CRYPTO_AEGIS256=y
CONFIG_CRYPTO_MORUS640=y
CONFIG_CRYPTO_MORUS1280=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=y
# CONFIG_CRYPTO_XTS is not set
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_NHPOLY1305=y
CONFIG_CRYPTO_ADIANTUM=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32C_INTEL is not set
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD128=y
CONFIG_CRYPTO_RMD160=y
# CONFIG_CRYPTO_RMD256 is not set
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_TGR192=y
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_586=y
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=y
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
# CONFIG_CRYPTO_CAST5 is not set
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_FCRYPT is not set
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_586=y
# CONFIG_CRYPTO_SM4 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_586=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
# CONFIG_ASYMMETRIC_KEY_TYPE is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_RAID6_PQ_BENCHMARK=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
CONFIG_CRC32_SARWATE=y
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
# CONFIG_XZ_DEC is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_BCH=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_DMA_DECLARE_COHERENT=y
# CONFIG_DMA_CMA is not set
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_DDR=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_SG_POOL=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
CONFIG_STRING_SELFTEST=y
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_BTF is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
CONFIG_UNUSED_SYMBOLS=y
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
# CONFIG_MAGIC_SYSRQ_SERIAL is not set
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y
CONFIG_PAGE_OWNER=y
CONFIG_PAGE_POISONING=y
CONFIG_PAGE_POISONING_NO_SANITY=y
CONFIG_PAGE_POISONING_ZERO=y
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
CONFIG_DEBUG_OBJECTS_FREE=y
# CONFIG_DEBUG_OBJECTS_TIMERS is not set
# CONFIG_DEBUG_OBJECTS_WORK is not set
# CONFIG_DEBUG_OBJECTS_RCU_HEAD is not set
# CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_DEBUG_HIGHMEM=y
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_KASAN_STACK=1
# end of Memory Debugging

CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# end of Debug Lockups and Hangs

# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHEDSTATS is not set
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_DEBUG_TIMEKEEPING=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=y
# CONFIG_WW_MUTEX_SELFTEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=y
CONFIG_RCU_PERF_TEST=y
CONFIG_RCU_TORTURE_TEST=y
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=y
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=y
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FAULT_INJECTION=y
CONFIG_FAIL_PAGE_ALLOC=y
# CONFIG_FAIL_MAKE_REQUEST is not set
CONFIG_FAIL_IO_TIMEOUT=y
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=y
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=y
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=y
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_STACKINIT=y
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_UBSAN_ALIGNMENT=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
CONFIG_X86_PTDUMP_CORE=y
CONFIG_X86_PTDUMP=y
CONFIG_EFI_PGT_DUMP=y
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
CONFIG_IO_DELAY_0XED=y
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=1
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
CONFIG_DEBUG_ENTRY=y
CONFIG_DEBUG_NMI_SELFTEST=y
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_FRAME_POINTER=y
# end of Kernel hacking

--=_5ce91b39.uW0cMqn9vfRPpK06muQiAvNX+6hIRsMtzvEBdoLoDwOpVoKY--
