Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2DCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9136F21917
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254041;
	bh=NxXRcJ3jjqBatWNttiXROuR0DJCWAc6IjwwmYNFChLQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=QczVFVkoAJlv6Fh/qqIRyi4npC5r8x9mbBC+yga4f+0jX9GSK0ZgoHs6rIvQbh34r
	 gV467ZTYTipgjFss6LyTkcSZZdU/JgB/SogPjtsSjUGSv3VSj/Y6YEmoFejT5nG0Dd
	 7FE7bxC5bFxCHxEW6Sr4eWqZDPUW8z7MpUFS0ByM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbfCVL1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:27:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729006AbfCVL1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:27:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 196622183E;
        Fri, 22 Mar 2019 11:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254034;
        bh=NxXRcJ3jjqBatWNttiXROuR0DJCWAc6IjwwmYNFChLQ=;
        h=From:To:Cc:Subject:Date:From;
        b=seUsZUaY3eNT+yi0Mo06oI2omGEBzS8bMmsAzApTjv/avXcO9Ox9nw3O/Kn6ZeYVc
         SC7AiL3KpcEzcnSvNBFU0QSkakKgWHEVXWry+QsLXt5yf64jr5+ACo34rKj5rkUA6v
         vxEma05SqM4mV5B9UfBNgIghCu5QQ/6WFhVZiSJw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 000/230] 4.4.177-stable review
Date:   Fri, 22 Mar 2019 12:12:18 +0100
Message-Id: <20190322111236.796964179@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.177-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.177-rc1
X-KernelTest-Deadline: 2019-03-24T11:12+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.177 release.
There are 230 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Mar 24 11:10:58 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.177-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.177-rc1

Wanpeng Li <kernellwp@gmail.com>
    KVM: X86: Fix residual mmio emulation request to userspace

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: nVMX: Ignore limit checks on VMX instructions using flat segments

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: nVMX: Sign extend displacements of VMX instr's mem operands

Gustavo A. R. Silva <gustavo@embeddedor.com>
    drm/radeon/evergreen_cs: fix missing break in switch statement

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: uvcvideo: Avoid NULL pointer dereference at the end of streaming

Zhang, Jun <jun.zhang@intel.com>
    rcu: Do RCU GP kthread self-wakeup from softirq and interrupt

Viresh Kumar <viresh.kumar@linaro.org>
    PM / wakeup: Rework wakeup source timer cancellation

Yihao Wu <wuyihao@linux.alibaba.com>
    nfsd: fix wrong check in write_v4_end_grace()

NeilBrown <neilb@suse.com>
    nfsd: fix memory corruption caused by readdir

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFS: Don't recoalesce on error in nfs_pageio_complete_mirror()

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFS: Fix an I/O request leakage in nfs_do_recoalesce

Aditya Pakki <pakki001@umn.edu>
    md: Fix failed allocation of md_register_thread

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix overlap calculation for padding

Adrian Hunter <adrian.hunter@intel.com>
    perf auxtrace: Define auxtrace record alignment

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix CYC timestamp calculation after OVF

Peng Tao <tao.peng@primarydata.com>
    NFS41: pop some layoutget errors to application

NeilBrown <neil@brown.name>
    dm: fix to_sector() for 32bit

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ARM: s3c24xx: Fix boolean expressions in osiris_dvs_notify

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/83xx: Also save/restore SPRG4-7 during suspend

Jordan Niethe <jniethe5@gmail.com>
    powerpc/powernv: Make opal log only readable by root

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/wii: properly disable use of BATs when requested.

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/32: Clear on-stack exception marker upon exception return

zhangyi (F) <yi.zhang@huawei.com>
    jbd2: fix compile warning when using JBUFFER_TRACE

zhangyi (F) <yi.zhang@huawei.com>
    jbd2: clear dirty flag when revoking a buffer from an older transaction

Jay Dolan <jay.dolan@accesio.com>
    serial: 8250_pci: Have ACCES cards that use the four port Pericom PI7C9X7954 chip use the pci_pericom_setup()

Jay Dolan <jay.dolan@accesio.com>
    serial: 8250_pci: Fix number of ports for ACCES serial cards

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf bench: Copy kernel files needed to build mem{cpy,set} x86_64 benchmarks

Sowjanya Komatineni <skomatineni@nvidia.com>
    i2c: tegra: fix maximum transfer size

QiaoChong <qiaochong@loongson.cn>
    parport_pc: fix find_superio io compare code, should use equal test.

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    intel_th: Don't reference unassigned outputs

Zev Weiss <zev@bewilderbeest.net>
    kernel/sysctl.c: add missing range check in do_proc_dointvec_minmax_conv

Roman Penyaev <rpenyaev@suse.de>
    mm/vmalloc: fix size check for remap_vmalloc_range_partial()

Phuong Nguyen <phuong.nguyen.xw@renesas.com>
    dmaengine: usb-dmac: Make DMAC system sleep callbacks explicit

Paul Cercueil <paul@crapouillou.net>
    clk: ingenic: Fix round_rate misbehaving with non-integer dividers

Jan Kara <jack@suse.cz>
    ext2: Fix underflow in ext2_max_size()

Jan Kara <jack@suse.cz>
    ext4: fix crash during online resizing

Arnd Bergmann <arnd@arndb.de>
    cpufreq: pxa2xx: remove incorrect __init annotation

Yangtao Li <tiny.windzz@gmail.com>
    cpufreq: tegra124: add missing of_node_put()

Eric Biggers <ebiggers@google.com>
    crypto: pcbc - remove bogus memcpy()s with src == dest

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix corruption reading shared and compressed extents after hole punching

Johannes Thumshirn <jthumshirn@suse.de>
    btrfs: ensure that a DUP or RAID1 block group has exactly two stripes

