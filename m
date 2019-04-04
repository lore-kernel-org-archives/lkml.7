Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28983C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0E321872
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368040;
	bh=RtGEtjvLWFGi0qJYW8fCUfPf3yguJcd/iY8x80hzoAE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=EIRCsOjX0sbHvYbJRakCRCKNCgJbBprYhiq7X14qLeCZ9KyM0TC+aAZQtiPbqQdY5
	 q5xG+0+3rH96nISwN1jAZui9BKifu7m/pBRPTwED5Kmg1DdIro4xCukv8CrMWcrmUC
	 voKqjQaTSxuiBuYzuikPMmM2rlZsLQHcEvi7IC4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbfDDIx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:53:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729908AbfDDIxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:53:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46FD8217D4;
        Thu,  4 Apr 2019 08:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368031;
        bh=RtGEtjvLWFGi0qJYW8fCUfPf3yguJcd/iY8x80hzoAE=;
        h=From:To:Cc:Subject:Date:From;
        b=nEftBTVa3gHfmcOeJQdZSy0z4BIf/El594Z9RAwzpm9b3gh19WC6Oz/2QoTZ8LGmT
         HxuVwfi8Uzu63sonjJLcuZfLTGOOrzClWgecq/VJ0OI13ropew3h8S/CFlwbMvf4Sl
         xdIMM21AILtvBzo5BOUGX4b6eCdH8Y7nVMeXcCx8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 000/121] 4.14.111-stable review
Date:   Thu,  4 Apr 2019 10:46:28 +0200
Message-Id: <20190404084545.245659903@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.111-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.111-rc1
X-KernelTest-Deadline: 2019-04-06T08:45+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.111 release.
There are 121 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Apr  6 08:44:23 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.111-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.111-rc1

Hans de Goede <hdegoede@redhat.com>
    ACPI / video: Extend chassis-type detection with a "Lunch Box" check

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/dp/mst: Configure no_stop_bit correctly for remote i2c xfers

Ben Dooks <ben.dooks@codethink.co.uk>
    dmaengine: tegra: avoid overflow of byte tracking

Katsuhiro Suzuki <katsuhiro@katsuster.net>
    clk: rockchip: fix frac settings of GPLL clock for rk3328

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

Paul Kocialkowski <paul.kocialkowski@bootlin.com>
    drm: Auto-set allow_fb_modifiers when given modifiers at plane init

Axel Lin <axel.lin@ingics.com>
    regulator: act8865: Fix act8600_sudcdc_voltage_ranges setting

Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
    media: s5p-jpeg: Check for fmt_ver_flag when doing fmt enumeration

Florian Westphal <fw@strlen.de>
    netfilter: physdev: relax br_netfilter dependency

Shunyong Yang <shunyong.yang@hxt-semitech.com>
    dmaengine: qcom_hidma: initialize tx flags in hidma_prep_dma_*

Shunyong Yang <shunyong.yang@hxt-semitech.com>
    dmaengine: qcom_hidma: assign channel cookie correctly

Anders Roxell <anders.roxell@linaro.org>
    dmaengine: imx-dma: fix warning comparison of distinct pointer types

Valentin Schneider <valentin.schneider@arm.com>
    cpu/hotplug: Mute hotplug lockdep during init

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

Roger Quadros <rogerq@ti.com>
    usb: dwc3: gadget: Fix OTG events when gadget driver isn't loaded

Nathan Fontenot <nfont@linux.vnet.ibm.com>
    powerpc/pseries: Perform full re-add of CPU for topology update post-migration

Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
    tty: increase the default flip buffer limit to 2*640K

Chen-Yu Tsai <wens@csie.org>
    backlight: pwm_bl: Use gpiod_get_value_cansleep() to get initial state

Oleg Nesterov <oleg@redhat.com>
    cgroup/pids: turn cgroup_subsys->free() into cgroup_subsys->release() to fix the accounting

Valdis Kletnieks <valdis.kletnieks@vt.edu>
    bpf: fix missing prototype warnings

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: avoid Cortex-A9 livelock on tight dmb loops

