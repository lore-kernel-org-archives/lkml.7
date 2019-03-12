Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F051C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152432147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412698;
	bh=Iw3kqnvMf7ZJgzIymDikdKibJdq5nN+QCZibCvwlMbg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=yy4Khs8x4MExHrNup+EKMmJVjhkHE5Oag2JgwOLBl0prTuv9Kun51qbxnuky8RATS
	 QN1jiSaWky5xhq3VogXmO0KA0kOdStVODX/iOLPFBBIuJFfOgkLW6A9SjhMB9CaTTK
	 1QIYsljLKcm+ZMqO9QNB3Pa4f9Edh1AfHy+zuz8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfCLRo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:44:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728792AbfCLRPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:36 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7659E21871;
        Tue, 12 Mar 2019 17:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410935;
        bh=Iw3kqnvMf7ZJgzIymDikdKibJdq5nN+QCZibCvwlMbg=;
        h=From:To:Cc:Subject:Date:From;
        b=wjR5aubPZv1aI/hOL9pOjgrukR+xmQXPOkaMC6OGmxAflzA2UNp9ACAOaaxSe+FLG
         iPc/uY8HY2uicEh3HIR2XMR4fwNdMPAG3aJo4V65EoCGkJG7ygxYdXJ8fGwUrc9BJe
         54Ph/lPAisLLj4W/Y6dVwJKZ7dlxup6CTZMs5xQs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 000/135] 4.14.106-stable review
Date:   Tue, 12 Mar 2019 10:07:27 -0700
Message-Id: <20190312170341.127810985@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.106-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.106-rc1
X-KernelTest-Deadline: 2019-03-14T17:03+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.106 release.
There are 135 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Mar 14 17:02:27 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.106-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.106-rc1

Peter Zijlstra (Intel) <peterz@infradead.org>
    perf/x86/intel: Implement support for TSX Force Abort

Peter Zijlstra (Intel) <peterz@infradead.org>
    x86: Add TSX Force Abort CPUID/MSR

Peter Zijlstra (Intel) <peterz@infradead.org>
    perf/x86/intel: Generalize dynamic constraint creation

Peter Zijlstra (Intel) <peterz@infradead.org>
    perf/x86/intel: Make cpuc allocations consistent

Geert Uytterhoeven <geert+renesas@glider.be>
    driver core: Postpone DMA tear-down until after devres release

Daniel F. Dickinson <cshored@thecshore.com>
    ath9k: Avoid OF no-EEPROM quirks without qca,no-eeprom

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Fix missed wakeups in find_insert_glock

Vincent Whitchurch <vincent.whitchurch@axis.com>
    ARM: 8781/1: Fix Thumb-2 syscall return for binutils 2.29+

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    drm: disable uncached DMA optimization for ARM and arm64

Marek Szyprowski <m.szyprowski@samsung.com>
    ARM: dts: exynos: Add minimal clkout parameters to Exynos3250 PMU

Marek Szyprowski <m.szyprowski@samsung.com>
    ARM: dts: exynos: Fix pinctrl definition for eMMC RTSN line on Odroid X2/U3

Jan Kiszka <jan.kiszka@siemens.com>
    arm64: dts: hikey: Give wifi some time after power-on

Gustavo A. R. Silva <gustavo@embeddedor.com>
    scsi: aacraid: Fix missing break in switch statement

Gustavo A. R. Silva <gustavo@embeddedor.com>
    iscsi_ibft: Fix missing break in switch statement

Vincent Batts <vbatts@hashbangbash.com>
    Input: elan_i2c - add id for touchpad found in Lenovo s21e-20

Jason Gerecke <jason.gerecke@wacom.com>
    Input: wacom_serial4 - add support for Wacom ArtPad II tablet

Sudarsana Reddy Kalluru <skalluru@marvell.com>
    qed: Consider TX tcs while deriving the max num_queues for PF.

Manish Chopra <manishc@marvell.com>
    qed: Fix EQ full firmware assert.

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    fs: ratelimit __find_get_block_slow() failure message.

Tony Lindgren <tony@atomide.com>
    i2c: omap: Use noirq system sleep pm ops to idle device for suspend

Jun-Ru Chang <jrjang@realtek.com>
    MIPS: Remove function size check in get_frame_info()

Huacai Chen <chenhc@lemote.com>
    MIPS: Loongson: Introduce and use loongson_llsc_mb()

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf trace: Support multiple "vfs_getname" probes