Finn Thain <fthain@telegraphics.com.au>
    m68k: Add -ffreestanding to CFLAGS

Bart Van Assche <bvanassche@acm.org>
    scsi: target/iscsi: Avoid iscsit_release_commands_from_conn() deadlock

Felipe Franciosi <felipe@nutanix.com>
    scsi: virtio_scsi: don't send sc payload with tmfs

Halil Pasic <pasic@linux.ibm.com>
    s390/virtio: handle find on invalid queue gracefully

Stuart Menefy <stuart.menefy@mathembedded.com>
    clocksource/drivers/exynos_mct: Clear timer interrupt when shutdown

Stuart Menefy <stuart.menefy@mathembedded.com>
    clocksource/drivers/exynos_mct: Move one-shot check from tick clear to ISR

Stuart Menefy <stuart.menefy@mathembedded.com>
    regulator: s2mpa01: Fix step values for some LDOs

Krzysztof Kozlowski <krzk@kernel.org>
    regulator: s2mps11: Fix steps for buck7, buck8 and LDO35

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    ACPI / device_sysfs: Avoid OF modalias creation for removed device

zhangyi (F) <yi.zhang@huawei.com>
    tracing: Do not free iter->trace in fail path of tracing_open_pipe()

Pavel Shilovsky <piastryyy@gmail.com>
    CIFS: Fix read after write for files with read caching

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    crypto: arm64/aes-ccm - fix logical bug in AAD MAC handling

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    stm class: Prevent division by zero

Darrick J. Wong <darrick.wong@oracle.com>
    tmpfs: fix uninitialized return value in shmem_link

Mao Wenan <maowenan@huawei.com>
    net: set static variable an initial value in atl2_probe()

Li RongQing <lirongqing@baidu.com>
    mac80211_hwsim: propagate genlmsg_reply return code

Arnd Bergmann <arnd@arndb.de>
    phonet: fix building with clang

Vineet Gupta <vgupta@synopsys.com>
    ARC: uacces: remove lp_start, lp_end from clobber list

Darrick J. Wong <darrick.wong@oracle.com>
    tmpfs: fix link accounting when a tmpfile is linked in

Vladimir Murzin <vladimir.murzin@arm.com>
    arm64: Relax GIC version check during early boot

Bard liao <yung-chuan.liao@linux.intel.com>
    ASoC: topology: free created components in tplg load error

Alexey Khoroshilov <khoroshilov@ispras.ru>
    net: mv643xx_eth: disable clk on error path in mv643xx_eth_shared_probe()

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    pinctrl: meson: meson8b: fix the sdxc_a data 1..3 pins

Florian Fainelli <f.fainelli@gmail.com>
    net: systemport: Fix reception of BPDUs

Anoob Soman <anoob.soman@citrix.com>
    scsi: libiscsi: Fix race between iscsi_xmit_task and iscsi_complete_task

David Howells <dhowells@redhat.com>
    assoc_array: Fix shortcut creation

Dietmar Eggemann <dietmar.eggemann@arm.com>
    ARM: 8824/1: fix a migrating irq bug when hotplug cpu

Gabriel Fernandez <gabriel.fernandez@st.com>
    Input: st-keyscan - fix potential zalloc NULL dereference

Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
    i2c: cadence: Fix the hold bit setting

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: matrix_keypad - use flush_delayed_work()

Yizhuo <yzhai003@ucr.edu>
    ARM: OMAP2+: Variable "reg" in function omap4_dsi_mux_pads() could be uninitialized

Stefan Haberland <sth@linux.ibm.com>
    s390/dasd: fix using offset into zero size array error

Steve Longerbeam <slongerbeam@gmail.com>
    gpu: ipu-v3: Fix CSI offsets for imx53

Alexander Shiyan <shc_work@mail.ru>
    gpu: ipu-v3: Fix i.MX51 CSI control registers offset

Eric Biggers <ebiggers@google.com>
    crypto: ahash - fix another early termination in hash walk

Pankaj Gupta <pankaj.gupta@nxp.com>
    crypto: caam - fixed handling of sg list

Zhi Jin <zhi.jin@intel.com>
    stm class: Fix an endless loop in channel allocation

S.j. Wang <shengjiu.wang@nxp.com>
    ASoC: fsl_esai: fix register setting issue in RIGHT_J mode

zhengbin <zhengbin13@huawei.com>
    9p/net: fix memory leak in p9_client_create

Hou Tao <houtao1@huawei.com>
    9p: use inode->i_lock to protect i_size_write() under 32-bit

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: videobuf2-v4l2: drop WARN_ON in vb2_warn_zero_bytesused()

Xiao Ni <xni@redhat.com>
    It's wrong to add len to sector_nr in raid10 reshape twice

Sasha Levin <sasha.levin@oracle.com>
    fs/9p: use fscache mutex rather than spinlock

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: bebob: use more identical mod_alias for Saffire Pro 10 I/O against Liquid Saffire 56

Eric Dumazet <edumazet@google.com>
    tcp/dccp: remove reqsk_put() from inet_child_forget()

Eric Dumazet <edumazet@google.com>
    gro_cells: make sure device is up in gro_cells_receive()

Eric Dumazet <edumazet@google.com>
    net/hsr: fix possible crash in add_timer()

Stefano Brivio <sbrivio@redhat.com>
    vxlan: Fix GRO cells race condition between receive and link delete

Eric Dumazet <edumazet@google.com>
    vxlan: test dev->flags & IFF_UP before calling gro_cells_receive()

Daniel Borkmann <daniel@iogearbox.net>
    ipvlan: disallow userns cap_net_admin to change global mode/flags

Al Viro <viro@zeniv.linux.org.uk>
    missing barriers in some of unix_sock ->addr and ->path accesses

