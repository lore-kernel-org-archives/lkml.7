Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448AFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA963213F2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553259802;
	bh=qJ1N60v+tfRmtG9zKJ860ESwMXnUZJ1YDB/KBZPp4YE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=nkexh2HEtXAkzAnpDyonrERyQELqwXbu6BVFtbE/80LJDxgopB6/Spq4+rn29jXVJ
	 TrxzzAkb6aAUWxglpfBRwV3QJBJtWUl9KqgHzNc6CnJIgYnV0jCv0PdlxaYpNVFASQ
	 ZLruSVco9WtwpWVYRmIqeVdYoqZhmjhqUc5oNMtg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbfCVLko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:40:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731277AbfCVLki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:40:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1926021916;
        Fri, 22 Mar 2019 11:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254836;
        bh=qJ1N60v+tfRmtG9zKJ860ESwMXnUZJ1YDB/KBZPp4YE=;
        h=From:To:Cc:Subject:Date:From;
        b=MfrhOhx/ytRe9JxzjD300MWbNsbcljbohWdH1JIdz+lrXMX6kk5D9YzrpPXIvcEFf
         wVbslVF1TKCaB5uprRalEQrdbzOeMoBSLQZfpJtgxL4apogwVGuWW/zJ/ryBqUOH++
         X23zJPu1CamzI7ulJDRIMVdQ9kiPfVBxzvT6zW/s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 000/118] 4.9.165-stable review
Date:   Fri, 22 Mar 2019 12:14:32 +0100
Message-Id: <20190322111215.873964544@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.165-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.165-rc1
X-KernelTest-Deadline: 2019-03-24T11:12+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.165 release.
There are 118 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Mar 24 11:11:02 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.165-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.165-rc1

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

Aditya Pakki <pakki001@umn.edu>
    md: Fix failed allocation of md_register_thread

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix divide by zero when TSC is not available

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix overlap calculation for padding

Adrian Hunter <adrian.hunter@intel.com>
    perf auxtrace: Define auxtrace record alignment

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix CYC timestamp calculation after OVF

Daniel Axtens <dja@axtens.net>
    bcache: never writeback a discard operation

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

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFS: Fix I/O request leakages

NeilBrown <neil@brown.name>
    dm: fix to_sector() for 32bit

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ARM: s3c24xx: Fix boolean expressions in osiris_dvs_notify

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/ptrace: Simplify vr_get/set() to avoid GCC warning

Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
    powerpc: Fix 32-bit KVM-PR lockup and host crash with MacOS guest

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

Angelo Butti <buttiangelo@gmail.com>
    8250: FIX Fourth port offset of Pericom PI7C9X7954 boards

Lubomir Rintel <lkundrak@v3.sk>
    serial: 8250_of: assume reg-shift of 2 for mrvl,mmp-uart

Anssi Hannula <anssi.hannula@bitwise.fi>
    serial: uartps: Fix stuck ISR if RX disabled with non-empty FIFO

Tvrtko Ursulin <tvrtko.ursulin@intel.com>
    drm/i915: Relax mmap VMA check

Sowjanya Komatineni <skomatineni@nvidia.com>
    i2c: tegra: fix maximum transfer size

QiaoChong <qiaochong@loongson.cn>
    parport_pc: fix find_superio io compare code, should use equal test.

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    intel_th: Don't reference unassigned outputs

Heikki Krogerus <heikki.krogerus@linux.intel.com>
    device property: Fix the length used in PROPERTY_ENTRY_STRING()

Zev Weiss <zev@bewilderbeest.net>
    kernel/sysctl.c: add missing range check in do_proc_dointvec_minmax_conv

Roman Penyaev <rpenyaev@suse.de>
    mm/vmalloc: fix size check for remap_vmalloc_range_partial()

zhongjiang <zhongjiang@huawei.com>
    mm: hwpoison: fix thp split handing in soft_offline_in_use_page()

Dexuan Cui <decui@microsoft.com>
    nfit: acpi_nfit_ctl(): Check out_obj->type in the right place

Paul Cercueil <paul@crapouillou.net>
    clk: ingenic: Fix doc of ingenic_cgu_div_info

Paul Cercueil <paul@crapouillou.net>
    clk: ingenic: Fix round_rate misbehaving with non-integer dividers

Tony Lindgren <tony@atomide.com>
    clk: clk-twl6040: Fix imprecise external abort for pdmclk

Jan Kara <jack@suse.cz>
    ext2: Fix underflow in ext2_max_size()

Jan Kara <jack@suse.cz>
    ext4: fix crash during online resizing