Jiri Olsa <jolsa@redhat.com>
    perf symbols: Filter out hidden symbols from labels

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qeth: fix use-after-free in error path

Martynas Pumputis <martynas@weave.works>
    netfilter: nf_nat: skip nat clash resolution for same-origin entries

Florian Westphal <fw@strlen.de>
    selftests: netfilter: add simple masq/redirect test cases

Naresh Kamboju <naresh.kamboju@linaro.org>
    selftests: netfilter: fix config fragment CONFIG_NF_TABLES_INET

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    dmaengine: dmatest: Abort test in case of mapping error

Stefano Garzarella <sgarzare@redhat.com>
    vsock/virtio: reset connected sockets on device removal

Stefano Garzarella <sgarzare@redhat.com>
    vsock/virtio: fix kernel panic after device hot-unplug

Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
    dmaengine: at_xdmac: Fix wrongfull report of a channel as in use

Paul Kocialkowski <paul.kocialkowski@bootlin.com>
    drm/sun4i: tcon: Prepare and enable TCON channel 0 clock at init

Alexei Starovoitov <ast@kernel.org>
    bpf: fix lockdep false positive in percpu_freelist

Martynas Pumputis <m@lambda.lt>
    bpf, selftests: fix handling of sparse CPU allocations

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    relay: check return of create_buf_file() properly

Zenghui Yu <yuzenghui@huawei.com>
    irqchip/gic-v3-its: Fix ITT_entry_size accessor

Jose Abreu <jose.abreu@synopsys.com>
    net: stmmac: Disable EEE mode earlier in XMIT callback

Jose Abreu <jose.abreu@synopsys.com>
    net: stmmac: Send TSO packets always from Queue 0

Jose Abreu <jose.abreu@synopsys.com>
    net: stmmac: Fallback to Platform Data clock in Watchdog conversion

Lubomir Rintel <lkundrak@v3.sk>
    irqchip/mmp: Only touch the PJ4 IRQ & FIQ bits on enable/disable

Anders Roxell <anders.roxell@linaro.org>
    usb: phy: fix link errors

Zhou Yanjie <zhouyanjie@cduestc.edu.cn>
    DTS: CI20: Fix bugs in ci20's device tree.

Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
    arm64: dts: add msm8996 compatible to gicv3

Peng Hao <peng.hao2@zte.com.cn>
    ARM: pxa: ssp: unneeded to free devm_ allocated data

Yafang Shao <laoar.shao@gmail.com>
    bpf: sock recvbuff must be limited by rmem_max in bpf_setsockopt()

Madalin Bucur <madalin.bucur@nxp.com>
    soc: fsl: qbman: avoid race in clearing QMan interrupt

Geert Uytterhoeven <geert+renesas@glider.be>
    arm64: dts: renesas: r8a7796: Enable DMA for SCIF2

Tony Lindgren <tony@atomide.com>
    ARM: dts: omap4-droid4: Fix typo in cpcap IRQ flags

Ian Kent <raven@themaw.net>
    autofs: fix error return in autofs_fill_super()

Pan Bian <bianpan2016@163.com>
    autofs: drop dentry reference only when it is never used

Jan Kara <jack@suse.cz>
    fs/drop_caches.c: avoid softlockups in drop_pagecache_sb()

Dan Carpenter <dan.carpenter@oracle.com>
    lib/test_kmod.c: potential double free in error handling

Mikhail Zaslonko <zaslonko@linux.ibm.com>
    mm, memory_hotplug: test_pages_in_a_zone do not pass the end of zone

Michal Hocko <mhocko@suse.com>
    mm, memory_hotplug: is_mem_section_removable do not pass the end of a zone

Qian Cai <cai@lca.pw>
    x86_64: increase stack size for KASAN_EXTRA

Kairui Song <kasong@redhat.com>
    x86/kexec: Don't setup EFI info if EFI runtime is not enabled

John Johansen <john.johansen@canonical.com>
    apparmor: Fix aa_label_build() error handling for failed merges

James Morse <james.morse@arm.com>
    arm64: kprobe: Always blacklist the KVM world-switch code

Thomas Lendacky <Thomas.Lendacky@amd.com>
    x86/microcode/amd: Don't falsely trick the late loading mechanism

Ronnie Sahlberg <lsahlber@redhat.com>
    cifs: fix computation for MAX_SMB2_HDR_SIZE

