Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8F5C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E4821905
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126279;
	bh=QxQ8zM2dMhDgrI5azwc1ZwFmg7/Y462eKsWaGJxhE1w=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=DCornhxS8tpC4uiz02iMk3VG6gaFAJ12cBSpladd4zreahwEICFYWLh6MXkzqc5M7
	 T/jenOfcUlapGL4shWbEJxQxrEoQpNb9DCg9cXXm1V1k6cvRfLM/SvJ1wYeP6WSXYz
	 jGVl1qyeN1/hZ88DknZ+VDg0ZI4ndx3hem7YoCYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388750AbfDXRR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:17:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388733AbfDXRRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:17:54 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 027EC2054F;
        Wed, 24 Apr 2019 17:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126272;
        bh=QxQ8zM2dMhDgrI5azwc1ZwFmg7/Y462eKsWaGJxhE1w=;
        h=From:To:Cc:Subject:Date:From;
        b=2Up2+R1PWkInKB2gplTZXLxFAdtl1hRAlGyfxAX2Pn6c9eZCPPs8OerWF7jU9/AaG
         h1NfGuST2b/iW8ZujBku4BvkJtkAQTZW/6AACPxBxmDq2TEOuO0zXtvjiffVtcxRzX
         Z25O9DqG+JjGlzBt+JJzLzNRF8CB52neln8rGfos=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 000/168] 4.4.179-stable review
Date:   Wed, 24 Apr 2019 19:07:24 +0200
Message-Id: <20190424170923.452349382@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.179-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.179-rc1
X-KernelTest-Deadline: 2019-04-26T17:09+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.179 release.
There are 168 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri 26 Apr 2019 05:07:28 PM UTC.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.179-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.179-rc1

Takashi Iwai <tiwai@suse.de>
    ALSA: info: Fix racy addition/deletion of nodes

Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
    mm/vmstat.c: fix /proc/vmstat format for CONFIG_DEBUG_TLBFLUSH=y CONFIG_SMP=n

Jann Horn <jannh@google.com>
    device_cgroup: fix RCU imbalance in error case

Phil Auld <pauld@redhat.com>
    sched/fair: Limit sched_cfs_period_timer() loop to avoid hard lockup

Matthias Kaehlcke <mka@chromium.org>
    Revert "kbuild: use -Oz instead of -Os when using clang"

Felix Fietkau <nbd@nbd.name>
    mac80211: do not call driver wake_tx_queue op during reconfig

Masami Hiramatsu <mhiramat@kernel.org>
    kprobes: Fix error check when reusing optimized probes

Masami Hiramatsu <mhiramat@kernel.org>
    kprobes: Mark ftrace mcount handler functions nokprobe

Masami Hiramatsu <mhiramat@kernel.org>
    x86/kprobes: Verify stack frame on kretprobe

Nathan Chancellor <natechancellor@gmail.com>
    arm64: futex: Restore oldval initialization to work around buggy compilers

Eric Biggers <ebiggers@google.com>
    crypto: x86/poly1305 - fix overflow during partial reduction

Takashi Iwai <tiwai@suse.de>
    ALSA: core: Fix card races between register and disconnect

Ian Abbott <abbotti@mev.co.uk>
    staging: comedi: ni_usb6501: Fix possible double-free of ->usb_rx_buf

Ian Abbott <abbotti@mev.co.uk>
    staging: comedi: ni_usb6501: Fix use of uninitialized mutex

Ian Abbott <abbotti@mev.co.uk>
    staging: comedi: vmk80xx: Fix possible double-free of ->usb_rx_buf

Ian Abbott <abbotti@mev.co.uk>
    staging: comedi: vmk80xx: Fix use of uninitialized semaphore

he, bo <bo.he@intel.com>
    io: accel: kxcjk1013: restore the range after resume.

Georg Ottinger <g.ottinger@abatec.at>
    iio: adc: at91: disable adc channel interrupt in timeout case

Dragos Bogdan <dragos.bogdan@analog.com>
    iio: ad_sigma_delta: select channel when reading register