Kalash Nainwal <kalash@arista.com>
    net: Set rtm_table to RT_TABLE_COMPAT for ipv6 for tables > 255

YueHaibing <yuehaibing@huawei.com>
    mdio_bus: Fix use-after-free on device_register fails

Eric Dumazet <edumazet@google.com>
    net/x25: fix a race in x25_bind()

Jack Morgenstein <jackm@dev.mellanox.co.il>
    net/mlx4_core: Fix qp mtt size calculation

Jack Morgenstein <jackm@dev.mellanox.co.il>
    net/mlx4_core: Fix reset flow when in command polling mode

Guillaume Nault <gnault@redhat.com>
    tcp: handle inet_csk_reqsk_queue_add() failures

Xin Long <lucien.xin@gmail.com>
    route: set the deleted fnhe fnhe_daddr to 0 in ip_del_fnhe to fix a race

Masaru Nagai <masaru.nagai.vx@renesas.com>
    ravb: Decrease TxFIFO depth of Q3 and Q2 to one

Xin Long <lucien.xin@gmail.com>
    pptp: dst_release sk_dst_cache in pptp_sock_destruct

Eric Dumazet <edumazet@google.com>
    net/x25: reset state in x25_connect()

Eric Dumazet <edumazet@google.com>
    net/x25: fix use-after-free in x25_device_event()

Miaohe Lin <linmiaohe@huawei.com>
    net: sit: fix UBSAN Undefined behaviour in check_6rd

Mao Wenan <maowenan@huawei.com>
    net: hsr: fix memory leak in hsr_dev_finalize()

Eric Dumazet <edumazet@google.com>
    l2tp: fix infoleak in l2tp_ip6_recvmsg()

Eric Biggers <ebiggers@google.com>
    KEYS: restrict /proc/keys by credentials at open time

Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
    netfilter: nf_conntrack_tcp: Fix stack out of bounds when parsing TCP options

Phil Turnbull <phil.turnbull@oracle.com>
    netfilter: nfnetlink_acct: validate NFACCT_FILTER parameters

Ken-ichirou MATSUZAWA <chamaken@gmail.com>
    netfilter: nfnetlink_log: just returns error for unknown command

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: x_tables: enforce nul-terminated table name from getsockopt GET_ENTRIES

Eric Dumazet <edumazet@google.com>
    udplite: call proper backlog handlers

Krzysztof Kozlowski <krzk@kernel.org>
    ARM: dts: exynos: Do not ignore real-world fuse values for thermal zone 0 on Exynos5420

Sasha Levin <sashal@kernel.org>
    Revert "x86/platform/UV: Use efi_runtime_lock to serialise BIOS calls"

Marek Szyprowski <m.szyprowski@samsung.com>
    ARM: dts: exynos: Add minimal clkout parameters to Exynos3250 PMU

Peter Zijlstra <peterz@infradead.org>
    futex,rt_mutex: Restructure rt_mutex_finish_proxy_lock()

Gustavo A. R. Silva <gustavo@embeddedor.com>
    iscsi_ibft: Fix missing break in switch statement

Vincent Batts <vbatts@hashbangbash.com>
    Input: elan_i2c - add id for touchpad found in Lenovo s21e-20

Jason Gerecke <jason.gerecke@wacom.com>
    Input: wacom_serial4 - add support for Wacom ArtPad II tablet

Jun-Ru Chang <jrjang@realtek.com>
    MIPS: Remove function size check in get_frame_info()

Jiri Olsa <jolsa@redhat.com>
    perf symbols: Filter out hidden symbols from labels

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qeth: fix use-after-free in error path

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    dmaengine: dmatest: Abort test in case of mapping error

Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
    dmaengine: at_xdmac: Fix wrongfull report of a channel as in use

Lubomir Rintel <lkundrak@v3.sk>
    irqchip/mmp: Only touch the PJ4 IRQ & FIQ bits on enable/disable

Peng Hao <peng.hao2@zte.com.cn>
    ARM: pxa: ssp: unneeded to free devm_ allocated data

Ian Kent <raven@themaw.net>
    autofs: fix error return in autofs_fill_super()

Pan Bian <bianpan2016@163.com>
    autofs: drop dentry reference only when it is never used

Jan Kara <jack@suse.cz>
    fs/drop_caches.c: avoid softlockups in drop_pagecache_sb()

Mikhail Zaslonko <zaslonko@linux.ibm.com>
    mm, memory_hotplug: test_pages_in_a_zone do not pass the end of zone

Michal Hocko <mhocko@suse.com>
    mm, memory_hotplug: is_mem_section_removable do not pass the end of a zone

Qian Cai <cai@lca.pw>
    x86_64: increase stack size for KASAN_EXTRA

Kairui Song <kasong@redhat.com>
    x86/kexec: Don't setup EFI info if EFI runtime is not enabled

Ronnie Sahlberg <lsahlber@redhat.com>
    cifs: fix computation for MAX_SMB2_HDR_SIZE

Sinan Kaya <okaya@kernel.org>
    platform/x86: Fix unmet dependency warning for SAMSUNG_Q10

Ming Lu <ming.lu@citrix.com>
    scsi: libfc: free skb when receiving invalid flogi resp

Yao Liu <yotta.liu@ucloud.cn>
    nfs: Fix NULL pointer dereference of dev_name

Andrew Lunn <andrew@lunn.ch>
    gpio: vf610: Mask all GPIO interrupts

Alexey Khoroshilov <khoroshilov@ispras.ru>
    net: stmmac: dwmac-rk: fix error handling in rk_gmac_powerup()

Yonglong Liu <liuyonglong@huawei.com>
    net: hns: Fix wrong read accesses via Clause 45 MDIO protocol

