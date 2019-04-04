Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6D8C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE992147C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554367814;
	bh=cDtFWU2ax9w6eRQenOVkeMrcNY79RMq8KztLjuP2Xx0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=oERCEDDZUF5iaid0GirWyBrdx2ZNTFI9n0C8rKfyQz4rLAwaJb+wjrstTEIJXQE4F
	 31GM+hdi+0BTvwTfNrWE4KtGiO5+siWCHhSmV3XKlK5YjXy0m6YLa4z7LIm3ldJZ4H
	 AA0kY9THQpW3ZbpU2c+FeiJw+griiI0Pguw/7g6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbfDDIuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:50:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728859AbfDDIuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:50:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12CC320882;
        Thu,  4 Apr 2019 08:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554367809;
        bh=cDtFWU2ax9w6eRQenOVkeMrcNY79RMq8KztLjuP2Xx0=;
        h=From:To:Cc:Subject:Date:From;
        b=UoaCxKYsSzF89hWcGP9SFErchdHDAG7Hvyty0wTBKFtmv17JaH/UjQsaFynxXrZkU
         g4QSfy3kSNnqlsx7sUGGKKGOR7jdVWyddYuZJRqib2fPJnAEACoNyXyOk5UTEx91ug
         ++k/qE8umUOJeYjaPW0tozyOZC9gymWqey1MS98c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/91] 4.9.168-stable review
Date:   Thu,  4 Apr 2019 10:46:44 +0200
Message-Id: <20190404084535.450029272@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.168-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.168-rc1
X-KernelTest-Deadline: 2019-04-06T08:45+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.168 release.
There are 91 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Apr  6 08:44:27 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.168-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.168-rc1

Hans de Goede <hdegoede@redhat.com>
    ACPI / video: Extend chassis-type detection with a "Lunch Box" check

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/dp/mst: Configure no_stop_bit correctly for remote i2c xfers

Ben Dooks <ben.dooks@codethink.co.uk>
    dmaengine: tegra: avoid overflow of byte tracking

Rafael Ávila de Espíndola <rafael@espindo.la>
    x86/build: Mark per-CPU symbols as absolute explicitly for LLD

Zumeng Chen <zumeng.chen@gmail.com>
    wlcore: Fix memory leak in case wl12xx_fetch_firmware failure

Ondrej Mosnacek <omosnace@redhat.com>
    selinux: do not override context on context mounts

George Rimar <grimar@accesssoftek.com>
    x86/build: Specify elf_i386 linker emulation explicitly for i386 objects

Daniel Vetter <daniel.vetter@ffwll.ch>
    drm/nouveau: Stop using drm_crtc_force_disable

Axel Lin <axel.lin@ingics.com>
    regulator: act8865: Fix act8600_sudcdc_voltage_ranges setting

Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
    media: s5p-jpeg: Check for fmt_ver_flag when doing fmt enumeration

Florian Westphal <fw@strlen.de>
    netfilter: physdev: relax br_netfilter dependency

Shunyong Yang <shunyong.yang@hxt-semitech.com>
    dmaengine: qcom_hidma: assign channel cookie correctly

Anders Roxell <anders.roxell@linaro.org>
    dmaengine: imx-dma: fix warning comparison of distinct pointer types

Buland Singh <bsingh@redhat.com>
    hpet: Fix missing '=' character in the __setup() code of hpet_mmap_enable

Song Hongyan <hongyan.song@intel.com>
    HID: intel-ish: ipc: handle PIMR before ish_wakeup also clear PISR busy_clear bit

Timo Alho <talho@nvidia.com>
    soc/tegra: fuse: Fix illegal free of IO base address

David Tolnay <dtolnay@gmail.com>
    hwrng: virtio - Avoid repeated init of completion

Akinobu Mita <akinobu.mita@gmail.com>
    media: mt9m111: set initial frame size other than 0x0

Nathan Fontenot <nfont@linux.vnet.ibm.com>
    powerpc/pseries: Perform full re-add of CPU for topology update post-migration

Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
    tty: increase the default flip buffer limit to 2*640K

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: avoid Cortex-A9 livelock on tight dmb loops