Arnd Bergmann <arnd@arndb.de>
    cpufreq: pxa2xx: remove incorrect __init annotation

Yangtao Li <tiny.windzz@gmail.com>
    cpufreq: tegra124: add missing of_node_put()

Lubomir Rintel <lkundrak@v3.sk>
    libertas_tf: don't set URB_ZERO_PACKET on IN USB transfer

Eric Biggers <ebiggers@google.com>
    crypto: pcbc - remove bogus memcpy()s with src == dest

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix corruption reading shared and compressed extents after hole punching

Johannes Thumshirn <jthumshirn@suse.de>
    btrfs: ensure that a DUP or RAID1 block group has exactly two stripes

Finn Thain <fthain@telegraphics.com.au>
    m68k: Add -ffreestanding to CFLAGS

Jann Horn <jannh@google.com>
    splice: don't merge into linked buffers

Varad Gautam <vrd@amazon.de>
    fs/devpts: always delete dcache dentry-s in dput()

Bart Van Assche <bvanassche@acm.org>
    scsi: target/iscsi: Avoid iscsit_release_commands_from_conn() deadlock

Martin K. Petersen <martin.petersen@oracle.com>
    scsi: sd: Optimal I/O size should be a multiple of physical block size

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
    spi: pxa2xx: Setup maximum supported DMA transfer length

Vignesh R <vigneshr@ti.com>
    spi: ti-qspi: Fix mmap read when more than one CS in use

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    ACPI / device_sysfs: Avoid OF modalias creation for removed device

zhangyi (F) <yi.zhang@huawei.com>
    tracing: Do not free iter->trace in fail path of tracing_open_pipe()

Tom Zanussi <tom.zanussi@linux.intel.com>
    tracing: Use strncpy instead of memcpy for string keys in hist triggers

Pavel Shilovsky <piastryyy@gmail.com>
    CIFS: Fix read after write for files with read caching

Pavel Shilovsky <piastryyy@gmail.com>
    CIFS: Do not reset lease state to NONE on lease break

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    crypto: arm64/aes-ccm - fix logical bug in AAD MAC handling

Eric Biggers <ebiggers@google.com>
    crypto: hash - set CRYPTO_TFM_NEED_KEY if ->setkey() fails

Oliver O'Halloran <oohall@gmail.com>
    libnvdimm: Fix altmap reservation size calculation

Dan Williams <dan.j.williams@intel.com>
    libnvdimm/pmem: Honor force_raw for legacy pmem regions

Dan Williams <dan.j.williams@intel.com>
    libnvdimm/label: Clear 'updating' flag after label-set update

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    stm class: Prevent division by zero

Darrick J. Wong <darrick.wong@oracle.com>
    tmpfs: fix uninitialized return value in shmem_link

Mao Wenan <maowenan@huawei.com>
    net: set static variable an initial value in atl2_probe()

Jiong Wang <jiong.wang@netronome.com>
    nfp: bpf: fix ALU32 high bits clearance bug

Jiong Wang <jiong.wang@netronome.com>
    nfp: bpf: fix code-gen bug on BPF_ALU | BPF_XOR | BPF_K

Vadim Lomovtsev <vlomovtsev@marvell.com>
    net: thunderx: make CFG_DONE message to run through generic send-ack sequence

Li RongQing <lirongqing@baidu.com>
    mac80211_hwsim: propagate genlmsg_reply return code

Arnd Bergmann <arnd@arndb.de>
    phonet: fix building with clang

Vineet Gupta <vgupta@synopsys.com>
    ARC: uacces: remove lp_start, lp_end from clobber list

Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
    ARCv2: lib: memcpy: fix doing prefetchw outside of buffer

Darrick J. Wong <darrick.wong@oracle.com>
    tmpfs: fix link accounting when a tmpfile is linked in

Russell King <rmk+kernel@armlinux.org.uk>
    net: marvell: mvneta: fix DMA debug warning

Vladimir Murzin <vladimir.murzin@arm.com>
    arm64: Relax GIC version check during early boot

Bard liao <yung-chuan.liao@linux.intel.com>
    ASoC: topology: free created components in tplg load error

Alexey Khoroshilov <khoroshilov@ispras.ru>
    net: mv643xx_eth: disable clk on error path in mv643xx_eth_shared_probe()

Beniamino Galvani <bgalvani@redhat.com>
    qmi_wwan: apply SET_DTR quirk to Sierra WP7607

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

Andre Przywara <andre.przywara@arm.com>
    clk: sunxi: A31: Fix wrong AHB gate number

