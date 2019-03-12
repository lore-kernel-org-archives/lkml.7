Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EABBC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D3F217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552410888;
	bh=DWkoY3ZCxT99tKqokQ+wZUPHDtsWteUoANLBhZnRVEU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=wQ6CiDWkjdtZ2dAu9117Epgh3zT++q9QCAUyKhhTR+Dl/1wOdzv/UaY1+mMhJ97Nq
	 KWhj5mdThBDuC12ZWzDHUD1WhlihruawtQNp91rNdC00XqpeVuTYFqfEgz9d/ifdGp
	 EI9gFw3tBmzEf/Aklzgw7Uole7vbQ5N2Tcj8DlLE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbfCLROq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:14:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728125AbfCLRNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:55 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 707E621741;
        Tue, 12 Mar 2019 17:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410831;
        bh=DWkoY3ZCxT99tKqokQ+wZUPHDtsWteUoANLBhZnRVEU=;
        h=From:To:Cc:Subject:Date:From;
        b=L23lBxt7gBcWG58L8E2psxgPz7ttcsETC9StKci39s7fvWE3z/bLrj9stYDek/4JH
         wm4/j/OIcTMT2+ziBBMLuzZnFTdD2F7mltY01J52Q+vxVWztQlB6ozOynF0BsdEQt5
         47P4cn93cCC0o0/AV3j/xbXd4K/6+nNDe/6xeAmY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.19 000/149] 4.19.29-stable review
Date:   Tue, 12 Mar 2019 10:06:58 -0700
Message-Id: <20190312170349.421581206@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.29-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.29-rc1
X-KernelTest-Deadline: 2019-03-14T17:04+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.19.29 release.
There are 149 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Mar 14 17:02:30 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.29-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.29-rc1

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

Ronnie Sahlberg <lsahlber@redhat.com>
    cifs: allow calling SMB2_xxx_free(NULL)

Gao Xiang <gaoxiang25@huawei.com>
    staging: erofs: keep corrupted fs from crashing kernel in erofs_namei()

Gao Xiang <gaoxiang25@huawei.com>
    staging: erofs: fix race of initializing xattrs of a inode at the same time

Gao Xiang <gaoxiang25@huawei.com>
    staging: erofs: fix memleak of inode's shared xattr array

Gao Xiang <gaoxiang25@huawei.com>
    staging: erofs: fix fast symlink w/o xattr when fs xattr is on

Gao Xiang <gaoxiang25@huawei.com>
    staging: erofs: add error handling for xattr submodule

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Fix missed wakeups in find_insert_glock

Taehee Yoo <ap420073@gmail.com>
    netfilter: xt_TEE: add missing code to get interface index in checkentry.

Taehee Yoo <ap420073@gmail.com>
    netfilter: xt_TEE: fix wrong interface selection

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    drm: disable uncached DMA optimization for ARM and arm64

Marek Szyprowski <m.szyprowski@samsung.com>
    ARM: dts: exynos: Fix max voltage for buck8 regulator on Odroid XU3/XU4

Marek Szyprowski <m.szyprowski@samsung.com>
    ARM: dts: exynos: Add minimal clkout parameters to Exynos3250 PMU

Marek Szyprowski <m.szyprowski@samsung.com>
    ARM: dts: exynos: Fix pinctrl definition for eMMC RTSN line on Odroid X2/U3

Alistair Strachan <astrachan@google.com>
    arm64: dts: hikey: Revert "Enable HS200 mode on eMMC"

Jan Kiszka <jan.kiszka@siemens.com>
    arm64: dts: hikey: Give wifi some time after power-on

Jan Kiszka <jan.kiszka@siemens.com>
    arm64: dts: zcu100-revC: Give wifi some time after power-on

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    x86/PCI: Fixup RTIT_BAR of Intel Denverton Trace Hub

Gustavo A. R. Silva <gustavo@embeddedor.com>
    scsi: aacraid: Fix missing break in switch statement