Sinan Kaya <okaya@kernel.org>
    platform/x86: Fix unmet dependency warning for SAMSUNG_Q10

Dan Carpenter <dan.carpenter@oracle.com>
    scsi: 53c700: pass correct "dev" to dma_alloc_attrs()

Ming Lu <ming.lu@citrix.com>
    scsi: libfc: free skb when receiving invalid flogi resp

Manish Chopra <manishc@marvell.com>
    qed: Fix stack out of bounds bug

Manish Chopra <manishc@marvell.com>
    qed: Fix system crash in ll2 xmit

Manish Chopra <manishc@marvell.com>
    qed: Fix VF probe failure while FLR

Manish Chopra <manishc@marvell.com>
    qed: Fix LACP pdu drops for VFs

Manish Chopra <manishc@marvell.com>
    qed: Fix bug in tx promiscuous mode settings

Yao Liu <yotta.liu@ucloud.cn>
    nfs: Fix NULL pointer dereference of dev_name

Fathi Boudra <fathi.boudra@linaro.org>
    selftests: timers: use LDLIBS instead of LDFLAGS

Andrew Lunn <andrew@lunn.ch>
    gpio: vf610: Mask all GPIO interrupts

Florian Westphal <fw@strlen.de>
    netfilter: ebtables: compat: un-break 32bit setsockopt when no rules are present

Alexey Khoroshilov <khoroshilov@ispras.ru>
    net: stmmac: dwmac-rk: fix error handling in rk_gmac_powerup()

Yonglong Liu <liuyonglong@huawei.com>
    net: hns: Fix wrong read accesses via Clause 45 MDIO protocol

Yonglong Liu <liuyonglong@huawei.com>
    net: hns: Restart autoneg need return failed when autoneg off

Yonglong Liu <liuyonglong@huawei.com>
    net: hns: Fix for missing of_node_put() after of_parse_phandle()

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

Colin Ian King <colin.king@canonical.com>
    selftests: cpu-hotplug: fix case where CPUs offline > CPUs present

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: SMP: fix ccount_timer_shutdown

Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
    iommu/amd: Fix IOMMU page flush when detach device from a domain

ZhangXiaoxu <zhangxiaoxu5@huawei.com>
    ipvs: Fix signed integer overflow when setsockopt timeout

Jerry Snitselaar <jsnitsel@redhat.com>
    iommu/amd: Unmap all mapped pages in error path of map_sg

Jerry Snitselaar <jsnitsel@redhat.com>
    iommu/amd: Call free_iova_fast with pfn in map_sg

Brian Welty <brian.welty@intel.com>
    IB/{hfi1, qib}: Fix WC.byte_len calculation for UD_SEND_WITH_IMM

Stephane Eranian <eranian@google.com>
    perf tools: Handle TOPOLOGY headers with no CPU

Stephane Eranian <eranian@google.com>
    perf core: Fix perf_proc_update_handler() bug

Su Yanjun <suyj.fnst@cn.fujitsu.com>
    vti4: Fix a ipip packet processing bug in 'IPCOMP' virtual tunnel

Alistair Strachan <astrachan@google.com>
    media: uvcvideo: Fix 'type' check leading to overflow

Martin Wilck <mwilck@suse.com>
    scsi: core: reset host byte in DID_NEXUS_FAILURE case

YueHaibing <yuehaibing@huawei.com>
    exec: Fix mem leak in kernel_read_file

Matthias Kaehlcke <mka@chromium.org>
    Bluetooth: Fix locking in bt_accept_enqueue() for BH context

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: fix get_wchan

Mike Kravetz <mike.kravetz@oracle.com>
    hugetlbfs: fix races and page leaks during migration

Liu Xiang <liu.xiang6@zte.com.cn>
    MIPS: irq: Allocate accurate order pages for irq stack

Gustavo A. R. Silva <gustavo@embeddedor.com>
    applicom: Fix potential Spectre v1 vulnerabilities

Jiaxun Yang <jiaxun.yang@flygoat.com>
    x86/CPU/AMD: Set the CPB bit unconditionally on F17h

Andrew Lunn <andrew@lunn.ch>
    net: dsa: mv88e6xxx: Fix statistics on mv88e6161

Rajasingh Thavamani <T.Rajasingh@landisgyr.com>
    net: phy: Micrel KSZ8061: link failure after cable connect

Timur Celik <mail@timurcelik.de>
    tun: remove unnecessary memory barrier