Vladimir Murzin <vladimir.murzin@arm.com>
    ARM: 8830/1: NOMMU: Toggle only bits in EXC_RETURN we are really care of

Stanislaw Gruszka <sgruszka@redhat.com>
    mt7601u: bump supported EEPROM version

Alexey Khoroshilov <khoroshilov@ispras.ru>
    soc: qcom: gsbi: Fix error handling in gsbi_probe()

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    efi/arm/arm64: Allow SetVirtualAddressMap() to be omitted

Mathieu Malaterre <malat@debian.org>
    ARM: dts: lpc32xx: Remove leading 0x and 0s from bindings notation

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    efi/memattr: Don't bail on zero VA if it equals the region's PA

Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
    sched/debug: Initialize sd_sysctl_cpus if !CONFIG_CPUMASK_OFFSTACK

wen yang <yellowriver2010@hotmail.com>
    ASoC: fsl-asoc-card: fix object reference leaks in fsl_asoc_card_probe

Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
    platform/x86: intel_pmc_core: Fix PCH IP sts reading

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

Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
    sched/topology: Fix percpu data types in struct sd_data & struct s_data

John Stultz <john.stultz@linaro.org>
    usb: f_fs: Avoid crash due to out-of-scope stack ptr access

Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
    ALSA: PCM: check if ops are defined before suspending PCM

Nathan Chancellor <natechancellor@gmail.com>
    ARM: 8833/1: Ensure that NEON code always compiles with Clang

Chieh-Min Wang <chiehminw@synology.com>
    netfilter: conntrack: fix cloned unconfirmed skb->_nfct race in __nf_conntrack_confirm

Andrea Righi <righi.andrea@gmail.com>
    kprobes: Prohibit probing on bsearch()

Hans de Goede <hdegoede@redhat.com>
    ACPI / video: Refactor and fix dmi_is_desktop()

Sara Sharon <sara.sharon@intel.com>
    iwlwifi: pcie: fix emergency path

Michal Kazior <michal@plume.com>
    leds: lp55xx: fix null deref on firmware load failure

Theodore Ts'o <tytso@mit.edu>
    jbd2: fix race when writing superblock

Hong Liu <hong.liu@intel.com>
    HID: intel-ish-hid: avoid binding wrong ishtp_cl_device

Aurelien Jarno <aurelien@aurel32.net>
    vfs: fix preadv64v2 and pwritev64v2 compat syscalls with offset == -1

Ezequiel Garcia <ezequiel@collabora.com>
    media: mtk-jpeg: Correct return type for mem2mem buffer helpers

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

Sedat Dilek <sedat.dilek@gmail.com>
    scsi: fcoe: make use of fip_mode enum complete

Jason Yan <yanaijie@huawei.com>
    scsi: megaraid_sas: return error when create DMA pool failed

Ross Lagerwall <ross.lagerwall@citrix.com>
    efi: cper: Fix possible out-of-bounds access

Erwan Velu <erwanaliasr1@gmail.com>
    cpufreq: acpi-cpufreq: Report if CPU doesn't support boost technologies

Katsuhiro Suzuki <katsuhiro@katsuster.net>
    clk: fractional-divider: check parent rate only if flag is set

Håkon Bugge <haakon.bugge@oracle.com>
    IB/mlx4: Increase the timeout for CM cache

Florian Fainelli <f.fainelli@gmail.com>
    mlxsw: spectrum: Avoid -Wformat-truncation warnings

Florian Fainelli <f.fainelli@gmail.com>
    e1000e: Fix -Wformat-truncation warnings

Aaro Koskinen <aaro.koskinen@iki.fi>
    mmc: omap: fix the maximum timeout setting

Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
    powerpc/hugetlb: Handle mmap_min_addr correctly in get_unmapped_area callback

Nicolas Boichat <drinkcat@chromium.org>
    iommu/io-pgtable-arm-v7s: Only kmemleak_ignore L2 tables

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    ARM: 8840/1: use a raw_spinlock_t in unwind

Lubomir Rintel <lkundrak@v3.sk>
    serial: 8250_pxa: honor the port number from devicetree

Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
    coresight: etm4x: Add support to enable ETMv4.2