Tomonori Sakita <tomonori.sakita@sord.co.jp>
    net: altera_tse: fix msgdma_tx_completion on non-zero fill_level case

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: SMP: limit number of possible CPUs by NR_CPUS

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: SMP: mark each possible CPU as present

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: smp_lx200_defconfig: fix vectors clash

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: SMP: fix secondary CPU initialization

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: SMP: fix ccount_timer_shutdown

Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
    iommu/amd: Fix IOMMU page flush when detach device from a domain

ZhangXiaoxu <zhangxiaoxu5@huawei.com>
    ipvs: Fix signed integer overflow when setsockopt timeout

Brian Welty <brian.welty@intel.com>
    IB/{hfi1, qib}: Fix WC.byte_len calculation for UD_SEND_WITH_IMM

Stephane Eranian <eranian@google.com>
    perf tools: Handle TOPOLOGY headers with no CPU

Su Yanjun <suyj.fnst@cn.fujitsu.com>
    vti4: Fix a ipip packet processing bug in 'IPCOMP' virtual tunnel

Alistair Strachan <astrachan@google.com>
    media: uvcvideo: Fix 'type' check leading to overflow

Ido Schimmel <idosch@mellanox.com>
    ip6mr: Do not call __IP6_INC_STATS() from preemptible context

Andrew Lunn <andrew@lunn.ch>
    net: dsa: mv88e6xxx: Fix u64 statistics

Paul Moore <paul@paul-moore.com>
    netlabel: fix out-of-bounds memory accesses

Mike Kravetz <mike.kravetz@oracle.com>
    hugetlbfs: fix races and page leaks during migration

Liu Xiang <liu.xiang6@zte.com.cn>
    MIPS: irq: Allocate accurate order pages for irq stack

Gustavo A. R. Silva <gustavo@embeddedor.com>
    applicom: Fix potential Spectre v1 vulnerabilities

Jiaxun Yang <jiaxun.yang@flygoat.com>
    x86/CPU/AMD: Set the CPB bit unconditionally on F17h

Rajasingh Thavamani <T.Rajasingh@landisgyr.com>
    net: phy: Micrel KSZ8061: link failure after cable connect

Nazarov Sergey <s-nazarov@yandex.ru>
    net: avoid use IPCB in cipso_v4_error

Nazarov Sergey <s-nazarov@yandex.ru>
    net: Add __icmp_send helper.

Igor Druzhinin <igor.druzhinin@citrix.com>
    xen-netback: fix occasional leak of grant ref mappings under memory pressure

YueHaibing <yuehaibing@huawei.com>
    net: nfc: Fix NULL dereference on nfc_llcp_build_tlv fails

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Drop oversize TX packets to prevent errors.

Ido Schimmel <idosch@mellanox.com>
    team: Free BPF filter when unregistering netdev

Kai-Heng Feng <kai.heng.feng@canonical.com>
    sky2: Disable MSI on Dell Inspiron 1545 and Gateway P-79

YueHaibing <yuehaibing@huawei.com>
    net-sysfs: Fix mem leak in netdev_register_kobject

Dmitry Eremin <dmitry.eremin@intel.com>
    staging: lustre: fix buffer overflow of string buffer

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    isdn: isdn_tty: fix build warning of strncpy

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    ncpfs: fix build warning of strncpy

Andreas Gruenbacher <agruenba@redhat.com>
    sockfs: getxattr: Fail with -EOPNOTSUPP for invalid attribute names

Viresh Kumar <viresh.kumar@linaro.org>
    cpufreq: Use struct kobj_attribute instead of struct global_attr

Mans Rullgard <mans@mansr.com>
    USB: serial: ftdi_sio: add ID for Hjelmslund Electronics USB485

Ivan Mironov <mironov.ivan@gmail.com>
    USB: serial: cp210x: add ID for Ingenico 3070

Daniele Palmas <dnlplm@gmail.com>
    USB: serial: option: add Telit ME910 ECM composition

Andy Lutomirski <luto@kernel.org>
    x86/uaccess: Don't leak the AC flag into __put_user() value evaluation

Jann Horn <jannh@google.com>
    mm: enforce min addr even if capable() in expand_downwards()

Jonathan Neuschäfer <j.neuschaefer@gmx.net>
    mmc: spi: Fix card detection during probe

Seth Forshee <seth.forshee@canonical.com>
    powerpc: Always initialize input array when calling epapr_hypercall()

Christoffer Dall <christoffer.dall@linaro.org>
    KVM: arm/arm64: Fix MMIO emulation data handling

Marc Zyngier <marc.zyngier@arm.com>
    arm/arm64: KVM: Feed initialized memory to MMIO accesses

Vitaly Kuznetsov <vkuznets@redhat.com>
    KVM: nSVM: clear events pending from svm_complete_interrupts() when exiting to L1

Chaitanya Tata <chaitanya.tata@bluwirelesstechnology.com>
    cfg80211: extend range deviation for DMG

Balaji Pothunoori <bpothuno@codeaurora.org>
    mac80211: don't initiate TDLS connection if station is not associated to AP

Thomas Falcon <tlfalcon@linux.ibm.com>
    ibmveth: Do not process frames after calling napi_reschedule

Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
    net: altera_tse: fix connect_local_phy error path

Varun Prakash <varun@chelsio.com>
    scsi: csiostor: fix NULL pointer dereference in csio_vport_set_state()

Tomonori Sakita <tomonori.sakita@sord.co.jp>
    serial: fsl_lpuart: fix maximum acceptable baud rate with over-sampling

Bob Copeland <me@bobcopeland.com>
    mac80211: fix miscounting of ttl-dropped frames

Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    ARC: fix __ffs return value to avoid build warnings