Timur Celik <mail@timurcelik.de>
    tun: fix blocking read

David Ahern <dsahern@gmail.com>
    mpls: Return error for RTA_GATEWAY attribute

David Ahern <dsahern@gmail.com>
    ipv6: Return error for RTA_VIA attribute

David Ahern <dsahern@gmail.com>
    ipv4: Return error for RTA_VIA attribute

Nazarov Sergey <s-nazarov@yandex.ru>
    net: avoid use IPCB in cipso_v4_error

Nazarov Sergey <s-nazarov@yandex.ru>
    net: Add __icmp_send helper.

Igor Druzhinin <igor.druzhinin@citrix.com>
    xen-netback: fix occasional leak of grant ref mappings under memory pressure

Igor Druzhinin <igor.druzhinin@citrix.com>
    xen-netback: don't populate the hash cache on XenBus disconnect

Eric Biggers <ebiggers@google.com>
    net: socket: set sock->sk to NULL after calling proto_ops::release()

Mao Wenan <maowenan@huawei.com>
    net: sit: fix memory leak in sit_init_net()

Heiner Kallweit <hkallweit1@gmail.com>
    net: phy: phylink: fix uninitialized variable in phylink_get_mac_state

YueHaibing <yuehaibing@huawei.com>
    net: nfc: Fix NULL dereference on nfc_llcp_build_tlv fails

Sheng Lan <lansheng@huawei.com>
    net: netem: fix skb length BUG_ON in __skb_to_sgvec

Paul Moore <paul@paul-moore.com>
    netlabel: fix out-of-bounds memory accesses

Andrew Lunn <andrew@lunn.ch>
    net: dsa: mv88e6xxx: Fix u64 statistics

Haiyang Zhang <haiyangz@microsoft.com>
    hv_netvsc: Fix IP header checksum for coalesced packets

Jiri Benc <jbenc@redhat.com>
    geneve: correctly handle ipv6.disable module parameter

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Drop oversize TX packets to prevent errors.

Erik Hugne <erik.hugne@gmail.com>
    tipc: fix RDM/DGRAM connect() regression

Ido Schimmel <idosch@mellanox.com>
    team: Free BPF filter when unregistering netdev

Kai-Heng Feng <kai.heng.feng@canonical.com>
    sky2: Disable MSI on Dell Inspiron 1545 and Gateway P-79

YueHaibing <yuehaibing@huawei.com>
    net-sysfs: Fix mem leak in netdev_register_kobject

Heiner Kallweit <hkallweit1@gmail.com>
    net: dsa: mv88e6xxx: handle unknown duplex modes gracefully in mv88e6xxx_port_set_duplex

Ido Schimmel <idosch@mellanox.com>
    ip6mr: Do not call __IP6_INC_STATS() from preemptible context

Qing Xia <saberlily.xia@hisilicon.com>
    staging: android: ion: fix sys heap pool's gfp_flags

Ajay Singh <ajay.kathat@microchip.com>
    staging: wilc1000: fix to set correct value for 'vif_num'

Gustavo A. R. Silva <gustavo@embeddedor.com>
    staging: comedi: ni_660x: fix missing break in switch statement

Mans Rullgard <mans@mansr.com>
    USB: serial: ftdi_sio: add ID for Hjelmslund Electronics USB485

Ivan Mironov <mironov.ivan@gmail.com>
    USB: serial: cp210x: add ID for Ingenico 3070

Daniele Palmas <dnlplm@gmail.com>
    USB: serial: option: add Telit ME910 ECM composition