Gustavo A. R. Silva <gustavo@embeddedor.com>
    iscsi_ibft: Fix missing break in switch statement

Vincent Batts <vbatts@hashbangbash.com>
    Input: elan_i2c - add id for touchpad found in Lenovo s21e-20

Jason Gerecke <jason.gerecke@wacom.com>
    Input: wacom_serial4 - add support for Wacom ArtPad II tablet

Keith Busch <keith.busch@intel.com>
    nvme-pci: add missing unlock for reset error

Liu Bo <bo.liu@linux.alibaba.com>
    blk-iolatency: fix IO hang due to negative inflight counter

Sudarsana Reddy Kalluru <skalluru@marvell.com>
    qede: Fix system crash on configuring channels.

Sudarsana Reddy Kalluru <skalluru@marvell.com>
    qed: Consider TX tcs while deriving the max num_queues for PF.

Manish Chopra <manishc@marvell.com>
    qed: Fix EQ full firmware assert.

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    fs: ratelimit __find_get_block_slow() failure message.

Keith Busch <keith.busch@intel.com>
    nvme-pci: fix rapid add remove sequence

Keith Busch <keith.busch@intel.com>
    nvme: lock NS list changes while handling command effects

Philip Yang <Philip.Yang@amd.com>
    drm/amdgpu: use spin_lock_irqsave to protect vm_manager.pasid_idr

Tony Lindgren <tony@atomide.com>
    i2c: omap: Use noirq system sleep pm ops to idle device for suspend

Ross Lagerwall <ross.lagerwall@citrix.com>
    Revert "scsi: libfc: Add WARN_ON() when deleting rports"

Jun-Ru Chang <jrjang@realtek.com>
    MIPS: Remove function size check in get_frame_info()

Huacai Chen <chenhc@lemote.com>
    MIPS: Loongson: Introduce and use loongson_llsc_mb()

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf trace: Support multiple "vfs_getname" probes

Jiri Olsa <jolsa@redhat.com>
    perf symbols: Filter out hidden symbols from labels

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qeth: cancel close_dev work before removing a card

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qeth: fix use-after-free in error path

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qeth: release cmd buffer in error paths

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

Martin KaFai Lau <kafai@fb.com>
    bpf: Fix syscall's stackmap lookup potential deadlock

Alexei Starovoitov <ast@kernel.org>
    bpf: fix potential deadlock in bpf_prog_register

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

Chris Wilson <chris@chris-wilson.co.uk>
    drm/amdgpu: Transfer fences to dmabuf importer

Alex Deucher <alexander.deucher@amd.com>
    drm/radeon: check if device is root before getting pci speed caps

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: Add missing power attribute to APU check

Lubomir Rintel <lkundrak@v3.sk>
    irqchip/mmp: Only touch the PJ4 IRQ & FIQ bits on enable/disable

Marc Zyngier <marc.zyngier@arm.com>
    irqchip/gic-v3-its: Gracefully fail on LPI exhaustion

Heyi Guo <guoheyi@huawei.com>
    irqchip/gic-v4: Fix occasional VLPI drop

Anders Roxell <anders.roxell@linaro.org>
    usb: phy: fix link errors

Zhou Yanjie <zhouyanjie@cduestc.edu.cn>
    DTS: CI20: Fix bugs in ci20's device tree.

Felix Fietkau <nbd@nbd.name>
    batman-adv: release station info tidstats

Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
    arm64: dts: add msm8996 compatible to gicv3

Peng Hao <peng.hao2@zte.com.cn>
    ARM: pxa: ssp: unneeded to free devm_ allocated data

Yafang Shao <laoar.shao@gmail.com>
    bpf: sock recvbuff must be limited by rmem_max in bpf_setsockopt()

Paolo Abeni <pabeni@redhat.com>
    bpftool: fix percpu maps updating