Mike Looijmans <mike.looijmans@topic.nl>
    iio/gyro/bmg160: Use millidegrees for temperature scale

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: x86: Don't clear EFER during SMM transitions for 32-bit vCPU

Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
    tpm/tpm_i2c_atmel: Return -E2BIG when the transfer is incomplete

Masahiro Yamada <yamada.masahiro@socionext.com>
    modpost: file2alias: check prototype of handler

Masahiro Yamada <yamada.masahiro@socionext.com>
    modpost: file2alias: go back to simple devtable lookup

Christian Lamparter <chunkeey@gmail.com>
    crypto: crypto4xx - properly set IV after de- and encrypt

Eric Dumazet <edumazet@google.com>
    ipv4: ensure rcu_read_lock() in ipv4_link_failure()

Stephen Suryaputra <ssuryaextr@gmail.com>
    ipv4: recompile ip options in ipv4_link_failure

Eric Dumazet <edumazet@google.com>
    tcp: tcp_grow_window() needs to respect tcp_space()

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    net: fou: do not use guehdr after iptunnel_pull_offloads in gue_udp_recv

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    net: bridge: multicast: use rcu to access port list from br_multicast_start_querier

Gustavo A. R. Silva <gustavo@embeddedor.com>
    net: atm: Fix potential Spectre v1 vulnerabilities

Sabrina Dubroca <sd@queasysnail.net>
    bonding: fix event handling for stacked bonds

Arnd Bergmann <arnd@arndb.de>
    appletalk: Fix compile regression

Miklos Szeredi <mszeredi@redhat.com>
    ovl: fix uid/gid when creating over whiteout

Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
    tpm/tpm_crb: Avoid unaligned reads in crb_recv()

Pi-Hsun Shih <pihsun@chromium.org>
    include/linux/swap.h: use offsetof() instead of custom __swapoffset macro

Stanislaw Gruszka <sgruszka@redhat.com>
    lib/div64.c: off by one in shift

YueHaibing <yuehaibing@huawei.com>
    appletalk: Fix use-after-free in atalk_proc_exit

Yang Shi <yang.shi@linaro.org>
    ARM: 8839/1: kprobe: make patch_lock a raw_spinlock_t

Julia Cartwright <julia@ni.com>
    iommu/dmar: Fix buffer overflow during PCI bus notification

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    crypto: sha512/arm - fix crash bug in Thumb2 build

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    crypto: sha256/arm - fix crash bug in Thumb2 build

Steve French <stfrench@microsoft.com>
    cifs: fallback to older infolevels on findfirst queryinfo retry

Ronald Tschalär <ronald@innovation.ch>
    ACPI / SBS: Fix GPE storm on recent MacBookPro's

Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
    ARM: samsung: Limit SAMSUNG_PM_CHECK config option to non-Exynos platforms

Michal Simek <michal.simek@xilinx.com>
    serial: uartps: console_setup() can't be placed to init section

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to do sanity check with current segment number

Dinu-Razvan Chis-Serban <justcsdr@gmail.com>
    9p locks: add mount option for lock retry interval

Gertjan Halkes <gertjan@google.com>
    9p: do not trust pdu content for stat item size

Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>
    rsi: improve kernel thread handling to fix kernel panic

Darrick J. Wong <darrick.wong@oracle.com>
    ext4: prohibit fstrim in norecovery mode

Steve French <stfrench@microsoft.com>
    fix incorrect error code mapping for OBJECTID_NOT_FOUND

Nathan Chancellor <natechancellor@gmail.com>
    x86/hw_breakpoints: Make default case in hw_breakpoint_arch_parse() return an error

Lu Baolu <baolu.lu@linux.intel.com>
    iommu/vt-d: Check capability before disabling protected memory

Matthew Whitehead <tedheadster@gmail.com>
    x86/cpu/cyrix: Use correct macros for Cyrix calls on Geode processors

Aditya Pakki <pakki001@umn.edu>
    x86/hpet: Prevent potential NULL pointer dereference

Changbin Du <changbin.du@gmail.com>
    perf tests: Fix a memory leak in test__perf_evsel__tp_sched_test()