Stanislaw Gruszka <sgruszka@redhat.com>
    mt7601u: bump supported EEPROM version

Alexey Khoroshilov <khoroshilov@ispras.ru>
    soc: qcom: gsbi: Fix error handling in gsbi_probe()

Mathieu Malaterre <malat@debian.org>
    ARM: dts: lpc32xx: Remove leading 0x and 0s from bindings notation

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    efi/memattr: Don't bail on zero VA if it equals the region's PA

wen yang <yellowriver2010@hotmail.com>
    ASoC: fsl-asoc-card: fix object reference leaks in fsl_asoc_card_probe

Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
    e1000e: fix cyclic resets at link up with active tx

Guenter Roeck <linux@roeck-us.net>
    cdrom: Fix race condition in cdrom_sysctl_register

Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
    fbdev: fbmem: fix memory access if logo is bigger than the screen

Raju Rangoju <rajur@chelsio.com>
    iw_cxgb4: fix srqidx leak during connection abort

Thomas Gleixner <tglx@linutronix.de>
    genirq: Avoid summation loops for /proc/stat

Coly Li <colyli@suse.de>
    bcache: improve sysfs_strtoul_clamp()

Coly Li <colyli@suse.de>
    bcache: fix input overflow to sequential_cutoff

Coly Li <colyli@suse.de>
    bcache: fix input overflow to cache set sysfs file io_error_halflife

John Stultz <john.stultz@linaro.org>
    usb: f_fs: Avoid crash due to out-of-scope stack ptr access

Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
    ALSA: PCM: check if ops are defined before suspending PCM

Nathan Chancellor <natechancellor@gmail.com>
    ARM: 8833/1: Ensure that NEON code always compiles with Clang

Andrea Righi <righi.andrea@gmail.com>
    kprobes: Prohibit probing on bsearch()

Hans de Goede <hdegoede@redhat.com>
    ACPI / video: Refactor and fix dmi_is_desktop()

Sara Sharon <sara.sharon@intel.com>
    iwlwifi: pcie: fix emergency path

Michal Kazior <michal@plume.com>
    leds: lp55xx: fix null deref on firmware load failure

Hong Liu <hong.liu@intel.com>
    HID: intel-ish-hid: avoid binding wrong ishtp_cl_device

Aurelien Jarno <aurelien@aurel32.net>
    vfs: fix preadv64v2 and pwritev64v2 compat syscalls with offset == -1

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
    mlxsw: spectrum: Avoid -Wformat-truncation warnings

Florian Fainelli <f.fainelli@gmail.com>
    e1000e: Fix -Wformat-truncation warnings

Aaro Koskinen <aaro.koskinen@iki.fi>
    mmc: omap: fix the maximum timeout setting

Nicolas Boichat <drinkcat@chromium.org>
    iommu/io-pgtable-arm-v7s: Only kmemleak_ignore L2 tables

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    ARM: 8840/1: use a raw_spinlock_t in unwind

Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
    coresight: etm4x: Add support to enable ETMv4.2

Benjamin Block <bblock@linux.ibm.com>
    scsi: core: replace GFP_ATOMIC with GFP_KERNEL in scsi_scan.c

Paul Kocialkowski <paul.kocialkowski@bootlin.com>
    usb: chipidea: Grab the (legacy) USB PHY by phandle first

Julia Lawall <Julia.Lawall@lip6.fr>
    crypto: crypto4xx - add missing of_node_put after of_device_is_available

Alexei Avshalom Lazar <ailizaro@codeaurora.org>
    wil6210: check null pointer in _wil_cfg80211_merge_extra_ies

Tony Jones <tonyj@suse.de>
    tools lib traceevent: Fix buffer overflow in arg_eval

Carlos Maiolino <cmaiolino@redhat.com>
    fs: fix guard_bio_eod to check for real EOD errors

luojiajun <luojiajun3@huawei.com>
    jbd2: fix invalid descriptor block checksum

Slavomir Kaslev <kaslevs@vmware.com>
    fs: Make splice() and tee() take into account O_NONBLOCK flag on pipes

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

John Garry <john.garry@huawei.com>
    scsi: hisi_sas: Set PHY linkrate when disconnected

