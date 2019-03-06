Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864D2C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 12:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A884520684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 12:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Idlumg1x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbfCFMIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 07:08:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56430 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729908AbfCFMIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 07:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IzaSCzTYq5gjE+iXR5qpdgC2KwVlVysNzaSt+dmPjgw=; b=Idlumg1x2vD9aDyqjGUOhmBuO
        jXlinYpUVmLpPzxfHqqQPfiPc/04sKtkNwZv3T5wiflvc1rznmLyOuYdp4Gv5XZBY/pfP039gzvGU
        Lh0JpcMdcUMCp/A1jUoqK5YmuO52MaXIhy2ecQwSYzb2/H+4e0geMNt+COZd/oZ12eaCvvqY3Fi9L
        9vqjDLrVGaBxTTIH6McYiwJqbI7dvqZASbptg4rV9duUbzvg8Zj0NXb2WURX8yZBAh1QFFNRAUCdt
        /YJH59b6+Ud6/VpYCBuNX40fduHG4PlZNBOiff+WTgJKhsq0RMmSi6pMqOScBn3ESf6++tEe5tYBM
        jIK9BIxDA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1VLn-0000qN-DG; Wed, 06 Mar 2019 12:08:43 +0000
Date:   Wed, 6 Mar 2019 04:08:43 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     LKP <lkp@01.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: 2264f5132f ("xarray: Add xas_create_range"):  watchdog: BUG:
 soft lockup - CPU#1 stuck for 22s! [swapper/0:1]
Message-ID: <20190306120843.GI13380@bombadil.infradead.org>
References: <5c7f75d7.NdpsgvpLDi1/MiHT%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c7f75d7.NdpsgvpLDi1/MiHT%lkp@intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 03:25:11PM +0800, kernel test robot wrote:
> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> commit 2264f5132fe45571139727ebdeb78696b35d1506
> Author:     Matthew Wilcox <willy@infradead.org>
> AuthorDate: Mon Dec 4 00:11:48 2017 -0500
> Commit:     Matthew Wilcox <willy@infradead.org>
> CommitDate: Sun Oct 21 10:45:59 2018 -0400
> 
>     xarray: Add xas_create_range

This is a bogus report caused by an overloaded test system.

> [   20.773777] test_uuid: all 18 tests passed
> [   46.091442] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [swapper/0:1]
> [   46.111602] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.19.0-rc5-00256-g2264f51 #1
> [   46.121589] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [   46.131615] EIP: arch_local_irq_restore+0x2/0x7
> [   46.141580] Code: 2d b2 00 75 13 68 6a fc e1 b1 68 e2 0e e1 b1 e8 5d 53 fd ff 0f 0b 58 5a c7 43 20 00 00 00 00 5b c3 9c 58 8d 74 26 00 c3 50 9d <8d> 74 26 00 c3 fa 90 8d 74 26 00 c3 fb 90 8d 74 26 00 c3 3d b0 2e
> [   46.171652] EAX: 00200206 EBX: 00200206 ECX: 00000000 EDX: 00200206
> [   46.181601] ESI: b231907c EDI: 00043eb8 EBP: b1f8b740 ESP: cdc31e34
> [   46.191592] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00200206
> [   46.201599] CR0: 80050033 CR2: ffffffff CR3: 0218c000 CR4: 00000690
> [   46.211554] Call Trace:
> [   46.211554]  ? _raw_spin_unlock_irqrestore+0xf/0x18
> [   46.221628]  ? debug_object_active_state+0xac/0xc6
> [   46.231606]  ? debug_rcu_head_queue+0x20/0x26
> [   46.231606]  ? __call_rcu+0x27/0x162
> [   46.241616]  ? radix_tree_node_ctor+0x19/0x19
> [   46.251605]  ? call_rcu_sched+0xc/0xe
> [   46.251605]  ? xas_free_nodes+0x64/0x73
> [   46.261587]  ? xas_store+0x11b/0x2bd
> [   46.271596]  ? __check_store_iter+0x143/0x26f
> [   46.271596]  ? check_store_iter+0x1a9/0x25c
> [   46.281606]  ? check_xas_retry+0x328/0x328
> [   46.291619]  ? xarray_checks+0x41/0x73
> [   46.301602]  ? do_one_initcall+0x62/0x132
> [   46.301602]  ? do_early_param+0x6c/0x6c
> [   46.311591]  ? kernel_init_freeable+0xdc/0x17b
> [   46.321601]  ? kernel_init_freeable+0xfe/0x17b
> [   46.321601]  ? rest_init+0x9c/0x9c
> [   46.331608]  ? kernel_init+0x5/0xd1
> [   46.341600]  ? ret_from_fork+0x19/0x24
> [   46.341600] Kernel panic - not syncing: softlockup: hung tasks
> [   46.351557] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G             L    4.19.0-rc5-00256-g2264f51 #1
> [   46.361587] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [   46.371629] Call Trace:
> [   46.381579]  ? dump_stack+0x52/0x66
> [   46.381579]  ? panic+0x93/0x1aa
> [   46.391564]  ? watchdog_timer_fn+0x1dc/0x1fd
> [   46.391564]  ? __hrtimer_run_queues+0xa3/0xe9
> [   46.401635]  ? softlockup_fn+0x25/0x25
> [   46.411624]  ? hrtimer_run_queues+0xc7/0xdb
> [   46.411624]  ? run_local_timers+0x12/0x36
> [   46.421599]  ? update_process_times+0x19/0x40
> [   46.431580]  ? tick_nohz_handler+0xaf/0xe9
> [   46.431580]  ? smp_apic_timer_interrupt+0x51/0x60
> [   46.442305]  ? apic_timer_interrupt+0xf8/0x100
> [   46.451611]  ? arch_local_irq_restore+0x2/0x7
> [   46.451611]  ? _raw_spin_unlock_irqrestore+0xf/0x18
> [   46.461659]  ? debug_object_active_state+0xac/0xc6
> [   46.471580]  ? debug_rcu_head_queue+0x20/0x26
> [   46.481588]  ? __call_rcu+0x27/0x162
> [   46.491506]  ? radix_tree_node_ctor+0x19/0x19
> [   46.491629]  ? call_rcu_sched+0xc/0xe
> [   46.501620]  ? xas_free_nodes+0x64/0x73
> [   46.501620]  ? xas_store+0x11b/0x2bd
> [   46.511630]  ? __check_store_iter+0x143/0x26f
> [   46.521609]  ? check_store_iter+0x1a9/0x25c
> [   46.531591]  ? check_xas_retry+0x328/0x328
> [   46.541597]  ? xarray_checks+0x41/0x73
> [   46.541597]  ? do_one_initcall+0x62/0x132
> [   46.551579]  ? do_early_param+0x6c/0x6c
> [   46.561494]  ? kernel_init_freeable+0xdc/0x17b
> [   46.561594]  ? kernel_init_freeable+0xfe/0x17b
> [   46.571616]  ? rest_init+0x9c/0x9c
> [   46.581628]  ? kernel_init+0x5/0xd1
> [   46.581628]  ? ret_from_fork+0x19/0x24
> [   46.591638] Kernel Offset: disabled
> 
> 
>                                                           # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
> git bisect start v4.20 v4.19 --
> git bisect  bad 1de4f2ef216dade3b5bd5f5247c4c750a953f51c  # 10:55  B     11     1   11  34  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace
> git bisect good 69d5b97c597307773fe6c59775a5d5a88bb7e6b3  # 11:20  G    150     0    0   0  HID: we do not randomly make new drivers 'default y'
> git bisect  bad b5b1de3537e2cd8f52971224a1be24bb3ce34a65  # 11:36  B     39     6   39  39  Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost
> git bisect  bad 6ef746769ef5cfef84cdfdf61ecbab5a6aa4651a  # 11:49  B     30     8   30  30  Merge tag 'pm-4.20-rc1-2' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> git bisect  bad fe675d4d3c6b96710d481346821839b4a817c672  # 12:01  B     38     6   38  38  Merge tag 'mailbox-v4.20' of git://git.linaro.org/landing-teams/working/fujitsu/integration
> git bisect  bad 9f51ae62c84a23ade0ba86457d30a30c9db0c50f  # 12:15  B     11     3   12  12  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
> git bisect  bad ac747c0715f29c2be3848b719a1b7e65b07f7b21  # 12:29  B     12     6   13  13  Merge tag 'kbuild-v4.20' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
> git bisect  bad dad4f140edaa3f6bb452b6913d41af1ffd672e45  # 12:51  B      4     2    4   4  Merge branch 'xarray' of git://git.infradead.org/users/willy/linux-dax
> git bisect  bad 77da9389b9d5f07d54fda092d1ab56002ec0019a  # 13:04  B     10     1    0   0  mm: Convert collapse_shmem to XArray
> git bisect  bad eb797a8ee0ab4cd03df556980ce7bf167cadaa50  # 13:14  B      1     1    0   0  page cache: Rearrange address_space
> git bisect good 41aec91f55985e7f14ee75fe2f6e7bcfff0d0fae  # 13:27  G    157     0    0   0  xarray: Add XArray conditional store operations
> git bisect good 4e99d4e9579d3b950bf4b38d0d64eb1b9be78761  # 13:40  G    152     0    0   0  xarray: Add xas_for_each_conflict
> git bisect  bad 3d5bd6e1a04ae779bc5e0de9ba2e92aa55c40fe8  # 13:52  B     99     3    0   0  xarray: Add MAINTAINERS entry
> git bisect  bad 9f14d4f1f1045f161fd4db8a8e194b7825c2874a  # 14:07  B      3     1    1   1  xarray: Add xa_reserve and xa_release
> git bisect  bad 2264f5132fe45571139727ebdeb78696b35d1506  # 14:18  B     42     2    2   2  xarray: Add xas_create_range
> # first bad commit: [2264f5132fe45571139727ebdeb78696b35d1506] xarray: Add xas_create_range
> git bisect good 4e99d4e9579d3b950bf4b38d0d64eb1b9be78761  # 14:33  G    815     0    0   0  xarray: Add xas_for_each_conflict
> # extra tests with debug options
> git bisect  bad 2264f5132fe45571139727ebdeb78696b35d1506  # 14:46  B      0     2   16   0  xarray: Add xas_create_range
> # extra tests on HEAD of linus/master
> git bisect  bad 63bdf4284c38a48af21745ceb148a087b190cd21  # 14:57  B      3    12    3   4  Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
> # extra tests on tree/branch linus/master
> git bisect  bad 3717f613f48df0222311f974cf8a06c8a6c97bae  # 15:13  B      3     3    1   1  Merge branch 'core-rcu-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> # extra tests on tree/branch linux-next/master
> git bisect  bad baf5a9d1f9b95eb97e9eb54932e20dbbf814771c  # 15:23  B     13     2    0   0  Add linux-next specific files for 20190305
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/lkp                          Intel Corporation