Changbin Du <changbin.du@gmail.com>
    perf tests: Fix a memory leak of cpu_map object in the openat_syscall_event_on_all_cpus test

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf evsel: Free evsel->counts in perf_evsel__exit()

Changbin Du <changbin.du@gmail.com>
    perf top: Fix error handling in cmd_top()

David Arcari <darcari@redhat.com>
    tools/power turbostat: return the exit status of a command

Matthew Garrett <matthewgarrett@google.com>
    thermal/int340x_thermal: fix mode setting

Matthew Garrett <matthewgarrett@google.com>
    thermal/int340x_thermal: Add additional UUIDs

Colin Ian King <colin.king@canonical.com>
    ALSA: opl3: fix mismatch between snd_opl3_drum_switch definition and declaration

Arnd Bergmann <arnd@arndb.de>
    mmc: davinci: remove extraneous __init annotation

Jack Morgenstein <jackm@dev.mellanox.co.il>
    IB/mlx4: Fix race condition between catas error reset and aliasguid flows

Kangjie Lu <kjlu@umn.edu>
    ALSA: sb8: add a check for request_region

Kangjie Lu <kjlu@umn.edu>
    ALSA: echoaudio: add a check for ioremap_nocache

Lukas Czerner <lczerner@redhat.com>
    ext4: report real fs size after failed resize

Lukas Czerner <lczerner@redhat.com>
    ext4: add missing brelse() in add_new_gdb_meta_bg()

Stephane Eranian <eranian@google.com>
    perf/core: Restore mmap record type correctly

Andre Przywara <andre.przywara@arm.com>
    PCI: Add function 1 DMA alias quirk for Marvell 9170 SATA controller

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: fix return_address

Mel Gorman <mgorman@techsingularity.net>
    sched/fair: Do not re-read ->h_load_next during hierarchical load calculation

Dan Carpenter <dan.carpenter@oracle.com>
    xen: Prevent buffer overflow in privcmd ioctl

Will Deacon <will.deacon@arm.com>
    arm64: futex: Fix FUTEX_WAKE_OP atomic ops with non-zero result value

David Engraf <david.engraf@sysgo.com>
    ARM: dts: at91: Fix typo in ISC_D0 on PC9

Stephen Boyd <swboyd@chromium.org>
    genirq: Respect IRQCHIP_SKIP_SET_WAKE in irq_chip_set_wake_parent()

Jérôme Glisse <jglisse@redhat.com>
    block: do not leak memory in bio_copy_user_iov()

S.j. Wang <shengjiu.wang@nxp.com>
    ASoC: fsl_esai: fix channel swap issue when stream starts

Arnd Bergmann <arnd@arndb.de>
    include/linux/bitrev.h: fix constant bitrev

Zubin Mithra <zsm@chromium.org>
    ALSA: seq: Fix OOB-reads from strlcpy

Sheena Mira-ato <sheena.mira-ato@alliedtelesis.co.nz>
    ip6_tunnel: Match to ARPHRD_TUNNEL6 for dev type

Li RongQing <lirongqing@baidu.com>
    net: ethtool: not call vzalloc for zero sized memory request

Eric Dumazet <edumazet@google.com>
    netns: provide pure entropy for net_hash_mix()

Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
    tcp: Ensure DCTCP reacts to losses

Xin Long <lucien.xin@gmail.com>
    sctp: initialize _pad of sockaddr_in before copying to user memory

Bjørn Mork <bjorn@mork.no>
    qmi_wwan: add Olicard 600

Andrea Righi <andrea.righi@canonical.com>
    openvswitch: fix flow actions reallocation

Mao Wenan <maowenan@huawei.com>
    net: rds: force to destroy connection if t_sock is NULL in rds_tcp_kill_sock().

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    ipv6: sit: reset ip header pointer in ipip6_rcv

Junwei Hu <hujunwei4@huawei.com>
    ipv6: Fix dangling pointer when ipv6 fragment

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    tty: ldisc: add sysctl to prevent autoloading of ldiscs

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    tty: mark Siemens R3964 line discipline as BROKEN