Silvio Cesare <silvio.cesare@gmail.com>
    ASoC: imx-audmux: change snprintf to scnprintf for possible overflow

Silvio Cesare <silvio.cesare@gmail.com>
    ASoC: dapm: change snprintf to scnprintf for possible overflow

Dan Carpenter <dan.carpenter@oracle.com>
    usb: gadget: Potential NULL dereference on allocation error

Zeng Tao <prime.zeng@hisilicon.com>
    usb: dwc3: gadget: Fix the uninitialized link_state when udc starts

Dan Carpenter <dan.carpenter@oracle.com>
    thermal: int340x_thermal: Fix a NULL vs IS_ERR() check

Dan Carpenter <dan.carpenter@oracle.com>
    ALSA: compress: prevent potential divide by zero bugs

Rander Wang <rander.wang@linux.intel.com>
    ASoC: Intel: Haswell/Broadwell: fix setting for .dynamic field

Kristian H. Kristensen <hoegsberg@gmail.com>
    drm/msm: Unblock writer if reader closes file

John Garry <john.garry@huawei.com>
    scsi: libsas: Fix rphy phy_identifier for PHYs with end devices attached

Ilya Dryomov <idryomov@gmail.com>
    libceph: handle an empty authorize reply

Hangbin Liu <liuhangbin@gmail.com>
    Revert "bridge: do not add port to router list when receives query with source 0.0.0.0"

Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    ARCv2: Enable unaligned access in early ASM code

Saeed Mahameed <saeedm@mellanox.com>
    net/mlx4_en: Force CHECKSUM_NONE for short ethernet frames

Hangbin Liu <liuhangbin@gmail.com>
    sit: check if IPv6 enabled before calling ip6_err_gen_icmpv6_unreach()

Cong Wang <xiyou.wangcong@gmail.com>
    team: avoid complex list operations in team_nl_cmd_options_set()

Kal Conley <kal.conley@dectris.com>
    net/packet: fix 4gb buffer limit due to overflow check

Eric Dumazet <edumazet@google.com>
    batman-adv: fix uninit-value in batadv_interface_tx()

Eric Biggers <ebiggers@google.com>
    KEYS: always initialize keyring_index_key::desc_len

Eric Biggers <ebiggers@google.com>
    KEYS: user: Align the payload buffer

Bart Van Assche <bvanassche@acm.org>
    RDMA/srp: Rework SCSI device reset handling

Nathan Chancellor <natechancellor@gmail.com>
    isdn: avm: Fix string plus integer warning from Clang

Kangjie Lu <kjlu@umn.edu>
    leds: lp5523: fix a missing check of return value of lp55xx_read

Colin Ian King <colin.king@canonical.com>
    atm: he: fix sign-extension overflow on large shift

Jia-Ju Bai <baijiaju1990@gmail.com>
    isdn: i4l: isdn_tty: Fix some concurrency double-free bugs

Thomas Bogendoerfer <tbogendoerfer@suse.de>
    MIPS: jazz: fix 64bit build

Logan Gunthorpe <logang@deltatee.com>
    scsi: isci: initialize shost fully before calling scsi_add_host()

YueHaibing <yuehaibing@huawei.com>
    scsi: qla4xxx: check return code of qla4xxx_copy_from_fwddb_param

Alban Bedel <albeu@free.fr>
    MIPS: ath79: Enable OF serial ports in the default config

Yonglong Liu <liuyonglong@huawei.com>
    net: hns: Fix use after free identified by SLUB debug

Kangjie Lu <kjlu@umn.edu>
    mfd: mc13xxx: Fix a missing check of a register-read failure

Charles Keepax <ckeepax@opensource.cirrus.com>
    mfd: wm5110: Add missing ASRC rate register

Jonathan Marek <jonathan@marek.ca>
    mfd: qcom_rpm: write fw_version to CTRL_REG

Dan Carpenter <dan.carpenter@oracle.com>
    mfd: ab8500-core: Return zero in get_register_interruptible()

Nathan Chancellor <natechancellor@gmail.com>
    mfd: db8500-prcmu: Fix some section annotations

Nathan Chancellor <natechancellor@gmail.com>
    mfd: twl-core: Fix section annotations on {,un}protect_pm_master

Vignesh R <vigneshr@ti.com>
    mfd: ti_am335x_tscadc: Use PLATFORM_DEVID_AUTO while registering mfd cells

Eric Biggers <ebiggers@google.com>
    KEYS: allow reaching the keys quotas exactly

Ralph Campbell <rcampbell@nvidia.com>
    numa: change get_mempolicy() to use nr_node_ids instead of MAX_NUMNODES