Nathan Chancellor <natechancellor@gmail.com>
    powerpc/xmon: Fix opcode being uninitialized in print_insn_powerpc

Benjamin Block <bblock@linux.ibm.com>
    scsi: core: replace GFP_ATOMIC with GFP_KERNEL in scsi_scan.c

Paul Kocialkowski <paul.kocialkowski@bootlin.com>
    usb: chipidea: Grab the (legacy) USB PHY by phandle first

Eric Biggers <ebiggers@google.com>
    crypto: cavium/zip - fix collision with generic cra_driver_name

Julia Lawall <Julia.Lawall@lip6.fr>
    crypto: crypto4xx - add missing of_node_put after of_device_is_available

Alexei Avshalom Lazar <ailizaro@codeaurora.org>
    wil6210: check null pointer in _wil_cfg80211_merge_extra_ies

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    PCI/PME: Fix hotplug/sysfs remove deadlock in pcie_pme_remove()

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

Qian Cai <cai@lca.pw>
    page_poison: play nicely with KASAN

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

Vlastimil Babka <vbabka@suse.cz>
    mm, mempolicy: fix uninit memory access

Qian Cai <cai@lca.pw>
    mm/page_ext.c: fix an imbalance with kmemleak

Peng Fan <peng.fan@nxp.com>
    mm/cma.c: cma_declare_contiguous: correct err handling

Jiri Olsa <jolsa@redhat.com>
    perf c2c: Fix c2c report for empty numa node

Linus Torvalds <torvalds@linux-foundation.org>
    iio: adc: fix warning in Qualcomm PM8xxx HK/XOADC driver

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

Tonghao Zhang <xiangxia.m.yue@gmail.com>
    net/mlx5: Avoid panic when setting vport mac, getting vport config

Tonghao Zhang <xiangxia.m.yue@gmail.com>
    net/mlx5: Avoid panic when setting vport rate

Douglas Anderson <dianders@chromium.org>
    tracing: kdb: Fix ftdump to not sleep

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to avoid deadlock in f2fs_read_inline_dir()

Masahiro Yamada <yamada.masahiro@socionext.com>
    h8300: use cc-cross-prefix instead of hardcoding h8300-unknown-linux-

Aurelien Aptel <aaptel@suse.com>
    CIFS: fix POSIX lock leak and invalid ptr deref

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
    arm64: debug: Don't propagate UNKNOWN FAR into si_code for debug signals


-------------