Arnd Bergmann <arnd@arndb.de>
    enic: fix build warning without CONFIG_CPUMASK_OFFSTACK

Christian Brauner <christian@brauner.io>
    sysctl: handle overflow for file-max

Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
    include/linux/relay.h: fix percpu annotation in struct rchan

Russell King <rmk+kernel@armlinux.org.uk>
    gpio: gpio-omap: fix level interrupt idling

Douglas Anderson <dianders@chromium.org>
    tracing: kdb: Fix ftdump to not sleep

Masahiro Yamada <yamada.masahiro@socionext.com>
    h8300: use cc-cross-prefix instead of hardcoding h8300-unknown-linux-

Aurelien Aptel <aaptel@suse.com>
    CIFS: fix POSIX lock leak and invalid ptr deref

Jeremy Compostella <jeremy.compostella@intel.com>
    i2c: core-smbus: prevent stack corruption on read I2C_BLOCK_DATA

Yang Shi <yang.shi@linux.alibaba.com>
    mm: mempolicy: make mbind() return -EIO when MPOL_MF_STRICT is specified

Razvan Stefanescu <razvan.stefanescu@microchip.com>
    tty/serial: atmel: RS485 HD w/DMA: enable RX after TX is stopped

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

 Documentation/arm/kernel_mode_neon.txt         |  4 +-
 Makefile                                       |  4 +-
 arch/arm/boot/dts/lpc32xx.dtsi                 | 18 ++++----
 arch/arm/include/asm/barrier.h                 |  2 +
 arch/arm/include/asm/processor.h               |  6 ++-
 arch/arm/kernel/machine_kexec.c                |  5 ++-
 arch/arm/kernel/smp.c                          |  4 +-
 arch/arm/kernel/unwind.c                       | 14 +++----
 arch/arm/lib/Makefile                          |  2 +-
 arch/arm/lib/xor-neon.c                        |  2 +-
 arch/arm/mach-omap2/prm_common.c               |  4 +-
 arch/arm64/kernel/kgdb.c                       | 15 +++++--
 arch/arm64/kernel/probes/kprobes.c             |  6 +++
 arch/arm64/mm/fault.c                          | 11 ++---
 arch/h8300/Makefile                            |  2 +-
 arch/powerpc/include/asm/topology.h            |  2 +
 arch/powerpc/mm/numa.c                         |  9 +---
 arch/powerpc/platforms/pseries/hotplug-cpu.c   | 19 +++++++++
 arch/x86/boot/Makefile                         |  2 +-
 arch/x86/kernel/vmlinux.lds.S                  |  2 +-
 arch/x86/realmode/rm/Makefile                  |  2 +-
 drivers/acpi/acpi_video.c                      | 20 ++++++---
 drivers/cdrom/cdrom.c                          |  7 ++--
 drivers/char/hpet.c                            |  2 +-
 drivers/char/hw_random/virtio-rng.c            |  2 +-
 drivers/crypto/amcc/crypto4xx_trng.c           |  4 +-
 drivers/dma/imx-dma.c                          |  2 +-
 drivers/dma/qcom/hidma.c                       | 17 ++++----
 drivers/dma/tegra20-apb-dma.c                  |  5 ++-
 drivers/firmware/efi/memattr.c                 |  2 +-
 drivers/gpio/gpio-omap.c                       | 14 ++++---
 drivers/gpu/drm/drm_dp_mst_topology.c          |  1 +
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c      |  4 +-
 drivers/hid/intel-ish-hid/ipc/ipc.c            |  9 ++--
 drivers/hid/intel-ish-hid/ishtp/bus.c          |  4 +-
 drivers/hwtracing/coresight/coresight-etm4x.c  |  3 +-
 drivers/i2c/i2c-core.c                         | 12 +++---
 drivers/infiniband/hw/cxgb4/cm.c               |  5 ++-
 drivers/infiniband/hw/mlx4/cm.c                |  2 +-
 drivers/iommu/io-pgtable-arm-v7s.c             |  3 +-
 drivers/leds/leds-lp55xx-common.c              |  4 +-
 drivers/md/bcache/sysfs.c                      | 17 ++++++--
 drivers/md/bcache/sysfs.h                      | 13 ++++--
 drivers/md/dm-thin.c                           | 13 ++++++
 drivers/media/i2c/mt9m111.c                    |  2 +
 drivers/media/platform/mx2_emmaprp.c           |  6 +--
 drivers/media/platform/s5p-g2d/g2d.c           |  6 +--
 drivers/media/platform/s5p-jpeg/jpeg-core.c    | 57 ++++++++++++++------------
 drivers/media/platform/sh_veu.c                |  4 +-
 drivers/mmc/host/omap.c                        |  2 +-
 drivers/net/ethernet/cisco/enic/enic_main.c    |  6 +--
 drivers/net/ethernet/intel/e1000e/netdev.c     | 19 ++++-----
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c |  4 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c    | 14 +++++--
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c   | 11 +++--
 drivers/net/wireless/mediatek/mt7601u/eeprom.h |  2 +-
 drivers/net/wireless/ti/wlcore/main.c          |  7 +++-
 drivers/regulator/act8865-regulator.c          |  5 ++-
 drivers/scsi/hisi_sas/hisi_sas_main.c          | 10 +++++
 drivers/scsi/megaraid/megaraid_sas_base.c      |  1 +
 drivers/scsi/scsi_scan.c                       |  6 +--
 drivers/soc/qcom/qcom_gsbi.c                   |  7 +++-
 drivers/soc/tegra/fuse/fuse-tegra.c            | 12 ++++--
 drivers/tty/serial/atmel_serial.c              | 43 ++++++++++++++-----
 drivers/tty/tty_buffer.c                       |  2 +-
 drivers/usb/chipidea/core.c                    |  9 +++-
 drivers/usb/gadget/function/f_fs.c             |  1 +
 drivers/video/fbdev/core/fbmem.c               |  3 ++
 fs/buffer.c                                    |  7 ++++
 fs/cifs/cifs_dfs_ref.c                         |  4 +-
 fs/cifs/connect.c                              |  5 +++
 fs/cifs/file.c                                 | 14 ++++++-
 fs/cifs/smb1ops.c                              |  2 +-
 fs/ext4/indirect.c                             | 47 ++++++++++-----------
 fs/f2fs/trace.c                                |  8 +++-
 fs/file.c                                      |  1 +
 fs/jbd2/commit.c                               |  6 ++-
 fs/ocfs2/cluster/nodemanager.c                 | 14 ++++---
 fs/read_write.c                                |  6 +++
 fs/splice.c                                    | 12 ++++++
 include/linux/irqdesc.h                        |  1 +
 include/linux/relay.h                          |  2 +-
 include/linux/ring_buffer.h                    |  2 +-
 include/net/netfilter/br_netfilter.h           |  1 -
 kernel/irq/chip.c                              | 12 +++++-
 kernel/irq/internals.h                         |  8 +++-
 kernel/irq/irqdesc.c                           |  7 +++-
 kernel/sysctl.c                                |  3 ++
 kernel/trace/ring_buffer.c                     |  5 ++-
 kernel/trace/trace.c                           |  6 ++-
 kernel/trace/trace_kdb.c                       |  6 ++-
 lib/bsearch.c                                  |  2 +
 lib/int_sqrt.c                                 |  6 +--
 lib/raid6/Makefile                             |  2 +-
 mm/cma.c                                       |  4 +-
 mm/mempolicy.c                                 | 18 ++++++--
 mm/page_ext.c                                  |  1 +
 mm/slab.c                                      | 17 ++++----
 mm/vmalloc.c                                   |  6 ++-
 net/bridge/br_netfilter_hooks.c                |  5 ---
 net/netfilter/xt_physdev.c                     |  9 +++-
 security/selinux/hooks.c                       |  9 +++-
 sound/core/pcm_native.c                        |  8 ++++
 sound/soc/fsl/fsl-asoc-card.c                  |  1 +
 sound/soc/fsl/imx-sgtl5000.c                   |  1 +
 tools/lib/traceevent/event-parse.c             |  2 +-
 tools/perf/tests/evsel-tp-sched.c              |  6 +--
 107 files changed, 549 insertions(+), 266 deletions(-)