Nick Desaulniers <ndesaulniers@google.com>
    lib/string.c: implement a basic bcmp

Nick Desaulniers <ndesaulniers@google.com>
    x86/vdso: Drop implicit common-page-size linker flag

Alistair Strachan <astrachan@google.com>
    x86: vdso: Use $LD instead of $CC to link

George Rimar <grimar@accesssoftek.com>
    x86/build: Specify elf_i386 linker emulation explicitly for i386 objects

Nick Desaulniers <ndesaulniers@google.com>
    kbuild: clang: choose GCC_TOOLCHAIN_DIR not on LD

Linus Torvalds <torvalds@linux-foundation.org>
    binfmt_elf: switch to new creds when switching to new mm

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/dp/mst: Configure no_stop_bit correctly for remote i2c xfers

Ben Dooks <ben.dooks@codethink.co.uk>
    dmaengine: tegra: avoid overflow of byte tracking

Rafael Ávila de Espíndola <rafael@espindo.la>
    x86/build: Mark per-CPU symbols as absolute explicitly for LLD

Zumeng Chen <zumeng.chen@gmail.com>
    wlcore: Fix memory leak in case wl12xx_fetch_firmware failure

Axel Lin <axel.lin@ingics.com>
    regulator: act8865: Fix act8600_sudcdc_voltage_ranges setting

Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
    media: s5p-jpeg: Check for fmt_ver_flag when doing fmt enumeration

Florian Westphal <fw@strlen.de>
    netfilter: physdev: relax br_netfilter dependency

Anders Roxell <anders.roxell@linaro.org>
    dmaengine: imx-dma: fix warning comparison of distinct pointer types

Buland Singh <bsingh@redhat.com>
    hpet: Fix missing '=' character in the __setup() code of hpet_mmap_enable

Timo Alho <talho@nvidia.com>
    soc/tegra: fuse: Fix illegal free of IO base address

David Tolnay <dtolnay@gmail.com>
    hwrng: virtio - Avoid repeated init of completion

Akinobu Mita <akinobu.mita@gmail.com>
    media: mt9m111: set initial frame size other than 0x0

Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
    tty: increase the default flip buffer limit to 2*640K

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: avoid Cortex-A9 livelock on tight dmb loops

Stanislaw Gruszka <sgruszka@redhat.com>
    mt7601u: bump supported EEPROM version

Alexey Khoroshilov <khoroshilov@ispras.ru>
    soc: qcom: gsbi: Fix error handling in gsbi_probe()

wen yang <yellowriver2010@hotmail.com>
    ASoC: fsl-asoc-card: fix object reference leaks in fsl_asoc_card_probe

Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
    e1000e: fix cyclic resets at link up with active tx

Guenter Roeck <linux@roeck-us.net>
    cdrom: Fix race condition in cdrom_sysctl_register

Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
    fbdev: fbmem: fix memory access if logo is bigger than the screen

Coly Li <colyli@suse.de>
    bcache: improve sysfs_strtoul_clamp()

Coly Li <colyli@suse.de>
    bcache: fix input overflow to sequential_cutoff

Coly Li <colyli@suse.de>
    bcache: fix input overflow to cache set sysfs file io_error_halflife

Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
    ALSA: PCM: check if ops are defined before suspending PCM

Nathan Chancellor <natechancellor@gmail.com>
    ARM: 8833/1: Ensure that NEON code always compiles with Clang

Andrea Righi <righi.andrea@gmail.com>
    kprobes: Prohibit probing on bsearch()

Michal Kazior <michal@plume.com>
    leds: lp55xx: fix null deref on firmware load failure

Ezequiel Garcia <ezequiel@collabora.com>
    media: mx2_emmaprp: Correct return type for mem2mem buffer helpers

Ezequiel Garcia <ezequiel@collabora.com>
    media: s5p-g2d: Correct return type for mem2mem buffer helpers

Ezequiel Garcia <ezequiel@collabora.com>
    media: s5p-jpeg: Correct return type for mem2mem buffer helpers

Ezequiel Garcia <ezequiel@collabora.com>
    media: sh_veu: Correct return type for mem2mem buffer helpers