Diffstat:

 Documentation/arm/kernel_mode_neon.txt            |  4 +-
 Makefile                                          |  4 +-
 arch/arm/boot/dts/lpc32xx.dtsi                    | 18 +++----
 arch/arm/include/asm/barrier.h                    |  2 +
 arch/arm/include/asm/processor.h                  |  6 ++-
 arch/arm/include/asm/v7m.h                        |  2 +-
 arch/arm/kernel/entry-header.S                    |  3 +-
 arch/arm/kernel/entry-v7m.S                       |  4 ++
 arch/arm/kernel/machine_kexec.c                   |  5 +-
 arch/arm/kernel/smp.c                             |  4 +-
 arch/arm/kernel/unwind.c                          | 14 +++---
 arch/arm/lib/Makefile                             |  2 +-
 arch/arm/lib/xor-neon.c                           |  2 +-
 arch/arm/mach-omap2/prm_common.c                  |  4 +-
 arch/arm/mm/proc-v7m.S                            |  3 ++
 arch/arm64/mm/fault.c                             | 11 +++--
 arch/h8300/Makefile                               |  2 +-
 arch/powerpc/include/asm/topology.h               |  2 +
 arch/powerpc/mm/hugetlbpage-radix.c               |  5 +-
 arch/powerpc/mm/numa.c                            |  9 +---
 arch/powerpc/platforms/pseries/hotplug-cpu.c      | 19 ++++++++
 arch/powerpc/xmon/ppc-dis.c                       |  2 +-
 arch/x86/boot/Makefile                            |  2 +-
 arch/x86/kernel/vmlinux.lds.S                     |  2 +-
 arch/x86/realmode/rm/Makefile                     |  2 +-
 drivers/acpi/acpi_video.c                         | 20 +++++---
 drivers/cdrom/cdrom.c                             |  7 ++-
 drivers/char/hpet.c                               |  2 +-
 drivers/char/hw_random/virtio-rng.c               |  2 +-
 drivers/clk/clk-fractional-divider.c              |  2 +-
 drivers/clk/rockchip/clk-rk3328.c                 | 12 ++---
 drivers/cpufreq/acpi-cpufreq.c                    |  4 +-
 drivers/crypto/amcc/crypto4xx_trng.c              |  4 +-
 drivers/crypto/cavium/zip/zip_main.c              |  6 ++-
 drivers/dma/imx-dma.c                             |  2 +-
 drivers/dma/qcom/hidma.c                          | 19 ++++----
 drivers/dma/tegra20-apb-dma.c                     |  5 +-
 drivers/firmware/efi/cper.c                       | 13 ++++--
 drivers/firmware/efi/libstub/arm-stub.c           |  5 ++
 drivers/firmware/efi/libstub/efi-stub-helper.c    | 10 ++++
 drivers/firmware/efi/libstub/efistub.h            |  1 +
 drivers/firmware/efi/libstub/fdt.c                |  3 ++
 drivers/firmware/efi/memattr.c                    |  2 +-
 drivers/gpio/gpio-omap.c                          | 14 +++---
 drivers/gpu/drm/drm_dp_mst_topology.c             |  1 +
 drivers/gpu/drm/drm_plane.c                       |  3 ++
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c         |  4 +-
 drivers/hid/intel-ish-hid/ipc/ipc.c               |  9 ++--
 drivers/hid/intel-ish-hid/ishtp/bus.c             |  4 +-
 drivers/hwtracing/coresight/coresight-etm4x.c     |  3 +-
 drivers/iio/adc/qcom-pm8xxx-xoadc.c               | 10 ++--
 drivers/infiniband/hw/cxgb4/cm.c                  |  5 +-
 drivers/infiniband/hw/mlx4/cm.c                   |  2 +-
 drivers/iommu/io-pgtable-arm-v7s.c                |  3 +-
 drivers/leds/leds-lp55xx-common.c                 |  4 +-
 drivers/md/bcache/sysfs.c                         | 17 +++++--
 drivers/md/bcache/sysfs.h                         | 13 ++++--
 drivers/md/dm-thin.c                              | 13 ++++++
 drivers/media/i2c/mt9m111.c                       |  2 +
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c   | 40 ++++++++--------
 drivers/media/platform/mx2_emmaprp.c              |  6 +--
 drivers/media/platform/s5p-g2d/g2d.c              |  6 +--
 drivers/media/platform/s5p-jpeg/jpeg-core.c       | 57 ++++++++++++-----------
 drivers/media/platform/sh_veu.c                   |  4 +-
 drivers/mmc/host/omap.c                           |  2 +-
 drivers/net/ethernet/cisco/enic/enic_main.c       |  6 +--
 drivers/net/ethernet/intel/e1000e/netdev.c        | 19 ++++----
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c | 17 ++++---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c    |  4 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c       | 14 ++++--
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c      | 11 +++--
 drivers/net/wireless/mediatek/mt7601u/eeprom.h    |  2 +-
 drivers/net/wireless/ti/wlcore/main.c             |  7 ++-
 drivers/pci/pcie/pme.c                            | 22 ++++++---
 drivers/platform/x86/intel_pmc_core.c             |  3 +-
 drivers/platform/x86/intel_pmc_core.h             |  2 +-
 drivers/regulator/act8865-regulator.c             |  5 +-
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                 |  2 +-
 drivers/scsi/fcoe/fcoe.c                          |  2 +-
 drivers/scsi/fcoe/fcoe_ctlr.c                     |  7 ++-
 drivers/scsi/fcoe/fcoe_transport.c                |  2 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c             | 10 ++++
 drivers/scsi/megaraid/megaraid_sas_base.c         |  1 +
 drivers/scsi/qedf/qedf_main.c                     |  2 +-
 drivers/scsi/scsi_scan.c                          |  6 +--
 drivers/soc/qcom/qcom_gsbi.c                      |  7 ++-
 drivers/soc/tegra/fuse/fuse-tegra.c               | 12 +++--
 drivers/tty/serial/8250/8250_pxa.c                |  4 ++
 drivers/tty/serial/atmel_serial.c                 | 43 ++++++++++++-----
 drivers/tty/tty_buffer.c                          |  2 +-
 drivers/usb/chipidea/core.c                       |  9 +++-
 drivers/usb/dwc3/gadget.c                         |  2 +
 drivers/usb/gadget/function/f_fs.c                |  1 +
 drivers/video/backlight/pwm_bl.c                  |  2 +-
 drivers/video/fbdev/core/fbmem.c                  |  3 ++
 fs/buffer.c                                       |  7 +++
 fs/cifs/cifs_dfs_ref.c                            |  4 +-
 fs/cifs/connect.c                                 |  5 ++
 fs/cifs/file.c                                    | 14 +++++-
 fs/cifs/smb1ops.c                                 |  2 +-
 fs/ext4/indirect.c                                | 47 +++++++++----------
 fs/f2fs/inline.c                                  |  8 +++-
 fs/f2fs/trace.c                                   |  8 +++-
 fs/file.c                                         |  1 +
 fs/jbd2/commit.c                                  |  6 ++-
 fs/jbd2/journal.c                                 | 52 +++++++++++----------
 fs/ocfs2/cluster/nodemanager.c                    | 14 +++---
 fs/read_write.c                                   |  6 +++
 fs/splice.c                                       | 12 +++++
 include/linux/cgroup-defs.h                       |  2 +-
 include/linux/cgroup.h                            |  2 +
 include/linux/clk-provider.h                      |  3 ++
 include/linux/filter.h                            |  4 +-
 include/linux/irqdesc.h                           |  1 +
 include/linux/relay.h                             |  2 +-
 include/linux/ring_buffer.h                       |  2 +-
 include/linux/sched/topology.h                    |  8 ++--
 include/net/netfilter/br_netfilter.h              |  1 -
 include/scsi/libfcoe.h                            |  4 +-
 kernel/cgroup/cgroup.c                            | 15 +++---
 kernel/cgroup/pids.c                              |  4 +-
 kernel/cpu.c                                      |  9 ++++
 kernel/exit.c                                     |  1 +
 kernel/irq/chip.c                                 | 12 ++++-
 kernel/irq/internals.h                            |  8 +++-
 kernel/irq/irqdesc.c                              |  7 ++-
 kernel/sched/debug.c                              |  4 ++
 kernel/sched/topology.c                           |  2 +-
 kernel/sysctl.c                                   |  3 ++
 kernel/trace/ring_buffer.c                        |  5 +-
 kernel/trace/trace.c                              |  6 ++-
 kernel/trace/trace_kdb.c                          |  6 ++-
 lib/bsearch.c                                     |  2 +
 lib/int_sqrt.c                                    |  6 +--
 lib/raid6/Makefile                                |  2 +-
 mm/cma.c                                          |  4 +-
 mm/mempolicy.c                                    | 42 +++++++++++++----
 mm/page_alloc.c                                   |  2 +-
 mm/page_ext.c                                     |  1 +
 mm/page_poison.c                                  |  4 ++
 mm/slab.c                                         | 17 +++----
 mm/vmalloc.c                                      |  6 ++-
 net/bridge/br_netfilter_hooks.c                   |  5 --
 net/netfilter/nf_conntrack_core.c                 | 14 ++++--
 net/netfilter/xt_physdev.c                        |  9 +++-
 security/selinux/hooks.c                          |  9 +++-
 sound/core/pcm_native.c                           |  8 ++++
 sound/soc/fsl/fsl-asoc-card.c                     |  1 +
 sound/soc/fsl/imx-sgtl5000.c                      |  1 +
 tools/lib/traceevent/event-parse.c                |  2 +-
 tools/perf/builtin-c2c.c                          |  8 +++-
 tools/perf/tests/evsel-tp-sched.c                 |  6 +--
 152 files changed, 771 insertions(+), 378 deletions(-)