Jiri Olsa <jolsa@kernel.org>
    bpftool: Fix prog dump by tag

Ulf Hansson <ulf.hansson@linaro.org>
    wlcore: sdio: Fixup power on/off sequence

Jason Kridner <jkridner@gmail.com>
    pinctrl: mcp23s08: spi: Fix regmap allocation for mcp23s18

Madalin Bucur <madalin.bucur@nxp.com>
    soc: fsl: qbman: avoid race in clearing QMan interrupt

Geert Uytterhoeven <geert+renesas@glider.be>
    arm64: dts: renesas: r8a77965: Enable DMA for SCIF2

Geert Uytterhoeven <geert+renesas@glider.be>
    arm64: dts: renesas: r8a7796: Enable DMA for SCIF2

Anson Huang <anson.huang@nxp.com>
    ARM: dts: imx6sx: correct backward compatible of gpt

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    ARM: dts: meson8m2: mxiii-plus: mark the SD card detection GPIO active-low

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    ARM: dts: meson8b: odroidc1: mark the SD card detection GPIO active-low

Carlo Caione <ccaione@baylibre.com>
    arm: dts: meson: Fix IRQ trigger type for macirq

Jernej Skrabec <jernej.skrabec@siol.net>
    ARM: dts: sun8i: h3: Add ethernet0 alias to Beelink X2

Tony Lindgren <tony@atomide.com>
    ARM: dts: omap4-droid4: Fix typo in cpcap IRQ flags

Aaro Koskinen <aaro.koskinen@iki.fi>
    ARM: OMAP: dts: N950/N9: fix onenand timings

Michal Hocko <mhocko@suse.com>
    mm, memory_hotplug: fix off-by-one in is_pageblock_removable

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