Gabriel Fernandez <gabriel.fernandez@st.com>
    Input: st-keyscan - fix potential zalloc NULL dereference

Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
    i2c: cadence: Fix the hold bit setting

Huang Zijiang <huang.zijiang@zte.com.cn>
    net: hns: Fix object reference leaks in hns_dsaf_roce_reset()

Jann Horn <jannh@google.com>
    mm: page_alloc: fix ref bias in page_frag_alloc() for 1-byte allocs

Yu Zhao <yuzhao@google.com>
    mm/gup: fix gup_pmd_range() for dax

Yufen Yu <yuyufen@huawei.com>
    floppy: check_events callback should not return a negative number

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: matrix_keypad - use flush_delayed_work()

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: cap11xx - switch to using set_brightness_blocking()

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

Krzysztof Kozlowski <krzk@kernel.org>
    iio: adc: exynos-adc: Fix NULL pointer exception on unbind

S.j. Wang <shengjiu.wang@nxp.com>
    ASoC: fsl_esai: fix register setting issue in RIGHT_J mode

zhengbin <zhengbin13@huawei.com>
    9p/net: fix memory leak in p9_client_create

Hou Tao <houtao1@huawei.com>
    9p: use inode->i_lock to protect i_size_write() under 32-bit

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: videobuf2-v4l2: drop WARN_ON in vb2_warn_zero_bytesused()


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arc/include/asm/uaccess.h                     |   8 +-
 arch/arc/lib/memcpy-archs.S                        |  14 --
 arch/arm/Kconfig                                   |   1 +
 arch/arm/include/asm/irq.h                         |   1 -
 arch/arm/kernel/irq.c                              |  62 --------
 arch/arm/kernel/smp.c                              |   2 +-
 arch/arm/mach-omap2/display.c                      |   7 +-
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c            |   8 +-
 arch/arm64/crypto/aes-ce-ccm-core.S                |   5 +-
 arch/arm64/kernel/head.S                           |   3 +-
 arch/m68k/Makefile                                 |   5 +-
 arch/powerpc/kernel/entry_32.S                     |   9 ++
 arch/powerpc/kernel/process.c                      |   2 +-
 arch/powerpc/kernel/ptrace.c                       |  10 +-
 arch/powerpc/platforms/83xx/suspend-asm.S          |  34 +++-
 arch/powerpc/platforms/embedded6xx/wii.c           |   4 +
 arch/powerpc/platforms/powernv/opal-msglog.c       |   2 +-
 arch/x86/kvm/vmx.c                                 |  17 +-
 arch/x86/kvm/x86.c                                 |   1 +
 crypto/ahash.c                                     |  42 +++--
 crypto/pcbc.c                                      |  14 +-
 crypto/shash.c                                     |  18 ++-
 drivers/acpi/device_sysfs.c                        |   6 +-
 drivers/acpi/nfit/core.c                           |  14 +-
 drivers/base/power/wakeup.c                        |   8 +-
 drivers/block/floppy.c                             |   2 +-
 drivers/clk/clk-twl6040.c                          |  53 ++++++-
 drivers/clk/ingenic/cgu.c                          |  10 +-
 drivers/clk/ingenic/cgu.h                          |   2 +-
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c               |   4 +-
 drivers/clocksource/exynos_mct.c                   |  23 +--
 drivers/cpufreq/pxa2xx-cpufreq.c                   |   4 +-
 drivers/cpufreq/tegra124-cpufreq.c                 |   2 +
 drivers/crypto/caam/caamalg.c                      |   1 +
 drivers/gpu/drm/i915/i915_gem.c                    |   3 +-
 drivers/gpu/drm/radeon/evergreen_cs.c              |   1 +
 drivers/gpu/ipu-v3/ipu-common.c                    |   8 +-
 drivers/hwtracing/intel_th/gth.c                   |   4 +
 drivers/hwtracing/stm/core.c                       |  11 +-
 drivers/i2c/busses/i2c-cadence.c                   |   9 +-
 drivers/i2c/busses/i2c-tegra.c                     |   2 +-
 drivers/iio/adc/exynos_adc.c                       |   2 +-
 drivers/input/keyboard/cap11xx.c                   |  35 ++---
 drivers/input/keyboard/matrix_keypad.c             |   2 +-
 drivers/input/keyboard/st-keyscan.c                |   4 +-
 drivers/md/bcache/writeback.h                      |   3 +
 drivers/md/raid10.c                                |   2 +
 drivers/md/raid5.c                                 |   2 +
 drivers/media/usb/uvc/uvc_video.c                  |   8 +
 drivers/media/v4l2-core/videobuf2-v4l2.c           |   1 -
 drivers/net/ethernet/atheros/atlx/atl2.c           |   4 +-
 drivers/net/ethernet/broadcom/bcmsysport.c         |   4 +
 drivers/net/ethernet/cavium/thunder/nic_main.c     |   2 +-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   |  15 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c |   2 +
 drivers/net/ethernet/marvell/mv643xx_eth.c         |   7 +-
 drivers/net/ethernet/marvell/mvneta.c              |   2 +-
 drivers/net/ethernet/netronome/nfp/nfp_bpf_jit.c   |  17 +-
 drivers/net/usb/qmi_wwan.c                         |   4 +-
 drivers/net/wireless/mac80211_hwsim.c              |   2 +-
 drivers/net/wireless/marvell/libertas_tf/if_usb.c  |   2 -
 drivers/nvdimm/label.c                             |  23 ++-
 drivers/nvdimm/namespace_devs.c                    |   4 +
 drivers/nvdimm/pfn_devs.c                          |   2 +-
 drivers/parport/parport_pc.c                       |   2 +-
 drivers/pinctrl/meson/pinctrl-meson8b.c            |   2 +-
 drivers/regulator/s2mpa01.c                        |  10 +-
 drivers/regulator/s2mps11.c                        |   6 +-
 drivers/s390/block/dasd_eckd.c                     |   8 +
 drivers/s390/virtio/virtio_ccw.c                   |   4 +-
 drivers/scsi/libiscsi.c                            |   6 +
 drivers/scsi/sd.c                                  |  59 +++++--
 drivers/scsi/virtio_scsi.c                         |   2 -
 drivers/spi/spi-pxa2xx.c                           |   1 +
 drivers/spi/spi-ti-qspi.c                          |   6 +-
 drivers/target/iscsi/iscsi_target.c                |   4 +-
 drivers/tty/serial/8250/8250_of.c                  |   4 +
 drivers/tty/serial/8250/8250_pci.c                 | 175 ++++++++++++++++++---
 drivers/tty/serial/xilinx_uartps.c                 |   8 +-
 fs/9p/v9fs_vfs.h                                   |  23 ++-
 fs/9p/vfs_file.c                                   |   6 +-
 fs/9p/vfs_inode.c                                  |  23 ++-
 fs/9p/vfs_inode_dotl.c                             |  27 ++--
 fs/9p/vfs_super.c                                  |   4 +-
 fs/btrfs/extent_io.c                               |   4 +-
 fs/btrfs/volumes.c                                 |   4 +-
 fs/cifs/file.c                                     |  12 +-
 fs/cifs/smb2misc.c                                 |  17 +-
 fs/cifs/smb2ops.c                                  |  15 +-
 fs/devpts/inode.c                                  |   1 +
 fs/ext2/super.c                                    |  39 +++--
 fs/ext4/resize.c                                   |   3 +-
 fs/jbd2/transaction.c                              |  33 ++--
 fs/nfs/pagelist.c                                  |  29 +++-
 fs/nfsd/nfs3proc.c                                 |  16 +-
 fs/nfsd/nfs3xdr.c                                  |   1 +
 fs/nfsd/nfsctl.c                                   |   2 +-
 fs/pipe.c                                          |  14 ++
 fs/splice.c                                        |   4 +
 include/linux/device-mapper.h                      |   2 +-
 include/linux/pipe_fs_i.h                          |   1 +
 include/linux/property.h                           |   2 +-
 include/net/phonet/pep.h                           |   5 +-
 kernel/rcu/tree.c                                  |  20 ++-
 kernel/sysctl.c                                    |  11 +-
 kernel/trace/trace.c                               |   1 -
 kernel/trace/trace_events_hist.c                   |   5 +-
 lib/assoc_array.c                                  |   8 +-
 mm/gup.c                                           |   3 +-
 mm/memory-failure.c                                |  14 +-
 mm/page_alloc.c                                    |   8 +-
 mm/shmem.c                                         |  12 +-
 mm/vmalloc.c                                       |   2 +-
 net/9p/client.c                                    |   2 +-
 net/phonet/pep.c                                   |  32 ++--
 sound/soc/fsl/fsl_esai.c                           |   7 +-
 sound/soc/soc-topology.c                           |   8 +-
 tools/perf/util/auxtrace.c                         |   4 +-
 tools/perf/util/auxtrace.h                         |   3 +
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  37 ++++-
 tools/perf/util/intel-pt.c                         |   2 +
 122 files changed, 919 insertions(+), 433 deletions(-)