Wen Yang <yellowriver2010@hotmail.com>
    SoC: imx-sgtl5000: add missing put_device()

Thomas Richter <tmricht@linux.ibm.com>
    perf test: Fix failure of 'evsel-tp-sched' test on s390

Jason Yan <yanaijie@huawei.com>
    scsi: megaraid_sas: return error when create DMA pool failed

Håkon Bugge <haakon.bugge@oracle.com>
    IB/mlx4: Increase the timeout for CM cache

Florian Fainelli <f.fainelli@gmail.com>
    e1000e: Fix -Wformat-truncation warnings

Aaro Koskinen <aaro.koskinen@iki.fi>
    mmc: omap: fix the maximum timeout setting

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    ARM: 8840/1: use a raw_spinlock_t in unwind

Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
    coresight: etm4x: Add support to enable ETMv4.2

Benjamin Block <bblock@linux.ibm.com>
    scsi: core: replace GFP_ATOMIC with GFP_KERNEL in scsi_scan.c

Paul Kocialkowski <paul.kocialkowski@bootlin.com>
    usb: chipidea: Grab the (legacy) USB PHY by phandle first

Tony Jones <tonyj@suse.de>
    tools lib traceevent: Fix buffer overflow in arg_eval

Carlos Maiolino <cmaiolino@redhat.com>
    fs: fix guard_bio_eod to check for real EOD errors

Yao Liu <yotta.liu@ucloud.cn>
    cifs: Fix NULL pointer dereference of devname

Jason Cai (Xiang Feng) <jason.cai.kern@gmail.com>
    dm thin: add sanity checks to thin-pool and external snapshot creation

Louis Taylor <louis@kragniz.eu>
    cifs: use correct format characters

Shuriyc Chu <sureeju@gmail.com>
    fs/file.c: initialize init_files.resize_wait

Sahitya Tummala <stummala@codeaurora.org>
    f2fs: do not use mutex lock in atomic context

Jia Guo <guojia12@huawei.com>
    ocfs2: fix a panic problem caused by o2cb_ctl

Qian Cai <cai@lca.pw>
    mm/slab.c: kmemleak no scan alien caches

Uladzislau Rezki (Sony) <urezki@gmail.com>
    mm/vmalloc.c: fix kernel BUG at mm/vmalloc.c:512!

Qian Cai <cai@lca.pw>
    mm/page_ext.c: fix an imbalance with kmemleak

Peng Fan <peng.fan@nxp.com>
    mm/cma.c: cma_declare_contiguous: correct err handling

Arnd Bergmann <arnd@arndb.de>
    enic: fix build warning without CONFIG_CPUMASK_OFFSTACK

Christian Brauner <christian@brauner.io>
    sysctl: handle overflow for file-max

Russell King <rmk+kernel@armlinux.org.uk>
    gpio: gpio-omap: fix level interrupt idling

Douglas Anderson <dianders@chromium.org>
    tracing: kdb: Fix ftdump to not sleep

Masahiro Yamada <yamada.masahiro@socionext.com>
    h8300: use cc-cross-prefix instead of hardcoding h8300-unknown-linux-

Aurelien Aptel <aaptel@suse.com>
    CIFS: fix POSIX lock leak and invalid ptr deref

Razvan Stefanescu <razvan.stefanescu@microchip.com>
    tty/serial: atmel: RS485 HD w/DMA: enable RX after TX is stopped

Myungho Jung <mhjungk@gmail.com>
    Bluetooth: Fix decrementing reference count twice in releasing socket

Jeremy Compostella <jeremy.compostella@intel.com>
    i2c: core-smbus: prevent stack corruption on read I2C_BLOCK_DATA

Yang Shi <yang.shi@linux.alibaba.com>
    mm: mempolicy: make mbind() return -EIO when MPOL_MF_STRICT is specified

Razvan Stefanescu <razvan.stefanescu@microchip.com>
    tty/serial: atmel: Add is_half_duplex helper

Peter Zijlstra <peterz@infradead.org>
    lib/int_sqrt: optimize initial value compute