> #!/bin/bash
> 
> kernel=$1
> initrd=quantal-trinity-i386.cgz
> 
> wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/quantal/$initrd
> 
> kvm=(
> 	qemu-system-x86_64
> 	-enable-kvm
> 	-cpu kvm64
> 	-kernel $kernel
> 	-initrd $initrd
> 	-m 512
> 	-smp 2
> 	-device e1000,netdev=net0
> 	-netdev user,id=net0
> 	-boot order=nc
> 	-no-reboot
> 	-watchdog i6300esb
> 	-watchdog-action debug
> 	-rtc base=localtime
> 	-serial stdio
> 	-display none
> 	-monitor null
> )
> 
> append=(
> 	root=/dev/ram0
> 	hung_task_panic=1
> 	debug
> 	apic=debug
> 	sysrq_always_enabled
> 	rcupdate.rcu_cpu_stall_timeout=100
> 	net.ifnames=0
> 	printk.devkmsg=on
> 	panic=-1
> 	softlockup_panic=1
> 	nmi_watchdog=panic
> 	oops=panic
> 	load_ramdisk=2
> 	prompt_ramdisk=0
> 	drbd.minor_count=8
> 	systemd.log_level=err
> 	ignore_loglevel
> 	console=tty0
> 	earlyprintk=ttyS0,115200
> 	console=ttyS0,115200
> 	vga=normal
> 	rw
> 	drbd.minor_count=8
> 	rcuperf.shutdown=0
> )
> 
> "${kvm[@]}" -append "${append[*]}"

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/i386 4.19.0-rc5 Kernel Configuration
> #
> 
> #
> # Compiler: gcc-8 (Debian 8.2.0-21) 8.2.0
> #
> CONFIG_CC_IS_GCC=y
> CONFIG_GCC_VERSION=80200
> CONFIG_CLANG_VERSION=0
> CONFIG_CONSTRUCTORS=y
> CONFIG_IRQ_WORK=y
> CONFIG_BUILDTIME_EXTABLE_SORT=y
> CONFIG_THREAD_INFO_IN_TASK=y
> 
> #
> # General setup
> #
> CONFIG_INIT_ENV_ARG_LIMIT=32
> # CONFIG_COMPILE_TEST is not set
> CONFIG_LOCALVERSION=""
> CONFIG_LOCALVERSION_AUTO=y
> CONFIG_BUILD_SALT=""
> CONFIG_HAVE_KERNEL_GZIP=y
> CONFIG_HAVE_KERNEL_BZIP2=y
> CONFIG_HAVE_KERNEL_LZMA=y
> CONFIG_HAVE_KERNEL_XZ=y
> CONFIG_HAVE_KERNEL_LZO=y
> CONFIG_HAVE_KERNEL_LZ4=y
> # CONFIG_KERNEL_GZIP is not set
> CONFIG_KERNEL_BZIP2=y
> # CONFIG_KERNEL_LZMA is not set
> # CONFIG_KERNEL_XZ is not set
> # CONFIG_KERNEL_LZO is not set
> # CONFIG_KERNEL_LZ4 is not set
> CONFIG_DEFAULT_HOSTNAME="(none)"
> CONFIG_SYSVIPC=y
> CONFIG_SYSVIPC_SYSCTL=y
> # CONFIG_POSIX_MQUEUE is not set
> CONFIG_CROSS_MEMORY_ATTACH=y
> # CONFIG_USELIB is not set
> # CONFIG_AUDIT is not set
> CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> 
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_PROBE=y
> CONFIG_GENERIC_IRQ_SHOW=y
> CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
> CONFIG_GENERIC_PENDING_IRQ=y
> CONFIG_GENERIC_IRQ_MIGRATION=y
> CONFIG_GENERIC_IRQ_CHIP=y
> CONFIG_IRQ_DOMAIN=y
> CONFIG_IRQ_DOMAIN_HIERARCHY=y
> CONFIG_GENERIC_MSI_IRQ=y
> CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
> CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
> CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
> CONFIG_IRQ_FORCED_THREADING=y
> CONFIG_SPARSE_IRQ=y
> # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> CONFIG_CLOCKSOURCE_WATCHDOG=y
> CONFIG_ARCH_CLOCKSOURCE_DATA=y
> CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
> CONFIG_GENERIC_TIME_VSYSCALL=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
> CONFIG_GENERIC_CMOS_UPDATE=y
> 
> #
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=y
> CONFIG_NO_HZ_COMMON=y
> # CONFIG_HZ_PERIODIC is not set
> CONFIG_NO_HZ_IDLE=y
> CONFIG_NO_HZ=y
> # CONFIG_HIGH_RES_TIMERS is not set
> CONFIG_PREEMPT_NONE=y
> # CONFIG_PREEMPT_VOLUNTARY is not set
> # CONFIG_PREEMPT is not set
> CONFIG_PREEMPT_COUNT=y
> 
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_TICK_CPU_ACCOUNTING=y
> # CONFIG_IRQ_TIME_ACCOUNTING is not set
> CONFIG_BSD_PROCESS_ACCT=y
> # CONFIG_BSD_PROCESS_ACCT_V3 is not set
> # CONFIG_TASKSTATS is not set
> CONFIG_CPU_ISOLATION=y
> 
> #
> # RCU Subsystem
> #
> CONFIG_TREE_RCU=y
> CONFIG_RCU_EXPERT=y
> CONFIG_SRCU=y
> CONFIG_TREE_SRCU=y
> CONFIG_TASKS_RCU=y
> CONFIG_RCU_STALL_COMMON=y
> CONFIG_RCU_NEED_SEGCBLIST=y
> CONFIG_RCU_FANOUT=32
> CONFIG_RCU_FANOUT_LEAF=16
> CONFIG_RCU_FAST_NO_HZ=y
> # CONFIG_RCU_NOCB_CPU is not set
> CONFIG_BUILD_BIN2C=y
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> CONFIG_LOG_BUF_SHIFT=20
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
> CONFIG_CGROUPS=y
> # CONFIG_MEMCG is not set
> # CONFIG_CGROUP_SCHED is not set
> CONFIG_CGROUP_PIDS=y
> # CONFIG_CGROUP_RDMA is not set
> CONFIG_CGROUP_FREEZER=y
> # CONFIG_CPUSETS is not set
> CONFIG_CGROUP_DEVICE=y
> # CONFIG_CGROUP_CPUACCT is not set
> # CONFIG_CGROUP_PERF is not set
> CONFIG_CGROUP_DEBUG=y
> # CONFIG_NAMESPACES is not set
> # CONFIG_CHECKPOINT_RESTORE is not set
> # CONFIG_SCHED_AUTOGROUP is not set
> # CONFIG_SYSFS_DEPRECATED is not set
> CONFIG_RELAY=y
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE=""
> CONFIG_RD_GZIP=y
> CONFIG_RD_BZIP2=y
> CONFIG_RD_LZMA=y
> CONFIG_RD_XZ=y
> CONFIG_RD_LZO=y
> CONFIG_RD_LZ4=y
> # CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
> CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> CONFIG_SYSCTL=y
> CONFIG_ANON_INODES=y
> CONFIG_HAVE_UID16=y
> CONFIG_SYSCTL_EXCEPTION_TRACE=y
> CONFIG_HAVE_PCSPKR_PLATFORM=y
> CONFIG_BPF=y
> CONFIG_EXPERT=y
> # CONFIG_UID16 is not set
> CONFIG_MULTIUSER=y
> CONFIG_SGETMASK_SYSCALL=y
> CONFIG_SYSFS_SYSCALL=y
> # CONFIG_SYSCTL_SYSCALL is not set
> CONFIG_FHANDLE=y
> CONFIG_POSIX_TIMERS=y
> CONFIG_PRINTK=y
> CONFIG_PRINTK_NMI=y
> CONFIG_BUG=y
> CONFIG_PCSPKR_PLATFORM=y
> # CONFIG_BASE_FULL is not set
> CONFIG_FUTEX=y
> CONFIG_FUTEX_PI=y
> CONFIG_EPOLL=y
> CONFIG_SIGNALFD=y
> CONFIG_TIMERFD=y
> CONFIG_EVENTFD=y
> CONFIG_SHMEM=y
> CONFIG_AIO=y
> CONFIG_ADVISE_SYSCALLS=y
> CONFIG_MEMBARRIER=y
> CONFIG_KALLSYMS=y
> CONFIG_KALLSYMS_ALL=y
> CONFIG_KALLSYMS_BASE_RELATIVE=y
> # CONFIG_BPF_SYSCALL is not set
> CONFIG_USERFAULTFD=y
> CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
> CONFIG_RSEQ=y
> CONFIG_DEBUG_RSEQ=y
> CONFIG_EMBEDDED=y
> CONFIG_HAVE_PERF_EVENTS=y
> CONFIG_PC104=y
> 
> #
> # Kernel Performance Events And Counters
> #
> CONFIG_PERF_EVENTS=y
> # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> CONFIG_VM_EVENT_COUNTERS=y
> CONFIG_COMPAT_BRK=y
> # CONFIG_SLAB is not set
> # CONFIG_SLUB is not set
> CONFIG_SLOB=y
> CONFIG_SLAB_MERGE_DEFAULT=y
> # CONFIG_PROFILING is not set
> CONFIG_X86_32=y
> CONFIG_X86=y
> CONFIG_INSTRUCTION_DECODER=y
> CONFIG_OUTPUT_FORMAT="elf32-i386"
> CONFIG_ARCH_DEFCONFIG="arch/x86/configs/i386_defconfig"
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_MMU=y
> CONFIG_ARCH_MMAP_RND_BITS_MIN=8
> CONFIG_ARCH_MMAP_RND_BITS_MAX=16
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_GENERIC_BUG=y
> CONFIG_GENERIC_HWEIGHT=y
> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> CONFIG_RWSEM_XCHGADD_ALGORITHM=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_ARCH_HAS_CPU_RELAX=y
> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
> CONFIG_ARCH_HAS_FILTER_PGPROT=y
> CONFIG_HAVE_SETUP_PER_CPU_AREA=y
> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
> CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> CONFIG_ARCH_SUSPEND_POSSIBLE=y
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> CONFIG_X86_32_SMP=y
> CONFIG_ARCH_SUPPORTS_UPROBES=y
> CONFIG_FIX_EARLYCON_MEM=y
> CONFIG_PGTABLE_LEVELS=2
> CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
> 
> #
> # Processor type and features
> #
> CONFIG_ZONE_DMA=y
> CONFIG_SMP=y
> CONFIG_X86_FEATURE_NAMES=y
> CONFIG_X86_MPPARSE=y
> CONFIG_GOLDFISH=y
> # CONFIG_RETPOLINE is not set
> # CONFIG_INTEL_RDT is not set
> CONFIG_X86_BIGSMP=y
> CONFIG_X86_EXTENDED_PLATFORM=y
> # CONFIG_X86_GOLDFISH is not set
> CONFIG_X86_INTEL_CE=y
> # CONFIG_X86_INTEL_LPSS is not set
> # CONFIG_X86_AMD_PLATFORM_DEVICE is not set
> CONFIG_IOSF_MBI=y
> # CONFIG_IOSF_MBI_DEBUG is not set
> CONFIG_X86_RDC321X=y
> CONFIG_X86_32_NON_STANDARD=y
> CONFIG_STA2X11=y
> # CONFIG_X86_32_IRIS is not set
> # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
> CONFIG_HYPERVISOR_GUEST=y
> CONFIG_PARAVIRT=y
> # CONFIG_PARAVIRT_DEBUG is not set
> # CONFIG_PARAVIRT_SPINLOCKS is not set
> CONFIG_KVM_GUEST=y
> # CONFIG_KVM_DEBUG_FS is not set
> # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
> CONFIG_PARAVIRT_CLOCK=y
> CONFIG_NO_BOOTMEM=y
> # CONFIG_M486 is not set
> # CONFIG_M586 is not set
> # CONFIG_M586TSC is not set
> # CONFIG_M586MMX is not set
> # CONFIG_M686 is not set
> # CONFIG_MPENTIUMII is not set
> # CONFIG_MPENTIUMIII is not set
> # CONFIG_MPENTIUMM is not set
> CONFIG_MPENTIUM4=y
> # CONFIG_MK6 is not set
> # CONFIG_MK7 is not set
> # CONFIG_MK8 is not set
> # CONFIG_MCRUSOE is not set
> # CONFIG_MEFFICEON is not set
> # CONFIG_MWINCHIPC6 is not set
> # CONFIG_MWINCHIP3D is not set
> # CONFIG_MELAN is not set
> # CONFIG_MGEODEGX1 is not set
> # CONFIG_MGEODE_LX is not set
> # CONFIG_MCYRIXIII is not set
> # CONFIG_MVIAC3_2 is not set
> # CONFIG_MVIAC7 is not set
> # CONFIG_MCORE2 is not set
> # CONFIG_MATOM is not set
> CONFIG_X86_GENERIC=y
> CONFIG_X86_INTERNODE_CACHE_SHIFT=7
> CONFIG_X86_L1_CACHE_SHIFT=7
> CONFIG_X86_INTEL_USERCOPY=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> CONFIG_X86_TSC=y
> CONFIG_X86_CMPXCHG64=y
> CONFIG_X86_CMOV=y
> CONFIG_X86_MINIMUM_CPU_FAMILY=6
> CONFIG_X86_DEBUGCTLMSR=y
> # CONFIG_PROCESSOR_SELECT is not set
> CONFIG_CPU_SUP_INTEL=y
> CONFIG_CPU_SUP_CYRIX_32=y
> CONFIG_CPU_SUP_AMD=y
> CONFIG_CPU_SUP_CENTAUR=y
> CONFIG_CPU_SUP_TRANSMETA_32=y
> CONFIG_CPU_SUP_UMC_32=y
> CONFIG_HPET_TIMER=y
> CONFIG_HPET_EMULATE_RTC=y
> CONFIG_DMI=y
> CONFIG_NR_CPUS_RANGE_BEGIN=2
> CONFIG_NR_CPUS_RANGE_END=64
> CONFIG_NR_CPUS_DEFAULT=32
> CONFIG_NR_CPUS=32
> CONFIG_SCHED_SMT=y
> # CONFIG_SCHED_MC is not set
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
> # CONFIG_X86_MCE is not set
> 
> #
> # Performance monitoring
> #
> CONFIG_PERF_EVENTS_INTEL_UNCORE=y
> CONFIG_PERF_EVENTS_INTEL_RAPL=y
> CONFIG_PERF_EVENTS_INTEL_CSTATE=y
> CONFIG_PERF_EVENTS_AMD_POWER=y
> CONFIG_X86_LEGACY_VM86=y
> CONFIG_VM86=y
> # CONFIG_X86_16BIT is not set
> # CONFIG_TOSHIBA is not set
> CONFIG_I8K=y
> CONFIG_X86_REBOOTFIXUPS=y
> CONFIG_MICROCODE=y
> CONFIG_MICROCODE_INTEL=y
> CONFIG_MICROCODE_AMD=y
> CONFIG_MICROCODE_OLD_INTERFACE=y
> CONFIG_X86_MSR=y
> CONFIG_X86_CPUID=y
> # CONFIG_NOHIGHMEM is not set
> CONFIG_HIGHMEM4G=y
> # CONFIG_HIGHMEM64G is not set
> # CONFIG_VMSPLIT_3G is not set
> CONFIG_VMSPLIT_3G_OPT=y
> # CONFIG_VMSPLIT_2G is not set
> # CONFIG_VMSPLIT_2G_OPT is not set
> # CONFIG_VMSPLIT_1G is not set
> CONFIG_PAGE_OFFSET=0xB0000000
> CONFIG_HIGHMEM=y
> CONFIG_ARCH_HAS_MEM_ENCRYPT=y
> CONFIG_ARCH_FLATMEM_ENABLE=y
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> CONFIG_ILLEGAL_POINTER_VALUE=0
> # CONFIG_HIGHPTE is not set
> CONFIG_X86_CHECK_BIOS_CORRUPTION=y
> # CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
> CONFIG_X86_RESERVE_LOW=64
> CONFIG_MATH_EMULATION=y
> CONFIG_MTRR=y
> # CONFIG_MTRR_SANITIZER is not set
> # CONFIG_X86_PAT is not set
> CONFIG_ARCH_RANDOM=y
> CONFIG_X86_SMAP=y
> CONFIG_X86_INTEL_UMIP=y
> # CONFIG_EFI is not set
> CONFIG_SECCOMP=y
> # CONFIG_HZ_100 is not set
> # CONFIG_HZ_250 is not set
> CONFIG_HZ_300=y
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=300
> # CONFIG_KEXEC is not set
> # CONFIG_CRASH_DUMP is not set
> CONFIG_PHYSICAL_START=0x1000000
> # CONFIG_RELOCATABLE is not set
> CONFIG_PHYSICAL_ALIGN=0x200000
> CONFIG_HOTPLUG_CPU=y
> # CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
> CONFIG_DEBUG_HOTPLUG_CPU0=y
> CONFIG_COMPAT_VDSO=y
> # CONFIG_CMDLINE_BOOL is not set
> CONFIG_MODIFY_LDT_SYSCALL=y
> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> 
> #
> # Power management and ACPI options
> #
> # CONFIG_SUSPEND is not set
> # CONFIG_PM is not set
> CONFIG_ARCH_SUPPORTS_ACPI=y
> CONFIG_ACPI=y
> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
> # CONFIG_ACPI_DEBUGGER is not set
> CONFIG_ACPI_SPCR_TABLE=y
> # CONFIG_ACPI_PROCFS_POWER is not set
> CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
> # CONFIG_ACPI_EC_DEBUGFS is not set
> CONFIG_ACPI_AC=y
> CONFIG_ACPI_BATTERY=y
> CONFIG_ACPI_BUTTON=y
> CONFIG_ACPI_VIDEO=y
> CONFIG_ACPI_FAN=y
> # CONFIG_ACPI_DOCK is not set
> CONFIG_ACPI_CPU_FREQ_PSS=y
> CONFIG_ACPI_PROCESSOR_CSTATE=y
> CONFIG_ACPI_PROCESSOR_IDLE=y
> CONFIG_ACPI_PROCESSOR=y
> # CONFIG_ACPI_IPMI is not set
> CONFIG_ACPI_HOTPLUG_CPU=y
> # CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
> CONFIG_ACPI_THERMAL=y
> CONFIG_ACPI_CUSTOM_DSDT_FILE=""
> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
> CONFIG_ACPI_TABLE_UPGRADE=y
> # CONFIG_ACPI_DEBUG is not set
> # CONFIG_ACPI_PCI_SLOT is not set
> CONFIG_ACPI_CONTAINER=y
> CONFIG_ACPI_HOTPLUG_IOAPIC=y
> # CONFIG_ACPI_SBS is not set
> # CONFIG_ACPI_HED is not set
> # CONFIG_ACPI_CUSTOM_METHOD is not set
> # CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
> CONFIG_HAVE_ACPI_APEI=y
> CONFIG_HAVE_ACPI_APEI_NMI=y
> # CONFIG_ACPI_APEI is not set
> # CONFIG_DPTF_POWER is not set
> # CONFIG_PMIC_OPREGION is not set
> # CONFIG_ACPI_CONFIGFS is not set
> CONFIG_X86_PM_TIMER=y
> # CONFIG_SFI is not set
> 
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_GOV_ATTR_SET=y
> CONFIG_CPU_FREQ_GOV_COMMON=y
> CONFIG_CPU_FREQ_STAT=y
> # CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
> # CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> CONFIG_CPU_FREQ_GOV_USERSPACE=y
> CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> # CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set
> 
> #
> # CPU frequency scaling drivers
> #
> CONFIG_CPUFREQ_DT=y
> CONFIG_CPUFREQ_DT_PLATDEV=y
> CONFIG_X86_INTEL_PSTATE=y
> # CONFIG_X86_PCC_CPUFREQ is not set
> # CONFIG_X86_ACPI_CPUFREQ is not set
> # CONFIG_X86_POWERNOW_K6 is not set
> CONFIG_X86_POWERNOW_K7=y
> CONFIG_X86_POWERNOW_K7_ACPI=y
> CONFIG_X86_GX_SUSPMOD=y
> # CONFIG_X86_SPEEDSTEP_CENTRINO is not set
> CONFIG_X86_SPEEDSTEP_ICH=y
> # CONFIG_X86_SPEEDSTEP_SMI is not set
> CONFIG_X86_P4_CLOCKMOD=y
> CONFIG_X86_CPUFREQ_NFORCE2=y
> CONFIG_X86_LONGRUN=y
> # CONFIG_X86_LONGHAUL is not set
> # CONFIG_X86_E_POWERSAVER is not set
> 
> #
> # shared options
> #
> CONFIG_X86_SPEEDSTEP_LIB=y
> CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK=y
> 
> #
> # CPU Idle
> #
> CONFIG_CPU_IDLE=y
> CONFIG_CPU_IDLE_GOV_LADDER=y
> CONFIG_CPU_IDLE_GOV_MENU=y
> # CONFIG_INTEL_IDLE is not set
> 
> #
> # Bus options (PCI etc.)
> #
> CONFIG_PCI=y
> # CONFIG_PCI_GOBIOS is not set
> # CONFIG_PCI_GOMMCONFIG is not set
> CONFIG_PCI_GODIRECT=y
> # CONFIG_PCI_GOANY is not set
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_DOMAINS=y
> # CONFIG_PCI_CNB20LE_QUIRK is not set
> # CONFIG_PCIEPORTBUS is not set
> CONFIG_PCI_MSI=y
> CONFIG_PCI_MSI_IRQ_DOMAIN=y
> CONFIG_PCI_QUIRKS=y
> # CONFIG_PCI_DEBUG is not set
> CONFIG_PCI_REALLOC_ENABLE_AUTO=y
> CONFIG_PCI_STUB=y
> CONFIG_PCI_PF_STUB=y
> CONFIG_PCI_ATS=y
> CONFIG_PCI_ECAM=y
> CONFIG_PCI_LOCKLESS_CONFIG=y
> CONFIG_PCI_IOV=y
> CONFIG_PCI_PRI=y
> # CONFIG_PCI_PASID is not set
> CONFIG_PCI_LABEL=y
> CONFIG_HOTPLUG_PCI=y
> # CONFIG_HOTPLUG_PCI_ACPI is not set
> # CONFIG_HOTPLUG_PCI_CPCI is not set
> # CONFIG_HOTPLUG_PCI_SHPC is not set
> 
> #
> # PCI controller drivers
> #
> 
> #
> # Cadence PCIe controllers support
> #
> # CONFIG_PCIE_CADENCE_HOST is not set
> CONFIG_PCI_FTPCI100=y
> CONFIG_PCI_HOST_COMMON=y
> CONFIG_PCI_HOST_GENERIC=y
> CONFIG_PCIE_XILINX=y
> 
> #
> # DesignWare PCI Core Support
> #
> # CONFIG_PCIE_DW_PLAT_HOST is not set
> 
> #
> # PCI Endpoint
> #
> # CONFIG_PCI_ENDPOINT is not set
> 
> #
> # PCI switch controller drivers
> #
> CONFIG_PCI_SW_SWITCHTEC=y
> # CONFIG_ISA_BUS is not set
> CONFIG_ISA_DMA_API=y
> CONFIG_ISA=y
> # CONFIG_EISA is not set
> CONFIG_SCx200=y
> CONFIG_SCx200HR_TIMER=y
> # CONFIG_OLPC is not set
> CONFIG_ALIX=y
> CONFIG_NET5501=y
> # CONFIG_GEOS is not set
> CONFIG_AMD_NB=y
> CONFIG_PCCARD=y
> # CONFIG_PCMCIA is not set
> CONFIG_CARDBUS=y
> 
> #
> # PC-card bridges
> #
> # CONFIG_YENTA is not set
> CONFIG_PCMCIA_PROBE=y
> # CONFIG_RAPIDIO is not set
> # CONFIG_X86_SYSFB is not set
> 
> #
> # Binary Emulations
> #
> CONFIG_COMPAT_32=y
> CONFIG_HAVE_ATOMIC_IOMAP=y
> CONFIG_X86_DEV_DMA_OPS=y
> CONFIG_X86_DMA_REMAP=y
> CONFIG_HAVE_GENERIC_GUP=y
> 
> #
> # Firmware Drivers
> #
> # CONFIG_EDD is not set
> CONFIG_FIRMWARE_MEMMAP=y
> CONFIG_DELL_RBU=y
> CONFIG_DCDBAS=y
> # CONFIG_DMIID is not set
> # CONFIG_DMI_SYSFS is not set
> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
> # CONFIG_ISCSI_IBFT_FIND is not set
> # CONFIG_FW_CFG_SYSFS is not set
> # CONFIG_GOOGLE_FIRMWARE is not set
> 
> #
> # Tegra firmware driver
> #
> CONFIG_HAVE_KVM=y
> # CONFIG_VIRTUALIZATION is not set
> 
> #
> # General architecture-dependent options
> #
> CONFIG_CRASH_CORE=y
> CONFIG_HOTPLUG_SMT=y
> CONFIG_HAVE_OPROFILE=y
> CONFIG_OPROFILE_NMI_TIMER=y
> CONFIG_JUMP_LABEL=y
> # CONFIG_STATIC_KEYS_SELFTEST is not set
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> CONFIG_HAVE_IOREMAP_PROT=y
> CONFIG_HAVE_KPROBES=y
> CONFIG_HAVE_KRETPROBES=y
> CONFIG_HAVE_OPTPROBES=y
> CONFIG_HAVE_KPROBES_ON_FTRACE=y
> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
> CONFIG_HAVE_NMI=y
> CONFIG_HAVE_ARCH_TRACEHOOK=y
> CONFIG_HAVE_DMA_CONTIGUOUS=y
> CONFIG_GENERIC_SMP_IDLE_THREAD=y
> CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
> CONFIG_ARCH_HAS_SET_MEMORY=y
> CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> CONFIG_HAVE_RSEQ=y
> CONFIG_HAVE_CLK=y
> CONFIG_HAVE_HW_BREAKPOINT=y
> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
> CONFIG_HAVE_USER_RETURN_NOTIFIER=y
> CONFIG_HAVE_PERF_EVENTS_NMI=y
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_HAVE_PERF_REGS=y
> CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> CONFIG_HAVE_ARCH_JUMP_LABEL=y
> CONFIG_HAVE_RCU_TABLE_FREE=y
> CONFIG_HAVE_RCU_TABLE_INVALIDATE=y
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> CONFIG_HAVE_CMPXCHG_LOCAL=y
> CONFIG_HAVE_CMPXCHG_DOUBLE=y
> CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
> CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> CONFIG_SECCOMP_FILTER=y
> CONFIG_HAVE_STACKPROTECTOR=y
> CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
> CONFIG_STACKPROTECTOR=y
> CONFIG_STACKPROTECTOR_STRONG=y
> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> CONFIG_MODULES_USE_ELF_REL=y
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
> CONFIG_HAVE_EXIT_THREAD=y
> CONFIG_ARCH_MMAP_RND_BITS=8
> CONFIG_HAVE_COPY_THREAD_TLS=y
> CONFIG_ISA_BUS_API=y
> CONFIG_CLONE_BACKWARDS=y
> CONFIG_OLD_SIGSUSPEND3=y
> CONFIG_OLD_SIGACTION=y
> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
> CONFIG_STRICT_KERNEL_RWX=y
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
> CONFIG_ARCH_HAS_PHYS_TO_DMA=y
> CONFIG_ARCH_HAS_REFCOUNT=y
> CONFIG_REFCOUNT_FULL=y
> CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
> 
> #
> # GCOV-based kernel profiling
> #
> CONFIG_GCOV_KERNEL=y
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> # CONFIG_GCOV_PROFILE_ALL is not set
> CONFIG_GCOV_FORMAT_4_7=y
> CONFIG_PLUGIN_HOSTCC="g++"
> CONFIG_HAVE_GCC_PLUGINS=y
> # CONFIG_GCC_PLUGINS is not set
> CONFIG_RT_MUTEXES=y
> CONFIG_BASE_SMALL=1
> # CONFIG_MODULES is not set
> CONFIG_MODULES_TREE_LOOKUP=y
> # CONFIG_BLOCK is not set
> CONFIG_ASN1=y
> CONFIG_UNINLINE_SPIN_UNLOCK=y
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> CONFIG_MUTEX_SPIN_ON_OWNER=y
> CONFIG_RWSEM_SPIN_ON_OWNER=y
> CONFIG_LOCK_SPIN_ON_OWNER=y
> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
> CONFIG_QUEUED_SPINLOCKS=y
> CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
> CONFIG_QUEUED_RWLOCKS=y
> CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
> CONFIG_FREEZER=y
> 
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=y
> CONFIG_ELFCORE=y
> CONFIG_BINFMT_SCRIPT=y
> CONFIG_HAVE_AOUT=y
> CONFIG_BINFMT_AOUT=y
> # CONFIG_BINFMT_MISC is not set
> # CONFIG_COREDUMP is not set
> 
> #
> # Memory Management options
> #
> CONFIG_SELECT_MEMORY_MODEL=y
> CONFIG_FLATMEM_MANUAL=y
> # CONFIG_SPARSEMEM_MANUAL is not set
> CONFIG_FLATMEM=y
> CONFIG_FLAT_NODE_MEM_MAP=y
> CONFIG_SPARSEMEM_STATIC=y
> CONFIG_HAVE_MEMBLOCK=y
> CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
> CONFIG_ARCH_DISCARD_MEMBLOCK=y
> CONFIG_MEMORY_ISOLATION=y
> CONFIG_SPLIT_PTLOCK_CPUS=4
> CONFIG_MEMORY_BALLOON=y
> CONFIG_BALLOON_COMPACTION=y
> CONFIG_COMPACTION=y
> CONFIG_MIGRATION=y
> CONFIG_VIRT_TO_BUS=y
> CONFIG_MMU_NOTIFIER=y
> CONFIG_KSM=y
> CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> CONFIG_TRANSPARENT_HUGEPAGE=y
> # CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
> CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
> CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
> CONFIG_CLEANCACHE=y
> CONFIG_CMA=y
> # CONFIG_CMA_DEBUG is not set
> CONFIG_CMA_DEBUGFS=y
> CONFIG_CMA_AREAS=7
> CONFIG_ZPOOL=y
> CONFIG_ZBUD=y
> # CONFIG_Z3FOLD is not set
> CONFIG_ZSMALLOC=y
> CONFIG_PGTABLE_MAPPING=y
> # CONFIG_ZSMALLOC_STAT is not set
> CONFIG_GENERIC_EARLY_IOREMAP=y
> CONFIG_IDLE_PAGE_TRACKING=y
> CONFIG_PERCPU_STATS=y
> # CONFIG_GUP_BENCHMARK is not set
> CONFIG_ARCH_HAS_PTE_SPECIAL=y
> CONFIG_NET=y
> 
> #
> # Networking options
> #
> # CONFIG_PACKET is not set
> CONFIG_UNIX=y
> # CONFIG_UNIX_DIAG is not set
> # CONFIG_TLS is not set
> CONFIG_XFRM=y
> # CONFIG_XFRM_USER is not set
> # CONFIG_XFRM_INTERFACE is not set
> # CONFIG_XFRM_SUB_POLICY is not set
> # CONFIG_XFRM_MIGRATE is not set
> # CONFIG_XFRM_STATISTICS is not set
> # CONFIG_NET_KEY is not set
> CONFIG_INET=y
> # CONFIG_IP_MULTICAST is not set
> # CONFIG_IP_ADVANCED_ROUTER is not set
> CONFIG_IP_PNP=y
> CONFIG_IP_PNP_DHCP=y
> # CONFIG_IP_PNP_BOOTP is not set
> # CONFIG_IP_PNP_RARP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE_DEMUX is not set
> CONFIG_NET_IP_TUNNEL=y
> # CONFIG_SYN_COOKIES is not set
> # CONFIG_NET_IPVTI is not set
> # CONFIG_NET_FOU is not set
> # CONFIG_NET_FOU_IP_TUNNELS is not set
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
> CONFIG_INET_TUNNEL=y
> CONFIG_INET_XFRM_MODE_TRANSPORT=y
> CONFIG_INET_XFRM_MODE_TUNNEL=y
> CONFIG_INET_XFRM_MODE_BEET=y
> CONFIG_INET_DIAG=y
> CONFIG_INET_TCP_DIAG=y
> # CONFIG_INET_UDP_DIAG is not set
> # CONFIG_INET_RAW_DIAG is not set
> # CONFIG_INET_DIAG_DESTROY is not set
> # CONFIG_TCP_CONG_ADVANCED is not set
> CONFIG_TCP_CONG_CUBIC=y
> CONFIG_DEFAULT_TCP_CONG="cubic"
> # CONFIG_TCP_MD5SIG is not set
> CONFIG_IPV6=y
> # CONFIG_IPV6_ROUTER_PREF is not set
> # CONFIG_IPV6_OPTIMISTIC_DAD is not set
> # CONFIG_INET6_AH is not set
> # CONFIG_INET6_ESP is not set
> # CONFIG_INET6_IPCOMP is not set
> # CONFIG_IPV6_MIP6 is not set
> CONFIG_INET6_XFRM_MODE_TRANSPORT=y
> CONFIG_INET6_XFRM_MODE_TUNNEL=y
> CONFIG_INET6_XFRM_MODE_BEET=y
> # CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
> # CONFIG_IPV6_VTI is not set
> CONFIG_IPV6_SIT=y
> # CONFIG_IPV6_SIT_6RD is not set
> CONFIG_IPV6_NDISC_NODETYPE=y
> # CONFIG_IPV6_TUNNEL is not set
> # CONFIG_IPV6_MULTIPLE_TABLES is not set
> # CONFIG_IPV6_MROUTE is not set
> # CONFIG_IPV6_SEG6_LWTUNNEL is not set
> # CONFIG_IPV6_SEG6_HMAC is not set
> # CONFIG_NETLABEL is not set
> # CONFIG_NETWORK_SECMARK is not set
> CONFIG_NET_PTP_CLASSIFY=y
> # CONFIG_NETWORK_PHY_TIMESTAMPING is not set
> # CONFIG_NETFILTER is not set
> # CONFIG_BPFILTER is not set
> # CONFIG_IP_DCCP is not set
> # CONFIG_IP_SCTP is not set
> # CONFIG_RDS is not set
> # CONFIG_TIPC is not set
> # CONFIG_ATM is not set
> # CONFIG_L2TP is not set
> # CONFIG_BRIDGE is not set
> CONFIG_HAVE_NET_DSA=y
> # CONFIG_NET_DSA is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_DECNET is not set
> # CONFIG_LLC2 is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_PHONET is not set
> # CONFIG_6LOWPAN is not set
> # CONFIG_IEEE802154 is not set
> # CONFIG_NET_SCHED is not set
> # CONFIG_DCB is not set
> CONFIG_DNS_RESOLVER=y
> # CONFIG_BATMAN_ADV is not set
> # CONFIG_OPENVSWITCH is not set
> # CONFIG_VSOCKETS is not set
> # CONFIG_NETLINK_DIAG is not set
> # CONFIG_MPLS is not set
> # CONFIG_NET_NSH is not set
> # CONFIG_HSR is not set
> # CONFIG_NET_SWITCHDEV is not set
> # CONFIG_NET_L3_MASTER_DEV is not set
> # CONFIG_NET_NCSI is not set
> CONFIG_RPS=y
> CONFIG_RFS_ACCEL=y
> CONFIG_XPS=y
> # CONFIG_CGROUP_NET_PRIO is not set
> # CONFIG_CGROUP_NET_CLASSID is not set
> CONFIG_NET_RX_BUSY_POLL=y
> CONFIG_BQL=y
> CONFIG_NET_FLOW_LIMIT=y
> 
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> # CONFIG_HAMRADIO is not set
> # CONFIG_CAN is not set
> # CONFIG_BT is not set
> # CONFIG_AF_RXRPC is not set
> # CONFIG_AF_KCM is not set
> CONFIG_WIRELESS=y
> # CONFIG_CFG80211 is not set
> 
> #
> # CFG80211 needs to be enabled for MAC80211
> #
> CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
> # CONFIG_WIMAX is not set
> # CONFIG_RFKILL is not set
> CONFIG_NET_9P=y
> CONFIG_NET_9P_VIRTIO=y
> # CONFIG_NET_9P_DEBUG is not set
> # CONFIG_CAIF is not set
> # CONFIG_CEPH_LIB is not set
> # CONFIG_NFC is not set
> # CONFIG_PSAMPLE is not set
> # CONFIG_NET_IFE is not set
> # CONFIG_LWTUNNEL is not set
> CONFIG_DST_CACHE=y
> CONFIG_GRO_CELLS=y
> # CONFIG_NET_DEVLINK is not set
> CONFIG_MAY_USE_DEVLINK=y
> # CONFIG_FAILOVER is not set
> CONFIG_HAVE_EBPF_JIT=y
> 
> #
> # Device Drivers
> #
> 
> #
> # Generic Driver Options
> #
> CONFIG_UEVENT_HELPER=y
> CONFIG_UEVENT_HELPER_PATH=""
> CONFIG_DEVTMPFS=y
> CONFIG_DEVTMPFS_MOUNT=y
> # CONFIG_STANDALONE is not set
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> 
> #
> # Firmware loader
> #
> CONFIG_FW_LOADER=y
> CONFIG_EXTRA_FIRMWARE=""
> CONFIG_FW_LOADER_USER_HELPER=y
> # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
> CONFIG_ALLOW_DEV_COREDUMP=y
> # CONFIG_DEBUG_DRIVER is not set
> # CONFIG_DEBUG_DEVRES is not set
> CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
> CONFIG_GENERIC_CPU_AUTOPROBE=y
> CONFIG_GENERIC_CPU_VULNERABILITIES=y
> CONFIG_REGMAP=y
> CONFIG_REGMAP_I2C=y
> CONFIG_REGMAP_SPI=y
> CONFIG_REGMAP_W1=y
> CONFIG_REGMAP_MMIO=y
> CONFIG_REGMAP_IRQ=y
> CONFIG_DMA_SHARED_BUFFER=y
> # CONFIG_DMA_FENCE_TRACE is not set
> # CONFIG_DMA_CMA is not set
> 
> #
> # Bus devices
> #
> # CONFIG_CONNECTOR is not set
> # CONFIG_GNSS is not set
> CONFIG_MTD=y
> CONFIG_MTD_REDBOOT_PARTS=y
> CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
> # CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
> # CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
> CONFIG_MTD_CMDLINE_PARTS=y
> CONFIG_MTD_OF_PARTS=y
> CONFIG_MTD_AR7_PARTS=y
> 
> #
> # Partition parsers
> #
> 
> #
> # User Modules And Translation Layers
> #
> # CONFIG_MTD_OOPS is not set
> # CONFIG_MTD_PARTITIONED_MASTER is not set
> 
> #
> # RAM/ROM/Flash chip drivers
> #
> CONFIG_MTD_CFI=y
> CONFIG_MTD_JEDECPROBE=y
> CONFIG_MTD_GEN_PROBE=y
> CONFIG_MTD_CFI_ADV_OPTIONS=y
> # CONFIG_MTD_CFI_NOSWAP is not set
> CONFIG_MTD_CFI_BE_BYTE_SWAP=y
> # CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
> # CONFIG_MTD_CFI_GEOMETRY is not set
> CONFIG_MTD_MAP_BANK_WIDTH_1=y
> CONFIG_MTD_MAP_BANK_WIDTH_2=y
> CONFIG_MTD_MAP_BANK_WIDTH_4=y
> CONFIG_MTD_CFI_I1=y
> CONFIG_MTD_CFI_I2=y
> # CONFIG_MTD_OTP is not set
> CONFIG_MTD_CFI_INTELEXT=y
> CONFIG_MTD_CFI_AMDSTD=y
> CONFIG_MTD_CFI_STAA=y
> CONFIG_MTD_CFI_UTIL=y
> CONFIG_MTD_RAM=y
> CONFIG_MTD_ROM=y
> # CONFIG_MTD_ABSENT is not set
> 
> #
> # Mapping drivers for chip access
> #
> # CONFIG_MTD_COMPLEX_MAPPINGS is not set
> CONFIG_MTD_PHYSMAP=y
> CONFIG_MTD_PHYSMAP_COMPAT=y
> CONFIG_MTD_PHYSMAP_START=0x8000000
> CONFIG_MTD_PHYSMAP_LEN=0
> CONFIG_MTD_PHYSMAP_BANKWIDTH=2
> CONFIG_MTD_PHYSMAP_OF=y
> # CONFIG_MTD_PHYSMAP_OF_VERSATILE is not set
> # CONFIG_MTD_PHYSMAP_OF_GEMINI is not set
> # CONFIG_MTD_SCx200_DOCFLASH is not set
> # CONFIG_MTD_AMD76XROM is not set
> # CONFIG_MTD_ICHXROM is not set
> CONFIG_MTD_ESB2ROM=y
> CONFIG_MTD_CK804XROM=y
> CONFIG_MTD_SCB2_FLASH=y
> # CONFIG_MTD_NETtel is not set
> # CONFIG_MTD_L440GX is not set
> # CONFIG_MTD_INTEL_VR_NOR is not set
> CONFIG_MTD_PLATRAM=y
> 
> #
> # Self-contained MTD device drivers
> #
> CONFIG_MTD_PMC551=y
> # CONFIG_MTD_PMC551_BUGFIX is not set
> # CONFIG_MTD_PMC551_DEBUG is not set
> CONFIG_MTD_DATAFLASH=y
> CONFIG_MTD_DATAFLASH_WRITE_VERIFY=y
> CONFIG_MTD_DATAFLASH_OTP=y
> CONFIG_MTD_MCHP23K256=y
> CONFIG_MTD_SST25L=y
> # CONFIG_MTD_SLRAM is not set
> CONFIG_MTD_PHRAM=y
> # CONFIG_MTD_MTDRAM is not set
> 
> #
> # Disk-On-Chip Device Drivers
> #
> # CONFIG_MTD_DOCG3 is not set
> CONFIG_MTD_ONENAND=y
> # CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
> CONFIG_MTD_ONENAND_GENERIC=y
> CONFIG_MTD_ONENAND_OTP=y
> CONFIG_MTD_ONENAND_2X_PROGRAM=y
> CONFIG_MTD_NAND_ECC=y
> CONFIG_MTD_NAND_ECC_SMC=y
> CONFIG_MTD_NAND=y
> CONFIG_MTD_NAND_BCH=y
> CONFIG_MTD_NAND_ECC_BCH=y
> CONFIG_MTD_SM_COMMON=y
> CONFIG_MTD_NAND_DENALI=y
> # CONFIG_MTD_NAND_DENALI_PCI is not set
> CONFIG_MTD_NAND_DENALI_DT=y
> CONFIG_MTD_NAND_GPIO=y
> CONFIG_MTD_NAND_RICOH=y
> CONFIG_MTD_NAND_DISKONCHIP=y
> # CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
> CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
> # CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE is not set
> # CONFIG_MTD_NAND_DOCG4 is not set
> CONFIG_MTD_NAND_CAFE=y
> CONFIG_MTD_NAND_CS553X=y
> # CONFIG_MTD_NAND_NANDSIM is not set
> # CONFIG_MTD_NAND_PLATFORM is not set
> # CONFIG_MTD_SPI_NAND is not set
> 
> #
> # LPDDR & LPDDR2 PCM memory drivers
> #
> CONFIG_MTD_LPDDR=y
> CONFIG_MTD_QINFO_PROBE=y
> # CONFIG_MTD_SPI_NOR is not set
> CONFIG_MTD_UBI=y
> CONFIG_MTD_UBI_WL_THRESHOLD=4096
> CONFIG_MTD_UBI_BEB_LIMIT=20
> CONFIG_MTD_UBI_FASTMAP=y
> CONFIG_MTD_UBI_GLUEBI=y
> CONFIG_DTC=y
> CONFIG_OF=y
> CONFIG_OF_UNITTEST=y
> CONFIG_OF_FLATTREE=y
> CONFIG_OF_EARLY_FLATTREE=y
> CONFIG_OF_KOBJ=y
> CONFIG_OF_DYNAMIC=y
> CONFIG_OF_ADDRESS=y
> CONFIG_OF_IRQ=y
> CONFIG_OF_NET=y
> CONFIG_OF_MDIO=y
> CONFIG_OF_RESOLVE=y
> # CONFIG_OF_OVERLAY is not set
> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> # CONFIG_PARPORT is not set
> CONFIG_PNP=y
> CONFIG_PNP_DEBUG_MESSAGES=y
> 
> #
> # Protocols
> #
> # CONFIG_ISAPNP is not set
> # CONFIG_PNPBIOS is not set
> CONFIG_PNPACPI=y
> 
> #
> # NVME Support
> #
> 
> #
> # Misc devices
> #
> CONFIG_SENSORS_LIS3LV02D=y
> # CONFIG_AD525X_DPOT is not set
> # CONFIG_DUMMY_IRQ is not set
> # CONFIG_IBM_ASM is not set
> # CONFIG_PHANTOM is not set
> CONFIG_SGI_IOC4=y
> CONFIG_TIFM_CORE=y
> CONFIG_TIFM_7XX1=y
> CONFIG_ICS932S401=y
> CONFIG_ENCLOSURE_SERVICES=y
> CONFIG_CS5535_MFGPT=y
> CONFIG_CS5535_MFGPT_DEFAULT_IRQ=7
> CONFIG_CS5535_CLOCK_EVENT_SRC=y
> CONFIG_HP_ILO=y
> # CONFIG_APDS9802ALS is not set
> # CONFIG_ISL29003 is not set
> CONFIG_ISL29020=y
> CONFIG_SENSORS_TSL2550=y
> CONFIG_SENSORS_BH1770=y
> # CONFIG_SENSORS_APDS990X is not set
> CONFIG_HMC6352=y
> CONFIG_DS1682=y
> # CONFIG_VMWARE_BALLOON is not set
> CONFIG_PCH_PHUB=y
> CONFIG_USB_SWITCH_FSA9480=y
> CONFIG_LATTICE_ECP3_CONFIG=y
> # CONFIG_SRAM is not set
> CONFIG_PCI_ENDPOINT_TEST=y
> CONFIG_MISC_RTSX=y
> CONFIG_C2PORT=y
> CONFIG_C2PORT_DURAMAR_2150=y
> 
> #
> # EEPROM support
> #
> # CONFIG_EEPROM_AT24 is not set
> # CONFIG_EEPROM_AT25 is not set
> CONFIG_EEPROM_LEGACY=y
> # CONFIG_EEPROM_MAX6875 is not set
> CONFIG_EEPROM_93CX6=y
> CONFIG_EEPROM_93XX46=y
> CONFIG_EEPROM_IDT_89HPESX=y
> CONFIG_CB710_CORE=y
> CONFIG_CB710_DEBUG=y
> CONFIG_CB710_DEBUG_ASSUMPTIONS=y
> 
> #
> # Texas Instruments shared transport line discipline
> #
> # CONFIG_TI_ST is not set
> CONFIG_SENSORS_LIS3_I2C=y
> # CONFIG_ALTERA_STAPL is not set
> CONFIG_INTEL_MEI=y
> CONFIG_INTEL_MEI_ME=y
> CONFIG_INTEL_MEI_TXE=y
> CONFIG_VMWARE_VMCI=y
> 
> #
> # Intel MIC & related support
> #
> 
> #
> # Intel MIC Bus Driver
> #
> 
> #
> # SCIF Bus Driver
> #
> 
> #
> # VOP Bus Driver
> #
> 
> #
> # Intel MIC Host Driver
> #
> 
> #
> # Intel MIC Card Driver
> #
> 
> #
> # SCIF Driver
> #
> 
> #
> # Intel MIC Coprocessor State Management (COSM) Drivers
> #
> 
> #
> # VOP Driver
> #
> CONFIG_ECHO=y
> CONFIG_MISC_RTSX_PCI=y
> CONFIG_HAVE_IDE=y
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=y
> # CONFIG_FUSION is not set
> 
> #
> # IEEE 1394 (FireWire) support
> #
> CONFIG_FIREWIRE=y
> CONFIG_FIREWIRE_OHCI=y
> # CONFIG_FIREWIRE_NET is not set
> CONFIG_FIREWIRE_NOSY=y
> CONFIG_MACINTOSH_DRIVERS=y
> # CONFIG_MAC_EMUMOUSEBTN is not set
> CONFIG_NETDEVICES=y
> CONFIG_NET_CORE=y
> # CONFIG_BONDING is not set
> # CONFIG_DUMMY is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_NET_TEAM is not set
> # CONFIG_MACVLAN is not set
> # CONFIG_VXLAN is not set
> # CONFIG_MACSEC is not set
> # CONFIG_NETCONSOLE is not set
> # CONFIG_NTB_NETDEV is not set
> # CONFIG_TUN is not set
> # CONFIG_TUN_VNET_CROSS_LE is not set
> # CONFIG_VETH is not set
> # CONFIG_VIRTIO_NET is not set
> # CONFIG_NLMON is not set
> # CONFIG_ARCNET is not set
> 
> #
> # CAIF transport drivers
> #
> 
> #
> # Distributed Switch Architecture drivers
> #
> CONFIG_ETHERNET=y
> CONFIG_MDIO=y
> CONFIG_NET_VENDOR_3COM=y
> # CONFIG_EL3 is not set
> # CONFIG_3C515 is not set
> # CONFIG_VORTEX is not set
> # CONFIG_TYPHOON is not set
> CONFIG_NET_VENDOR_ADAPTEC=y
> # CONFIG_ADAPTEC_STARFIRE is not set
> CONFIG_NET_VENDOR_AGERE=y
> # CONFIG_ET131X is not set
> CONFIG_NET_VENDOR_ALACRITECH=y
> # CONFIG_SLICOSS is not set
> CONFIG_NET_VENDOR_ALTEON=y
> # CONFIG_ACENIC is not set
> # CONFIG_ALTERA_TSE is not set
> CONFIG_NET_VENDOR_AMAZON=y
> # CONFIG_ENA_ETHERNET is not set
> CONFIG_NET_VENDOR_AMD=y
> # CONFIG_AMD8111_ETH is not set
> # CONFIG_LANCE is not set
> # CONFIG_PCNET32 is not set
> # CONFIG_NI65 is not set
> # CONFIG_AMD_XGBE is not set
> CONFIG_NET_VENDOR_AQUANTIA=y
> CONFIG_NET_VENDOR_ARC=y
> CONFIG_NET_VENDOR_ATHEROS=y
> # CONFIG_ATL2 is not set
> # CONFIG_ATL1 is not set
> # CONFIG_ATL1E is not set
> # CONFIG_ATL1C is not set
> # CONFIG_ALX is not set
> CONFIG_NET_VENDOR_AURORA=y
> # CONFIG_AURORA_NB8800 is not set
> CONFIG_NET_VENDOR_BROADCOM=y
> # CONFIG_B44 is not set
> # CONFIG_BCMGENET is not set
> # CONFIG_BNX2 is not set
> # CONFIG_CNIC is not set
> # CONFIG_TIGON3 is not set
> # CONFIG_BNX2X is not set
> # CONFIG_SYSTEMPORT is not set
> # CONFIG_BNXT is not set
> CONFIG_NET_VENDOR_BROCADE=y
> # CONFIG_BNA is not set
> CONFIG_NET_VENDOR_CADENCE=y
> # CONFIG_MACB is not set
> CONFIG_NET_VENDOR_CAVIUM=y
> CONFIG_NET_VENDOR_CHELSIO=y
> # CONFIG_CHELSIO_T1 is not set
> # CONFIG_CHELSIO_T3 is not set
> # CONFIG_CHELSIO_T4 is not set
> # CONFIG_CHELSIO_T4VF is not set
> CONFIG_NET_VENDOR_CIRRUS=y
> # CONFIG_CS89x0 is not set
> CONFIG_NET_VENDOR_CISCO=y
> # CONFIG_ENIC is not set
> CONFIG_NET_VENDOR_CORTINA=y
> # CONFIG_GEMINI_ETHERNET is not set
> # CONFIG_CX_ECAT is not set
> # CONFIG_DNET is not set
> CONFIG_NET_VENDOR_DEC=y
> # CONFIG_NET_TULIP is not set
> CONFIG_NET_VENDOR_DLINK=y
> # CONFIG_DL2K is not set
> # CONFIG_SUNDANCE is not set
> CONFIG_NET_VENDOR_EMULEX=y
> # CONFIG_BE2NET is not set
> CONFIG_NET_VENDOR_EZCHIP=y
> # CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
> CONFIG_NET_VENDOR_HP=y
> # CONFIG_HP100 is not set
> CONFIG_NET_VENDOR_HUAWEI=y
> # CONFIG_HINIC is not set
> CONFIG_NET_VENDOR_I825XX=y
> CONFIG_NET_VENDOR_INTEL=y
> # CONFIG_E100 is not set
> CONFIG_E1000=y
> CONFIG_E1000E=y
> CONFIG_E1000E_HWTS=y
> CONFIG_IGB=y
> CONFIG_IGB_HWMON=y
> # CONFIG_IGBVF is not set
> # CONFIG_IXGB is not set
> CONFIG_IXGBE=y
> CONFIG_IXGBE_HWMON=y
> # CONFIG_IXGBEVF is not set
> # CONFIG_I40E is not set
> # CONFIG_I40EVF is not set
> # CONFIG_ICE is not set
> # CONFIG_FM10K is not set
> # CONFIG_JME is not set
> CONFIG_NET_VENDOR_MARVELL=y
> # CONFIG_MVMDIO is not set
> # CONFIG_SKGE is not set
> # CONFIG_SKY2 is not set
> CONFIG_NET_VENDOR_MELLANOX=y
> # CONFIG_MLX4_EN is not set
> # CONFIG_MLX5_CORE is not set
> # CONFIG_MLXSW_CORE is not set
> # CONFIG_MLXFW is not set
> CONFIG_NET_VENDOR_MICREL=y
> # CONFIG_KS8851 is not set
> # CONFIG_KS8851_MLL is not set
> # CONFIG_KSZ884X_PCI is not set
> CONFIG_NET_VENDOR_MICROCHIP=y
> # CONFIG_ENC28J60 is not set
> # CONFIG_ENCX24J600 is not set
> # CONFIG_LAN743X is not set
> CONFIG_NET_VENDOR_MICROSEMI=y
> CONFIG_NET_VENDOR_MYRI=y
> # CONFIG_MYRI10GE is not set
> # CONFIG_FEALNX is not set
> CONFIG_NET_VENDOR_NATSEMI=y
> # CONFIG_NATSEMI is not set
> # CONFIG_NS83820 is not set
> CONFIG_NET_VENDOR_NETERION=y
> # CONFIG_S2IO is not set
> # CONFIG_VXGE is not set
> CONFIG_NET_VENDOR_NETRONOME=y
> # CONFIG_NFP is not set
> CONFIG_NET_VENDOR_NI=y
> CONFIG_NET_VENDOR_8390=y
> # CONFIG_NE2000 is not set
> # CONFIG_NE2K_PCI is not set
> # CONFIG_ULTRA is not set
> # CONFIG_WD80x3 is not set
> CONFIG_NET_VENDOR_NVIDIA=y
> # CONFIG_FORCEDETH is not set
> CONFIG_NET_VENDOR_OKI=y
> # CONFIG_PCH_GBE is not set
> # CONFIG_ETHOC is not set
> CONFIG_NET_VENDOR_PACKET_ENGINES=y
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> CONFIG_NET_VENDOR_QLOGIC=y
> # CONFIG_QLA3XXX is not set
> # CONFIG_QLCNIC is not set
> # CONFIG_QLGE is not set
> # CONFIG_NETXEN_NIC is not set
> # CONFIG_QED is not set
> CONFIG_NET_VENDOR_QUALCOMM=y
> # CONFIG_QCA7000_SPI is not set
> # CONFIG_QCOM_EMAC is not set
> # CONFIG_RMNET is not set
> CONFIG_NET_VENDOR_RDC=y
> # CONFIG_R6040 is not set
> CONFIG_NET_VENDOR_REALTEK=y
> # CONFIG_8139CP is not set
> # CONFIG_8139TOO is not set
> # CONFIG_R8169 is not set
> CONFIG_NET_VENDOR_RENESAS=y
> CONFIG_NET_VENDOR_ROCKER=y
> CONFIG_NET_VENDOR_SAMSUNG=y
> # CONFIG_SXGBE_ETH is not set
> CONFIG_NET_VENDOR_SEEQ=y
> CONFIG_NET_VENDOR_SOLARFLARE=y
> # CONFIG_SFC is not set
> # CONFIG_SFC_FALCON is not set
> CONFIG_NET_VENDOR_SILAN=y
> # CONFIG_SC92031 is not set
> CONFIG_NET_VENDOR_SIS=y
> # CONFIG_SIS900 is not set
> # CONFIG_SIS190 is not set
> CONFIG_NET_VENDOR_SMSC=y
> # CONFIG_SMC9194 is not set
> # CONFIG_EPIC100 is not set
> # CONFIG_SMSC911X is not set
> # CONFIG_SMSC9420 is not set
> CONFIG_NET_VENDOR_SOCIONEXT=y
> CONFIG_NET_VENDOR_STMICRO=y
> # CONFIG_STMMAC_ETH is not set
> CONFIG_NET_VENDOR_SUN=y
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> # CONFIG_CASSINI is not set
> # CONFIG_NIU is not set
> CONFIG_NET_VENDOR_SYNOPSYS=y
> # CONFIG_DWC_XLGMAC is not set
> CONFIG_NET_VENDOR_TEHUTI=y
> # CONFIG_TEHUTI is not set
> CONFIG_NET_VENDOR_TI=y
> # CONFIG_TI_CPSW_ALE is not set
> # CONFIG_TLAN is not set
> CONFIG_NET_VENDOR_VIA=y
> # CONFIG_VIA_RHINE is not set
> # CONFIG_VIA_VELOCITY is not set
> CONFIG_NET_VENDOR_WIZNET=y
> # CONFIG_WIZNET_W5100 is not set
> # CONFIG_WIZNET_W5300 is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_NET_SB1000 is not set
> CONFIG_MDIO_DEVICE=y
> CONFIG_MDIO_BUS=y
> # CONFIG_MDIO_BCM_UNIMAC is not set
> # CONFIG_MDIO_BITBANG is not set
> # CONFIG_MDIO_BUS_MUX_GPIO is not set
> # CONFIG_MDIO_BUS_MUX_MMIOREG is not set
> # CONFIG_MDIO_HISI_FEMAC is not set
> # CONFIG_MDIO_MSCC_MIIM is not set
> CONFIG_PHYLIB=y
> CONFIG_SWPHY=y
> # CONFIG_LED_TRIGGER_PHY is not set
> 
> #
> # MII PHY device drivers
> #
> # CONFIG_AMD_PHY is not set
> # CONFIG_AQUANTIA_PHY is not set
> # CONFIG_ASIX_PHY is not set
> # CONFIG_AT803X_PHY is not set
> # CONFIG_BCM7XXX_PHY is not set
> # CONFIG_BCM87XX_PHY is not set
> # CONFIG_BROADCOM_PHY is not set
> # CONFIG_CICADA_PHY is not set
> # CONFIG_CORTINA_PHY is not set
> # CONFIG_DAVICOM_PHY is not set
> # CONFIG_DP83822_PHY is not set
> # CONFIG_DP83TC811_PHY is not set
> # CONFIG_DP83848_PHY is not set
> # CONFIG_DP83867_PHY is not set
> CONFIG_FIXED_PHY=y
> # CONFIG_ICPLUS_PHY is not set
> # CONFIG_INTEL_XWAY_PHY is not set
> # CONFIG_LSI_ET1011C_PHY is not set
> # CONFIG_LXT_PHY is not set
> # CONFIG_MARVELL_PHY is not set
> # CONFIG_MARVELL_10G_PHY is not set
> # CONFIG_MICREL_PHY is not set
> # CONFIG_MICROCHIP_PHY is not set
> # CONFIG_MICROCHIP_T1_PHY is not set
> # CONFIG_MICROSEMI_PHY is not set
> # CONFIG_NATIONAL_PHY is not set
> # CONFIG_QSEMI_PHY is not set
> # CONFIG_REALTEK_PHY is not set
> # CONFIG_RENESAS_PHY is not set
> # CONFIG_ROCKCHIP_PHY is not set
> # CONFIG_SMSC_PHY is not set
> # CONFIG_STE10XP is not set
> # CONFIG_TERANETICS_PHY is not set
> # CONFIG_VITESSE_PHY is not set
> # CONFIG_XILINX_GMII2RGMII is not set
> # CONFIG_MICREL_KS8995MA is not set
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> 
> #
> # Host-side USB support is needed for USB Network Adapter support
> #
> CONFIG_WLAN=y
> # CONFIG_WIRELESS_WDS is not set
> CONFIG_WLAN_VENDOR_ADMTEK=y
> CONFIG_WLAN_VENDOR_ATH=y
> # CONFIG_ATH_DEBUG is not set
> # CONFIG_ATH5K_PCI is not set
> CONFIG_WLAN_VENDOR_ATMEL=y
> CONFIG_WLAN_VENDOR_BROADCOM=y
> CONFIG_WLAN_VENDOR_CISCO=y
> CONFIG_WLAN_VENDOR_INTEL=y
> CONFIG_WLAN_VENDOR_INTERSIL=y
> # CONFIG_HOSTAP is not set
> # CONFIG_PRISM54 is not set
> CONFIG_WLAN_VENDOR_MARVELL=y
> CONFIG_WLAN_VENDOR_MEDIATEK=y
> CONFIG_WLAN_VENDOR_RALINK=y
> CONFIG_WLAN_VENDOR_REALTEK=y
> CONFIG_WLAN_VENDOR_RSI=y
> CONFIG_WLAN_VENDOR_ST=y
> CONFIG_WLAN_VENDOR_TI=y
> CONFIG_WLAN_VENDOR_ZYDAS=y
> CONFIG_WLAN_VENDOR_QUANTENNA=y
> 
> #
> # Enable WiMAX (Networking options) to see the WiMAX drivers
> #
> # CONFIG_WAN is not set
> # CONFIG_VMXNET3 is not set
> # CONFIG_FUJITSU_ES is not set
> # CONFIG_NETDEVSIM is not set
> # CONFIG_NET_FAILOVER is not set
> # CONFIG_ISDN is not set
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> # CONFIG_INPUT_LEDS is not set
> CONFIG_INPUT_FF_MEMLESS=y
> CONFIG_INPUT_POLLDEV=y
> CONFIG_INPUT_SPARSEKMAP=y
> CONFIG_INPUT_MATRIXKMAP=y
> 
> #
> # Userland interfaces
> #
> # CONFIG_INPUT_MOUSEDEV is not set
> CONFIG_INPUT_JOYDEV=y
> CONFIG_INPUT_EVDEV=y
> # CONFIG_INPUT_EVBUG is not set
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> # CONFIG_KEYBOARD_ADC is not set
> # CONFIG_KEYBOARD_ADP5520 is not set
> # CONFIG_KEYBOARD_ADP5588 is not set
> # CONFIG_KEYBOARD_ADP5589 is not set
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_QT1070 is not set
> # CONFIG_KEYBOARD_QT2160 is not set
> # CONFIG_KEYBOARD_DLINK_DIR685 is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_GPIO is not set
> # CONFIG_KEYBOARD_GPIO_POLLED is not set
> # CONFIG_KEYBOARD_TCA6416 is not set
> # CONFIG_KEYBOARD_TCA8418 is not set
> # CONFIG_KEYBOARD_MATRIX is not set
> # CONFIG_KEYBOARD_LM8323 is not set
> # CONFIG_KEYBOARD_LM8333 is not set
> # CONFIG_KEYBOARD_MAX7359 is not set
> # CONFIG_KEYBOARD_MCS is not set
> # CONFIG_KEYBOARD_MPR121 is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> # CONFIG_KEYBOARD_OPENCORES is not set
> # CONFIG_KEYBOARD_SAMSUNG is not set
> # CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
> # CONFIG_KEYBOARD_STOWAWAY is not set
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_STMPE is not set
> # CONFIG_KEYBOARD_OMAP4 is not set
> # CONFIG_KEYBOARD_TC3589X is not set
> # CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_CROS_EC is not set
> # CONFIG_KEYBOARD_CAP11XX is not set
> # CONFIG_KEYBOARD_BCM is not set
> # CONFIG_KEYBOARD_MTK_PMIC is not set
> # CONFIG_INPUT_MOUSE is not set
> CONFIG_INPUT_JOYSTICK=y
> # CONFIG_JOYSTICK_ANALOG is not set
> # CONFIG_JOYSTICK_A3D is not set
> CONFIG_JOYSTICK_ADI=y
> CONFIG_JOYSTICK_COBRA=y
> # CONFIG_JOYSTICK_GF2K is not set
> CONFIG_JOYSTICK_GRIP=y
> # CONFIG_JOYSTICK_GRIP_MP is not set
> # CONFIG_JOYSTICK_GUILLEMOT is not set
> CONFIG_JOYSTICK_INTERACT=y
> CONFIG_JOYSTICK_SIDEWINDER=y
> # CONFIG_JOYSTICK_TMDC is not set
> CONFIG_JOYSTICK_IFORCE=y
> # CONFIG_JOYSTICK_IFORCE_232 is not set
> CONFIG_JOYSTICK_WARRIOR=y
> CONFIG_JOYSTICK_MAGELLAN=y
> CONFIG_JOYSTICK_SPACEORB=y
> CONFIG_JOYSTICK_SPACEBALL=y
> CONFIG_JOYSTICK_STINGER=y
> # CONFIG_JOYSTICK_TWIDJOY is not set
> CONFIG_JOYSTICK_ZHENHUA=y
> # CONFIG_JOYSTICK_AS5011 is not set
> CONFIG_JOYSTICK_JOYDUMP=y
> # CONFIG_JOYSTICK_XPAD is not set
> CONFIG_JOYSTICK_PSXPAD_SPI=y
> CONFIG_JOYSTICK_PSXPAD_SPI_FF=y
> # CONFIG_JOYSTICK_PXRC is not set
> # CONFIG_INPUT_TABLET is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> CONFIG_INPUT_MISC=y
> CONFIG_INPUT_88PM860X_ONKEY=y
> CONFIG_INPUT_AD714X=y
> # CONFIG_INPUT_AD714X_I2C is not set
> # CONFIG_INPUT_AD714X_SPI is not set
> # CONFIG_INPUT_ATMEL_CAPTOUCH is not set
> # CONFIG_INPUT_BMA150 is not set
> CONFIG_INPUT_E3X0_BUTTON=y
> # CONFIG_INPUT_PCSPKR is not set
> CONFIG_INPUT_MAX77693_HAPTIC=y
> CONFIG_INPUT_MAX8925_ONKEY=y
> CONFIG_INPUT_MAX8997_HAPTIC=y
> CONFIG_INPUT_MMA8450=y
> CONFIG_INPUT_APANEL=y
> CONFIG_INPUT_GP2A=y
> CONFIG_INPUT_GPIO_BEEPER=y
> # CONFIG_INPUT_GPIO_DECODER is not set
> CONFIG_INPUT_CPCAP_PWRBUTTON=y
> CONFIG_INPUT_WISTRON_BTNS=y
> # CONFIG_INPUT_ATLAS_BTNS is not set
> # CONFIG_INPUT_ATI_REMOTE2 is not set
> # CONFIG_INPUT_KEYSPAN_REMOTE is not set
> # CONFIG_INPUT_KXTJ9 is not set
> # CONFIG_INPUT_POWERMATE is not set
> # CONFIG_INPUT_YEALINK is not set
> # CONFIG_INPUT_CM109 is not set
> CONFIG_INPUT_RETU_PWRBUTTON=y
> CONFIG_INPUT_TPS65218_PWRBUTTON=y
> CONFIG_INPUT_AXP20X_PEK=y
> CONFIG_INPUT_TWL6040_VIBRA=y
> CONFIG_INPUT_UINPUT=y
> CONFIG_INPUT_PALMAS_PWRBUTTON=y
> # CONFIG_INPUT_PCF8574 is not set
> # CONFIG_INPUT_PWM_BEEPER is not set
> CONFIG_INPUT_PWM_VIBRA=y
> CONFIG_INPUT_RK805_PWRKEY=y
> CONFIG_INPUT_GPIO_ROTARY_ENCODER=y
> CONFIG_INPUT_DA9055_ONKEY=y
> CONFIG_INPUT_DA9063_ONKEY=y
> # CONFIG_INPUT_WM831X_ON is not set
> CONFIG_INPUT_ADXL34X=y
> # CONFIG_INPUT_ADXL34X_I2C is not set
> CONFIG_INPUT_ADXL34X_SPI=y
> # CONFIG_INPUT_CMA3000 is not set
> # CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
> CONFIG_INPUT_DRV260X_HAPTICS=y
> CONFIG_INPUT_DRV2665_HAPTICS=y
> CONFIG_INPUT_DRV2667_HAPTICS=y
> CONFIG_RMI4_CORE=y
> CONFIG_RMI4_I2C=y
> CONFIG_RMI4_SPI=y
> CONFIG_RMI4_SMB=y
> CONFIG_RMI4_F03=y
> CONFIG_RMI4_F03_SERIO=y
> CONFIG_RMI4_2D_SENSOR=y
> CONFIG_RMI4_F11=y
> CONFIG_RMI4_F12=y
> CONFIG_RMI4_F30=y
> CONFIG_RMI4_F34=y
> # CONFIG_RMI4_F55 is not set
> 
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_SERIO_SERPORT=y
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PCIPS2 is not set
> CONFIG_SERIO_LIBPS2=y
> CONFIG_SERIO_RAW=y
> CONFIG_SERIO_ALTERA_PS2=y
> CONFIG_SERIO_PS2MULT=y
> CONFIG_SERIO_ARC_PS2=y
> CONFIG_SERIO_APBPS2=y
> CONFIG_SERIO_GPIO_PS2=y
> CONFIG_USERIO=y
> CONFIG_GAMEPORT=y
> CONFIG_GAMEPORT_NS558=y
> CONFIG_GAMEPORT_L4=y
> CONFIG_GAMEPORT_EMU10K1=y
> CONFIG_GAMEPORT_FM801=y
> 
> #
> # Character devices
> #
> CONFIG_TTY=y
> # CONFIG_VT is not set
> CONFIG_UNIX98_PTYS=y
> CONFIG_LEGACY_PTYS=y
> CONFIG_LEGACY_PTY_COUNT=256
> CONFIG_SERIAL_NONSTANDARD=y
> CONFIG_ROCKETPORT=y
> # CONFIG_CYCLADES is not set
> CONFIG_MOXA_INTELLIO=y
> CONFIG_MOXA_SMARTIO=y
> # CONFIG_SYNCLINK is not set
> CONFIG_SYNCLINKMP=y
> CONFIG_SYNCLINK_GT=y
> CONFIG_NOZOMI=y
> # CONFIG_ISI is not set
> CONFIG_N_HDLC=y
> # CONFIG_N_GSM is not set
> CONFIG_TRACE_ROUTER=y
> CONFIG_TRACE_SINK=y
> # CONFIG_GOLDFISH_TTY is not set
> CONFIG_DEVMEM=y
> CONFIG_DEVKMEM=y
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=y
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
> CONFIG_SERIAL_8250_PNP=y
> # CONFIG_SERIAL_8250_FINTEK is not set
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_PCI=y
> CONFIG_SERIAL_8250_EXAR=y
> CONFIG_SERIAL_8250_NR_UARTS=4
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> CONFIG_SERIAL_8250_EXTENDED=y
> # CONFIG_SERIAL_8250_MANY_PORTS is not set
> CONFIG_SERIAL_8250_ASPEED_VUART=y
> # CONFIG_SERIAL_8250_SHARE_IRQ is not set
> # CONFIG_SERIAL_8250_DETECT_IRQ is not set
> # CONFIG_SERIAL_8250_RSA is not set
> # CONFIG_SERIAL_8250_DW is not set
> # CONFIG_SERIAL_8250_RT288X is not set
> CONFIG_SERIAL_8250_LPSS=y
> CONFIG_SERIAL_8250_MID=y
> CONFIG_SERIAL_8250_MOXA=y
> # CONFIG_SERIAL_OF_PLATFORM is not set
> 
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_MAX3100=y
> CONFIG_SERIAL_MAX310X=y
> CONFIG_SERIAL_UARTLITE=y
> CONFIG_SERIAL_UARTLITE_CONSOLE=y
> CONFIG_SERIAL_UARTLITE_NR_UARTS=1
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> CONFIG_SERIAL_JSM=y
> CONFIG_SERIAL_SCCNXP=y
> CONFIG_SERIAL_SCCNXP_CONSOLE=y
> # CONFIG_SERIAL_SC16IS7XX is not set
> # CONFIG_SERIAL_TIMBERDALE is not set
> # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> CONFIG_SERIAL_ALTERA_UART=y
> CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
> CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
> # CONFIG_SERIAL_ALTERA_UART_CONSOLE is not set
> CONFIG_SERIAL_IFX6X60=y
> CONFIG_SERIAL_PCH_UART=y
> CONFIG_SERIAL_PCH_UART_CONSOLE=y
> CONFIG_SERIAL_XILINX_PS_UART=y
> CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
> CONFIG_SERIAL_ARC=y
> # CONFIG_SERIAL_ARC_CONSOLE is not set
> CONFIG_SERIAL_ARC_NR_PORTS=1
> CONFIG_SERIAL_RP2=y
> CONFIG_SERIAL_RP2_NR_UARTS=32
> CONFIG_SERIAL_FSL_LPUART=y
> CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
> # CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
> # CONFIG_SERIAL_DEV_BUS is not set
> # CONFIG_TTY_PRINTK is not set
> CONFIG_HVC_DRIVER=y
> CONFIG_VIRTIO_CONSOLE=y
> CONFIG_IPMI_HANDLER=y
> CONFIG_IPMI_DMI_DECODE=y
> # CONFIG_IPMI_PANIC_EVENT is not set
> CONFIG_IPMI_DEVICE_INTERFACE=y
> CONFIG_IPMI_SI=y
> CONFIG_IPMI_SSIF=y
> # CONFIG_IPMI_WATCHDOG is not set
> # CONFIG_IPMI_POWEROFF is not set
> CONFIG_HW_RANDOM=y
> CONFIG_HW_RANDOM_TIMERIOMEM=y
> # CONFIG_HW_RANDOM_INTEL is not set
> # CONFIG_HW_RANDOM_AMD is not set
> CONFIG_HW_RANDOM_GEODE=y
> # CONFIG_HW_RANDOM_VIA is not set
> CONFIG_HW_RANDOM_VIRTIO=y
> # CONFIG_NVRAM is not set
> CONFIG_DTLK=y
> CONFIG_R3964=y
> CONFIG_APPLICOM=y
> CONFIG_SONYPI=y
> CONFIG_MWAVE=y
> # CONFIG_SCx200_GPIO is not set
> # CONFIG_PC8736x_GPIO is not set
> CONFIG_NSC_GPIO=y
> # CONFIG_HPET is not set
> # CONFIG_HANGCHECK_TIMER is not set
> CONFIG_TCG_TPM=y
> # CONFIG_HW_RANDOM_TPM is not set
> CONFIG_TCG_TIS_CORE=y
> # CONFIG_TCG_TIS is not set
> CONFIG_TCG_TIS_SPI=y
> # CONFIG_TCG_TIS_I2C_ATMEL is not set
> CONFIG_TCG_TIS_I2C_INFINEON=y
> CONFIG_TCG_TIS_I2C_NUVOTON=y
> CONFIG_TCG_NSC=y
> CONFIG_TCG_ATMEL=y
> # CONFIG_TCG_INFINEON is not set
> # CONFIG_TCG_CRB is not set
> # CONFIG_TCG_VTPM_PROXY is not set
> CONFIG_TCG_TIS_ST33ZP24=y
> CONFIG_TCG_TIS_ST33ZP24_I2C=y
> CONFIG_TCG_TIS_ST33ZP24_SPI=y
> CONFIG_TELCLOCK=y
> CONFIG_DEVPORT=y
> # CONFIG_XILLYBUS is not set
> # CONFIG_RANDOM_TRUST_CPU is not set
> 
> #
> # I2C support
> #
> CONFIG_I2C=y
> CONFIG_ACPI_I2C_OPREGION=y
> CONFIG_I2C_BOARDINFO=y
> # CONFIG_I2C_COMPAT is not set
> # CONFIG_I2C_CHARDEV is not set
> CONFIG_I2C_MUX=y
> 
> #
> # Multiplexer I2C Chip support
> #
> CONFIG_I2C_ARB_GPIO_CHALLENGE=y
> CONFIG_I2C_MUX_GPIO=y
> CONFIG_I2C_MUX_GPMUX=y
> # CONFIG_I2C_MUX_LTC4306 is not set
> CONFIG_I2C_MUX_PCA9541=y
> CONFIG_I2C_MUX_PCA954x=y
> CONFIG_I2C_MUX_PINCTRL=y
> CONFIG_I2C_MUX_REG=y
> CONFIG_I2C_DEMUX_PINCTRL=y
> CONFIG_I2C_MUX_MLXCPLD=y
> CONFIG_I2C_HELPER_AUTO=y
> CONFIG_I2C_SMBUS=y
> CONFIG_I2C_ALGOBIT=y
> CONFIG_I2C_ALGOPCA=y
> 
> #
> # I2C Hardware Bus support
> #
> 
> #
> # PC SMBus host controller drivers
> #
> CONFIG_I2C_ALI1535=y
> # CONFIG_I2C_ALI1563 is not set
> CONFIG_I2C_ALI15X3=y
> CONFIG_I2C_AMD756=y
> CONFIG_I2C_AMD756_S4882=y
> CONFIG_I2C_AMD8111=y
> # CONFIG_I2C_I801 is not set
> # CONFIG_I2C_ISCH is not set
> # CONFIG_I2C_ISMT is not set
> # CONFIG_I2C_PIIX4 is not set
> # CONFIG_I2C_NFORCE2 is not set
> # CONFIG_I2C_SIS5595 is not set
> CONFIG_I2C_SIS630=y
> CONFIG_I2C_SIS96X=y
> CONFIG_I2C_VIA=y
> CONFIG_I2C_VIAPRO=y
> 
> #
> # ACPI drivers
> #
> # CONFIG_I2C_SCMI is not set
> 
> #
> # I2C system bus drivers (mostly embedded / system-on-chip)
> #
> CONFIG_I2C_CBUS_GPIO=y
> CONFIG_I2C_DESIGNWARE_CORE=y
> # CONFIG_I2C_DESIGNWARE_PLATFORM is not set
> CONFIG_I2C_DESIGNWARE_PCI=y
> # CONFIG_I2C_EG20T is not set
> # CONFIG_I2C_EMEV2 is not set
> CONFIG_I2C_GPIO=y
> # CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
> # CONFIG_I2C_OCORES is not set
> # CONFIG_I2C_PCA_PLATFORM is not set
> CONFIG_I2C_PXA=y
> CONFIG_I2C_PXA_PCI=y
> CONFIG_I2C_RK3X=y
> CONFIG_I2C_SIMTEC=y
> # CONFIG_I2C_XILINX is not set
> 
> #
> # External I2C/SMBus adapter drivers
> #
> CONFIG_I2C_PARPORT_LIGHT=y
> CONFIG_I2C_TAOS_EVM=y
> 
> #
> # Other I2C/SMBus bus drivers
> #
> CONFIG_I2C_PCA_ISA=y
> # CONFIG_I2C_CROS_EC_TUNNEL is not set
> CONFIG_SCx200_ACB=y
> # CONFIG_I2C_FSI is not set
> CONFIG_I2C_SLAVE=y
> CONFIG_I2C_SLAVE_EEPROM=y
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> CONFIG_SPI=y
> CONFIG_SPI_DEBUG=y
> CONFIG_SPI_MASTER=y
> # CONFIG_SPI_MEM is not set
> 
> #
> # SPI Master Controller Drivers
> #
> CONFIG_SPI_ALTERA=y
> CONFIG_SPI_AXI_SPI_ENGINE=y
> CONFIG_SPI_BITBANG=y
> # CONFIG_SPI_CADENCE is not set
> # CONFIG_SPI_DESIGNWARE is not set
> CONFIG_SPI_GPIO=y
> # CONFIG_SPI_FSL_SPI is not set
> # CONFIG_SPI_OC_TINY is not set
> CONFIG_SPI_PXA2XX=y
> CONFIG_SPI_PXA2XX_PCI=y
> # CONFIG_SPI_ROCKCHIP is not set
> # CONFIG_SPI_SC18IS602 is not set
> CONFIG_SPI_TOPCLIFF_PCH=y
> CONFIG_SPI_XCOMM=y
> CONFIG_SPI_XILINX=y
> CONFIG_SPI_ZYNQMP_GQSPI=y
> 
> #
> # SPI Protocol Masters
> #
> CONFIG_SPI_SPIDEV=y
> CONFIG_SPI_TLE62X0=y
> CONFIG_SPI_SLAVE=y
> CONFIG_SPI_SLAVE_TIME=y
> CONFIG_SPI_SLAVE_SYSTEM_CONTROL=y
> # CONFIG_SPMI is not set
> CONFIG_HSI=y
> CONFIG_HSI_BOARDINFO=y
> 
> #
> # HSI controllers
> #
> 
> #
> # HSI clients
> #
> CONFIG_HSI_CHAR=y
> CONFIG_PPS=y
> # CONFIG_PPS_DEBUG is not set
> 
> #
> # PPS clients support
> #
> # CONFIG_PPS_CLIENT_KTIMER is not set
> # CONFIG_PPS_CLIENT_LDISC is not set
> # CONFIG_PPS_CLIENT_GPIO is not set
> 
> #
> # PPS generators support
> #
> 
> #
> # PTP clock support
> #
> CONFIG_PTP_1588_CLOCK=y
> 
> #
> # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
> #
> # CONFIG_PTP_1588_CLOCK_PCH is not set
> CONFIG_PTP_1588_CLOCK_KVM=y
> CONFIG_PINCTRL=y
> CONFIG_GENERIC_PINCTRL_GROUPS=y
> CONFIG_PINMUX=y
> CONFIG_GENERIC_PINMUX_FUNCTIONS=y
> CONFIG_PINCONF=y
> CONFIG_GENERIC_PINCONF=y
> CONFIG_DEBUG_PINCTRL=y
> CONFIG_PINCTRL_AXP209=y
> CONFIG_PINCTRL_AMD=y
> CONFIG_PINCTRL_MCP23S08=y
> CONFIG_PINCTRL_SINGLE=y
> # CONFIG_PINCTRL_SX150X is not set
> # CONFIG_PINCTRL_MAX77620 is not set
> # CONFIG_PINCTRL_PALMAS is not set
> # CONFIG_PINCTRL_RK805 is not set
> # CONFIG_PINCTRL_BAYTRAIL is not set
> # CONFIG_PINCTRL_CHERRYVIEW is not set
> # CONFIG_PINCTRL_BROXTON is not set
> # CONFIG_PINCTRL_CANNONLAKE is not set
> # CONFIG_PINCTRL_CEDARFORK is not set
> # CONFIG_PINCTRL_DENVERTON is not set
> # CONFIG_PINCTRL_GEMINILAKE is not set
> # CONFIG_PINCTRL_ICELAKE is not set
> # CONFIG_PINCTRL_LEWISBURG is not set
> # CONFIG_PINCTRL_SUNRISEPOINT is not set
> CONFIG_GPIOLIB=y
> CONFIG_GPIOLIB_FASTPATH_LIMIT=512
> CONFIG_OF_GPIO=y
> CONFIG_GPIO_ACPI=y
> CONFIG_GPIOLIB_IRQCHIP=y
> CONFIG_DEBUG_GPIO=y
> CONFIG_GPIO_SYSFS=y
> CONFIG_GPIO_GENERIC=y
> CONFIG_GPIO_MAX730X=y
> 
> #
> # Memory mapped GPIO drivers
> #
> # CONFIG_GPIO_74XX_MMIO is not set
> CONFIG_GPIO_ALTERA=y
> # CONFIG_GPIO_AMDPT is not set
> # CONFIG_GPIO_DWAPB is not set
> # CONFIG_GPIO_EXAR is not set
> CONFIG_GPIO_FTGPIO010=y
> # CONFIG_GPIO_GENERIC_PLATFORM is not set
> CONFIG_GPIO_GRGPIO=y
> CONFIG_GPIO_HLWD=y
> # CONFIG_GPIO_ICH is not set
> # CONFIG_GPIO_LYNXPOINT is not set
> CONFIG_GPIO_MB86S7X=y
> # CONFIG_GPIO_MOCKUP is not set
> CONFIG_GPIO_STA2X11=y
> CONFIG_GPIO_SYSCON=y
> CONFIG_GPIO_VX855=y
> CONFIG_GPIO_XILINX=y
> 
> #
> # Port-mapped I/O GPIO drivers
> #
> CONFIG_GPIO_104_DIO_48E=y
> # CONFIG_GPIO_104_IDIO_16 is not set
> CONFIG_GPIO_104_IDI_48=y
> CONFIG_GPIO_F7188X=y
> # CONFIG_GPIO_GPIO_MM is not set
> CONFIG_GPIO_IT87=y
> CONFIG_GPIO_SCH=y
> CONFIG_GPIO_SCH311X=y
> CONFIG_GPIO_WINBOND=y
> CONFIG_GPIO_WS16C48=y
> 
> #
> # I2C GPIO expanders
> #
> CONFIG_GPIO_ADP5588=y
> # CONFIG_GPIO_ADP5588_IRQ is not set
> # CONFIG_GPIO_ADNP is not set
> # CONFIG_GPIO_MAX7300 is not set
> CONFIG_GPIO_MAX732X=y
> # CONFIG_GPIO_MAX732X_IRQ is not set
> # CONFIG_GPIO_PCA953X is not set
> # CONFIG_GPIO_PCF857X is not set
> CONFIG_GPIO_TPIC2810=y
> 
> #
> # MFD GPIO expanders
> #
> CONFIG_GPIO_ADP5520=y
> CONFIG_GPIO_ARIZONA=y
> # CONFIG_GPIO_BD9571MWV is not set
> CONFIG_GPIO_CS5535=y
> # CONFIG_GPIO_DA9055 is not set
> CONFIG_GPIO_JANZ_TTL=y
> CONFIG_GPIO_LP3943=y
> # CONFIG_GPIO_LP873X is not set
> CONFIG_GPIO_LP87565=y
> CONFIG_GPIO_MAX77620=y
> # CONFIG_GPIO_PALMAS is not set
> # CONFIG_GPIO_STMPE is not set
> # CONFIG_GPIO_TC3589X is not set
> # CONFIG_GPIO_TIMBERDALE is not set
> CONFIG_GPIO_TPS65218=y
> CONFIG_GPIO_TPS65912=y
> # CONFIG_GPIO_TWL6040 is not set
> # CONFIG_GPIO_WM831X is not set
> CONFIG_GPIO_WM8350=y
> CONFIG_GPIO_WM8994=y
> 
> #
> # PCI GPIO expanders
> #
> # CONFIG_GPIO_AMD8111 is not set
> CONFIG_GPIO_BT8XX=y
> # CONFIG_GPIO_ML_IOH is not set
> # CONFIG_GPIO_PCH is not set
> # CONFIG_GPIO_PCI_IDIO_16 is not set
> CONFIG_GPIO_PCIE_IDIO_24=y
> CONFIG_GPIO_RDC321X=y
> # CONFIG_GPIO_SODAVILLE is not set
> 
> #
> # SPI GPIO expanders
> #
> CONFIG_GPIO_74X164=y
> CONFIG_GPIO_MAX3191X=y
> CONFIG_GPIO_MAX7301=y
> CONFIG_GPIO_MC33880=y
> # CONFIG_GPIO_PISOSR is not set
> # CONFIG_GPIO_XRA1403 is not set
> CONFIG_W1=y
> 
> #
> # 1-wire Bus Masters
> #
> CONFIG_W1_MASTER_MATROX=y
> # CONFIG_W1_MASTER_DS2482 is not set
> # CONFIG_W1_MASTER_DS1WM is not set
> CONFIG_W1_MASTER_GPIO=y
> 
> #
> # 1-wire Slaves
> #
> CONFIG_W1_SLAVE_THERM=y
> CONFIG_W1_SLAVE_SMEM=y
> CONFIG_W1_SLAVE_DS2405=y
> CONFIG_W1_SLAVE_DS2408=y
> CONFIG_W1_SLAVE_DS2408_READBACK=y
> CONFIG_W1_SLAVE_DS2413=y
> CONFIG_W1_SLAVE_DS2406=y
> CONFIG_W1_SLAVE_DS2423=y
> CONFIG_W1_SLAVE_DS2805=y
> CONFIG_W1_SLAVE_DS2431=y
> CONFIG_W1_SLAVE_DS2433=y
> # CONFIG_W1_SLAVE_DS2433_CRC is not set
> CONFIG_W1_SLAVE_DS2438=y
> CONFIG_W1_SLAVE_DS2780=y
> CONFIG_W1_SLAVE_DS2781=y
> CONFIG_W1_SLAVE_DS28E04=y
> CONFIG_W1_SLAVE_DS28E17=y
> # CONFIG_POWER_AVS is not set
> CONFIG_POWER_RESET=y
> # CONFIG_POWER_RESET_GPIO is not set
> CONFIG_POWER_RESET_GPIO_RESTART=y
> CONFIG_POWER_RESET_LTC2952=y
> # CONFIG_POWER_RESET_RESTART is not set
> # CONFIG_POWER_RESET_SYSCON is not set
> CONFIG_POWER_RESET_SYSCON_POWEROFF=y
> CONFIG_REBOOT_MODE=y
> CONFIG_SYSCON_REBOOT_MODE=y
> CONFIG_POWER_SUPPLY=y
> # CONFIG_POWER_SUPPLY_DEBUG is not set
> CONFIG_PDA_POWER=y
> CONFIG_GENERIC_ADC_BATTERY=y
> CONFIG_MAX8925_POWER=y
> CONFIG_WM831X_BACKUP=y
> CONFIG_WM831X_POWER=y
> CONFIG_WM8350_POWER=y
> # CONFIG_TEST_POWER is not set
> CONFIG_BATTERY_88PM860X=y
> # CONFIG_CHARGER_ADP5061 is not set
> CONFIG_BATTERY_ACT8945A=y
> CONFIG_BATTERY_CPCAP=y
> CONFIG_BATTERY_DS2760=y
> CONFIG_BATTERY_DS2780=y
> CONFIG_BATTERY_DS2781=y
> # CONFIG_BATTERY_DS2782 is not set
> CONFIG_BATTERY_LEGO_EV3=y
> CONFIG_BATTERY_SBS=y
> CONFIG_CHARGER_SBS=y
> CONFIG_MANAGER_SBS=y
> CONFIG_BATTERY_BQ27XXX=y
> CONFIG_BATTERY_BQ27XXX_I2C=y
> CONFIG_BATTERY_BQ27XXX_HDQ=y
> CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=y
> # CONFIG_BATTERY_DA9030 is not set
> CONFIG_CHARGER_AXP20X=y
> CONFIG_BATTERY_AXP20X=y
> CONFIG_AXP20X_POWER=y
> # CONFIG_AXP288_FUEL_GAUGE is not set
> CONFIG_BATTERY_MAX17040=y
> # CONFIG_BATTERY_MAX17042 is not set
> CONFIG_BATTERY_MAX1721X=y
> CONFIG_CHARGER_88PM860X=y
> CONFIG_CHARGER_MAX8903=y
> # CONFIG_CHARGER_LP8727 is not set
> CONFIG_CHARGER_LP8788=y
> CONFIG_CHARGER_GPIO=y
> CONFIG_CHARGER_LTC3651=y
> CONFIG_CHARGER_MAX14577=y
> CONFIG_CHARGER_DETECTOR_MAX14656=y
> CONFIG_CHARGER_MAX77693=y
> # CONFIG_CHARGER_BQ2415X is not set
> # CONFIG_CHARGER_BQ24190 is not set
> # CONFIG_CHARGER_BQ24257 is not set
> CONFIG_CHARGER_BQ24735=y
> CONFIG_CHARGER_BQ25890=y
> CONFIG_CHARGER_SMB347=y
> CONFIG_CHARGER_TPS65090=y
> # CONFIG_CHARGER_TPS65217 is not set
> CONFIG_BATTERY_GAUGE_LTC2941=y
> CONFIG_BATTERY_GOLDFISH=y
> CONFIG_BATTERY_RT5033=y
> CONFIG_CHARGER_RT9455=y
> # CONFIG_CHARGER_CROS_USBPD is not set
> CONFIG_HWMON=y
> CONFIG_HWMON_VID=y
> # CONFIG_HWMON_DEBUG_CHIP is not set
> 
> #
> # Native drivers
> #
> CONFIG_SENSORS_ABITUGURU=y
> CONFIG_SENSORS_ABITUGURU3=y
> CONFIG_SENSORS_AD7314=y
> CONFIG_SENSORS_AD7414=y
> # CONFIG_SENSORS_AD7418 is not set
> CONFIG_SENSORS_ADM1021=y
> # CONFIG_SENSORS_ADM1025 is not set
> CONFIG_SENSORS_ADM1026=y
> CONFIG_SENSORS_ADM1029=y
> # CONFIG_SENSORS_ADM1031 is not set
> # CONFIG_SENSORS_ADM9240 is not set
> # CONFIG_SENSORS_ADT7310 is not set
> # CONFIG_SENSORS_ADT7410 is not set
> CONFIG_SENSORS_ADT7411=y
> CONFIG_SENSORS_ADT7462=y
> CONFIG_SENSORS_ADT7470=y
> CONFIG_SENSORS_ADT7475=y
> CONFIG_SENSORS_ASC7621=y
> CONFIG_SENSORS_K8TEMP=y
> # CONFIG_SENSORS_K10TEMP is not set
> # CONFIG_SENSORS_FAM15H_POWER is not set
> CONFIG_SENSORS_APPLESMC=y
> CONFIG_SENSORS_ASB100=y
> CONFIG_SENSORS_ASPEED=y
> # CONFIG_SENSORS_ATXP1 is not set
> CONFIG_SENSORS_DS620=y
> CONFIG_SENSORS_DS1621=y
> CONFIG_SENSORS_DELL_SMM=y
> CONFIG_SENSORS_DA9055=y
> # CONFIG_SENSORS_I5K_AMB is not set
> CONFIG_SENSORS_F71805F=y
> CONFIG_SENSORS_F71882FG=y
> # CONFIG_SENSORS_F75375S is not set
> CONFIG_SENSORS_FSCHMD=y
> CONFIG_SENSORS_GL518SM=y
> CONFIG_SENSORS_GL520SM=y
> # CONFIG_SENSORS_G760A is not set
> CONFIG_SENSORS_G762=y
> # CONFIG_SENSORS_GPIO_FAN is not set
> # CONFIG_SENSORS_HIH6130 is not set
> CONFIG_SENSORS_IBMAEM=y
> CONFIG_SENSORS_IBMPEX=y
> CONFIG_SENSORS_IIO_HWMON=y
> CONFIG_SENSORS_I5500=y
> CONFIG_SENSORS_CORETEMP=y
> CONFIG_SENSORS_IT87=y
> CONFIG_SENSORS_JC42=y
> CONFIG_SENSORS_POWR1220=y
> # CONFIG_SENSORS_LINEAGE is not set
> CONFIG_SENSORS_LTC2945=y
> CONFIG_SENSORS_LTC2990=y
> CONFIG_SENSORS_LTC4151=y
> CONFIG_SENSORS_LTC4215=y
> # CONFIG_SENSORS_LTC4222 is not set
> # CONFIG_SENSORS_LTC4245 is not set
> CONFIG_SENSORS_LTC4260=y
> # CONFIG_SENSORS_LTC4261 is not set
> CONFIG_SENSORS_MAX1111=y
> # CONFIG_SENSORS_MAX16065 is not set
> # CONFIG_SENSORS_MAX1619 is not set
> CONFIG_SENSORS_MAX1668=y
> CONFIG_SENSORS_MAX197=y
> # CONFIG_SENSORS_MAX31722 is not set
> CONFIG_SENSORS_MAX6621=y
> CONFIG_SENSORS_MAX6639=y
> CONFIG_SENSORS_MAX6642=y
> CONFIG_SENSORS_MAX6650=y
> CONFIG_SENSORS_MAX6697=y
> # CONFIG_SENSORS_MAX31790 is not set
> CONFIG_SENSORS_MCP3021=y
> CONFIG_SENSORS_TC654=y
> CONFIG_SENSORS_MENF21BMC_HWMON=y
> # CONFIG_SENSORS_ADCXX is not set
> CONFIG_SENSORS_LM63=y
> # CONFIG_SENSORS_LM70 is not set
> CONFIG_SENSORS_LM73=y
> CONFIG_SENSORS_LM75=y
> # CONFIG_SENSORS_LM77 is not set
> CONFIG_SENSORS_LM78=y
> # CONFIG_SENSORS_LM80 is not set
> # CONFIG_SENSORS_LM83 is not set
> CONFIG_SENSORS_LM85=y
> CONFIG_SENSORS_LM87=y
> CONFIG_SENSORS_LM90=y
> # CONFIG_SENSORS_LM92 is not set
> CONFIG_SENSORS_LM93=y
> # CONFIG_SENSORS_LM95234 is not set
> CONFIG_SENSORS_LM95241=y
> CONFIG_SENSORS_LM95245=y
> CONFIG_SENSORS_PC87360=y
> # CONFIG_SENSORS_PC87427 is not set
> CONFIG_SENSORS_NTC_THERMISTOR=y
> # CONFIG_SENSORS_NCT6683 is not set
> CONFIG_SENSORS_NCT6775=y
> # CONFIG_SENSORS_NCT7802 is not set
> CONFIG_SENSORS_NCT7904=y
> CONFIG_SENSORS_NPCM7XX=y
> # CONFIG_SENSORS_PCF8591 is not set
> CONFIG_PMBUS=y
> # CONFIG_SENSORS_PMBUS is not set
> CONFIG_SENSORS_ADM1275=y
> # CONFIG_SENSORS_IBM_CFFPS is not set
> CONFIG_SENSORS_IR35221=y
> CONFIG_SENSORS_LM25066=y
> CONFIG_SENSORS_LTC2978=y
> CONFIG_SENSORS_LTC3815=y
> CONFIG_SENSORS_MAX16064=y
> # CONFIG_SENSORS_MAX20751 is not set
> CONFIG_SENSORS_MAX31785=y
> CONFIG_SENSORS_MAX34440=y
> CONFIG_SENSORS_MAX8688=y
> CONFIG_SENSORS_TPS40422=y
> # CONFIG_SENSORS_TPS53679 is not set
> CONFIG_SENSORS_UCD9000=y
> CONFIG_SENSORS_UCD9200=y
> # CONFIG_SENSORS_ZL6100 is not set
> # CONFIG_SENSORS_PWM_FAN is not set
> # CONFIG_SENSORS_SHT15 is not set
> CONFIG_SENSORS_SHT21=y
> CONFIG_SENSORS_SHT3x=y
> # CONFIG_SENSORS_SHTC1 is not set
> CONFIG_SENSORS_SIS5595=y
> CONFIG_SENSORS_DME1737=y
> CONFIG_SENSORS_EMC1403=y
> CONFIG_SENSORS_EMC2103=y
> # CONFIG_SENSORS_EMC6W201 is not set
> CONFIG_SENSORS_SMSC47M1=y
> CONFIG_SENSORS_SMSC47M192=y
> CONFIG_SENSORS_SMSC47B397=y
> CONFIG_SENSORS_STTS751=y
> CONFIG_SENSORS_SMM665=y
> CONFIG_SENSORS_ADC128D818=y
> CONFIG_SENSORS_ADS1015=y
> CONFIG_SENSORS_ADS7828=y
> CONFIG_SENSORS_ADS7871=y
> CONFIG_SENSORS_AMC6821=y
> CONFIG_SENSORS_INA209=y
> CONFIG_SENSORS_INA2XX=y
> CONFIG_SENSORS_INA3221=y
> # CONFIG_SENSORS_TC74 is not set
> CONFIG_SENSORS_THMC50=y
> # CONFIG_SENSORS_TMP102 is not set
> CONFIG_SENSORS_TMP103=y
> # CONFIG_SENSORS_TMP108 is not set
> # CONFIG_SENSORS_TMP401 is not set
> CONFIG_SENSORS_TMP421=y
> CONFIG_SENSORS_VIA_CPUTEMP=y
> CONFIG_SENSORS_VIA686A=y
> CONFIG_SENSORS_VT1211=y
> CONFIG_SENSORS_VT8231=y
> CONFIG_SENSORS_W83773G=y
> CONFIG_SENSORS_W83781D=y
> # CONFIG_SENSORS_W83791D is not set
> # CONFIG_SENSORS_W83792D is not set
> CONFIG_SENSORS_W83793=y
> CONFIG_SENSORS_W83795=y
> # CONFIG_SENSORS_W83795_FANCTRL is not set
> # CONFIG_SENSORS_W83L785TS is not set
> # CONFIG_SENSORS_W83L786NG is not set
> # CONFIG_SENSORS_W83627HF is not set
> CONFIG_SENSORS_W83627EHF=y
> CONFIG_SENSORS_WM831X=y
> # CONFIG_SENSORS_WM8350 is not set
> 
> #
> # ACPI drivers
> #
> # CONFIG_SENSORS_ACPI_POWER is not set
> # CONFIG_SENSORS_ATK0110 is not set
> CONFIG_THERMAL=y
> # CONFIG_THERMAL_STATISTICS is not set
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> CONFIG_THERMAL_HWMON=y
> CONFIG_THERMAL_OF=y
> # CONFIG_THERMAL_WRITABLE_TRIPS is not set
> CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
> # CONFIG_THERMAL_GOV_FAIR_SHARE is not set
> CONFIG_THERMAL_GOV_STEP_WISE=y
> # CONFIG_THERMAL_GOV_BANG_BANG is not set
> # CONFIG_THERMAL_GOV_USER_SPACE is not set
> # CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
> # CONFIG_CPU_THERMAL is not set
> # CONFIG_CLOCK_THERMAL is not set
> # CONFIG_DEVFREQ_THERMAL is not set
> # CONFIG_THERMAL_EMULATION is not set
> # CONFIG_MAX77620_THERMAL is not set
> # CONFIG_QORIQ_THERMAL is not set
> # CONFIG_DA9062_THERMAL is not set
> # CONFIG_INTEL_POWERCLAMP is not set
> # CONFIG_INTEL_SOC_DTS_THERMAL is not set
> 
> #
> # ACPI INT340X thermal drivers
> #
> # CONFIG_INT340X_THERMAL is not set
> # CONFIG_INTEL_PCH_THERMAL is not set
> # CONFIG_GENERIC_ADC_THERMAL is not set
> # CONFIG_WATCHDOG is not set
> CONFIG_SSB_POSSIBLE=y
> # CONFIG_SSB is not set
> CONFIG_BCMA_POSSIBLE=y
> # CONFIG_BCMA is not set
> 
> #
> # Multifunction device drivers
> #
> CONFIG_MFD_CORE=y
> CONFIG_MFD_CS5535=y
> CONFIG_MFD_ACT8945A=y
> # CONFIG_MFD_AS3711 is not set
> # CONFIG_MFD_AS3722 is not set
> CONFIG_PMIC_ADP5520=y
> CONFIG_MFD_AAT2870_CORE=y
> # CONFIG_MFD_ATMEL_FLEXCOM is not set
> CONFIG_MFD_ATMEL_HLCDC=y
> CONFIG_MFD_BCM590XX=y
> CONFIG_MFD_BD9571MWV=y
> CONFIG_MFD_AXP20X=y
> CONFIG_MFD_AXP20X_I2C=y
> CONFIG_MFD_CROS_EC=y
> CONFIG_MFD_CROS_EC_CHARDEV=y
> # CONFIG_MFD_MADERA is not set
> CONFIG_PMIC_DA903X=y
> # CONFIG_MFD_DA9052_SPI is not set
> # CONFIG_MFD_DA9052_I2C is not set
> CONFIG_MFD_DA9055=y
> CONFIG_MFD_DA9062=y
> CONFIG_MFD_DA9063=y
> # CONFIG_MFD_DA9150 is not set
> # CONFIG_MFD_MC13XXX_SPI is not set
> # CONFIG_MFD_MC13XXX_I2C is not set
> CONFIG_MFD_HI6421_PMIC=y
> CONFIG_HTC_PASIC3=y
> # CONFIG_HTC_I2CPLD is not set
> CONFIG_MFD_INTEL_QUARK_I2C_GPIO=y
> # CONFIG_LPC_ICH is not set
> CONFIG_LPC_SCH=y
> # CONFIG_INTEL_SOC_PMIC is not set
> # CONFIG_INTEL_SOC_PMIC_CHTWC is not set
> # CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
> CONFIG_MFD_INTEL_LPSS=y
> # CONFIG_MFD_INTEL_LPSS_ACPI is not set
> CONFIG_MFD_INTEL_LPSS_PCI=y
> CONFIG_MFD_JANZ_CMODIO=y
> # CONFIG_MFD_KEMPLD is not set
> # CONFIG_MFD_88PM800 is not set
> CONFIG_MFD_88PM805=y
> CONFIG_MFD_88PM860X=y
> CONFIG_MFD_MAX14577=y
> CONFIG_MFD_MAX77620=y
> # CONFIG_MFD_MAX77686 is not set
> CONFIG_MFD_MAX77693=y
> CONFIG_MFD_MAX77843=y
> CONFIG_MFD_MAX8907=y
> CONFIG_MFD_MAX8925=y
> CONFIG_MFD_MAX8997=y
> # CONFIG_MFD_MAX8998 is not set
> CONFIG_MFD_MT6397=y
> CONFIG_MFD_MENF21BMC=y
> # CONFIG_EZX_PCAP is not set
> CONFIG_MFD_CPCAP=y
> CONFIG_MFD_RETU=y
> # CONFIG_MFD_PCF50633 is not set
> CONFIG_MFD_RDC321X=y
> CONFIG_MFD_RT5033=y
> # CONFIG_MFD_RC5T583 is not set
> CONFIG_MFD_RK808=y
> # CONFIG_MFD_RN5T618 is not set
> # CONFIG_MFD_SEC_CORE is not set
> CONFIG_MFD_SI476X_CORE=y
> CONFIG_MFD_SM501=y
> CONFIG_MFD_SM501_GPIO=y
> # CONFIG_MFD_SKY81452 is not set
> CONFIG_MFD_SMSC=y
> CONFIG_ABX500_CORE=y
> # CONFIG_AB3100_CORE is not set
> CONFIG_MFD_STMPE=y
> 
> #
> # STMicroelectronics STMPE Interface Drivers
> #
> CONFIG_STMPE_I2C=y
> CONFIG_STMPE_SPI=y
> CONFIG_MFD_STA2X11=y
> CONFIG_MFD_SYSCON=y
> # CONFIG_MFD_TI_AM335X_TSCADC is not set
> CONFIG_MFD_LP3943=y
> CONFIG_MFD_LP8788=y
> # CONFIG_MFD_TI_LMU is not set
> CONFIG_MFD_PALMAS=y
> # CONFIG_TPS6105X is not set
> # CONFIG_TPS65010 is not set
> # CONFIG_TPS6507X is not set
> # CONFIG_MFD_TPS65086 is not set
> CONFIG_MFD_TPS65090=y
> CONFIG_MFD_TPS65217=y
> # CONFIG_MFD_TPS68470 is not set
> CONFIG_MFD_TI_LP873X=y
> CONFIG_MFD_TI_LP87565=y
> CONFIG_MFD_TPS65218=y
> # CONFIG_MFD_TPS6586X is not set
> # CONFIG_MFD_TPS65910 is not set
> CONFIG_MFD_TPS65912=y
> CONFIG_MFD_TPS65912_I2C=y
> CONFIG_MFD_TPS65912_SPI=y
> # CONFIG_MFD_TPS80031 is not set
> # CONFIG_TWL4030_CORE is not set
> CONFIG_TWL6040_CORE=y
> CONFIG_MFD_WL1273_CORE=y
> CONFIG_MFD_LM3533=y
> CONFIG_MFD_TIMBERDALE=y
> CONFIG_MFD_TC3589X=y
> CONFIG_MFD_VX855=y
> CONFIG_MFD_ARIZONA=y
> CONFIG_MFD_ARIZONA_I2C=y
> # CONFIG_MFD_ARIZONA_SPI is not set
> # CONFIG_MFD_CS47L24 is not set
> CONFIG_MFD_WM5102=y
> CONFIG_MFD_WM5110=y
> # CONFIG_MFD_WM8997 is not set
> # CONFIG_MFD_WM8998 is not set
> # CONFIG_MFD_WM8400 is not set
> CONFIG_MFD_WM831X=y
> # CONFIG_MFD_WM831X_I2C is not set
> CONFIG_MFD_WM831X_SPI=y
> CONFIG_MFD_WM8350=y
> CONFIG_MFD_WM8350_I2C=y
> CONFIG_MFD_WM8994=y
> # CONFIG_MFD_ROHM_BD718XX is not set
> # CONFIG_REGULATOR is not set
> CONFIG_CEC_CORE=y
> CONFIG_CEC_NOTIFIER=y
> CONFIG_RC_CORE=y
> CONFIG_RC_MAP=y
> CONFIG_LIRC=y
> CONFIG_RC_DECODERS=y
> CONFIG_IR_NEC_DECODER=y
> CONFIG_IR_RC5_DECODER=y
> CONFIG_IR_RC6_DECODER=y
> CONFIG_IR_JVC_DECODER=y
> # CONFIG_IR_SONY_DECODER is not set
> # CONFIG_IR_SANYO_DECODER is not set
> CONFIG_IR_SHARP_DECODER=y
> CONFIG_IR_MCE_KBD_DECODER=y
> CONFIG_IR_XMP_DECODER=y
> CONFIG_IR_IMON_DECODER=y
> CONFIG_RC_DEVICES=y
> # CONFIG_RC_ATI_REMOTE is not set
> CONFIG_IR_ENE=y
> CONFIG_IR_HIX5HD2=y
> # CONFIG_IR_IMON is not set
> # CONFIG_IR_IMON_RAW is not set
> # CONFIG_IR_MCEUSB is not set
> # CONFIG_IR_ITE_CIR is not set
> CONFIG_IR_FINTEK=y
> # CONFIG_IR_NUVOTON is not set
> # CONFIG_IR_REDRAT3 is not set
> # CONFIG_IR_SPI is not set
> # CONFIG_IR_STREAMZAP is not set
> CONFIG_IR_WINBOND_CIR=y
> # CONFIG_IR_IGORPLUGUSB is not set
> # CONFIG_IR_IGUANA is not set
> # CONFIG_IR_TTUSBIR is not set
> # CONFIG_RC_LOOPBACK is not set
> CONFIG_IR_GPIO_CIR=y
> CONFIG_IR_GPIO_TX=y
> # CONFIG_IR_PWM_TX is not set
> # CONFIG_IR_SERIAL is not set
> CONFIG_IR_SIR=y
> CONFIG_MEDIA_SUPPORT=y
> 
> #
> # Multimedia core support
> #
> # CONFIG_MEDIA_CAMERA_SUPPORT is not set
> # CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
> CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
> # CONFIG_MEDIA_RADIO_SUPPORT is not set
> # CONFIG_MEDIA_SDR_SUPPORT is not set
> # CONFIG_MEDIA_CEC_SUPPORT is not set
> CONFIG_MEDIA_CEC_RC=y
> # CONFIG_MEDIA_CONTROLLER is not set
> # CONFIG_VIDEO_ADV_DEBUG is not set
> CONFIG_VIDEO_FIXED_MINOR_RANGES=y
> CONFIG_DVB_CORE=y
> CONFIG_DVB_NET=y
> CONFIG_TTPCI_EEPROM=y
> CONFIG_DVB_MAX_ADAPTERS=16
> CONFIG_DVB_DYNAMIC_MINORS=y
> # CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
> CONFIG_DVB_ULE_DEBUG=y
> 
> #
> # Media drivers
> #
> CONFIG_MEDIA_PCI_SUPPORT=y
> 
> #
> # Media capture/analog/hybrid TV support
> #
> 
> #
> # Media digital TV PCI Adapters
> #
> CONFIG_DVB_BUDGET_CORE=y
> CONFIG_DVB_BUDGET=y
> CONFIG_DVB_BUDGET_CI=y
> CONFIG_DVB_B2C2_FLEXCOP_PCI=y
> # CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
> CONFIG_DVB_PLUTO2=y
> # CONFIG_DVB_DM1105 is not set
> CONFIG_DVB_PT1=y
> CONFIG_DVB_PT3=y
> CONFIG_MANTIS_CORE=y
> # CONFIG_DVB_MANTIS is not set
> CONFIG_DVB_HOPPER=y
> CONFIG_DVB_NGENE=y
> CONFIG_DVB_DDBRIDGE=y
> CONFIG_DVB_DDBRIDGE_MSIENABLE=y
> # CONFIG_DVB_SMIPCIE is not set
> # CONFIG_DVB_PLATFORM_DRIVERS is not set
> 
> #
> # Supported MMC/SDIO adapters
> #
> CONFIG_SMS_SDIO_DRV=y
> 
> #
> # Supported FireWire (IEEE 1394) Adapters
> #
> CONFIG_DVB_FIREDTV=y
> CONFIG_DVB_FIREDTV_INPUT=y
> CONFIG_MEDIA_COMMON_OPTIONS=y
> 
> #
> # common driver options
> #
> CONFIG_DVB_B2C2_FLEXCOP=y
> CONFIG_VIDEO_SAA7146=y
> CONFIG_SMS_SIANO_MDTV=y
> CONFIG_SMS_SIANO_RC=y
> 
> #
> # Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
> #
> # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
> 
> #
> # Media SPI Adapters
> #
> # CONFIG_CXD2880_SPI_DRV is not set
> CONFIG_MEDIA_TUNER=y
> 
> #
> # Customize TV tuners
> #
> CONFIG_MEDIA_TUNER_SIMPLE=y
> CONFIG_MEDIA_TUNER_TDA18250=y
> CONFIG_MEDIA_TUNER_TDA8290=y
> CONFIG_MEDIA_TUNER_TDA827X=y
> CONFIG_MEDIA_TUNER_TDA18271=y
> CONFIG_MEDIA_TUNER_TDA9887=y
> # CONFIG_MEDIA_TUNER_TEA5761 is not set
> # CONFIG_MEDIA_TUNER_TEA5767 is not set
> CONFIG_MEDIA_TUNER_MT20XX=y
> CONFIG_MEDIA_TUNER_MT2060=y
> CONFIG_MEDIA_TUNER_MT2063=y
> CONFIG_MEDIA_TUNER_MT2266=y
> # CONFIG_MEDIA_TUNER_MT2131 is not set
> # CONFIG_MEDIA_TUNER_QT1010 is not set
> CONFIG_MEDIA_TUNER_XC2028=y
> CONFIG_MEDIA_TUNER_XC5000=y
> # CONFIG_MEDIA_TUNER_XC4000 is not set
> CONFIG_MEDIA_TUNER_MXL5005S=y
> CONFIG_MEDIA_TUNER_MXL5007T=y
> CONFIG_MEDIA_TUNER_MC44S803=y
> CONFIG_MEDIA_TUNER_MAX2165=y
> CONFIG_MEDIA_TUNER_TDA18218=y
> CONFIG_MEDIA_TUNER_FC0011=y
> CONFIG_MEDIA_TUNER_FC0012=y
> # CONFIG_MEDIA_TUNER_FC0013 is not set
> # CONFIG_MEDIA_TUNER_TDA18212 is not set
> # CONFIG_MEDIA_TUNER_E4000 is not set
> # CONFIG_MEDIA_TUNER_FC2580 is not set
> CONFIG_MEDIA_TUNER_M88RS6000T=y
> CONFIG_MEDIA_TUNER_TUA9001=y
> CONFIG_MEDIA_TUNER_SI2157=y
> # CONFIG_MEDIA_TUNER_IT913X is not set
> CONFIG_MEDIA_TUNER_R820T=y
> CONFIG_MEDIA_TUNER_MXL301RF=y
> # CONFIG_MEDIA_TUNER_QM1D1C0042 is not set
> CONFIG_MEDIA_TUNER_QM1D1B0004=y
> 
> #
> # Customise DVB Frontends
> #
> 
> #
> # Multistandard (satellite) frontends
> #
> # CONFIG_DVB_STB0899 is not set
> # CONFIG_DVB_STB6100 is not set
> CONFIG_DVB_STV090x=y
> # CONFIG_DVB_STV0910 is not set
> # CONFIG_DVB_STV6110x is not set
> CONFIG_DVB_STV6111=y
> CONFIG_DVB_MXL5XX=y
> # CONFIG_DVB_M88DS3103 is not set
> 
> #
> # Multistandard (cable + terrestrial) frontends
> #
> CONFIG_DVB_DRXK=y
> # CONFIG_DVB_TDA18271C2DD is not set
> # CONFIG_DVB_SI2165 is not set
> CONFIG_DVB_MN88472=y
> # CONFIG_DVB_MN88473 is not set
> 
> #
> # DVB-S (satellite) frontends
> #
> CONFIG_DVB_CX24110=y
> CONFIG_DVB_CX24123=y
> CONFIG_DVB_MT312=y
> CONFIG_DVB_ZL10036=y
> # CONFIG_DVB_ZL10039 is not set
> CONFIG_DVB_S5H1420=y
> # CONFIG_DVB_STV0288 is not set
> # CONFIG_DVB_STB6000 is not set
> CONFIG_DVB_STV0299=y
> CONFIG_DVB_STV6110=y
> CONFIG_DVB_STV0900=y
> # CONFIG_DVB_TDA8083 is not set
> CONFIG_DVB_TDA10086=y
> CONFIG_DVB_TDA8261=y
> CONFIG_DVB_VES1X93=y
> CONFIG_DVB_TUNER_ITD1000=y
> CONFIG_DVB_TUNER_CX24113=y
> CONFIG_DVB_TDA826X=y
> # CONFIG_DVB_TUA6100 is not set
> # CONFIG_DVB_CX24116 is not set
> CONFIG_DVB_CX24117=y
> # CONFIG_DVB_CX24120 is not set
> # CONFIG_DVB_SI21XX is not set
> CONFIG_DVB_TS2020=y
> CONFIG_DVB_DS3000=y
> # CONFIG_DVB_MB86A16 is not set
> CONFIG_DVB_TDA10071=y
> 
> #
> # DVB-T (terrestrial) frontends
> #
> CONFIG_DVB_SP8870=y
> CONFIG_DVB_SP887X=y
> # CONFIG_DVB_CX22700 is not set
> CONFIG_DVB_CX22702=y
> CONFIG_DVB_S5H1432=y
> CONFIG_DVB_DRXD=y
> # CONFIG_DVB_L64781 is not set
> CONFIG_DVB_TDA1004X=y
> CONFIG_DVB_NXT6000=y
> CONFIG_DVB_MT352=y
> CONFIG_DVB_ZL10353=y
> CONFIG_DVB_DIB3000MB=y
> # CONFIG_DVB_DIB3000MC is not set
> # CONFIG_DVB_DIB7000M is not set
> CONFIG_DVB_DIB7000P=y
> # CONFIG_DVB_DIB9000 is not set
> # CONFIG_DVB_TDA10048 is not set
> CONFIG_DVB_AF9013=y
> CONFIG_DVB_EC100=y
> CONFIG_DVB_STV0367=y
> # CONFIG_DVB_CXD2820R is not set
> CONFIG_DVB_CXD2841ER=y
> CONFIG_DVB_RTL2830=y
> CONFIG_DVB_RTL2832=y
> CONFIG_DVB_SI2168=y
> CONFIG_DVB_ZD1301_DEMOD=y
> CONFIG_DVB_CXD2880=y
> 
> #
> # DVB-C (cable) frontends
> #
> CONFIG_DVB_VES1820=y
> CONFIG_DVB_TDA10021=y
> # CONFIG_DVB_TDA10023 is not set
> CONFIG_DVB_STV0297=y
> 
> #
> # ATSC (North American/Korean Terrestrial/Cable DTV) frontends
> #
> CONFIG_DVB_NXT200X=y
> CONFIG_DVB_OR51211=y
> # CONFIG_DVB_OR51132 is not set
> # CONFIG_DVB_BCM3510 is not set
> # CONFIG_DVB_LGDT330X is not set
> CONFIG_DVB_LGDT3305=y
> CONFIG_DVB_LGDT3306A=y
> # CONFIG_DVB_LG2160 is not set
> CONFIG_DVB_S5H1409=y
> CONFIG_DVB_AU8522=y
> CONFIG_DVB_AU8522_DTV=y
> CONFIG_DVB_S5H1411=y
> 
> #
> # ISDB-T (terrestrial) frontends
> #
> CONFIG_DVB_S921=y
> # CONFIG_DVB_DIB8000 is not set
> CONFIG_DVB_MB86A20S=y
> 
> #
> # ISDB-S (satellite) & ISDB-T (terrestrial) frontends
> #
> # CONFIG_DVB_TC90522 is not set
> CONFIG_DVB_MN88443X=y
> 
> #
> # Digital terrestrial only tuners/PLL
> #
> CONFIG_DVB_PLL=y
> CONFIG_DVB_TUNER_DIB0070=y
> CONFIG_DVB_TUNER_DIB0090=y
> 
> #
> # SEC control devices for DVB-S
> #
> CONFIG_DVB_DRX39XYJ=y
> CONFIG_DVB_LNBH25=y
> # CONFIG_DVB_LNBP21 is not set
> CONFIG_DVB_LNBP22=y
> # CONFIG_DVB_ISL6405 is not set
> # CONFIG_DVB_ISL6421 is not set
> # CONFIG_DVB_ISL6423 is not set
> CONFIG_DVB_A8293=y
> # CONFIG_DVB_LGS8GL5 is not set
> # CONFIG_DVB_LGS8GXX is not set
> CONFIG_DVB_ATBM8830=y
> # CONFIG_DVB_TDA665x is not set
> # CONFIG_DVB_IX2505V is not set
> CONFIG_DVB_M88RS2000=y
> CONFIG_DVB_AF9033=y
> # CONFIG_DVB_HORUS3A is not set
> CONFIG_DVB_ASCOT2E=y
> # CONFIG_DVB_HELENE is not set
> 
> #
> # Common Interface (EN50221) controller drivers
> #
> CONFIG_DVB_CXD2099=y
> CONFIG_DVB_SP2=y
> 
> #
> # Tools to develop new frontends
> #
> CONFIG_DVB_DUMMY_FE=y
> 
> #
> # Graphics support
> #
> CONFIG_AGP=y
> # CONFIG_AGP_ALI is not set
> CONFIG_AGP_ATI=y
> CONFIG_AGP_AMD=y
> CONFIG_AGP_AMD64=y
> CONFIG_AGP_INTEL=y
> # CONFIG_AGP_NVIDIA is not set
> CONFIG_AGP_SIS=y
> CONFIG_AGP_SWORKS=y
> # CONFIG_AGP_VIA is not set
> # CONFIG_AGP_EFFICEON is not set
> CONFIG_INTEL_GTT=y
> CONFIG_VGA_ARB=y
> CONFIG_VGA_ARB_MAX_GPUS=16
> # CONFIG_VGA_SWITCHEROO is not set
> CONFIG_DRM=y
> CONFIG_DRM_MIPI_DSI=y
> # CONFIG_DRM_DP_AUX_CHARDEV is not set
> # CONFIG_DRM_DEBUG_MM is not set
> # CONFIG_DRM_DEBUG_SELFTEST is not set
> CONFIG_DRM_KMS_HELPER=y
> CONFIG_DRM_KMS_FB_HELPER=y
> CONFIG_DRM_FBDEV_EMULATION=y
> CONFIG_DRM_FBDEV_OVERALLOC=100
> CONFIG_DRM_LOAD_EDID_FIRMWARE=y
> # CONFIG_DRM_DP_CEC is not set
> CONFIG_DRM_TTM=y
> CONFIG_DRM_GEM_CMA_HELPER=y
> CONFIG_DRM_KMS_CMA_HELPER=y
> CONFIG_DRM_SCHED=y
> 
> #
> # I2C encoder or helper chips
> #
> CONFIG_DRM_I2C_CH7006=y
> CONFIG_DRM_I2C_SIL164=y
> # CONFIG_DRM_I2C_NXP_TDA998X is not set
> CONFIG_DRM_I2C_NXP_TDA9950=y
> CONFIG_DRM_RADEON=y
> CONFIG_DRM_RADEON_USERPTR=y
> CONFIG_DRM_AMDGPU=y
> # CONFIG_DRM_AMDGPU_SI is not set
> # CONFIG_DRM_AMDGPU_CIK is not set
> CONFIG_DRM_AMDGPU_USERPTR=y
> CONFIG_DRM_AMDGPU_GART_DEBUGFS=y
> 
> #
> # ACP (Audio CoProcessor) Configuration
> #
> # CONFIG_DRM_AMD_ACP is not set
> 
> #
> # Display Engine Configuration
> #
> # CONFIG_DRM_AMD_DC is not set
> 
> #
> # AMD Library routines
> #
> CONFIG_CHASH=y
> # CONFIG_CHASH_STATS is not set
> CONFIG_CHASH_SELFTEST=y
> # CONFIG_DRM_NOUVEAU is not set
> # CONFIG_DRM_I915 is not set
> CONFIG_DRM_VGEM=y
> # CONFIG_DRM_VKMS is not set
> CONFIG_DRM_VMWGFX=y
> # CONFIG_DRM_VMWGFX_FBCON is not set
> CONFIG_DRM_GMA500=y
> # CONFIG_DRM_GMA600 is not set
> CONFIG_DRM_GMA3600=y
> # CONFIG_DRM_UDL is not set
> CONFIG_DRM_AST=y
> # CONFIG_DRM_MGAG200 is not set
> CONFIG_DRM_CIRRUS_QEMU=y
> CONFIG_DRM_RCAR_DW_HDMI=y
> # CONFIG_DRM_RCAR_LVDS is not set
> CONFIG_DRM_QXL=y
> # CONFIG_DRM_BOCHS is not set
> CONFIG_DRM_VIRTIO_GPU=y
> CONFIG_DRM_PANEL=y
> 
> #
> # Display Panels
> #
> CONFIG_DRM_PANEL_ARM_VERSATILE=y
> # CONFIG_DRM_PANEL_LVDS is not set
> # CONFIG_DRM_PANEL_SIMPLE is not set
> CONFIG_DRM_PANEL_ILITEK_IL9322=y
> CONFIG_DRM_PANEL_ILITEK_ILI9881C=y
> CONFIG_DRM_PANEL_INNOLUX_P079ZCA=y
> CONFIG_DRM_PANEL_JDI_LT070ME05000=y
> # CONFIG_DRM_PANEL_SAMSUNG_LD9040 is not set
> # CONFIG_DRM_PANEL_LG_LG4573 is not set
> CONFIG_DRM_PANEL_ORISETECH_OTM8009A=y
> CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=y
> CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
> CONFIG_DRM_PANEL_RAYDIUM_RM68200=y
> # CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2 is not set
> CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=y
> CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
> CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
> CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=y
> # CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
> CONFIG_DRM_PANEL_SITRONIX_ST7789V=y
> CONFIG_DRM_BRIDGE=y
> CONFIG_DRM_PANEL_BRIDGE=y
> 
> #
> # Display Interface Bridges
> #
> # CONFIG_DRM_ANALOGIX_ANX78XX is not set
> CONFIG_DRM_CDNS_DSI=y
> CONFIG_DRM_DUMB_VGA_DAC=y
> CONFIG_DRM_LVDS_ENCODER=y
> # CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW is not set
> # CONFIG_DRM_NXP_PTN3460 is not set
> # CONFIG_DRM_PARADE_PS8622 is not set
> CONFIG_DRM_SIL_SII8620=y
> CONFIG_DRM_SII902X=y
> CONFIG_DRM_SII9234=y
> # CONFIG_DRM_THINE_THC63LVD1024 is not set
> CONFIG_DRM_TOSHIBA_TC358767=y
> # CONFIG_DRM_TI_TFP410 is not set
> CONFIG_DRM_I2C_ADV7511=y
> # CONFIG_DRM_I2C_ADV7533 is not set
> CONFIG_DRM_I2C_ADV7511_CEC=y
> CONFIG_DRM_DW_HDMI=y
> CONFIG_DRM_DW_HDMI_CEC=y
> CONFIG_DRM_ARCPGU=y
> # CONFIG_DRM_HISI_HIBMC is not set
> # CONFIG_DRM_MXSFB is not set
> CONFIG_DRM_TINYDRM=y
> CONFIG_TINYDRM_MIPI_DBI=y
> # CONFIG_TINYDRM_ILI9225 is not set
> CONFIG_TINYDRM_ILI9341=y
> CONFIG_TINYDRM_MI0283QT=y
> CONFIG_TINYDRM_REPAPER=y
> CONFIG_TINYDRM_ST7586=y
> CONFIG_TINYDRM_ST7735R=y
> # CONFIG_DRM_LEGACY is not set
> CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
> 
> #
> # Frame buffer Devices
> #
> CONFIG_FB=y
> CONFIG_FIRMWARE_EDID=y
> CONFIG_FB_CMDLINE=y
> CONFIG_FB_NOTIFY=y
> CONFIG_FB_DDC=y
> CONFIG_FB_BOOT_VESA_SUPPORT=y
> CONFIG_FB_CFB_FILLRECT=y
> CONFIG_FB_CFB_COPYAREA=y
> CONFIG_FB_CFB_IMAGEBLIT=y
> CONFIG_FB_SYS_FILLRECT=y
> CONFIG_FB_SYS_COPYAREA=y
> CONFIG_FB_SYS_IMAGEBLIT=y
> # CONFIG_FB_FOREIGN_ENDIAN is not set
> CONFIG_FB_SYS_FOPS=y
> CONFIG_FB_DEFERRED_IO=y
> CONFIG_FB_HECUBA=y
> CONFIG_FB_SVGALIB=y
> CONFIG_FB_BACKLIGHT=y
> CONFIG_FB_MODE_HELPERS=y
> CONFIG_FB_TILEBLITTING=y
> 
> #
> # Frame buffer hardware drivers
> #
> # CONFIG_FB_CIRRUS is not set
> CONFIG_FB_PM2=y
> # CONFIG_FB_PM2_FIFO_DISCONNECT is not set
> CONFIG_FB_CYBER2000=y
> CONFIG_FB_CYBER2000_DDC=y
> # CONFIG_FB_ARC is not set
> # CONFIG_FB_ASILIANT is not set
> # CONFIG_FB_IMSTT is not set
> # CONFIG_FB_VGA16 is not set
> CONFIG_FB_VESA=y
> CONFIG_FB_N411=y
> # CONFIG_FB_HGA is not set
> # CONFIG_FB_OPENCORES is not set
> CONFIG_FB_S1D13XXX=y
> CONFIG_FB_NVIDIA=y
> CONFIG_FB_NVIDIA_I2C=y
> # CONFIG_FB_NVIDIA_DEBUG is not set
> # CONFIG_FB_NVIDIA_BACKLIGHT is not set
> CONFIG_FB_RIVA=y
> # CONFIG_FB_RIVA_I2C is not set
> # CONFIG_FB_RIVA_DEBUG is not set
> # CONFIG_FB_RIVA_BACKLIGHT is not set
> CONFIG_FB_I740=y
> CONFIG_FB_I810=y
> # CONFIG_FB_I810_GTF is not set
> CONFIG_FB_LE80578=y
> CONFIG_FB_CARILLO_RANCH=y
> CONFIG_FB_INTEL=y
> CONFIG_FB_INTEL_DEBUG=y
> # CONFIG_FB_INTEL_I2C is not set
> CONFIG_FB_MATROX=y
> CONFIG_FB_MATROX_MILLENIUM=y
> # CONFIG_FB_MATROX_MYSTIQUE is not set
> CONFIG_FB_MATROX_G=y
> # CONFIG_FB_MATROX_I2C is not set
> CONFIG_FB_RADEON=y
> # CONFIG_FB_RADEON_I2C is not set
> CONFIG_FB_RADEON_BACKLIGHT=y
> # CONFIG_FB_RADEON_DEBUG is not set
> # CONFIG_FB_ATY128 is not set
> CONFIG_FB_ATY=y
> CONFIG_FB_ATY_CT=y
> # CONFIG_FB_ATY_GENERIC_LCD is not set
> CONFIG_FB_ATY_GX=y
> CONFIG_FB_ATY_BACKLIGHT=y
> CONFIG_FB_S3=y
> CONFIG_FB_S3_DDC=y
> CONFIG_FB_SAVAGE=y
> CONFIG_FB_SAVAGE_I2C=y
> CONFIG_FB_SAVAGE_ACCEL=y
> CONFIG_FB_SIS=y
> CONFIG_FB_SIS_300=y
> # CONFIG_FB_SIS_315 is not set
> CONFIG_FB_VIA=y
> CONFIG_FB_VIA_DIRECT_PROCFS=y
> # CONFIG_FB_VIA_X_COMPATIBILITY is not set
> CONFIG_FB_NEOMAGIC=y
> CONFIG_FB_KYRO=y
> # CONFIG_FB_3DFX is not set
> # CONFIG_FB_VOODOO1 is not set
> # CONFIG_FB_VT8623 is not set
> CONFIG_FB_TRIDENT=y
> # CONFIG_FB_ARK is not set
> # CONFIG_FB_PM3 is not set
> CONFIG_FB_CARMINE=y
> CONFIG_FB_CARMINE_DRAM_EVAL=y
> # CONFIG_CARMINE_DRAM_CUSTOM is not set
> # CONFIG_FB_GEODE is not set
> CONFIG_FB_SM501=y
> CONFIG_FB_IBM_GXT4500=y
> # CONFIG_FB_GOLDFISH is not set
> CONFIG_FB_VIRTUAL=y
> CONFIG_FB_METRONOME=y
> CONFIG_FB_MB862XX=y
> CONFIG_FB_MB862XX_PCI_GDC=y
> # CONFIG_FB_MB862XX_I2C is not set
> # CONFIG_FB_BROADSHEET is not set
> # CONFIG_FB_SIMPLE is not set
> CONFIG_FB_SSD1307=y
> CONFIG_FB_SM712=y
> CONFIG_BACKLIGHT_LCD_SUPPORT=y
> CONFIG_LCD_CLASS_DEVICE=y
> # CONFIG_LCD_L4F00242T03 is not set
> # CONFIG_LCD_LMS283GF05 is not set
> # CONFIG_LCD_LTV350QV is not set
> CONFIG_LCD_ILI922X=y
> CONFIG_LCD_ILI9320=y
> CONFIG_LCD_TDO24M=y
> # CONFIG_LCD_VGG2432A4 is not set
> # CONFIG_LCD_PLATFORM is not set
> # CONFIG_LCD_S6E63M0 is not set
> # CONFIG_LCD_LD9040 is not set
> # CONFIG_LCD_AMS369FG06 is not set
> # CONFIG_LCD_LMS501KF03 is not set
> # CONFIG_LCD_HX8357 is not set
> # CONFIG_LCD_OTM3225A is not set
> CONFIG_BACKLIGHT_CLASS_DEVICE=y
> # CONFIG_BACKLIGHT_GENERIC is not set
> # CONFIG_BACKLIGHT_LM3533 is not set
> # CONFIG_BACKLIGHT_CARILLO_RANCH is not set
> CONFIG_BACKLIGHT_PWM=y
> # CONFIG_BACKLIGHT_DA903X is not set
> CONFIG_BACKLIGHT_MAX8925=y
> # CONFIG_BACKLIGHT_APPLE is not set
> CONFIG_BACKLIGHT_PM8941_WLED=y
> # CONFIG_BACKLIGHT_SAHARA is not set
> CONFIG_BACKLIGHT_WM831X=y
> CONFIG_BACKLIGHT_ADP5520=y
> CONFIG_BACKLIGHT_ADP8860=y
> CONFIG_BACKLIGHT_ADP8870=y
> CONFIG_BACKLIGHT_88PM860X=y
> CONFIG_BACKLIGHT_AAT2870=y
> # CONFIG_BACKLIGHT_LM3630A is not set
> CONFIG_BACKLIGHT_LM3639=y
> CONFIG_BACKLIGHT_LP855X=y
> CONFIG_BACKLIGHT_LP8788=y
> CONFIG_BACKLIGHT_OT200=y
> CONFIG_BACKLIGHT_TPS65217=y
> CONFIG_BACKLIGHT_GPIO=y
> CONFIG_BACKLIGHT_LV5207LP=y
> CONFIG_BACKLIGHT_BD6107=y
> # CONFIG_BACKLIGHT_ARCXCNN is not set
> CONFIG_VGASTATE=y
> CONFIG_VIDEOMODE_HELPERS=y
> CONFIG_HDMI=y
> CONFIG_LOGO=y
> # CONFIG_LOGO_LINUX_MONO is not set
> # CONFIG_LOGO_LINUX_VGA16 is not set
> # CONFIG_LOGO_LINUX_CLUT224 is not set
> # CONFIG_SOUND is not set
> 
> #
> # HID support
> #
> CONFIG_HID=y
> CONFIG_HID_BATTERY_STRENGTH=y
> CONFIG_HIDRAW=y
> CONFIG_UHID=y
> CONFIG_HID_GENERIC=y
> 
> #
> # Special HID drivers
> #
> # CONFIG_HID_A4TECH is not set
> # CONFIG_HID_ACRUX is not set
> # CONFIG_HID_APPLE is not set
> # CONFIG_HID_ASUS is not set
> # CONFIG_HID_AUREAL is not set
> # CONFIG_HID_BELKIN is not set
> CONFIG_HID_CHERRY=y
> CONFIG_HID_CHICONY=y
> # CONFIG_HID_COUGAR is not set
> CONFIG_HID_CMEDIA=y
> CONFIG_HID_CYPRESS=y
> CONFIG_HID_DRAGONRISE=y
> # CONFIG_DRAGONRISE_FF is not set
> # CONFIG_HID_EMS_FF is not set
> CONFIG_HID_ELECOM=y
> CONFIG_HID_EZKEY=y
> # CONFIG_HID_GEMBIRD is not set
> CONFIG_HID_GFRM=y
> CONFIG_HID_KEYTOUCH=y
> CONFIG_HID_KYE=y
> CONFIG_HID_WALTOP=y
> # CONFIG_HID_GYRATION is not set
> CONFIG_HID_ICADE=y
> # CONFIG_HID_ITE is not set
> CONFIG_HID_JABRA=y
> CONFIG_HID_TWINHAN=y
> CONFIG_HID_KENSINGTON=y
> # CONFIG_HID_LCPOWER is not set
> CONFIG_HID_LED=y
> CONFIG_HID_LENOVO=y
> CONFIG_HID_LOGITECH=y
> CONFIG_HID_LOGITECH_DJ=y
> CONFIG_HID_LOGITECH_HIDPP=y
> CONFIG_LOGITECH_FF=y
> # CONFIG_LOGIRUMBLEPAD2_FF is not set
> # CONFIG_LOGIG940_FF is not set
> # CONFIG_LOGIWHEELS_FF is not set
> # CONFIG_HID_MAGICMOUSE is not set
> CONFIG_HID_MAYFLASH=y
> CONFIG_HID_REDRAGON=y
> # CONFIG_HID_MICROSOFT is not set
> # CONFIG_HID_MONTEREY is not set
> CONFIG_HID_MULTITOUCH=y
> CONFIG_HID_NTI=y
> # CONFIG_HID_ORTEK is not set
> CONFIG_HID_PANTHERLORD=y
> CONFIG_PANTHERLORD_FF=y
> # CONFIG_HID_PETALYNX is not set
> CONFIG_HID_PICOLCD=y
> CONFIG_HID_PICOLCD_FB=y
> CONFIG_HID_PICOLCD_BACKLIGHT=y
> # CONFIG_HID_PICOLCD_LCD is not set
> CONFIG_HID_PICOLCD_LEDS=y
> # CONFIG_HID_PICOLCD_CIR is not set
> # CONFIG_HID_PLANTRONICS is not set
> CONFIG_HID_PRIMAX=y
> CONFIG_HID_SAITEK=y
> # CONFIG_HID_SAMSUNG is not set
> CONFIG_HID_SPEEDLINK=y
> # CONFIG_HID_STEAM is not set
> # CONFIG_HID_STEELSERIES is not set
> CONFIG_HID_SUNPLUS=y
> CONFIG_HID_RMI=y
> # CONFIG_HID_GREENASIA is not set
> CONFIG_HID_SMARTJOYPLUS=y
> CONFIG_SMARTJOYPLUS_FF=y
> CONFIG_HID_TIVO=y
> CONFIG_HID_TOPSEED=y
> CONFIG_HID_THINGM=y
> CONFIG_HID_THRUSTMASTER=y
> CONFIG_THRUSTMASTER_FF=y
> CONFIG_HID_UDRAW_PS3=y
> CONFIG_HID_WIIMOTE=y
> CONFIG_HID_XINMO=y
> # CONFIG_HID_ZEROPLUS is not set
> # CONFIG_HID_ZYDACRON is not set
> CONFIG_HID_SENSOR_HUB=y
> CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
> # CONFIG_HID_ALPS is not set
> 
> #
> # I2C HID support
> #
> # CONFIG_I2C_HID is not set
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> CONFIG_USB_SUPPORT=y
> CONFIG_USB_ARCH_HAS_HCD=y
> # CONFIG_USB is not set
> CONFIG_USB_PCI=y
> 
> #
> # USB port drivers
> #
> 
> #
> # USB Physical Layer drivers
> #
> # CONFIG_NOP_USB_XCEIV is not set
> # CONFIG_USB_GPIO_VBUS is not set
> # CONFIG_TAHVO_USB is not set
> # CONFIG_USB_GADGET is not set
> # CONFIG_TYPEC is not set
> # CONFIG_USB_LED_TRIG is not set
> # CONFIG_USB_ULPI_BUS is not set
> # CONFIG_UWB is not set
> CONFIG_MMC=y
> CONFIG_PWRSEQ_EMMC=y
> CONFIG_PWRSEQ_SIMPLE=y
> CONFIG_SDIO_UART=y
> CONFIG_MMC_TEST=y
> 
> #
> # MMC/SD/SDIO Host Controller Drivers
> #
> # CONFIG_MMC_DEBUG is not set
> # CONFIG_MMC_SDHCI is not set
> # CONFIG_MMC_WBSD is not set
> CONFIG_MMC_TIFM_SD=y
> CONFIG_MMC_GOLDFISH=y
> CONFIG_MMC_SPI=y
> CONFIG_MMC_CB710=y
> # CONFIG_MMC_VIA_SDMMC is not set
> CONFIG_MMC_USDHI6ROL0=y
> # CONFIG_MMC_REALTEK_PCI is not set
> CONFIG_MMC_CQHCI=y
> CONFIG_MMC_TOSHIBA_PCI=y
> CONFIG_MMC_MTK=y
> CONFIG_MEMSTICK=y
> # CONFIG_MEMSTICK_DEBUG is not set
> 
> #
> # MemoryStick drivers
> #
> # CONFIG_MEMSTICK_UNSAFE_RESUME is not set
> 
> #
> # MemoryStick Host Controller Drivers
> #
> CONFIG_MEMSTICK_TIFM_MS=y
> CONFIG_MEMSTICK_JMICRON_38X=y
> # CONFIG_MEMSTICK_R592 is not set
> CONFIG_MEMSTICK_REALTEK_PCI=y
> CONFIG_NEW_LEDS=y
> CONFIG_LEDS_CLASS=y
> CONFIG_LEDS_CLASS_FLASH=y
> # CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set
> 
> #
> # LED drivers
> #
> # CONFIG_LEDS_88PM860X is not set
> CONFIG_LEDS_AAT1290=y
> CONFIG_LEDS_APU=y
> CONFIG_LEDS_AS3645A=y
> CONFIG_LEDS_BCM6328=y
> CONFIG_LEDS_BCM6358=y
> # CONFIG_LEDS_CPCAP is not set
> CONFIG_LEDS_CR0014114=y
> CONFIG_LEDS_LM3530=y
> CONFIG_LEDS_LM3533=y
> CONFIG_LEDS_LM3642=y
> # CONFIG_LEDS_LM3692X is not set
> CONFIG_LEDS_LM3601X=y
> CONFIG_LEDS_MT6323=y
> CONFIG_LEDS_PCA9532=y
> # CONFIG_LEDS_PCA9532_GPIO is not set
> CONFIG_LEDS_GPIO=y
> CONFIG_LEDS_LP3944=y
> CONFIG_LEDS_LP3952=y
> CONFIG_LEDS_LP55XX_COMMON=y
> # CONFIG_LEDS_LP5521 is not set
> CONFIG_LEDS_LP5523=y
> CONFIG_LEDS_LP5562=y
> CONFIG_LEDS_LP8501=y
> # CONFIG_LEDS_LP8788 is not set
> # CONFIG_LEDS_LP8860 is not set
> CONFIG_LEDS_CLEVO_MAIL=y
> CONFIG_LEDS_PCA955X=y
> CONFIG_LEDS_PCA955X_GPIO=y
> CONFIG_LEDS_PCA963X=y
> CONFIG_LEDS_WM831X_STATUS=y
> CONFIG_LEDS_WM8350=y
> # CONFIG_LEDS_DA903X is not set
> # CONFIG_LEDS_DAC124S085 is not set
> # CONFIG_LEDS_PWM is not set
> # CONFIG_LEDS_BD2802 is not set
> # CONFIG_LEDS_INTEL_SS4200 is not set
> CONFIG_LEDS_LT3593=y
> CONFIG_LEDS_ADP5520=y
> CONFIG_LEDS_TCA6507=y
> # CONFIG_LEDS_TLC591XX is not set
> CONFIG_LEDS_MAX77693=y
> CONFIG_LEDS_MAX8997=y
> CONFIG_LEDS_LM355x=y
> CONFIG_LEDS_OT200=y
> # CONFIG_LEDS_MENF21BMC is not set
> # CONFIG_LEDS_KTD2692 is not set
> CONFIG_LEDS_IS31FL319X=y
> CONFIG_LEDS_IS31FL32XX=y
> 
> #
> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> #
> CONFIG_LEDS_BLINKM=y
> CONFIG_LEDS_SYSCON=y
> CONFIG_LEDS_MLXCPLD=y
> CONFIG_LEDS_MLXREG=y
> # CONFIG_LEDS_USER is not set
> # CONFIG_LEDS_NIC78BX is not set
> 
> #
> # LED Triggers
> #
> CONFIG_LEDS_TRIGGERS=y
> # CONFIG_LEDS_TRIGGER_TIMER is not set
> # CONFIG_LEDS_TRIGGER_ONESHOT is not set
> CONFIG_LEDS_TRIGGER_MTD=y
> CONFIG_LEDS_TRIGGER_HEARTBEAT=y
> CONFIG_LEDS_TRIGGER_BACKLIGHT=y
> CONFIG_LEDS_TRIGGER_CPU=y
> CONFIG_LEDS_TRIGGER_ACTIVITY=y
> CONFIG_LEDS_TRIGGER_GPIO=y
> # CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set
> 
> #
> # iptables trigger is under Netfilter config (LED target)
> #
> CONFIG_LEDS_TRIGGER_TRANSIENT=y
> # CONFIG_LEDS_TRIGGER_CAMERA is not set
> # CONFIG_LEDS_TRIGGER_PANIC is not set
> # CONFIG_LEDS_TRIGGER_NETDEV is not set
> CONFIG_ACCESSIBILITY=y
> # CONFIG_INFINIBAND is not set
> CONFIG_EDAC_ATOMIC_SCRUB=y
> CONFIG_EDAC_SUPPORT=y
> # CONFIG_EDAC is not set
> CONFIG_RTC_LIB=y
> CONFIG_RTC_MC146818_LIB=y
> CONFIG_RTC_CLASS=y
> # CONFIG_RTC_HCTOSYS is not set
> CONFIG_RTC_SYSTOHC=y
> CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
> # CONFIG_RTC_DEBUG is not set
> # CONFIG_RTC_NVMEM is not set
> 
> #
> # RTC interfaces
> #
> CONFIG_RTC_INTF_SYSFS=y
> # CONFIG_RTC_INTF_PROC is not set
> CONFIG_RTC_INTF_DEV=y
> CONFIG_RTC_INTF_DEV_UIE_EMUL=y
> # CONFIG_RTC_DRV_TEST is not set
> 
> #
> # I2C RTC drivers
> #
> CONFIG_RTC_DRV_88PM860X=y
> CONFIG_RTC_DRV_ABB5ZES3=y
> CONFIG_RTC_DRV_ABX80X=y
> CONFIG_RTC_DRV_DS1307=y
> CONFIG_RTC_DRV_DS1307_CENTURY=y
> # CONFIG_RTC_DRV_DS1374 is not set
> # CONFIG_RTC_DRV_DS1672 is not set
> CONFIG_RTC_DRV_HYM8563=y
> CONFIG_RTC_DRV_LP8788=y
> CONFIG_RTC_DRV_MAX6900=y
> CONFIG_RTC_DRV_MAX8907=y
> # CONFIG_RTC_DRV_MAX8925 is not set
> CONFIG_RTC_DRV_MAX8997=y
> CONFIG_RTC_DRV_MAX77686=y
> CONFIG_RTC_DRV_RK808=y
> CONFIG_RTC_DRV_RS5C372=y
> # CONFIG_RTC_DRV_ISL1208 is not set
> CONFIG_RTC_DRV_ISL12022=y
> CONFIG_RTC_DRV_ISL12026=y
> CONFIG_RTC_DRV_X1205=y
> CONFIG_RTC_DRV_PCF8523=y
> CONFIG_RTC_DRV_PCF85063=y
> # CONFIG_RTC_DRV_PCF85363 is not set
> CONFIG_RTC_DRV_PCF8563=y
> # CONFIG_RTC_DRV_PCF8583 is not set
> CONFIG_RTC_DRV_M41T80=y
> # CONFIG_RTC_DRV_M41T80_WDT is not set
> CONFIG_RTC_DRV_BQ32K=y
> # CONFIG_RTC_DRV_PALMAS is not set
> CONFIG_RTC_DRV_S35390A=y
> # CONFIG_RTC_DRV_FM3130 is not set
> CONFIG_RTC_DRV_RX8010=y
> # CONFIG_RTC_DRV_RX8581 is not set
> # CONFIG_RTC_DRV_RX8025 is not set
> CONFIG_RTC_DRV_EM3027=y
> # CONFIG_RTC_DRV_RV8803 is not set
> 
> #
> # SPI RTC drivers
> #
> # CONFIG_RTC_DRV_M41T93 is not set
> CONFIG_RTC_DRV_M41T94=y
> CONFIG_RTC_DRV_DS1302=y
> # CONFIG_RTC_DRV_DS1305 is not set
> CONFIG_RTC_DRV_DS1343=y
> # CONFIG_RTC_DRV_DS1347 is not set
> CONFIG_RTC_DRV_DS1390=y
> CONFIG_RTC_DRV_MAX6916=y
> CONFIG_RTC_DRV_R9701=y
> CONFIG_RTC_DRV_RX4581=y
> CONFIG_RTC_DRV_RX6110=y
> CONFIG_RTC_DRV_RS5C348=y
> CONFIG_RTC_DRV_MAX6902=y
> CONFIG_RTC_DRV_PCF2123=y
> CONFIG_RTC_DRV_MCP795=y
> CONFIG_RTC_I2C_AND_SPI=y
> 
> #
> # SPI and I2C RTC drivers
> #
> # CONFIG_RTC_DRV_DS3232 is not set
> CONFIG_RTC_DRV_PCF2127=y
> CONFIG_RTC_DRV_RV3029C2=y
> # CONFIG_RTC_DRV_RV3029_HWMON is not set
> 
> #
> # Platform RTC drivers
> #
> CONFIG_RTC_DRV_CMOS=y
> CONFIG_RTC_DRV_DS1286=y
> # CONFIG_RTC_DRV_DS1511 is not set
> CONFIG_RTC_DRV_DS1553=y
> CONFIG_RTC_DRV_DS1685_FAMILY=y
> CONFIG_RTC_DRV_DS1685=y
> # CONFIG_RTC_DRV_DS1689 is not set
> # CONFIG_RTC_DRV_DS17285 is not set
> # CONFIG_RTC_DRV_DS17485 is not set
> # CONFIG_RTC_DRV_DS17885 is not set
> # CONFIG_RTC_DS1685_PROC_REGS is not set
> # CONFIG_RTC_DRV_DS1742 is not set
> CONFIG_RTC_DRV_DS2404=y
> # CONFIG_RTC_DRV_DA9055 is not set
> CONFIG_RTC_DRV_DA9063=y
> # CONFIG_RTC_DRV_STK17TA8 is not set
> CONFIG_RTC_DRV_M48T86=y
> # CONFIG_RTC_DRV_M48T35 is not set
> # CONFIG_RTC_DRV_M48T59 is not set
> # CONFIG_RTC_DRV_MSM6242 is not set
> CONFIG_RTC_DRV_BQ4802=y
> CONFIG_RTC_DRV_RP5C01=y
> CONFIG_RTC_DRV_V3020=y
> CONFIG_RTC_DRV_WM831X=y
> CONFIG_RTC_DRV_WM8350=y
> # CONFIG_RTC_DRV_ZYNQMP is not set
> CONFIG_RTC_DRV_CROS_EC=y
> 
> #
> # on-CPU RTC drivers
> #
> # CONFIG_RTC_DRV_FTRTC010 is not set
> CONFIG_RTC_DRV_SNVS=y
> CONFIG_RTC_DRV_MT6397=y
> CONFIG_RTC_DRV_R7301=y
> CONFIG_RTC_DRV_CPCAP=y
> 
> #
> # HID Sensor RTC drivers
> #
> # CONFIG_DMADEVICES is not set
> 
> #
> # DMABUF options
> #
> CONFIG_SYNC_FILE=y
> CONFIG_SW_SYNC=y
> CONFIG_AUXDISPLAY=y
> # CONFIG_HD44780 is not set
> # CONFIG_IMG_ASCII_LCD is not set
> # CONFIG_HT16K33 is not set
> CONFIG_UIO=y
> # CONFIG_UIO_CIF is not set
> CONFIG_UIO_PDRV_GENIRQ=y
> CONFIG_UIO_DMEM_GENIRQ=y
> CONFIG_UIO_AEC=y
> # CONFIG_UIO_SERCOS3 is not set
> CONFIG_UIO_PCI_GENERIC=y
> CONFIG_UIO_NETX=y
> # CONFIG_UIO_PRUSS is not set
> CONFIG_UIO_MF624=y
> CONFIG_VIRT_DRIVERS=y
> CONFIG_VBOXGUEST=y
> CONFIG_VIRTIO=y
> CONFIG_VIRTIO_MENU=y
> CONFIG_VIRTIO_PCI=y
> # CONFIG_VIRTIO_PCI_LEGACY is not set
> CONFIG_VIRTIO_BALLOON=y
> # CONFIG_VIRTIO_INPUT is not set
> CONFIG_VIRTIO_MMIO=y
> # CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set
> 
> #
> # Microsoft Hyper-V guest support
> #
> # CONFIG_HYPERV is not set
> CONFIG_STAGING=y
> # CONFIG_COMEDI is not set
> 
> #
> # IIO staging drivers
> #
> 
> #
> # Accelerometers
> #
> CONFIG_ADIS16203=y
> CONFIG_ADIS16240=y
> 
> #
> # Analog to digital converters
> #
> # CONFIG_AD7606 is not set
> # CONFIG_AD7780 is not set
> # CONFIG_AD7816 is not set
> # CONFIG_AD7192 is not set
> CONFIG_AD7280=y
> 
> #
> # Analog digital bi-direction converters
> #
> CONFIG_ADT7316=y
> CONFIG_ADT7316_SPI=y
> CONFIG_ADT7316_I2C=y
> 
> #
> # Capacitance to digital converters
> #
> # CONFIG_AD7150 is not set
> CONFIG_AD7152=y
> CONFIG_AD7746=y
> 
> #
> # Direct Digital Synthesis
> #
> # CONFIG_AD9832 is not set
> # CONFIG_AD9834 is not set
> 
> #
> # Network Analyzer, Impedance Converters
> #
> # CONFIG_AD5933 is not set
> 
> #
> # Active energy metering IC
> #
> # CONFIG_ADE7854 is not set
> 
> #
> # Resolver to digital converters
> #
> CONFIG_AD2S90=y
> CONFIG_AD2S1210=y
> # CONFIG_FB_SM750 is not set
> CONFIG_FB_XGI=y
> 
> #
> # Speakup console speech
> #
> CONFIG_STAGING_MEDIA=y
> 
> #
> # Android
> #
> # CONFIG_ASHMEM is not set
> CONFIG_ANDROID_VSOC=y
> CONFIG_ION=y
> # CONFIG_ION_SYSTEM_HEAP is not set
> CONFIG_ION_CARVEOUT_HEAP=y
> # CONFIG_ION_CHUNK_HEAP is not set
> CONFIG_STAGING_BOARD=y
> CONFIG_FIREWIRE_SERIAL=y
> CONFIG_FWTTY_MAX_TOTAL_PORTS=64
> CONFIG_FWTTY_MAX_CARD_PORTS=32
> CONFIG_GOLDFISH_AUDIO=y
> # CONFIG_MTD_SPINAND_MT29F is not set
> # CONFIG_DGNC is not set
> # CONFIG_GS_FPGABOOT is not set
> CONFIG_UNISYSSPAR=y
> CONFIG_COMMON_CLK_XLNX_CLKWZRD=y
> CONFIG_FB_TFT=y
> CONFIG_FB_TFT_AGM1264K_FL=y
> CONFIG_FB_TFT_BD663474=y
> CONFIG_FB_TFT_HX8340BN=y
> CONFIG_FB_TFT_HX8347D=y
> CONFIG_FB_TFT_HX8353D=y
> CONFIG_FB_TFT_HX8357D=y
> # CONFIG_FB_TFT_ILI9163 is not set
> CONFIG_FB_TFT_ILI9320=y
> CONFIG_FB_TFT_ILI9325=y
> CONFIG_FB_TFT_ILI9340=y
> # CONFIG_FB_TFT_ILI9341 is not set
> CONFIG_FB_TFT_ILI9481=y
> CONFIG_FB_TFT_ILI9486=y
> CONFIG_FB_TFT_PCD8544=y
> CONFIG_FB_TFT_RA8875=y
> CONFIG_FB_TFT_S6D02A1=y
> CONFIG_FB_TFT_S6D1121=y
> CONFIG_FB_TFT_SH1106=y
> CONFIG_FB_TFT_SSD1289=y
> CONFIG_FB_TFT_SSD1305=y
> # CONFIG_FB_TFT_SSD1306 is not set
> CONFIG_FB_TFT_SSD1331=y
> CONFIG_FB_TFT_SSD1351=y
> # CONFIG_FB_TFT_ST7735R is not set
> # CONFIG_FB_TFT_ST7789V is not set
> CONFIG_FB_TFT_TINYLCD=y
> # CONFIG_FB_TFT_TLS8204 is not set
> CONFIG_FB_TFT_UC1611=y
> # CONFIG_FB_TFT_UC1701 is not set
> # CONFIG_FB_TFT_UPD161704 is not set
> CONFIG_FB_TFT_WATTEROTT=y
> CONFIG_FB_FLEX=y
> # CONFIG_FB_TFT_FBTFT_DEVICE is not set
> # CONFIG_MOST is not set
> # CONFIG_KS7010 is not set
> CONFIG_GREYBUS=y
> CONFIG_GREYBUS_BOOTROM=y
> # CONFIG_GREYBUS_FIRMWARE is not set
> CONFIG_GREYBUS_HID=y
> # CONFIG_GREYBUS_LIGHT is not set
> CONFIG_GREYBUS_LOG=y
> # CONFIG_GREYBUS_LOOPBACK is not set
> CONFIG_GREYBUS_POWER=y
> CONFIG_GREYBUS_RAW=y
> # CONFIG_GREYBUS_VIBRATOR is not set
> # CONFIG_GREYBUS_BRIDGED_PHY is not set
> # CONFIG_DRM_VBOXVIDEO is not set
> CONFIG_PI433=y
> CONFIG_MTK_MMC=y
> # CONFIG_MTK_AEE_KDUMP is not set
> # CONFIG_MTK_MMC_CD_POLL is not set
> 
> #
> # Gasket devices
> #
> CONFIG_XIL_AXIS_FIFO=y
> CONFIG_X86_PLATFORM_DEVICES=y
> # CONFIG_ACER_WIRELESS is not set
> # CONFIG_ACERHDF is not set
> # CONFIG_ASUS_LAPTOP is not set
> # CONFIG_DELL_SMBIOS is not set
> # CONFIG_DELL_SMO8800 is not set
> # CONFIG_FUJITSU_LAPTOP is not set
> # CONFIG_FUJITSU_TABLET is not set
> # CONFIG_GPD_POCKET_FAN is not set
> # CONFIG_HP_ACCEL is not set
> # CONFIG_HP_WIRELESS is not set
> # CONFIG_PANASONIC_LAPTOP is not set
> # CONFIG_THINKPAD_ACPI is not set
> # CONFIG_SENSORS_HDAPS is not set
> # CONFIG_INTEL_MENLOW is not set
> # CONFIG_EEEPC_LAPTOP is not set
> # CONFIG_ASUS_WIRELESS is not set
> # CONFIG_ACPI_WMI is not set
> # CONFIG_TOPSTAR_LAPTOP is not set
> # CONFIG_TOSHIBA_BT_RFKILL is not set
> # CONFIG_TOSHIBA_HAPS is not set
> # CONFIG_ACPI_CMPC is not set
> # CONFIG_INTEL_INT0002_VGPIO is not set
> # CONFIG_INTEL_HID_EVENT is not set
> # CONFIG_INTEL_VBTN is not set
> # CONFIG_INTEL_IPS is not set
> # CONFIG_INTEL_PMC_CORE is not set
> # CONFIG_IBM_RTL is not set
> # CONFIG_SAMSUNG_LAPTOP is not set
> # CONFIG_SAMSUNG_Q10 is not set
> # CONFIG_APPLE_GMUX is not set
> # CONFIG_INTEL_RST is not set
> # CONFIG_INTEL_SMARTCONNECT is not set
> CONFIG_PVPANIC=y
> # CONFIG_INTEL_PMC_IPC is not set
> # CONFIG_SURFACE_PRO3_BUTTON is not set
> CONFIG_INTEL_PUNIT_IPC=y
> CONFIG_MLX_PLATFORM=y
> # CONFIG_I2C_MULTI_INSTANTIATE is not set
> CONFIG_PMC_ATOM=y
> # CONFIG_GOLDFISH_PIPE is not set
> CONFIG_CHROME_PLATFORMS=y
> CONFIG_CHROMEOS_LAPTOP=y
> CONFIG_CHROMEOS_PSTORE=y
> # CONFIG_CHROMEOS_TBMC is not set
> CONFIG_CROS_EC_CTL=y
> CONFIG_CROS_EC_I2C=y
> # CONFIG_CROS_EC_SPI is not set
> # CONFIG_CROS_EC_LPC is not set
> CONFIG_CROS_EC_PROTO=y
> # CONFIG_CROS_KBD_LED_BACKLIGHT is not set
> # CONFIG_MELLANOX_PLATFORM is not set
> CONFIG_CLKDEV_LOOKUP=y
> CONFIG_HAVE_CLK_PREPARE=y
> CONFIG_COMMON_CLK=y
> 
> #
> # Common Clock Framework
> #
> CONFIG_COMMON_CLK_WM831X=y
> # CONFIG_CLK_HSDK is not set
> CONFIG_COMMON_CLK_MAX77686=y
> CONFIG_COMMON_CLK_MAX9485=y
> # CONFIG_COMMON_CLK_RK808 is not set
> CONFIG_COMMON_CLK_SI5351=y
> CONFIG_COMMON_CLK_SI514=y
> # CONFIG_COMMON_CLK_SI544 is not set
> CONFIG_COMMON_CLK_SI570=y
> CONFIG_COMMON_CLK_CDCE706=y
> # CONFIG_COMMON_CLK_CDCE925 is not set
> CONFIG_COMMON_CLK_CS2000_CP=y
> CONFIG_CLK_TWL6040=y
> CONFIG_COMMON_CLK_PALMAS=y
> CONFIG_COMMON_CLK_PWM=y
> CONFIG_COMMON_CLK_VC5=y
> # CONFIG_HWSPINLOCK is not set
> 
> #
> # Clock Source drivers
> #
> CONFIG_CLKSRC_I8253=y
> CONFIG_CLKEVT_I8253=y
> CONFIG_I8253_LOCK=y
> CONFIG_CLKBLD_I8253=y
> CONFIG_MAILBOX=y
> CONFIG_PLATFORM_MHU=y
> # CONFIG_PCC is not set
> # CONFIG_ALTERA_MBOX is not set
> CONFIG_MAILBOX_TEST=y
> # CONFIG_IOMMU_SUPPORT is not set
> 
> #
> # Remoteproc drivers
> #
> # CONFIG_REMOTEPROC is not set
> 
> #
> # Rpmsg drivers
> #
> CONFIG_RPMSG=y
> # CONFIG_RPMSG_CHAR is not set
> CONFIG_RPMSG_QCOM_GLINK_NATIVE=y
> CONFIG_RPMSG_QCOM_GLINK_RPM=y
> CONFIG_RPMSG_VIRTIO=y
> # CONFIG_SOUNDWIRE is not set
> 
> #
> # SOC (System On Chip) specific Drivers
> #
> 
> #
> # Amlogic SoC drivers
> #
> 
> #
> # Broadcom SoC drivers
> #
> 
> #
> # NXP/Freescale QorIQ SoC drivers
> #
> 
> #
> # i.MX SoC drivers
> #
> 
> #
> # Qualcomm SoC drivers
> #
> # CONFIG_SOC_TI is not set
> 
> #
> # Xilinx SoC drivers
> #
> # CONFIG_XILINX_VCU is not set
> CONFIG_PM_DEVFREQ=y
> 
> #
> # DEVFREQ Governors
> #
> CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
> CONFIG_DEVFREQ_GOV_PERFORMANCE=y
> # CONFIG_DEVFREQ_GOV_POWERSAVE is not set
> CONFIG_DEVFREQ_GOV_USERSPACE=y
> CONFIG_DEVFREQ_GOV_PASSIVE=y
> 
> #
> # DEVFREQ Drivers
> #
> CONFIG_PM_DEVFREQ_EVENT=y
> CONFIG_EXTCON=y
> 
> #
> # Extcon Device Drivers
> #
> CONFIG_EXTCON_ADC_JACK=y
> # CONFIG_EXTCON_AXP288 is not set
> # CONFIG_EXTCON_GPIO is not set
> # CONFIG_EXTCON_INTEL_INT3496 is not set
> CONFIG_EXTCON_MAX14577=y
> # CONFIG_EXTCON_MAX3355 is not set
> # CONFIG_EXTCON_MAX77693 is not set
> CONFIG_EXTCON_MAX77843=y
> # CONFIG_EXTCON_MAX8997 is not set
> CONFIG_EXTCON_PALMAS=y
> CONFIG_EXTCON_RT8973A=y
> CONFIG_EXTCON_SM5502=y
> CONFIG_EXTCON_USB_GPIO=y
> # CONFIG_EXTCON_USBC_CROS_EC is not set
> CONFIG_MEMORY=y
> CONFIG_IIO=y
> CONFIG_IIO_BUFFER=y
> CONFIG_IIO_BUFFER_CB=y
> CONFIG_IIO_BUFFER_HW_CONSUMER=y
> CONFIG_IIO_KFIFO_BUF=y
> CONFIG_IIO_TRIGGERED_BUFFER=y
> CONFIG_IIO_CONFIGFS=y
> CONFIG_IIO_TRIGGER=y
> CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
> # CONFIG_IIO_SW_DEVICE is not set
> CONFIG_IIO_SW_TRIGGER=y
> 
> #
> # Accelerometers
> #
> CONFIG_ADIS16201=y
> # CONFIG_ADIS16209 is not set
> CONFIG_BMA180=y
> # CONFIG_BMA220 is not set
> # CONFIG_BMC150_ACCEL is not set
> CONFIG_DA280=y
> # CONFIG_DA311 is not set
> CONFIG_DMARD06=y
> # CONFIG_DMARD09 is not set
> CONFIG_DMARD10=y
> CONFIG_HID_SENSOR_ACCEL_3D=y
> CONFIG_IIO_CROS_EC_ACCEL_LEGACY=y
> # CONFIG_KXSD9 is not set
> CONFIG_KXCJK1013=y
> CONFIG_MC3230=y
> # CONFIG_MMA7455_I2C is not set
> # CONFIG_MMA7455_SPI is not set
> # CONFIG_MMA7660 is not set
> # CONFIG_MMA8452 is not set
> CONFIG_MMA9551_CORE=y
> CONFIG_MMA9551=y
> # CONFIG_MMA9553 is not set
> CONFIG_MXC4005=y
> # CONFIG_MXC6255 is not set
> CONFIG_SCA3000=y
> # CONFIG_STK8312 is not set
> # CONFIG_STK8BA50 is not set
> 
> #
> # Analog to digital converters
> #
> CONFIG_AD_SIGMA_DELTA=y
> CONFIG_AD7266=y
> CONFIG_AD7291=y
> CONFIG_AD7298=y
> # CONFIG_AD7476 is not set
> CONFIG_AD7766=y
> CONFIG_AD7791=y
> # CONFIG_AD7793 is not set
> CONFIG_AD7887=y
> CONFIG_AD7923=y
> CONFIG_AD799X=y
> CONFIG_AXP20X_ADC=y
> # CONFIG_AXP288_ADC is not set
> # CONFIG_CPCAP_ADC is not set
> # CONFIG_ENVELOPE_DETECTOR is not set
> # CONFIG_HI8435 is not set
> # CONFIG_HX711 is not set
> CONFIG_LP8788_ADC=y
> # CONFIG_LTC2471 is not set
> CONFIG_LTC2485=y
> CONFIG_LTC2497=y
> CONFIG_MAX1027=y
> CONFIG_MAX11100=y
> CONFIG_MAX1118=y
> CONFIG_MAX1363=y
> CONFIG_MAX9611=y
> CONFIG_MCP320X=y
> # CONFIG_MCP3422 is not set
> CONFIG_NAU7802=y
> CONFIG_PALMAS_GPADC=y
> CONFIG_SD_ADC_MODULATOR=y
> # CONFIG_STX104 is not set
> CONFIG_TI_ADC081C=y
> # CONFIG_TI_ADC0832 is not set
> CONFIG_TI_ADC084S021=y
> # CONFIG_TI_ADC12138 is not set
> CONFIG_TI_ADC108S102=y
> CONFIG_TI_ADC128S052=y
> CONFIG_TI_ADC161S626=y
> CONFIG_TI_ADS7950=y
> # CONFIG_TI_ADS8688 is not set
> # CONFIG_TI_TLC4541 is not set
> CONFIG_VF610_ADC=y
> 
> #
> # Analog Front Ends
> #
> CONFIG_IIO_RESCALE=y
> 
> #
> # Amplifiers
> #
> CONFIG_AD8366=y
> 
> #
> # Chemical Sensors
> #
> CONFIG_ATLAS_PH_SENSOR=y
> CONFIG_BME680=y
> CONFIG_BME680_I2C=y
> CONFIG_BME680_SPI=y
> CONFIG_CCS811=y
> CONFIG_IAQCORE=y
> CONFIG_VZ89X=y
> CONFIG_IIO_CROS_EC_SENSORS_CORE=y
> # CONFIG_IIO_CROS_EC_SENSORS is not set
> 
> #
> # Hid Sensor IIO Common
> #
> CONFIG_HID_SENSOR_IIO_COMMON=y
> CONFIG_HID_SENSOR_IIO_TRIGGER=y
> CONFIG_IIO_MS_SENSORS_I2C=y
> 
> #
> # SSP Sensor Common
> #
> CONFIG_IIO_SSP_SENSORS_COMMONS=y
> CONFIG_IIO_SSP_SENSORHUB=y
> CONFIG_IIO_ST_SENSORS_I2C=y
> CONFIG_IIO_ST_SENSORS_SPI=y
> CONFIG_IIO_ST_SENSORS_CORE=y
> 
> #
> # Counters
> #
> CONFIG_104_QUAD_8=y
> 
> #
> # Digital to analog converters
> #
> # CONFIG_AD5064 is not set
> # CONFIG_AD5360 is not set
> CONFIG_AD5380=y
> CONFIG_AD5421=y
> # CONFIG_AD5446 is not set
> # CONFIG_AD5449 is not set
> CONFIG_AD5592R_BASE=y
> CONFIG_AD5592R=y
> CONFIG_AD5593R=y
> # CONFIG_AD5504 is not set
> # CONFIG_AD5624R_SPI is not set
> # CONFIG_LTC2632 is not set
> CONFIG_AD5686=y
> CONFIG_AD5686_SPI=y
> CONFIG_AD5696_I2C=y
> CONFIG_AD5755=y
> CONFIG_AD5758=y
> CONFIG_AD5761=y
> CONFIG_AD5764=y
> CONFIG_AD5791=y
> # CONFIG_AD7303 is not set
> CONFIG_CIO_DAC=y
> CONFIG_AD8801=y
> CONFIG_DPOT_DAC=y
> CONFIG_DS4424=y
> # CONFIG_M62332 is not set
> CONFIG_MAX517=y
> CONFIG_MAX5821=y
> # CONFIG_MCP4725 is not set
> # CONFIG_MCP4922 is not set
> # CONFIG_TI_DAC082S085 is not set
> # CONFIG_TI_DAC5571 is not set
> CONFIG_VF610_DAC=y
> 
> #
> # IIO dummy driver
> #
> 
> #
> # Frequency Synthesizers DDS/PLL
> #
> 
> #
> # Clock Generator/Distribution
> #
> # CONFIG_AD9523 is not set
> 
> #
> # Phase-Locked Loop (PLL) frequency synthesizers
> #
> CONFIG_ADF4350=y
> 
> #
> # Digital gyroscope sensors
> #
> # CONFIG_ADIS16080 is not set
> CONFIG_ADIS16130=y
> # CONFIG_ADIS16136 is not set
> CONFIG_ADIS16260=y
> CONFIG_ADXRS450=y
> CONFIG_BMG160=y
> CONFIG_BMG160_I2C=y
> CONFIG_BMG160_SPI=y
> CONFIG_HID_SENSOR_GYRO_3D=y
> CONFIG_MPU3050=y
> CONFIG_MPU3050_I2C=y
> # CONFIG_IIO_ST_GYRO_3AXIS is not set
> # CONFIG_ITG3200 is not set
> 
> #
> # Health Sensors
> #
> 
> #
> # Heart Rate Monitors
> #
> CONFIG_AFE4403=y
> CONFIG_AFE4404=y
> CONFIG_MAX30100=y
> CONFIG_MAX30102=y
> 
> #
> # Humidity sensors
> #
> # CONFIG_AM2315 is not set
> # CONFIG_DHT11 is not set
> CONFIG_HDC100X=y
> # CONFIG_HID_SENSOR_HUMIDITY is not set
> # CONFIG_HTS221 is not set
> CONFIG_HTU21=y
> CONFIG_SI7005=y
> CONFIG_SI7020=y
> 
> #
> # Inertial measurement units
> #
> # CONFIG_ADIS16400 is not set
> CONFIG_ADIS16480=y
> CONFIG_BMI160=y
> CONFIG_BMI160_I2C=y
> CONFIG_BMI160_SPI=y
> # CONFIG_KMX61 is not set
> CONFIG_INV_MPU6050_IIO=y
> # CONFIG_INV_MPU6050_I2C is not set
> CONFIG_INV_MPU6050_SPI=y
> # CONFIG_IIO_ST_LSM6DSX is not set
> CONFIG_IIO_ADIS_LIB=y
> CONFIG_IIO_ADIS_LIB_BUFFER=y
> 
> #
> # Light sensors
> #
> # CONFIG_ACPI_ALS is not set
> # CONFIG_ADJD_S311 is not set
> CONFIG_AL3320A=y
> CONFIG_APDS9300=y
> # CONFIG_APDS9960 is not set
> CONFIG_BH1750=y
> CONFIG_BH1780=y
> # CONFIG_CM32181 is not set
> CONFIG_CM3232=y
> # CONFIG_CM3323 is not set
> CONFIG_CM3605=y
> CONFIG_CM36651=y
> CONFIG_IIO_CROS_EC_LIGHT_PROX=y
> # CONFIG_GP2AP020A00F is not set
> CONFIG_SENSORS_ISL29018=y
> # CONFIG_SENSORS_ISL29028 is not set
> CONFIG_ISL29125=y
> CONFIG_HID_SENSOR_ALS=y
> CONFIG_HID_SENSOR_PROX=y
> CONFIG_JSA1212=y
> CONFIG_RPR0521=y
> CONFIG_SENSORS_LM3533=y
> CONFIG_LTR501=y
> CONFIG_LV0104CS=y
> CONFIG_MAX44000=y
> # CONFIG_OPT3001 is not set
> CONFIG_PA12203001=y
> # CONFIG_SI1133 is not set
> CONFIG_SI1145=y
> CONFIG_STK3310=y
> # CONFIG_ST_UVIS25 is not set
> CONFIG_TCS3414=y
> CONFIG_TCS3472=y
> # CONFIG_SENSORS_TSL2563 is not set
> CONFIG_TSL2583=y
> CONFIG_TSL2772=y
> CONFIG_TSL4531=y
> CONFIG_US5182D=y
> CONFIG_VCNL4000=y
> # CONFIG_VEML6070 is not set
> CONFIG_VL6180=y
> CONFIG_ZOPT2201=y
> 
> #
> # Magnetometer sensors
> #
> CONFIG_AK8974=y
> CONFIG_AK8975=y
> CONFIG_AK09911=y
> CONFIG_BMC150_MAGN=y
> # CONFIG_BMC150_MAGN_I2C is not set
> CONFIG_BMC150_MAGN_SPI=y
> CONFIG_MAG3110=y
> CONFIG_HID_SENSOR_MAGNETOMETER_3D=y
> # CONFIG_MMC35240 is not set
> CONFIG_IIO_ST_MAGN_3AXIS=y
> CONFIG_IIO_ST_MAGN_I2C_3AXIS=y
> CONFIG_IIO_ST_MAGN_SPI_3AXIS=y
> CONFIG_SENSORS_HMC5843=y
> CONFIG_SENSORS_HMC5843_I2C=y
> # CONFIG_SENSORS_HMC5843_SPI is not set
> 
> #
> # Multiplexers
> #
> # CONFIG_IIO_MUX is not set
> 
> #
> # Inclinometer sensors
> #
> CONFIG_HID_SENSOR_INCLINOMETER_3D=y
> CONFIG_HID_SENSOR_DEVICE_ROTATION=y
> 
> #
> # Triggers - standalone
> #
> CONFIG_IIO_HRTIMER_TRIGGER=y
> # CONFIG_IIO_INTERRUPT_TRIGGER is not set
> CONFIG_IIO_TIGHTLOOP_TRIGGER=y
> CONFIG_IIO_SYSFS_TRIGGER=y
> 
> #
> # Digital potentiometers
> #
> # CONFIG_AD5272 is not set
> CONFIG_DS1803=y
> CONFIG_MAX5481=y
> # CONFIG_MAX5487 is not set
> # CONFIG_MCP4018 is not set
> CONFIG_MCP4131=y
> CONFIG_MCP4531=y
> CONFIG_TPL0102=y
> 
> #
> # Digital potentiostats
> #
> CONFIG_LMP91000=y
> 
> #
> # Pressure sensors
> #
> CONFIG_ABP060MG=y
> CONFIG_BMP280=y
> CONFIG_BMP280_I2C=y
> CONFIG_BMP280_SPI=y
> # CONFIG_IIO_CROS_EC_BARO is not set
> # CONFIG_HID_SENSOR_PRESS is not set
> # CONFIG_HP03 is not set
> CONFIG_MPL115=y
> CONFIG_MPL115_I2C=y
> CONFIG_MPL115_SPI=y
> # CONFIG_MPL3115 is not set
> CONFIG_MS5611=y
> CONFIG_MS5611_I2C=y
> CONFIG_MS5611_SPI=y
> # CONFIG_MS5637 is not set
> # CONFIG_IIO_ST_PRESS is not set
> CONFIG_T5403=y
> CONFIG_HP206C=y
> CONFIG_ZPA2326=y
> CONFIG_ZPA2326_I2C=y
> CONFIG_ZPA2326_SPI=y
> 
> #
> # Lightning sensors
> #
> # CONFIG_AS3935 is not set
> 
> #
> # Proximity and distance sensors
> #
> # CONFIG_ISL29501 is not set
> # CONFIG_LIDAR_LITE_V2 is not set
> CONFIG_RFD77402=y
> # CONFIG_SRF04 is not set
> CONFIG_SX9500=y
> CONFIG_SRF08=y
> 
> #
> # Resolver to digital converters
> #
> # CONFIG_AD2S1200 is not set
> 
> #
> # Temperature sensors
> #
> CONFIG_MAXIM_THERMOCOUPLE=y
> CONFIG_HID_SENSOR_TEMP=y
> # CONFIG_MLX90614 is not set
> CONFIG_MLX90632=y
> # CONFIG_TMP006 is not set
> # CONFIG_TMP007 is not set
> # CONFIG_TSYS01 is not set
> # CONFIG_TSYS02D is not set
> CONFIG_NTB=y
> CONFIG_NTB_IDT=y
> CONFIG_NTB_SWITCHTEC=y
> # CONFIG_NTB_PINGPONG is not set
> CONFIG_NTB_TOOL=y
> CONFIG_NTB_PERF=y
> CONFIG_NTB_TRANSPORT=y
> # CONFIG_VME_BUS is not set
> CONFIG_PWM=y
> CONFIG_PWM_SYSFS=y
> # CONFIG_PWM_ATMEL_HLCDC_PWM is not set
> # CONFIG_PWM_CROS_EC is not set
> CONFIG_PWM_FSL_FTM=y
> CONFIG_PWM_LP3943=y
> CONFIG_PWM_LPSS=y
> CONFIG_PWM_LPSS_PCI=y
> # CONFIG_PWM_LPSS_PLATFORM is not set
> # CONFIG_PWM_PCA9685 is not set
> CONFIG_PWM_STMPE=y
> 
> #
> # IRQ chip support
> #
> CONFIG_IRQCHIP=y
> CONFIG_ARM_GIC_MAX_NR=1
> # CONFIG_IPACK_BUS is not set
> CONFIG_RESET_CONTROLLER=y
> CONFIG_RESET_TI_SYSCON=y
> CONFIG_FMC=y
> CONFIG_FMC_FAKEDEV=y
> CONFIG_FMC_TRIVIAL=y
> CONFIG_FMC_WRITE_EEPROM=y
> CONFIG_FMC_CHARDEV=y
> 
> #
> # PHY Subsystem
> #
> CONFIG_GENERIC_PHY=y
> # CONFIG_BCM_KONA_USB2_PHY is not set
> CONFIG_PHY_PXA_28NM_HSIC=y
> CONFIG_PHY_PXA_28NM_USB2=y
> # CONFIG_PHY_CPCAP_USB is not set
> # CONFIG_PHY_MAPPHONE_MDM6600 is not set
> CONFIG_POWERCAP=y
> CONFIG_INTEL_RAPL=y
> # CONFIG_IDLE_INJECT is not set
> # CONFIG_MCB is not set
> 
> #
> # Performance monitor support
> #
> CONFIG_RAS=y
> # CONFIG_THUNDERBOLT is not set
> 
> #
> # Android
> #
> CONFIG_ANDROID=y
> CONFIG_ANDROID_BINDER_IPC=y
> CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
> # CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
> # CONFIG_DAX is not set
> CONFIG_NVMEM=y
> 
> #
> # HW tracing support
> #
> # CONFIG_STM is not set
> CONFIG_INTEL_TH=y
> # CONFIG_INTEL_TH_PCI is not set
> # CONFIG_INTEL_TH_ACPI is not set
> CONFIG_INTEL_TH_GTH=y
> CONFIG_INTEL_TH_MSU=y
> CONFIG_INTEL_TH_PTI=y
> CONFIG_INTEL_TH_DEBUG=y
> CONFIG_FPGA=y
> # CONFIG_ALTERA_PR_IP_CORE is not set
> CONFIG_FPGA_MGR_ALTERA_PS_SPI=y
> # CONFIG_FPGA_MGR_ALTERA_CVP is not set
> CONFIG_FPGA_MGR_XILINX_SPI=y
> # CONFIG_FPGA_MGR_ICE40_SPI is not set
> CONFIG_FPGA_MGR_MACHXO2_SPI=y
> CONFIG_FPGA_BRIDGE=y
> CONFIG_XILINX_PR_DECOUPLER=y
> CONFIG_FPGA_REGION=y
> CONFIG_OF_FPGA_REGION=y
> CONFIG_FPGA_DFL=y
> # CONFIG_FPGA_DFL_FME is not set
> # CONFIG_FPGA_DFL_AFU is not set
> CONFIG_FPGA_DFL_PCI=y
> CONFIG_FSI=y
> CONFIG_FSI_NEW_DEV_NODE=y
> CONFIG_FSI_MASTER_GPIO=y
> CONFIG_FSI_MASTER_HUB=y
> CONFIG_FSI_SCOM=y
> CONFIG_FSI_SBEFIFO=y
> CONFIG_MULTIPLEXER=y
> 
> #
> # Multiplexer drivers
> #
> # CONFIG_MUX_ADG792A is not set
> # CONFIG_MUX_ADGS1408 is not set
> # CONFIG_MUX_GPIO is not set
> CONFIG_MUX_MMIO=y
> CONFIG_PM_OPP=y
> CONFIG_SIOX=y
> CONFIG_SIOX_BUS_GPIO=y
> CONFIG_SLIMBUS=y
> CONFIG_SLIM_QCOM_CTRL=y
> 
> #
> # File systems
> #
> CONFIG_DCACHE_WORD_ACCESS=y
> CONFIG_FS_POSIX_ACL=y
> CONFIG_EXPORTFS=y
> # CONFIG_EXPORTFS_BLOCK_OPS is not set
> CONFIG_FILE_LOCKING=y
> # CONFIG_MANDATORY_FILE_LOCKING is not set
> # CONFIG_FS_ENCRYPTION is not set
> CONFIG_FSNOTIFY=y
> # CONFIG_DNOTIFY is not set
> CONFIG_INOTIFY_USER=y
> CONFIG_FANOTIFY=y
> CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
> CONFIG_QUOTA=y
> # CONFIG_QUOTA_NETLINK_INTERFACE is not set
> CONFIG_PRINT_QUOTA_WARNING=y
> # CONFIG_QUOTA_DEBUG is not set
> CONFIG_QUOTA_TREE=y
> CONFIG_QFMT_V1=y
> CONFIG_QFMT_V2=y
> CONFIG_QUOTACTL=y
> CONFIG_AUTOFS4_FS=y
> CONFIG_AUTOFS_FS=y
> CONFIG_FUSE_FS=y
> # CONFIG_CUSE is not set
> CONFIG_OVERLAY_FS=y
> CONFIG_OVERLAY_FS_REDIRECT_DIR=y
> # CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
> CONFIG_OVERLAY_FS_INDEX=y
> CONFIG_OVERLAY_FS_XINO_AUTO=y
> CONFIG_OVERLAY_FS_METACOPY=y
> 
> #
> # Caches
> #
> CONFIG_FSCACHE=y
> CONFIG_FSCACHE_STATS=y
> # CONFIG_FSCACHE_HISTOGRAM is not set
> # CONFIG_FSCACHE_DEBUG is not set
> # CONFIG_FSCACHE_OBJECT_LIST is not set
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> CONFIG_PROC_SYSCTL=y
> # CONFIG_PROC_PAGE_MONITOR is not set
> # CONFIG_PROC_CHILDREN is not set
> CONFIG_KERNFS=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> # CONFIG_TMPFS_POSIX_ACL is not set
> # CONFIG_TMPFS_XATTR is not set
> # CONFIG_HUGETLBFS is not set
> CONFIG_MEMFD_CREATE=y
> CONFIG_CONFIGFS_FS=y
> # CONFIG_MISC_FILESYSTEMS is not set
> CONFIG_NETWORK_FILESYSTEMS=y
> CONFIG_NFS_FS=y
> CONFIG_NFS_V2=y
> CONFIG_NFS_V3=y
> # CONFIG_NFS_V3_ACL is not set
> CONFIG_NFS_V4=y
> # CONFIG_NFS_SWAP is not set
> # CONFIG_NFS_V4_1 is not set
> # CONFIG_ROOT_NFS is not set
> # CONFIG_NFS_FSCACHE is not set
> # CONFIG_NFS_USE_LEGACY_DNS is not set
> CONFIG_NFS_USE_KERNEL_DNS=y
> # CONFIG_NFSD is not set
> CONFIG_GRACE_PERIOD=y
> CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> CONFIG_NFS_COMMON=y
> CONFIG_SUNRPC=y
> CONFIG_SUNRPC_GSS=y
> CONFIG_RPCSEC_GSS_KRB5=y
> # CONFIG_SUNRPC_DEBUG is not set
> # CONFIG_CEPH_FS is not set
> CONFIG_CIFS=y
> # CONFIG_CIFS_STATS2 is not set
> CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
> # CONFIG_CIFS_WEAK_PW_HASH is not set
> # CONFIG_CIFS_UPCALL is not set
> # CONFIG_CIFS_XATTR is not set
> CONFIG_CIFS_DEBUG=y
> # CONFIG_CIFS_DEBUG2 is not set
> # CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
> # CONFIG_CIFS_DFS_UPCALL is not set
> # CONFIG_CIFS_FSCACHE is not set
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
> # CONFIG_9P_FS is not set
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-1"
> CONFIG_NLS_CODEPAGE_437=y
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> CONFIG_NLS_CODEPAGE_850=y
> CONFIG_NLS_CODEPAGE_852=y
> CONFIG_NLS_CODEPAGE_855=y
> CONFIG_NLS_CODEPAGE_857=y
> CONFIG_NLS_CODEPAGE_860=y
> CONFIG_NLS_CODEPAGE_861=y
> CONFIG_NLS_CODEPAGE_862=y
> CONFIG_NLS_CODEPAGE_863=y
> CONFIG_NLS_CODEPAGE_864=y
> CONFIG_NLS_CODEPAGE_865=y
> CONFIG_NLS_CODEPAGE_866=y
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> CONFIG_NLS_CODEPAGE_950=y
> CONFIG_NLS_CODEPAGE_932=y
> CONFIG_NLS_CODEPAGE_949=y
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> CONFIG_NLS_CODEPAGE_1250=y
> CONFIG_NLS_CODEPAGE_1251=y
> CONFIG_NLS_ASCII=y
> CONFIG_NLS_ISO8859_1=y
> CONFIG_NLS_ISO8859_2=y
> CONFIG_NLS_ISO8859_3=y
> CONFIG_NLS_ISO8859_4=y
> # CONFIG_NLS_ISO8859_5 is not set
> CONFIG_NLS_ISO8859_6=y
> # CONFIG_NLS_ISO8859_7 is not set
> CONFIG_NLS_ISO8859_9=y
> CONFIG_NLS_ISO8859_13=y
> # CONFIG_NLS_ISO8859_14 is not set
> # CONFIG_NLS_ISO8859_15 is not set
> CONFIG_NLS_KOI8_R=y
> CONFIG_NLS_KOI8_U=y
> CONFIG_NLS_MAC_ROMAN=y
> CONFIG_NLS_MAC_CELTIC=y
> CONFIG_NLS_MAC_CENTEURO=y
> # CONFIG_NLS_MAC_CROATIAN is not set
> CONFIG_NLS_MAC_CYRILLIC=y
> CONFIG_NLS_MAC_GAELIC=y
> # CONFIG_NLS_MAC_GREEK is not set
> # CONFIG_NLS_MAC_ICELAND is not set
> # CONFIG_NLS_MAC_INUIT is not set
> CONFIG_NLS_MAC_ROMANIAN=y
> # CONFIG_NLS_MAC_TURKISH is not set
> # CONFIG_NLS_UTF8 is not set
> # CONFIG_DLM is not set
> 
> #
> # Security options
> #
> CONFIG_KEYS=y
> CONFIG_PERSISTENT_KEYRINGS=y
> # CONFIG_BIG_KEYS is not set
> # CONFIG_TRUSTED_KEYS is not set
> CONFIG_ENCRYPTED_KEYS=y
> CONFIG_KEY_DH_OPERATIONS=y
> # CONFIG_SECURITY_DMESG_RESTRICT is not set
> CONFIG_SECURITY=y
> CONFIG_SECURITYFS=y
> CONFIG_SECURITY_NETWORK=y
> # CONFIG_SECURITY_NETWORK_XFRM is not set
> # CONFIG_SECURITY_PATH is not set
> CONFIG_FORTIFY_SOURCE=y
> # CONFIG_STATIC_USERMODEHELPER is not set
> # CONFIG_SECURITY_SMACK is not set
> # CONFIG_SECURITY_TOMOYO is not set
> # CONFIG_SECURITY_APPARMOR is not set
> # CONFIG_SECURITY_YAMA is not set
> CONFIG_INTEGRITY=y
> # CONFIG_INTEGRITY_SIGNATURE is not set
> # CONFIG_IMA is not set
> CONFIG_EVM=y
> CONFIG_EVM_ATTR_FSUUID=y
> # CONFIG_EVM_ADD_XATTRS is not set
> CONFIG_DEFAULT_SECURITY_DAC=y
> CONFIG_DEFAULT_SECURITY=""
> CONFIG_CRYPTO=y
> 
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_ALGAPI=y
> CONFIG_CRYPTO_ALGAPI2=y
> CONFIG_CRYPTO_AEAD=y
> CONFIG_CRYPTO_AEAD2=y
> CONFIG_CRYPTO_BLKCIPHER=y
> CONFIG_CRYPTO_BLKCIPHER2=y
> CONFIG_CRYPTO_HASH=y
> CONFIG_CRYPTO_HASH2=y
> CONFIG_CRYPTO_RNG=y
> CONFIG_CRYPTO_RNG2=y
> CONFIG_CRYPTO_RNG_DEFAULT=y
> CONFIG_CRYPTO_AKCIPHER2=y
> CONFIG_CRYPTO_AKCIPHER=y
> CONFIG_CRYPTO_KPP2=y
> CONFIG_CRYPTO_KPP=y
> CONFIG_CRYPTO_ACOMP2=y
> CONFIG_CRYPTO_RSA=y
> CONFIG_CRYPTO_DH=y
> CONFIG_CRYPTO_ECDH=y
> CONFIG_CRYPTO_MANAGER=y
> CONFIG_CRYPTO_MANAGER2=y
> # CONFIG_CRYPTO_USER is not set
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> CONFIG_CRYPTO_GF128MUL=y
> CONFIG_CRYPTO_NULL=y
> CONFIG_CRYPTO_NULL2=y
> # CONFIG_CRYPTO_PCRYPT is not set
> CONFIG_CRYPTO_WORKQUEUE=y
> CONFIG_CRYPTO_CRYPTD=y
> # CONFIG_CRYPTO_MCRYPTD is not set
> CONFIG_CRYPTO_AUTHENC=y
> CONFIG_CRYPTO_SIMD=y
> CONFIG_CRYPTO_ENGINE=y
> 
> #
> # Authenticated Encryption with Associated Data
> #
> CONFIG_CRYPTO_CCM=y
> # CONFIG_CRYPTO_GCM is not set
> CONFIG_CRYPTO_CHACHA20POLY1305=y
> # CONFIG_CRYPTO_AEGIS128 is not set
> # CONFIG_CRYPTO_AEGIS128L is not set
> CONFIG_CRYPTO_AEGIS256=y
> # CONFIG_CRYPTO_MORUS640 is not set
> CONFIG_CRYPTO_MORUS1280=y
> CONFIG_CRYPTO_SEQIV=y
> CONFIG_CRYPTO_ECHAINIV=y
> 
> #
> # Block modes
> #
> CONFIG_CRYPTO_CBC=y
> CONFIG_CRYPTO_CFB=y
> CONFIG_CRYPTO_CTR=y
> CONFIG_CRYPTO_CTS=y
> CONFIG_CRYPTO_ECB=y
> CONFIG_CRYPTO_LRW=y
> CONFIG_CRYPTO_PCBC=y
> CONFIG_CRYPTO_XTS=y
> # CONFIG_CRYPTO_KEYWRAP is not set
> 
> #
> # Hash modes
> #
> CONFIG_CRYPTO_CMAC=y
> CONFIG_CRYPTO_HMAC=y
> # CONFIG_CRYPTO_XCBC is not set
> CONFIG_CRYPTO_VMAC=y
> 
> #
> # Digest
> #
> CONFIG_CRYPTO_CRC32C=y
> CONFIG_CRYPTO_CRC32C_INTEL=y
> CONFIG_CRYPTO_CRC32=y
> CONFIG_CRYPTO_CRC32_PCLMUL=y
> CONFIG_CRYPTO_CRCT10DIF=y
> # CONFIG_CRYPTO_GHASH is not set
> CONFIG_CRYPTO_POLY1305=y
> CONFIG_CRYPTO_MD4=y
> CONFIG_CRYPTO_MD5=y
> CONFIG_CRYPTO_MICHAEL_MIC=y
> CONFIG_CRYPTO_RMD128=y
> # CONFIG_CRYPTO_RMD160 is not set
> # CONFIG_CRYPTO_RMD256 is not set
> # CONFIG_CRYPTO_RMD320 is not set
> CONFIG_CRYPTO_SHA1=y
> CONFIG_CRYPTO_SHA256=y
> CONFIG_CRYPTO_SHA512=y
> CONFIG_CRYPTO_SHA3=y
> CONFIG_CRYPTO_SM3=y
> # CONFIG_CRYPTO_TGR192 is not set
> # CONFIG_CRYPTO_WP512 is not set
> 
> #
> # Ciphers
> #
> CONFIG_CRYPTO_AES=y
> CONFIG_CRYPTO_AES_TI=y
> CONFIG_CRYPTO_AES_586=y
> CONFIG_CRYPTO_AES_NI_INTEL=y
> # CONFIG_CRYPTO_ANUBIS is not set
> CONFIG_CRYPTO_ARC4=y
> CONFIG_CRYPTO_BLOWFISH=y
> CONFIG_CRYPTO_BLOWFISH_COMMON=y
> # CONFIG_CRYPTO_CAMELLIA is not set
> CONFIG_CRYPTO_CAST_COMMON=y
> # CONFIG_CRYPTO_CAST5 is not set
> CONFIG_CRYPTO_CAST6=y
> CONFIG_CRYPTO_DES=y
> CONFIG_CRYPTO_FCRYPT=y
> CONFIG_CRYPTO_KHAZAD=y
> CONFIG_CRYPTO_SALSA20=y
> CONFIG_CRYPTO_CHACHA20=y
> CONFIG_CRYPTO_SEED=y
> CONFIG_CRYPTO_SERPENT=y
> # CONFIG_CRYPTO_SERPENT_SSE2_586 is not set
> CONFIG_CRYPTO_SM4=y
> # CONFIG_CRYPTO_SPECK is not set
> # CONFIG_CRYPTO_TEA is not set
> # CONFIG_CRYPTO_TWOFISH is not set
> # CONFIG_CRYPTO_TWOFISH_586 is not set
> 
> #
> # Compression
> #
> CONFIG_CRYPTO_DEFLATE=y
> CONFIG_CRYPTO_LZO=y
> CONFIG_CRYPTO_842=y
> CONFIG_CRYPTO_LZ4=y
> # CONFIG_CRYPTO_LZ4HC is not set
> CONFIG_CRYPTO_ZSTD=y
> 
> #
> # Random Number Generation
> #
> # CONFIG_CRYPTO_ANSI_CPRNG is not set
> CONFIG_CRYPTO_DRBG_MENU=y
> CONFIG_CRYPTO_DRBG_HMAC=y
> # CONFIG_CRYPTO_DRBG_HASH is not set
> # CONFIG_CRYPTO_DRBG_CTR is not set
> CONFIG_CRYPTO_DRBG=y
> CONFIG_CRYPTO_JITTERENTROPY=y
> # CONFIG_CRYPTO_USER_API_HASH is not set
> # CONFIG_CRYPTO_USER_API_SKCIPHER is not set
> # CONFIG_CRYPTO_USER_API_RNG is not set
> # CONFIG_CRYPTO_USER_API_AEAD is not set
> CONFIG_CRYPTO_HASH_INFO=y
> CONFIG_CRYPTO_HW=y
> CONFIG_CRYPTO_DEV_PADLOCK=y
> CONFIG_CRYPTO_DEV_PADLOCK_AES=y
> CONFIG_CRYPTO_DEV_PADLOCK_SHA=y
> # CONFIG_CRYPTO_DEV_GEODE is not set
> CONFIG_CRYPTO_DEV_HIFN_795X=y
> CONFIG_CRYPTO_DEV_HIFN_795X_RNG=y
> # CONFIG_CRYPTO_DEV_CCP is not set
> CONFIG_CRYPTO_DEV_QAT=y
> CONFIG_CRYPTO_DEV_QAT_DH895xCC=y
> CONFIG_CRYPTO_DEV_QAT_C3XXX=y
> CONFIG_CRYPTO_DEV_QAT_C62X=y
> CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=y
> CONFIG_CRYPTO_DEV_QAT_C3XXXVF=y
> # CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
> CONFIG_CRYPTO_DEV_VIRTIO=y
> CONFIG_CRYPTO_DEV_CCREE=y
> # CONFIG_ASYMMETRIC_KEY_TYPE is not set
> 
> #
> # Certificates for signature checking
> #
> # CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
> 
> #
> # Library routines
> #
> CONFIG_BITREVERSE=y
> CONFIG_RATIONAL=y
> CONFIG_GENERIC_STRNCPY_FROM_USER=y
> CONFIG_GENERIC_STRNLEN_USER=y
> CONFIG_GENERIC_NET_UTILS=y
> CONFIG_GENERIC_FIND_FIRST_BIT=y
> CONFIG_GENERIC_PCI_IOMAP=y
> CONFIG_GENERIC_IOMAP=y
> CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
> CONFIG_CRC_CCITT=y
> CONFIG_CRC16=y
> CONFIG_CRC_T10DIF=y
> CONFIG_CRC_ITU_T=y
> CONFIG_CRC32=y
> CONFIG_CRC32_SELFTEST=y
> # CONFIG_CRC32_SLICEBY8 is not set
> # CONFIG_CRC32_SLICEBY4 is not set
> # CONFIG_CRC32_SARWATE is not set
> CONFIG_CRC32_BIT=y
> CONFIG_CRC64=y
> CONFIG_CRC4=y
> CONFIG_CRC7=y
> CONFIG_LIBCRC32C=y
> CONFIG_CRC8=y
> CONFIG_XXHASH=y
> CONFIG_RANDOM32_SELFTEST=y
> CONFIG_842_COMPRESS=y
> CONFIG_842_DECOMPRESS=y
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=y
> CONFIG_LZO_COMPRESS=y
> CONFIG_LZO_DECOMPRESS=y
> CONFIG_LZ4_COMPRESS=y
> CONFIG_LZ4_DECOMPRESS=y
> CONFIG_ZSTD_COMPRESS=y
> CONFIG_ZSTD_DECOMPRESS=y
> CONFIG_XZ_DEC=y
> CONFIG_XZ_DEC_X86=y
> CONFIG_XZ_DEC_POWERPC=y
> CONFIG_XZ_DEC_IA64=y
> CONFIG_XZ_DEC_ARM=y
> # CONFIG_XZ_DEC_ARMTHUMB is not set
> CONFIG_XZ_DEC_SPARC=y
> CONFIG_XZ_DEC_BCJ=y
> CONFIG_XZ_DEC_TEST=y
> CONFIG_DECOMPRESS_GZIP=y
> CONFIG_DECOMPRESS_BZIP2=y
> CONFIG_DECOMPRESS_LZMA=y
> CONFIG_DECOMPRESS_XZ=y
> CONFIG_DECOMPRESS_LZO=y
> CONFIG_DECOMPRESS_LZ4=y
> CONFIG_GENERIC_ALLOCATOR=y
> CONFIG_REED_SOLOMON=y
> CONFIG_REED_SOLOMON_DEC16=y
> CONFIG_BCH=y
> CONFIG_INTERVAL_TREE=y
> CONFIG_XARRAY_MULTI=y
> CONFIG_RADIX_TREE_MULTIORDER=y
> CONFIG_ASSOCIATIVE_ARRAY=y
> CONFIG_HAS_IOMEM=y
> CONFIG_HAS_IOPORT_MAP=y
> CONFIG_HAS_DMA=y
> CONFIG_NEED_SG_DMA_LENGTH=y
> CONFIG_NEED_DMA_MAP_STATE=y
> CONFIG_HAVE_GENERIC_DMA_COHERENT=y
> CONFIG_DMA_DIRECT_OPS=y
> CONFIG_SWIOTLB=y
> CONFIG_SGL_ALLOC=y
> CONFIG_CHECK_SIGNATURE=y
> CONFIG_CPU_RMAP=y
> CONFIG_DQL=y
> CONFIG_NLATTR=y
> CONFIG_CLZ_TAB=y
> CONFIG_CORDIC=y
> CONFIG_DDR=y
> # CONFIG_IRQ_POLL is not set
> CONFIG_MPILIB=y
> CONFIG_LIBFDT=y
> CONFIG_OID_REGISTRY=y
> CONFIG_ARCH_HAS_SG_CHAIN=y
> CONFIG_STRING_SELFTEST=y
> 
> #
> # Kernel hacking
> #
> 
> #
> # printk and dmesg options
> #
> CONFIG_PRINTK_TIME=y
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> CONFIG_CONSOLE_LOGLEVEL_QUIET=4
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> CONFIG_BOOT_PRINTK_DELAY=y
> CONFIG_DYNAMIC_DEBUG=y
> 
> #
> # Compile-time checks and compiler options
> #
> CONFIG_DEBUG_INFO=y
> CONFIG_DEBUG_INFO_REDUCED=y
> # CONFIG_DEBUG_INFO_SPLIT is not set
> # CONFIG_DEBUG_INFO_DWARF4 is not set
> # CONFIG_GDB_SCRIPTS is not set
> # CONFIG_ENABLE_MUST_CHECK is not set
> CONFIG_FRAME_WARN=1024
> CONFIG_STRIP_ASM_SYMS=y
> # CONFIG_READABLE_ASM is not set
> CONFIG_UNUSED_SYMBOLS=y
> # CONFIG_PAGE_OWNER is not set
> CONFIG_DEBUG_FS=y
> CONFIG_HEADERS_CHECK=y
> CONFIG_DEBUG_SECTION_MISMATCH=y
> CONFIG_SECTION_MISMATCH_WARN_ONLY=y
> CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
> CONFIG_MAGIC_SYSRQ_SERIAL=y
> CONFIG_DEBUG_KERNEL=y
> 
> #
> # Memory Debugging
> #
> CONFIG_PAGE_EXTENSION=y
> # CONFIG_DEBUG_PAGEALLOC is not set
> # CONFIG_PAGE_POISONING is not set
> # CONFIG_DEBUG_RODATA_TEST is not set
> CONFIG_DEBUG_OBJECTS=y
> # CONFIG_DEBUG_OBJECTS_SELFTEST is not set
> CONFIG_DEBUG_OBJECTS_FREE=y
> # CONFIG_DEBUG_OBJECTS_TIMERS is not set
> CONFIG_DEBUG_OBJECTS_WORK=y
> CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
> # CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER is not set
> CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> # CONFIG_DEBUG_KMEMLEAK is not set
> CONFIG_DEBUG_STACK_USAGE=y
> # CONFIG_DEBUG_VM is not set
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> CONFIG_DEBUG_VIRTUAL=y
> # CONFIG_DEBUG_MEMORY_INIT is not set
> # CONFIG_DEBUG_PER_CPU_MAPS is not set
> # CONFIG_DEBUG_HIGHMEM is not set
> CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
> # CONFIG_DEBUG_STACKOVERFLOW is not set
> CONFIG_CC_HAS_SANCOV_TRACE_PC=y
> # CONFIG_DEBUG_SHIRQ is not set
> 
> #
> # Debug Lockups and Hangs
> #
> CONFIG_LOCKUP_DETECTOR=y
> CONFIG_SOFTLOCKUP_DETECTOR=y
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=1
> # CONFIG_HARDLOCKUP_DETECTOR is not set
> # CONFIG_DETECT_HUNG_TASK is not set
> # CONFIG_WQ_WATCHDOG is not set
> CONFIG_PANIC_ON_OOPS=y
> CONFIG_PANIC_ON_OOPS_VALUE=1
> CONFIG_PANIC_TIMEOUT=0
> CONFIG_SCHED_DEBUG=y
> CONFIG_SCHED_INFO=y
> CONFIG_SCHEDSTATS=y
> CONFIG_SCHED_STACK_END_CHECK=y
> CONFIG_DEBUG_TIMEKEEPING=y
> 
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> CONFIG_LOCK_DEBUGGING_SUPPORT=y
> # CONFIG_PROVE_LOCKING is not set
> # CONFIG_LOCK_STAT is not set
> CONFIG_DEBUG_RT_MUTEXES=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_MUTEXES=y
> # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> # CONFIG_DEBUG_RWSEMS is not set
> # CONFIG_DEBUG_LOCK_ALLOC is not set
> CONFIG_DEBUG_ATOMIC_SLEEP=y
> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> CONFIG_LOCK_TORTURE_TEST=y
> CONFIG_WW_MUTEX_SELFTEST=y
> CONFIG_STACKTRACE=y
> CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
> # CONFIG_DEBUG_KOBJECT is not set
> CONFIG_DEBUG_BUGVERBOSE=y
> CONFIG_DEBUG_LIST=y
> CONFIG_DEBUG_PI_LIST=y
> CONFIG_DEBUG_SG=y
> CONFIG_DEBUG_NOTIFIERS=y
> # CONFIG_DEBUG_CREDENTIALS is not set
> 
> #
> # RCU Debugging
> #
> CONFIG_TORTURE_TEST=y
> CONFIG_RCU_PERF_TEST=y
> CONFIG_RCU_TORTURE_TEST=y
> CONFIG_RCU_CPU_STALL_TIMEOUT=21
> CONFIG_RCU_TRACE=y
> CONFIG_RCU_EQS_DEBUG=y
> CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
> # CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
> CONFIG_NOTIFIER_ERROR_INJECTION=y
> CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=y
> # CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
> CONFIG_FAULT_INJECTION=y
> # CONFIG_FAIL_PAGE_ALLOC is not set
> # CONFIG_FAIL_FUTEX is not set
> # CONFIG_FAULT_INJECTION_DEBUG_FS is not set
> CONFIG_LATENCYTOP=y
> CONFIG_USER_STACKTRACE_SUPPORT=y
> CONFIG_HAVE_FUNCTION_TRACER=y
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> CONFIG_HAVE_C_RECORDMCOUNT=y
> CONFIG_TRACE_CLOCK=y
> CONFIG_TRACING_SUPPORT=y
> # CONFIG_FTRACE is not set
> # CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
> # CONFIG_DMA_API_DEBUG is not set
> CONFIG_RUNTIME_TESTING_MENU=y
> CONFIG_TEST_LIST_SORT=y
> # CONFIG_TEST_SORT is not set
> # CONFIG_BACKTRACE_SELF_TEST is not set
> CONFIG_RBTREE_TEST=y
> # CONFIG_INTERVAL_TREE_TEST is not set
> CONFIG_ATOMIC64_SELFTEST=y
> CONFIG_TEST_HEXDUMP=y
> CONFIG_TEST_STRING_HELPERS=y
> # CONFIG_TEST_KSTRTOX is not set
> CONFIG_TEST_PRINTF=y
> # CONFIG_TEST_BITMAP is not set
> # CONFIG_TEST_BITFIELD is not set
> CONFIG_TEST_UUID=y
> CONFIG_TEST_XARRAY=y
> # CONFIG_TEST_OVERFLOW is not set
> # CONFIG_TEST_RHASHTABLE is not set
> # CONFIG_TEST_HASH is not set
> CONFIG_TEST_IDA=y
> CONFIG_FIND_BIT_BENCHMARK=y
> CONFIG_TEST_FIRMWARE=y
> # CONFIG_TEST_SYSCTL is not set
> # CONFIG_TEST_UDELAY is not set
> # CONFIG_TEST_DEBUG_VIRTUAL is not set
> CONFIG_MEMTEST=y
> CONFIG_BUG_ON_DATA_CORRUPTION=y
> # CONFIG_SAMPLES is not set
> CONFIG_HAVE_ARCH_KGDB=y
> # CONFIG_KGDB is not set
> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> CONFIG_UBSAN=y
> # CONFIG_UBSAN_SANITIZE_ALL is not set
> # CONFIG_UBSAN_ALIGNMENT is not set
> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
> CONFIG_STRICT_DEVMEM=y
> CONFIG_IO_STRICT_DEVMEM=y
> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> CONFIG_X86_VERBOSE_BOOTUP=y
> # CONFIG_EARLY_PRINTK is not set
> CONFIG_X86_PTDUMP_CORE=y
> CONFIG_X86_PTDUMP=y
> # CONFIG_DEBUG_WX is not set
> CONFIG_DOUBLEFAULT=y
> # CONFIG_DEBUG_TLBFLUSH is not set
> CONFIG_HAVE_MMIOTRACE_SUPPORT=y
> CONFIG_IO_DELAY_TYPE_0X80=0
> CONFIG_IO_DELAY_TYPE_0XED=1
> CONFIG_IO_DELAY_TYPE_UDELAY=2
> CONFIG_IO_DELAY_TYPE_NONE=3
> # CONFIG_IO_DELAY_0X80 is not set
> # CONFIG_IO_DELAY_0XED is not set
> CONFIG_IO_DELAY_UDELAY=y
> # CONFIG_IO_DELAY_NONE is not set
> CONFIG_DEFAULT_IO_DELAY_TYPE=2
> CONFIG_DEBUG_BOOT_PARAMS=y
> # CONFIG_CPA_DEBUG is not set
> CONFIG_OPTIMIZE_INLINING=y
> CONFIG_DEBUG_ENTRY=y
> CONFIG_DEBUG_NMI_SELFTEST=y
> # CONFIG_X86_DEBUG_FPU is not set
> CONFIG_PUNIT_ATOM_DEBUG=y
> # CONFIG_UNWINDER_FRAME_POINTER is not set
> CONFIG_UNWINDER_GUESS=y