Viresh Kumar <viresh.kumar@linaro.org>
    cpufreq: Use struct kobj_attribute instead of struct global_attr


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/boot/dts/exynos3250.dtsi                  |   3 +
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  13 +-
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi     |   2 +-
 arch/arm/kernel/entry-common.S                     |   4 +-
 arch/arm/plat-pxa/ssp.c                            |   3 -
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     |   1 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   2 +-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           |   3 +
 arch/arm64/kernel/probes/kprobes.c                 |   6 +-
 arch/mips/Kconfig                                  |  15 +
 arch/mips/boot/dts/ingenic/ci20.dts                |   8 +-
 arch/mips/include/asm/atomic.h                     |   6 +
 arch/mips/include/asm/barrier.h                    |  36 +
 arch/mips/include/asm/bitops.h                     |   5 +
 arch/mips/include/asm/futex.h                      |   3 +
 arch/mips/include/asm/pgtable.h                    |   2 +
 arch/mips/kernel/irq.c                             |   4 +-
 arch/mips/kernel/process.c                         |   7 +-
 arch/mips/loongson64/Platform                      |  23 +
 arch/mips/mm/tlbex.c                               |  10 +
 arch/x86/events/core.c                             |  13 +-
 arch/x86/events/intel/core.c                       | 154 ++++-
 arch/x86/events/perf_event.h                       |  17 +-
 arch/x86/include/asm/cpufeatures.h                 |   1 +
 arch/x86/include/asm/msr-index.h                   |   6 +
 arch/x86/include/asm/page_64_types.h               |   4 +
 arch/x86/kernel/cpu/amd.c                          |   8 +-
 arch/x86/kernel/cpu/microcode/amd.c                |   2 +-
 arch/x86/kernel/kexec-bzimage64.c                  |   3 +
 arch/xtensa/configs/smp_lx200_defconfig            |   1 +
 arch/xtensa/kernel/head.S                          |   5 +-
 arch/xtensa/kernel/process.c                       |   4 +-
 arch/xtensa/kernel/smp.c                           |  41 +-
 arch/xtensa/kernel/time.c                          |   2 +-
 drivers/base/dd.c                                  |   2 +-
 drivers/char/applicom.c                            |  35 +-
 drivers/cpufreq/cpufreq.c                          |   6 +-
 drivers/cpufreq/intel_pstate.c                     |  18 +-
 drivers/dma/at_xdmac.c                             |  19 +-
 drivers/dma/dmatest.c                              |  28 +-
 drivers/firmware/iscsi_ibft.c                      |   1 +
 drivers/gpio/gpio-vf610.c                          |   5 +
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |   2 +
 drivers/i2c/busses/i2c-omap.c                      |  13 +-
 drivers/infiniband/hw/hfi1/ud.c                    |   1 -
 drivers/infiniband/hw/qib/qib_ud.c                 |   1 -
 drivers/input/mouse/elan_i2c_core.c                |   1 +
 drivers/input/tablet/wacom_serial4.c               |   2 +
 drivers/iommu/amd_iommu.c                          |  19 +-
 drivers/irqchip/irq-mmp.c                          |   6 +-
 drivers/media/usb/uvc/uvc_driver.c                 |  14 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |   4 +-
 drivers/net/dsa/mv88e6xxx/port.c                   |   2 +-
 drivers/net/ethernet/altera/altera_msgdma.c        |   3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   6 +
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      |   5 +
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   |  16 +-
 drivers/net/ethernet/hisilicon/hns_mdio.c          |   2 +-
 drivers/net/ethernet/marvell/sky2.c                |  24 +-
 drivers/net/ethernet/qlogic/qed/qed_dev.c          |   8 +-
 drivers/net/ethernet/qlogic/qed/qed_l2.c           |  17 +-
 drivers/net/ethernet/qlogic/qed/qed_l2.h           |   3 +
 drivers/net/ethernet/qlogic/qed/qed_ll2.c          |  20 +-
 drivers/net/ethernet/qlogic/qed/qed_sp.h           |   1 +
 drivers/net/ethernet/qlogic/qed/qed_spq.c          |  15 +-
 drivers/net/ethernet/qlogic/qed/qed_sriov.c        |  10 +-
 drivers/net/ethernet/qlogic/qed/qed_vf.c           |  10 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |   4 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |  14 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  17 +-
 drivers/net/geneve.c                               |  11 +-
 drivers/net/hyperv/netvsc_drv.c                    |  22 +-
 drivers/net/phy/micrel.c                           |  13 +-
 drivers/net/phy/phylink.c                          |   4 +
 drivers/net/team/team_mode_loadbalance.c           |  15 +
 drivers/net/tun.c                                  |   4 +-
 drivers/net/wireless/ath/ath9k/init.c              |   6 +-
 drivers/net/xen-netback/hash.c                     |   2 +
 drivers/net/xen-netback/interface.c                |   7 +
 drivers/net/xen-netback/netback.c                  |  10 +-
 drivers/platform/x86/Kconfig                       |   1 +
 drivers/s390/net/qeth_core_main.c                  |  15 +-
 drivers/scsi/53c700.c                              |   2 +-
 drivers/scsi/aacraid/commsup.c                     |   5 +-
 drivers/scsi/libfc/fc_lport.c                      |   6 +-
 drivers/scsi/scsi_lib.c                            |   1 +
 drivers/soc/fsl/qbman/qman.c                       |   9 +-
 drivers/staging/android/ion/ion_system_heap.c      |   2 +-
 drivers/staging/comedi/drivers/ni_660x.c           |   1 +
 drivers/staging/wilc1000/linux_wlan.c              |   4 +-
 drivers/usb/phy/Kconfig                            |   2 +-
 drivers/usb/serial/cp210x.c                        |   1 +
 drivers/usb/serial/ftdi_sio.c                      |   2 +
 drivers/usb/serial/ftdi_sio_ids.h                  |   6 +
 drivers/usb/serial/option.c                        |   2 +
 fs/autofs4/expire.c                                |   3 +-
 fs/autofs4/inode.c                                 |   4 +-
 fs/buffer.c                                        |  19 +-
 fs/cifs/smb2pdu.h                                  |   4 +-
 fs/drop_caches.c                                   |   8 +-
 fs/exec.c                                          |   2 +-
 fs/gfs2/glock.c                                    |   2 +-
 fs/hugetlbfs/inode.c                               |  12 +
 fs/nfs/super.c                                     |   5 +
 include/drm/drm_cache.h                            |  18 +
 include/linux/cpufreq.h                            |  12 +-
 include/linux/irqchip/arm-gic-v3.h                 |   2 +-
 include/linux/stmmac.h                             |   1 +
 include/net/bluetooth/bluetooth.h                  |   2 +-
 include/net/icmp.h                                 |   9 +-
 include/net/ip.h                                   |   2 +
 kernel/bpf/hashtab.c                               |   4 +-
 kernel/bpf/percpu_freelist.c                       |  41 +-
 kernel/bpf/percpu_freelist.h                       |   4 +
 kernel/events/core.c                               |  14 +-
 kernel/relay.c                                     |   4 +-
 lib/test_kmod.c                                    |   2 +-
 mm/hugetlb.c                                       |  16 +-
 mm/memory_hotplug.c                                |   6 +-
 mm/migrate.c                                       |  11 +
 net/bluetooth/af_bluetooth.c                       |  16 +-
 net/bluetooth/l2cap_sock.c                         |   2 +-
 net/bluetooth/rfcomm/sock.c                        |   2 +-
 net/bluetooth/sco.c                                |   2 +-
 net/bridge/netfilter/ebtables.c                    |   9 +-
 net/core/filter.c                                  |   2 +
 net/core/net-sysfs.c                               |   3 +
 net/ipv4/cipso_ipv4.c                              |  20 +-
 net/ipv4/fib_frontend.c                            |   4 +
 net/ipv4/icmp.c                                    |   7 +-
 net/ipv4/ip_options.c                              |  22 +-
 net/ipv4/ip_vti.c                                  |  50 ++
 net/ipv6/ip6mr.c                                   |   8 +-
 net/ipv6/route.c                                   |   4 +
 net/ipv6/sit.c                                     |   1 +
 net/mpls/af_mpls.c                                 |   3 +
 net/netfilter/ipvs/ip_vs_ctl.c                     |  12 +
 net/netfilter/nf_conntrack_core.c                  |  16 +
 net/netlabel/netlabel_kapi.c                       |   3 +-
 net/nfc/llcp_commands.c                            |  20 +
 net/nfc/llcp_core.c                                |  24 +-
 net/sched/sch_netem.c                              |  10 +-
 net/socket.c                                       |   1 +
 net/tipc/socket.c                                  |   2 +-
 net/vmw_vsock/virtio_transport.c                   |  29 +-
 security/apparmor/domain.c                         |   5 +-
 tools/perf/builtin-trace.c                         |  25 +-
 tools/perf/util/cpumap.c                           |  11 +-
 tools/perf/util/symbol-elf.c                       |   9 +-
 tools/testing/selftests/bpf/bpf_util.h             |  30 +-
 .../selftests/cpu-hotplug/cpu-on-off-test.sh       |  13 +-
 tools/testing/selftests/netfilter/Makefile         |   2 +-
 tools/testing/selftests/netfilter/config           |   2 +-
 tools/testing/selftests/netfilter/nft_nat.sh       | 762 +++++++++++++++++++++
 tools/testing/selftests/timers/Makefile            |   2 +-
 156 files changed, 1893 insertions(+), 375 deletions(-)