Alexey Dobriyan <adobriyan@gmail.com>
    proc: fix /proc/net/* after setns(2)

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

Wei Huang <wei@redhat.com>
    x86/boot/compressed/64: Set EFER.LME=1 in 32-bit trampoline before returning to long mode

Harini Katakam <harini.katakam@xilinx.com>
    net: macb: Apply RXUBR workaround only to versions with errata

Sinan Kaya <okaya@kernel.org>
    platform/x86: Fix unmet dependency warning for SAMSUNG_Q10

Sinan Kaya <okaya@kernel.org>
    platform/x86: Fix unmet dependency warning for ACPI_CMPC

Dan Carpenter <dan.carpenter@oracle.com>
    scsi: 53c700: pass correct "dev" to dma_alloc_attrs()

Dan Carpenter <dan.carpenter@oracle.com>
    scsi: bnx2fc: Fix error handling in probe()

Douglas Gilbert <dgilbert@interlog.com>
    scsi: scsi_debug: fix write_same with virtual_gb problem

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

Fathi Boudra <fathi.boudra@linaro.org>
    selftests: net: use LDLIBS instead of LDFLAGS

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

Christoph Hellwig <hch@lst.de>
    iomap: fix a use after free in iomap_dio_rw

Piotr Jaroszynski <pjaroszynski@nvidia.com>
    iomap: get/put the page in iomap_page_create/release()

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: SMP: mark each possible CPU as present

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: smp_lx200_defconfig: fix vectors clash

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: SMP: fix secondary CPU initialization

Colin Ian King <colin.king@canonical.com>
    selftests: cpu-hotplug: fix case where CPUs offline > CPUs present

Feras Daoud <ferasda@mellanox.com>
    IB/ipoib: Fix for use-after-free in ipoib_cm_tx_start

Alexandre Ghiti <aghiti@upmem.com>
    riscv: Adjust mmap base address at a third of task size

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: SMP: fix ccount_timer_shutdown

Taniya Das <tdas@codeaurora.org>
    clk: qcom: gcc: Use active only source for CPUSS clocks

Dan Carpenter <dan.carpenter@oracle.com>
    clk: ti: Fix error handling in ti_clk_parse_divider_data()

Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
    iommu/amd: Fix IOMMU page flush when detach device from a domain

ZhangXiaoxu <zhangxiaoxu5@huawei.com>
    ipvs: Fix signed integer overflow when setsockopt timeout

Guo Ren <ren_guo@c-sky.com>
    riscv: fixup max_low_pfn with PFN_DOWN.

Jerry Snitselaar <jsnitsel@redhat.com>
    iommu/amd: Unmap all mapped pages in error path of map_sg

Jerry Snitselaar <jsnitsel@redhat.com>
    iommu/amd: Call free_iova_fast with pfn in map_sg

Brian Welty <brian.welty@intel.com>
    IB/{hfi1, qib}: Fix WC.byte_len calculation for UD_SEND_WITH_IMM

Tony Jones <tonyj@suse.de>
    perf script: Fix crash when processing recorded stat data

Stephane Eranian <eranian@google.com>
    perf tools: Handle TOPOLOGY headers with no CPU

Stephane Eranian <eranian@google.com>
    perf core: Fix perf_proc_update_handler() bug

Andi Kleen <ak@linux.intel.com>
    perf script: Fix crash with printing mixed trace point and other events

Su Yanjun <suyj.fnst@cn.fujitsu.com>
    vti4: Fix a ipip packet processing bug in 'IPCOMP' virtual tunnel

Alistair Strachan <astrachan@google.com>
    media: uvcvideo: Fix 'type' check leading to overflow


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/boot/dts/exynos3250.dtsi                  |   3 +
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  13 +-
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |   2 +-
 arch/arm/boot/dts/imx6sx.dtsi                      |   2 +-
 arch/arm/boot/dts/meson.dtsi                       |   2 +-
 arch/arm/boot/dts/meson8b-odroidc1.dts             |   4 +-
 arch/arm/boot/dts/meson8m2-mxiii-plus.dts          |   3 +-
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi     |   2 +-
 arch/arm/boot/dts/omap3-n950-n9.dtsi               |  42 +-
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts          |   2 +-
 arch/arm/plat-pxa/ssp.c                            |   3 -
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     |   2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   2 +-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           |   3 +
 arch/arm64/boot/dts/renesas/r8a77965.dtsi          |   3 +
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts  |   1 +
 arch/arm64/kernel/probes/kprobes.c                 |   6 +-
 arch/mips/Kconfig                                  |  15 +
 arch/mips/boot/dts/ingenic/ci20.dts                |   8 +-
 arch/mips/include/asm/atomic.h                     |   6 +
 arch/mips/include/asm/barrier.h                    |  36 +
 arch/mips/include/asm/bitops.h                     |   5 +
 arch/mips/include/asm/futex.h                      |   3 +
 arch/mips/include/asm/pgtable.h                    |   2 +
 arch/mips/kernel/process.c                         |   7 +-
 arch/mips/loongson64/Platform                      |  23 +
 arch/mips/mm/tlbex.c                               |  10 +
 arch/riscv/include/asm/processor.h                 |   2 +-
 arch/riscv/kernel/setup.c                          |   2 +-
 arch/riscv/mm/init.c                               |   3 +-
 arch/x86/boot/compressed/head_64.S                 |   8 +
 arch/x86/boot/compressed/pgtable.h                 |   2 +-
 arch/x86/events/core.c                             |  13 +-
 arch/x86/events/intel/core.c                       | 154 ++++-
 arch/x86/events/perf_event.h                       |  17 +-
 arch/x86/include/asm/cpufeatures.h                 |   1 +
 arch/x86/include/asm/msr-index.h                   |   6 +
 arch/x86/include/asm/page_64_types.h               |   4 +
 arch/x86/kernel/cpu/microcode/amd.c                |   2 +-
 arch/x86/kernel/kexec-bzimage64.c                  |   3 +
 arch/x86/pci/fixup.c                               |  16 +
 arch/xtensa/configs/smp_lx200_defconfig            |   1 +
 arch/xtensa/kernel/head.S                          |   5 +-
 arch/xtensa/kernel/smp.c                           |  41 +-
 arch/xtensa/kernel/time.c                          |   2 +-
 block/blk-iolatency.c                              |  52 +-
 drivers/base/dd.c                                  |   2 +-
 drivers/clk/qcom/gcc-sdm845.c                      |  14 +-
 drivers/clk/ti/divider.c                           |  11 +-
 drivers/dma/at_xdmac.c                             |  19 +-
 drivers/dma/dmatest.c                              |  28 +-
 drivers/firmware/iscsi_ibft.c                      |   1 +
 drivers/gpio/gpio-vf610.c                          |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c          |  59 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |   5 +-
 drivers/gpu/drm/radeon/ci_dpm.c                    |   5 +-
 drivers/gpu/drm/radeon/si_dpm.c                    |   5 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |   2 +
 drivers/i2c/busses/i2c-omap.c                      |  13 +-
 drivers/infiniband/hw/hfi1/ud.c                    |   1 -
 drivers/infiniband/hw/qib/qib_ud.c                 |   1 -
 drivers/infiniband/ulp/ipoib/ipoib.h               |   1 -
 drivers/infiniband/ulp/ipoib/ipoib_cm.c            |   3 +-
 drivers/input/mouse/elan_i2c_core.c                |   1 +
 drivers/input/tablet/wacom_serial4.c               |   2 +
 drivers/iommu/amd_iommu.c                          |  19 +-
 drivers/irqchip/irq-gic-v3-its.c                   |  69 +-
 drivers/irqchip/irq-mmp.c                          |   6 +-
 drivers/media/usb/uvc/uvc_driver.c                 |  14 +-
 drivers/net/ethernet/altera/altera_msgdma.c        |   3 +-
 drivers/net/ethernet/cadence/macb.h                |   3 +
 drivers/net/ethernet/cadence/macb_main.c           |  28 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      |   5 +
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   |  16 +-
 drivers/net/ethernet/hisilicon/hns_mdio.c          |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_dev.c          |   8 +-
 drivers/net/ethernet/qlogic/qed/qed_l2.c           |  17 +-
 drivers/net/ethernet/qlogic/qed/qed_l2.h           |   3 +
 drivers/net/ethernet/qlogic/qed/qed_ll2.c          |  20 +-
 drivers/net/ethernet/qlogic/qed/qed_sp.h           |   1 +
 drivers/net/ethernet/qlogic/qed/qed_spq.c          |  15 +-
 drivers/net/ethernet/qlogic/qed/qed_sriov.c        |  10 +-
 drivers/net/ethernet/qlogic/qed/qed_vf.c           |  10 +
 drivers/net/ethernet/qlogic/qede/qede.h            |   3 +
 drivers/net/ethernet/qlogic/qede/qede_fp.c         |  13 +
 drivers/net/ethernet/qlogic/qede/qede_main.c       |   3 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |   4 +-
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |  14 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  17 +-
 drivers/net/wireless/ath/ath9k/init.c              |   6 +-
 drivers/net/wireless/ti/wlcore/sdio.c              |  15 +-
 drivers/nvme/host/core.c                           |   8 +-
 drivers/nvme/host/nvme.h                           |   1 +
 drivers/nvme/host/pci.c                            |  30 +-
 drivers/pinctrl/pinctrl-mcp23s08.c                 |   7 +-
 drivers/platform/x86/Kconfig                       |   2 +
 drivers/s390/net/qeth_core.h                       |   1 +
 drivers/s390/net/qeth_core_main.c                  |  21 +-
 drivers/s390/net/qeth_l2_main.c                    |   2 +
 drivers/s390/net/qeth_l3_main.c                    |   1 +
 drivers/scsi/53c700.c                              |   2 +-
 drivers/scsi/aacraid/commsup.c                     |   5 +-
 drivers/scsi/bnx2fc/bnx2fc_io.c                    |   4 +-
 drivers/scsi/libfc/fc_lport.c                      |   6 +-
 drivers/scsi/libfc/fc_rport.c                      |   1 -
 drivers/scsi/scsi_debug.c                          |  41 +-
 drivers/soc/fsl/qbman/qman.c                       |   9 +-
 drivers/staging/erofs/inode.c                      |   8 +-
 drivers/staging/erofs/internal.h                   |  16 +-
 drivers/staging/erofs/namei.c                      | 189 ++---
 drivers/staging/erofs/xattr.c                      | 165 +++--
 drivers/usb/phy/Kconfig                            |   2 +-
 fs/autofs/expire.c                                 |   3 +-
 fs/autofs/inode.c                                  |   4 +-
 fs/buffer.c                                        |  19 +-
 fs/cifs/smb2pdu.c                                  |  16 +-
 fs/cifs/smb2pdu.h                                  |   4 +-
 fs/drop_caches.c                                   |   8 +-
 fs/gfs2/glock.c                                    |   2 +-
 fs/iomap.c                                         |  37 +-
 fs/nfs/super.c                                     |   5 +
 fs/proc/generic.c                                  |   4 +-
 fs/proc/internal.h                                 |   1 +
 fs/proc/proc_net.c                                 |  20 +
 include/drm/drm_cache.h                            |  18 +
 include/linux/irqchip/arm-gic-v3.h                 |   2 +-
 include/linux/stmmac.h                             |   1 +
 kernel/bpf/hashtab.c                               |   4 +-
 kernel/bpf/percpu_freelist.c                       |  41 +-
 kernel/bpf/percpu_freelist.h                       |   4 +
 kernel/bpf/syscall.c                               |  12 +-
 kernel/events/core.c                               |  14 +-
 kernel/relay.c                                     |   4 +-
 kernel/trace/bpf_trace.c                           |  14 +-
 lib/test_kmod.c                                    |   2 +-
 mm/memory_hotplug.c                                |  29 +-
 net/batman-adv/bat_v_elp.c                         |   3 +
 net/bridge/netfilter/ebtables.c                    |   9 +-
 net/core/filter.c                                  |   2 +
 net/ipv4/ip_vti.c                                  |  50 ++
 net/netfilter/ipvs/ip_vs_ctl.c                     |  12 +
 net/netfilter/nf_conntrack_core.c                  |  16 +
 net/netfilter/xt_TEE.c                             |  76 +-
 net/vmw_vsock/virtio_transport.c                   |  29 +-
 security/apparmor/domain.c                         |   5 +-
 tools/bpf/bpftool/map.c                            |  16 +
 tools/bpf/bpftool/prog.c                           |   5 +-
 tools/perf/builtin-script.c                        |   9 +-
 tools/perf/builtin-trace.c                         |  25 +-
 tools/perf/util/cpumap.c                           |  11 +-
 tools/perf/util/symbol-elf.c                       |   9 +-
 tools/testing/selftests/bpf/bpf_util.h             |  30 +-
 .../selftests/cpu-hotplug/cpu-on-off-test.sh       |  13 +-
 tools/testing/selftests/net/Makefile               |   2 +-
 tools/testing/selftests/netfilter/Makefile         |   2 +-
 tools/testing/selftests/netfilter/config           |   2 +-
 tools/testing/selftests/netfilter/nft_nat.sh       | 762 +++++++++++++++++++++
 tools/testing/selftests/proc/.gitignore            |   1 +
 tools/testing/selftests/proc/Makefile              |   1 +
 tools/testing/selftests/proc/setns-dcache.c        | 129 ++++
 tools/testing/selftests/timers/Makefile            |   2 +-
 163 files changed, 2451 insertions(+), 612 deletions(-)