zhangyi (F) <yi.zhang@huawei.com>
    ext4: cleanup bh release code in ext4_ind_remove_space()

Will Deacon <will.deacon@arm.com>
    arm64: debug: Ensure debug handlers check triggering exception level

Will Deacon <will.deacon@arm.com>
    arm64: debug: Don't propagate UNKNOWN FAR into si_code for debug signals


-------------

Diffstat:

 Documentation/arm/kernel_mode_neon.txt            |   4 +-
 Makefile                                          |   8 +-
 arch/arm/boot/dts/sama5d2-pinfunc.h               |   2 +-
 arch/arm/crypto/sha256-armv4.pl                   |   3 +-
 arch/arm/crypto/sha256-core.S_shipped             |   3 +-
 arch/arm/crypto/sha512-armv4.pl                   |   3 +-
 arch/arm/crypto/sha512-core.S_shipped             |   3 +-
 arch/arm/include/asm/barrier.h                    |   2 +
 arch/arm/include/asm/processor.h                  |   6 +-
 arch/arm/kernel/machine_kexec.c                   |   5 +-
 arch/arm/kernel/patch.c                           |   6 +-
 arch/arm/kernel/smp.c                             |   4 +-
 arch/arm/kernel/unwind.c                          |  14 +--
 arch/arm/lib/Makefile                             |   2 +-
 arch/arm/lib/xor-neon.c                           |   2 +-
 arch/arm/mach-omap2/prm_common.c                  |   4 +-
 arch/arm/plat-samsung/Kconfig                     |   2 +-
 arch/arm64/include/asm/futex.h                    |  14 +--
 arch/arm64/kernel/kgdb.c                          |  15 ++-
 arch/arm64/mm/fault.c                             |   9 +-
 arch/h8300/Makefile                               |   2 +-
 arch/x86/boot/Makefile                            |   2 +-
 arch/x86/crypto/poly1305-avx2-x86_64.S            |  14 ++-
 arch/x86/crypto/poly1305-sse2-x86_64.S            |  22 ++--
 arch/x86/entry/vdso/Makefile                      |  22 ++--
 arch/x86/include/asm/xen/hypercall.h              |   3 +
 arch/x86/kernel/cpu/cyrix.c                       |  14 +--
 arch/x86/kernel/hpet.c                            |   2 +
 arch/x86/kernel/hw_breakpoint.c                   |   1 +
 arch/x86/kernel/kprobes/core.c                    |  26 ++++
 arch/x86/kernel/vmlinux.lds.S                     |   2 +-
 arch/x86/kvm/emulate.c                            |  21 ++--
 arch/x86/realmode/rm/Makefile                     |   2 +-
 arch/xtensa/kernel/stacktrace.c                   |   6 +-
 block/bio.c                                       |   5 +-
 crypto/testmgr.h                                  |  44 ++++++-
 drivers/acpi/sbs.c                                |   8 +-
 drivers/cdrom/cdrom.c                             |   7 +-
 drivers/char/Kconfig                              |   2 +-
 drivers/char/hpet.c                               |   2 +-
 drivers/char/hw_random/virtio-rng.c               |   2 +-
 drivers/char/tpm/tpm_crb.c                        |  22 +++-
 drivers/char/tpm/tpm_i2c_atmel.c                  |  10 +-
 drivers/crypto/amcc/crypto4xx_alg.c               |   3 +-
 drivers/crypto/amcc/crypto4xx_core.c              |   9 ++
 drivers/dma/imx-dma.c                             |   2 +-
 drivers/dma/tegra20-apb-dma.c                     |   5 +-
 drivers/gpio/gpio-omap.c                          |  14 ++-
 drivers/gpu/drm/drm_dp_mst_topology.c             |   1 +
 drivers/hwtracing/coresight/coresight-etm4x.c     |   3 +-
 drivers/i2c/i2c-core.c                            |  12 +-
 drivers/iio/accel/kxcjk-1013.c                    |   2 +
 drivers/iio/adc/ad_sigma_delta.c                  |   1 +
 drivers/iio/adc/at91_adc.c                        |  28 +++--
 drivers/iio/gyro/bmg160_core.c                    |   6 +-
 drivers/infiniband/hw/mlx4/alias_GUID.c           |   2 +-
 drivers/infiniband/hw/mlx4/cm.c                   |   2 +-
 drivers/iommu/dmar.c                              |   2 +-
 drivers/iommu/intel-iommu.c                       |   3 +
 drivers/leds/leds-lp55xx-common.c                 |   4 +-
 drivers/md/bcache/sysfs.c                         |  17 ++-
 drivers/md/bcache/sysfs.h                         |  13 +-
 drivers/md/dm-thin.c                              |  13 ++
 drivers/media/i2c/soc_camera/mt9m111.c            |   2 +
 drivers/media/platform/mx2_emmaprp.c              |   6 +-
 drivers/media/platform/s5p-g2d/g2d.c              |   6 +-
 drivers/media/platform/s5p-jpeg/jpeg-core.c       |  57 ++++-----
 drivers/media/platform/sh_veu.c                   |   4 +-
 drivers/mmc/host/davinci_mmc.c                    |   2 +-
 drivers/mmc/host/omap.c                           |   2 +-
 drivers/net/bonding/bond_main.c                   |   6 +-
 drivers/net/ethernet/cisco/enic/enic_main.c       |   6 +-
 drivers/net/ethernet/intel/e1000e/netdev.c        |  19 ++-
 drivers/net/usb/qmi_wwan.c                        |   1 +
 drivers/net/wireless/mediatek/mt7601u/eeprom.h    |   2 +-
 drivers/net/wireless/rsi/rsi_common.h             |   1 -
 drivers/net/wireless/ti/wlcore/main.c             |   7 +-
 drivers/pci/quirks.c                              |   2 +
 drivers/regulator/act8865-regulator.c             |   5 +-
 drivers/scsi/megaraid/megaraid_sas_base.c         |   1 +
 drivers/scsi/scsi_scan.c                          |   6 +-
 drivers/soc/qcom/qcom_gsbi.c                      |   7 +-
 drivers/soc/tegra/fuse/fuse-tegra.c               |  12 +-
 drivers/staging/comedi/drivers/ni_usb6501.c       |  10 +-
 drivers/staging/comedi/drivers/vmk80xx.c          |   8 +-
 drivers/thermal/int340x_thermal/int3400_thermal.c |  21 +++-
 drivers/tty/Kconfig                               |  23 ++++
 drivers/tty/serial/atmel_serial.c                 |  43 +++++--
 drivers/tty/serial/xilinx_uartps.c                |   2 +-
 drivers/tty/tty_buffer.c                          |   2 +-
 drivers/tty/tty_io.c                              |   3 +
 drivers/tty/tty_ldisc.c                           |  47 ++++++++
 drivers/usb/chipidea/core.c                       |   9 +-
 drivers/video/fbdev/core/fbmem.c                  |   3 +
 fs/9p/v9fs.c                                      |  21 ++++
 fs/9p/v9fs.h                                      |   1 +
 fs/9p/vfs_dir.c                                   |   8 +-
 fs/9p/vfs_file.c                                  |   6 +-
 fs/binfmt_elf.c                                   |   2 +-
 fs/buffer.c                                       |   7 ++
 fs/cifs/cifs_dfs_ref.c                            |   4 +-
 fs/cifs/connect.c                                 |   5 +
 fs/cifs/file.c                                    |  14 ++-
 fs/cifs/inode.c                                   |  69 ++++++-----
 fs/cifs/smb1ops.c                                 |   2 +-
 fs/cifs/smb2maperror.c                            |   3 +-
 fs/ext4/indirect.c                                |  47 ++++----
 fs/ext4/ioctl.c                                   |   7 ++
 fs/ext4/resize.c                                  |  17 ++-
 fs/f2fs/super.c                                   |  34 +++++-
 fs/f2fs/trace.c                                   |   8 +-
 fs/file.c                                         |   1 +
 fs/ocfs2/cluster/nodemanager.c                    |  14 ++-
 fs/overlayfs/dir.c                                |  13 +-
 include/linux/atalk.h                             |  20 ++-
 include/linux/bitrev.h                            |  36 +++---
 include/linux/kprobes.h                           |   1 +
 include/linux/ring_buffer.h                       |   2 +-
 include/linux/string.h                            |   3 +
 include/linux/swap.h                              |   4 +-
 include/net/net_namespace.h                       |   1 +
 include/net/netfilter/br_netfilter.h              |   1 -
 include/net/netns/hash.h                          |  15 +--
 kernel/events/core.c                              |   2 +
 kernel/irq/chip.c                                 |   4 +
 kernel/kprobes.c                                  |   6 +-
 kernel/sched/fair.c                               |  31 ++++-
 kernel/sysctl.c                                   |   3 +
 kernel/trace/ftrace.c                             |   6 +-
 kernel/trace/ring_buffer.c                        |   5 +-
 kernel/trace/trace.c                              |   6 +-
 kernel/trace/trace_kdb.c                          |   6 +-
 lib/bsearch.c                                     |   2 +
 lib/div64.c                                       |   4 +-
 lib/int_sqrt.c                                    |   6 +-
 lib/raid6/Makefile                                |   2 +-
 lib/string.c                                      |  20 +++
 mm/cma.c                                          |   4 +-
 mm/mempolicy.c                                    |   8 +-
 mm/page_ext.c                                     |   1 +
 mm/slab.c                                         |  17 +--
 mm/vmalloc.c                                      |   6 +-
 mm/vmstat.c                                       |   5 -
 net/9p/protocol.c                                 |   3 +-
 net/appletalk/atalk_proc.c                        |   2 +-
 net/appletalk/ddp.c                               |  37 +++++-
 net/appletalk/sysctl_net_atalk.c                  |   5 +-
 net/atm/lec.c                                     |   6 +-
 net/bluetooth/hci_sock.c                          |   3 +-
 net/bridge/br_multicast.c                         |   4 +-
 net/bridge/br_netfilter_hooks.c                   |   5 -
 net/core/ethtool.c                                |  29 +++--
 net/core/net_namespace.c                          |   1 +
 net/ipv4/fou.c                                    |   4 +-
 net/ipv4/route.c                                  |  16 ++-
 net/ipv4/tcp_dctcp.c                              |  36 +++---
 net/ipv4/tcp_input.c                              |  10 +-
 net/ipv6/ip6_output.c                             |   4 +-
 net/ipv6/ip6_tunnel.c                             |   4 +-
 net/ipv6/sit.c                                    |   4 +
 net/mac80211/driver-ops.h                         |   3 +
 net/netfilter/xt_physdev.c                        |   9 +-
 net/openvswitch/flow_netlink.c                    |   4 +-
 net/rds/tcp.c                                     |   2 +-
 net/sctp/protocol.c                               |   1 +
 scripts/mod/file2alias.c                          | 141 ++++++++--------------
 security/device_cgroup.c                          |   2 +-
 sound/core/info.c                                 |  12 +-
 sound/core/init.c                                 |  18 +--
 sound/core/pcm_native.c                           |   8 ++
 sound/core/seq/seq_clientmgr.c                    |   6 +-
 sound/drivers/opl3/opl3_voice.h                   |   2 +-
 sound/isa/sb/sb8.c                                |   4 +
 sound/pci/echoaudio/echoaudio.c                   |   5 +
 sound/soc/fsl/fsl-asoc-card.c                     |   1 +
 sound/soc/fsl/fsl_esai.c                          |  47 ++++++--
 sound/soc/fsl/imx-sgtl5000.c                      |   1 +
 tools/lib/traceevent/event-parse.c                |   2 +-
 tools/perf/builtin-top.c                          |   5 +-
 tools/perf/tests/evsel-tp-sched.c                 |   7 +-
 tools/perf/tests/openat-syscall-all-cpus.c        |   4 +-
 tools/perf/util/evsel.c                           |   1 +
 tools/power/x86/turbostat/turbostat.c             |   3 +
 183 files changed, 1200 insertions(+), 590 deletions(-)