Yan, Zheng <zyan@redhat.com>
    ceph: avoid repeatedly adding inode to mdsc->snap_flush_list


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arc/include/asm/bitops.h                      |   6 +-
 arch/arc/include/asm/uaccess.h                     |   8 +-
 arch/arc/kernel/head.S                             |  10 +
 arch/arm/Kconfig                                   |   1 +
 arch/arm/boot/dts/exynos3250.dtsi                  |   3 +
 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi  |  25 ++
 arch/arm/boot/dts/exynos5420.dtsi                  |  10 +-
 arch/arm/include/asm/irq.h                         |   1 -
 arch/arm/kernel/irq.c                              |  62 ----
 arch/arm/kernel/smp.c                              |   2 +-
 arch/arm/kvm/mmio.c                                |  10 +-
 arch/arm/mach-omap2/display.c                      |   7 +-
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c            |   8 +-
 arch/arm/plat-pxa/ssp.c                            |   3 -
 arch/arm64/crypto/aes-ce-ccm-core.S                |   5 +-
 arch/arm64/kernel/head.S                           |   3 +-
 arch/m68k/Makefile                                 |   5 +-
 arch/mips/configs/ath79_defconfig                  |   1 +
 arch/mips/jazz/jazzdma.c                           |   5 +-
 arch/mips/kernel/irq.c                             |   4 +-
 arch/mips/kernel/process.c                         |   7 +-
 arch/powerpc/include/asm/epapr_hcalls.h            |  12 +-
 arch/powerpc/kernel/entry_32.S                     |   9 +
 arch/powerpc/platforms/83xx/suspend-asm.S          |  34 ++-
 arch/powerpc/platforms/embedded6xx/wii.c           |   4 +
 arch/powerpc/platforms/powernv/opal-msglog.c       |   2 +-
 arch/x86/include/asm/page_64_types.h               |   4 +
 arch/x86/include/asm/uaccess.h                     |   7 +-
 arch/x86/include/asm/uv/bios.h                     |   8 +-
 arch/x86/kernel/cpu/amd.c                          |   8 +-
 arch/x86/kernel/kexec-bzimage64.c                  |   3 +
 arch/x86/kvm/svm.c                                 |   8 +
 arch/x86/kvm/vmx.c                                 |  17 +-
 arch/x86/kvm/x86.c                                 |   1 +
 arch/x86/platform/uv/bios_uv.c                     |  23 +-
 arch/xtensa/configs/smp_lx200_defconfig            |   1 +
 arch/xtensa/kernel/head.S                          |   5 +-
 arch/xtensa/kernel/smp.c                           |  41 ++-
 arch/xtensa/kernel/time.c                          |   2 +-
 crypto/ahash.c                                     |  14 +-
 crypto/pcbc.c                                      |  14 +-
 drivers/acpi/device_sysfs.c                        |   6 +-
 drivers/atm/he.c                                   |   2 +-
 drivers/base/power/wakeup.c                        |   8 +-
 drivers/char/applicom.c                            |  35 ++-
 drivers/clk/ingenic/cgu.c                          |  10 +-
 drivers/clocksource/exynos_mct.c                   |  23 +-
 drivers/cpufreq/cpufreq.c                          |   6 +-
 drivers/cpufreq/cpufreq_governor.h                 |  10 +-
 drivers/cpufreq/intel_pstate.c                     |  14 +-
 drivers/cpufreq/pxa2xx-cpufreq.c                   |   4 +-
 drivers/cpufreq/tegra124-cpufreq.c                 |   2 +
 drivers/crypto/caam/caamalg.c                      |   1 +
 drivers/dma/at_xdmac.c                             |  19 +-
 drivers/dma/dmatest.c                              |  28 +-
 drivers/dma/sh/usb-dmac.c                          |   2 +
 drivers/firmware/efi/runtime-wrappers.c            |   7 -
 drivers/firmware/iscsi_ibft.c                      |   1 +
 drivers/gpio/gpio-vf610.c                          |   5 +
 drivers/gpu/drm/msm/msm_rd.c                       |   7 +-
 drivers/gpu/drm/radeon/evergreen_cs.c              |   1 +
 drivers/gpu/ipu-v3/ipu-common.c                    |   8 +-
 drivers/hwtracing/intel_th/gth.c                   |   4 +
 drivers/hwtracing/stm/core.c                       |  11 +-
 drivers/i2c/busses/i2c-cadence.c                   |   9 +-
 drivers/i2c/busses/i2c-tegra.c                     |   2 +-
 drivers/infiniband/hw/qib/qib_ud.c                 |   1 -
 drivers/infiniband/ulp/srp/ib_srp.c                |  10 -
 drivers/input/keyboard/matrix_keypad.c             |   2 +-
 drivers/input/keyboard/st-keyscan.c                |   4 +-
 drivers/input/mouse/elan_i2c_core.c                |   1 +
 drivers/input/tablet/wacom_serial4.c               |   2 +
 drivers/iommu/amd_iommu.c                          |  15 +-
 drivers/irqchip/irq-mmp.c                          |   6 +-
 drivers/isdn/hardware/avm/b1.c                     |   2 +-
 drivers/isdn/i4l/isdn_tty.c                        |   8 +-
 drivers/leds/leds-lp5523.c                         |   4 +-
 drivers/md/raid10.c                                |   3 +-
 drivers/md/raid5.c                                 |   2 +
 drivers/media/usb/uvc/uvc_driver.c                 |  14 +-
 drivers/media/usb/uvc/uvc_video.c                  |   8 +
 drivers/media/v4l2-core/videobuf2-v4l2.c           |   1 -
 drivers/mfd/ab8500-core.c                          |   2 +-
 drivers/mfd/db8500-prcmu.c                         |   4 +-
 drivers/mfd/mc13xxx-core.c                         |   4 +-
 drivers/mfd/qcom_rpm.c                             |   4 +
 drivers/mfd/ti_am335x_tscadc.c                     |   5 +-
 drivers/mfd/twl-core.c                             |   4 +-
 drivers/mfd/wm5110-tables.c                        |   2 +
 drivers/mmc/host/mmc_spi.c                         |   1 +
 drivers/net/dsa/mv88e6xxx.c                        |   2 +-
 drivers/net/ethernet/altera/altera_msgdma.c        |   3 +-
 drivers/net/ethernet/altera/altera_tse_main.c      |   4 +-
 drivers/net/ethernet/atheros/atlx/atl2.c           |   4 +-
 drivers/net/ethernet/broadcom/bcmsysport.c         |   4 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   6 +
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c  |   6 +-
 drivers/net/ethernet/hisilicon/hns_mdio.c          |   2 +-
 drivers/net/ethernet/ibm/ibmveth.c                 |   2 -
 drivers/net/ethernet/marvell/mv643xx_eth.c         |   7 +-
 drivers/net/ethernet/marvell/sky2.c                |  24 +-
 drivers/net/ethernet/mellanox/mlx4/cmd.c           |   1 +
 drivers/net/ethernet/mellanox/mlx4/en_rx.c         |  23 +-
 .../net/ethernet/mellanox/mlx4/resource_tracker.c  |   6 +-
 drivers/net/ethernet/renesas/ravb_main.c           |   2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |   4 +-
 drivers/net/ipvlan/ipvlan_main.c                   |   9 +-
 drivers/net/phy/mdio_bus.c                         |   1 -
 drivers/net/phy/micrel.c                           |  14 +-
 drivers/net/ppp/pptp.c                             |   1 +
 drivers/net/team/team.c                            |  27 +-
 drivers/net/team/team_mode_loadbalance.c           |  15 +
 drivers/net/vxlan.c                                |  13 +-
 drivers/net/wireless/mac80211_hwsim.c              |   2 +-
 drivers/net/xen-netback/netback.c                  |  10 +-
 drivers/parport/parport_pc.c                       |   2 +-
 drivers/pinctrl/meson/pinctrl-meson8b.c            |   2 +-
 drivers/platform/x86/Kconfig                       |   1 +
 drivers/regulator/s2mpa01.c                        |  10 +-
 drivers/regulator/s2mps11.c                        |   6 +-
 drivers/s390/block/dasd_eckd.c                     |   8 +
 drivers/s390/net/qeth_core_main.c                  |  15 +-
 drivers/s390/virtio/virtio_ccw.c                   |   4 +-
 drivers/scsi/csiostor/csio_attr.c                  |   2 +-
 drivers/scsi/isci/init.c                           |  14 +-
 drivers/scsi/libfc/fc_lport.c                      |   6 +-
 drivers/scsi/libiscsi.c                            |   6 +
 drivers/scsi/libsas/sas_expander.c                 |   2 +
 drivers/scsi/qla4xxx/ql4_os.c                      |   2 +
 drivers/scsi/virtio_scsi.c                         |   2 -
 .../staging/lustre/lnet/klnds/socklnd/socklnd.c    |   9 +-
 drivers/staging/lustre/lnet/lnet/config.c          |  14 +-
 drivers/staging/lustre/lnet/selftest/conrpc.c      |   4 +-
 drivers/staging/lustre/lnet/selftest/console.c     |   6 +-
 .../staging/lustre/lustre/include/lustre_disk.h    |   1 +
 drivers/staging/lustre/lustre/libcfs/debug.c       |   6 +-
 drivers/staging/lustre/lustre/libcfs/hash.c        |   3 +-
 drivers/staging/lustre/lustre/libcfs/workitem.c    |   4 +-
 drivers/staging/lustre/lustre/llite/dir.c          |   2 +-
 drivers/staging/lustre/lustre/lov/lov_pool.c       |   3 +-
 drivers/staging/lustre/lustre/obdclass/obd_mount.c |  10 +-
 drivers/staging/lustre/lustre/ptlrpc/ptlrpcd.c     |   1 +
 drivers/staging/lustre/lustre/ptlrpc/sec_config.c  |   3 +-
 drivers/staging/rdma/hfi1/ud.c                     |   1 -
 drivers/target/iscsi/iscsi_target.c                |   4 +-
 .../int340x_thermal/processor_thermal_device.c     |   2 +-
 drivers/tty/serial/8250/8250_pci.c                 | 141 +++++++--
 drivers/tty/serial/fsl_lpuart.c                    |   2 +-
 drivers/usb/dwc3/gadget.c                          |   1 +
 drivers/usb/gadget/function/f_sourcesink.c         |   2 +-
 drivers/usb/serial/cp210x.c                        |   1 +
 drivers/usb/serial/ftdi_sio.c                      |   2 +
 drivers/usb/serial/ftdi_sio_ids.h                  |   6 +
 drivers/usb/serial/option.c                        |   2 +
 fs/9p/cache.c                                      |   8 +-
 fs/9p/v9fs.h                                       |   2 +-
 fs/9p/v9fs_vfs.h                                   |  23 +-
 fs/9p/vfs_file.c                                   |   6 +-
 fs/9p/vfs_inode.c                                  |  25 +-
 fs/9p/vfs_inode_dotl.c                             |  27 +-
 fs/9p/vfs_super.c                                  |   4 +-
 fs/autofs4/expire.c                                |   3 +-
 fs/autofs4/inode.c                                 |   4 +-
 fs/btrfs/extent_io.c                               |   4 +-
 fs/btrfs/volumes.c                                 |   4 +-
 fs/ceph/snap.c                                     |   3 +-
 fs/cifs/file.c                                     |  12 +-
 fs/cifs/smb2pdu.h                                  |   4 +-
 fs/drop_caches.c                                   |   8 +-
 fs/ext2/super.c                                    |  39 ++-
 fs/ext4/resize.c                                   |   3 +-
 fs/hugetlbfs/inode.c                               |  12 +
 fs/jbd2/transaction.c                              |  33 +-
 fs/ncpfs/ioctl.c                                   |   4 +-
 fs/nfs/direct.c                                    |  15 +-
 fs/nfs/filelayout/filelayout.c                     |  17 +-
 fs/nfs/flexfilelayout/flexfilelayout.c             |  25 +-
 fs/nfs/pagelist.c                                  |  12 +-
 fs/nfs/pnfs.c                                      |  24 +-
 fs/nfs/read.c                                      |   2 +-
 fs/nfs/super.c                                     |   5 +
 fs/nfsd/nfs3proc.c                                 |  16 +-
 fs/nfsd/nfs3xdr.c                                  |   1 +
 fs/nfsd/nfsctl.c                                   |   2 +-
 include/keys/user-type.h                           |   2 +-
 include/linux/cpufreq.h                            |  12 +-
 include/linux/device-mapper.h                      |   2 +-
 include/net/gro_cells.h                            |  12 +-
 include/net/icmp.h                                 |   9 +-
 include/net/ip.h                                   |   2 +
 include/net/phonet/pep.h                           |   5 +-
 kernel/futex.c                                     |   7 +-
 kernel/locking/rtmutex.c                           |  52 +++-
 kernel/locking/rtmutex_common.h                    |   8 +-
 kernel/rcu/tree.c                                  |  20 +-
 kernel/sysctl.c                                    |  11 +-
 kernel/trace/trace.c                               |   1 -
 lib/assoc_array.c                                  |   8 +-
 mm/hugetlb.c                                       |  14 +-
 mm/memory_hotplug.c                                |   6 +-
 mm/mempolicy.c                                     |   6 +-
 mm/migrate.c                                       |  11 +
 mm/mmap.c                                          |   7 +-
 mm/shmem.c                                         |  12 +-
 mm/vmalloc.c                                       |   2 +-
 net/9p/client.c                                    |   2 +-
 net/batman-adv/soft-interface.c                    |   2 +
 net/bridge/br_multicast.c                          |   9 +-
 net/bridge/netfilter/ebtables.c                    |   4 +
 net/ceph/messenger.c                               |  12 +-
 net/core/net-sysfs.c                               |   3 +
 net/hsr/hsr_device.c                               |  18 +-
 net/hsr/hsr_framereg.c                             |  12 +
 net/hsr/hsr_framereg.h                             |   1 +
 net/ipv4/cipso_ipv4.c                              |  23 +-
 net/ipv4/icmp.c                                    |   7 +-
 net/ipv4/inet_connection_sock.c                    |   2 +-
 net/ipv4/ip_options.c                              |  22 +-
 net/ipv4/ip_vti.c                                  |  50 +++
 net/ipv4/netfilter/arp_tables.c                    |   2 +
 net/ipv4/netfilter/ip_tables.c                     |   2 +
 net/ipv4/route.c                                   |   4 +
 net/ipv4/syncookies.c                              |   7 +-
 net/ipv4/tcp_input.c                               |   8 +-
 net/ipv4/udp.c                                     |   2 +-
 net/ipv4/udp_impl.h                                |   2 +-
 net/ipv4/udplite.c                                 |   2 +-
 net/ipv6/ip6mr.c                                   |   8 +-
 net/ipv6/netfilter/ip6_tables.c                    |   2 +
 net/ipv6/route.c                                   |   2 +-
 net/ipv6/sit.c                                     |   7 +-
 net/ipv6/udp.c                                     |   2 +-
 net/ipv6/udp_impl.h                                |   2 +-
 net/ipv6/udplite.c                                 |   2 +-
 net/l2tp/l2tp_ip6.c                                |   4 +-
 net/mac80211/cfg.c                                 |   4 +
 net/mac80211/rx.c                                  |   4 +-
 net/netfilter/ipvs/ip_vs_ctl.c                     |  12 +
 net/netfilter/nf_conntrack_proto_tcp.c             |   4 +
 net/netfilter/nfnetlink_acct.c                     |   3 +
 net/netfilter/nfnetlink_log.c                      |   2 +-
 net/nfc/llcp_commands.c                            |  20 ++
 net/nfc/llcp_core.c                                |  24 +-
 net/packet/af_packet.c                             |   2 +-
 net/phonet/pep.c                                   |  32 +-
 net/socket.c                                       |  24 +-
 net/unix/af_unix.c                                 |  48 +--
 net/unix/diag.c                                    |   3 +-
 net/wireless/reg.c                                 |   4 +-
 net/x25/af_x25.c                                   |  20 +-
 security/keys/key.c                                |   4 +-
 security/keys/keyring.c                            |   4 +-
 security/keys/proc.c                               |  11 +-
 security/keys/request_key.c                        |   1 +
 security/keys/request_key_auth.c                   |   2 +-
 security/lsm_audit.c                               |  10 +-
 sound/core/compress_offload.c                      |   3 +-
 sound/firewire/bebob/bebob.c                       |  14 +-
 sound/soc/fsl/fsl_esai.c                           |   7 +-
 sound/soc/fsl/imx-audmux.c                         |  24 +-
 sound/soc/intel/boards/broadwell.c                 |   2 +-
 sound/soc/intel/boards/haswell.c                   |   2 +-
 sound/soc/soc-dapm.c                               |  10 +-
 sound/soc/soc-topology.c                           |   8 +-
 tools/arch/x86/include/asm/cpufeatures.h           | 336 +++++++++++++++++++++
 tools/arch/x86/include/asm/disabled-features.h     |  65 ++++
 tools/arch/x86/include/asm/required-features.h     | 106 +++++++
 tools/arch/x86/lib/memcpy_64.S                     | 179 +++++++++++
 tools/arch/x86/lib/memset_64.S                     | 138 +++++++++
 .../{perf/util => }/include/asm/alternative-asm.h  |   4 +-
 tools/perf/MANIFEST                                |   8 +-
 tools/perf/Makefile.perf                           |  15 +
 tools/perf/bench/mem-memcpy-x86-64-asm.S           |   2 +-
 tools/perf/bench/mem-memset-x86-64-asm.S           |   2 +-
 tools/perf/util/auxtrace.c                         |   4 +-
 tools/perf/util/auxtrace.h                         |   3 +
 tools/perf/util/cpumap.c                           |  11 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  37 ++-
 tools/perf/util/symbol-elf.c                       |   9 +-
 virt/kvm/arm/vgic.c                                |   7 -
 281 files changed, 2463 insertions(+), 797 deletions(-)


