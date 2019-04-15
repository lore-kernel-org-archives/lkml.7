Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC86C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C24218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555353739;
	bh=e7CKbMvyYRpSB2Wid2zIXitOXPABFUfLh1LhnSyxCLo=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=EiAOo7LcPO9anr9p2chm4xIkQIO3L49xXTwGSb/mAV5n/A5NdR7XS7PKSWF7wFYj0
	 ZHCh/fh51/LK2IyRGIffNbKHWoYUgUrbEpmbMwGSMcau+qw76Rg6ufJzKpLPgtz8ak
	 KeUzgmwxFRzW8v095xUC33CN62GXtmu+O4cIUAoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfDOSmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:42:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:45786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727901AbfDOSmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:42:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 056EB2087C;
        Mon, 15 Apr 2019 18:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353736;
        bh=e7CKbMvyYRpSB2Wid2zIXitOXPABFUfLh1LhnSyxCLo=;
        h=Date:From:To:Cc:Subject:From;
        b=z26aLuAPTtD3KelGWxVSrZcomsIAUTw8JkrfR18+bV+xuBXmVHlbrDXKoKoUHDS7A
         xaVmY2n6A5yFS3WtCo/3wRKPM3A7+k+qYmF+/SytxQhSPVoDlSqhkpmvpDIgHjGoK8
         /oVsPaDHyGnOOoU7iseOL3CYOZxZPN80wAlzidGc=
Date:   Mon, 15 Apr 2019 20:42:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.111
Message-ID: <20190415184214.GA26967@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.111 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.14.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/arm/kernel_mode_neon.txt            |    4 -
 Makefile                                          |    2=20
 arch/arm/boot/dts/lpc32xx.dtsi                    |   18 +++---
 arch/arm/include/asm/barrier.h                    |    2=20
 arch/arm/include/asm/processor.h                  |    6 +-
 arch/arm/include/asm/v7m.h                        |    2=20
 arch/arm/kernel/entry-header.S                    |    3 -
 arch/arm/kernel/entry-v7m.S                       |    4 +
 arch/arm/kernel/machine_kexec.c                   |    5 +
 arch/arm/kernel/smp.c                             |    4 +
 arch/arm/kernel/unwind.c                          |   14 ++---
 arch/arm/lib/Makefile                             |    2=20
 arch/arm/lib/xor-neon.c                           |    2=20
 arch/arm/mach-omap2/prm_common.c                  |    4 +
 arch/arm/mm/proc-v7m.S                            |    3 +
 arch/arm64/mm/fault.c                             |   11 ++--
 arch/h8300/Makefile                               |    2=20
 arch/powerpc/include/asm/topology.h               |    2=20
 arch/powerpc/mm/hugetlbpage-radix.c               |    5 +
 arch/powerpc/mm/numa.c                            |    9 ---
 arch/powerpc/platforms/pseries/hotplug-cpu.c      |   19 +++++++
 arch/powerpc/xmon/ppc-dis.c                       |    2=20
 arch/x86/boot/Makefile                            |    2=20
 arch/x86/kernel/vmlinux.lds.S                     |    2=20
 arch/x86/realmode/rm/Makefile                     |    2=20
 drivers/acpi/acpi_video.c                         |   20 +++++--
 drivers/cdrom/cdrom.c                             |    7 +-
 drivers/char/hpet.c                               |    2=20
 drivers/char/hw_random/virtio-rng.c               |    2=20
 drivers/clk/clk-fractional-divider.c              |    2=20
 drivers/clk/rockchip/clk-rk3328.c                 |   12 ++--
 drivers/cpufreq/acpi-cpufreq.c                    |    4 +
 drivers/crypto/amcc/crypto4xx_trng.c              |    4 +
 drivers/crypto/cavium/zip/zip_main.c              |    6 +-
 drivers/dma/imx-dma.c                             |    2=20
 drivers/dma/qcom/hidma.c                          |   19 ++++---
 drivers/dma/tegra20-apb-dma.c                     |    5 +
 drivers/firmware/efi/cper.c                       |   13 +++--
 drivers/firmware/efi/libstub/arm-stub.c           |    5 +
 drivers/firmware/efi/libstub/efi-stub-helper.c    |   10 +++
 drivers/firmware/efi/libstub/efistub.h            |    1=20
 drivers/firmware/efi/libstub/fdt.c                |    3 +
 drivers/firmware/efi/memattr.c                    |    2=20
 drivers/gpio/gpio-omap.c                          |   14 +++--
 drivers/gpu/drm/drm_dp_mst_topology.c             |    1=20
 drivers/gpu/drm/drm_plane.c                       |    3 +
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c         |    4 +
 drivers/hid/intel-ish-hid/ipc/ipc.c               |    9 ++-
 drivers/hid/intel-ish-hid/ishtp/bus.c             |    4 +
 drivers/hwtracing/coresight/coresight-etm4x.c     |    3 -
 drivers/iio/adc/qcom-pm8xxx-xoadc.c               |   10 +--
 drivers/infiniband/hw/cxgb4/cm.c                  |    5 +
 drivers/infiniband/hw/mlx4/cm.c                   |    2=20
 drivers/iommu/io-pgtable-arm-v7s.c                |    3 -
 drivers/leds/leds-lp55xx-common.c                 |    4 -
 drivers/md/bcache/sysfs.c                         |   17 +++++-
 drivers/md/bcache/sysfs.h                         |   13 +++--
 drivers/md/dm-thin.c                              |   13 +++++
 drivers/media/i2c/mt9m111.c                       |    2=20
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c   |   40 +++++++--------
 drivers/media/platform/mx2_emmaprp.c              |    6 +-
 drivers/media/platform/s5p-g2d/g2d.c              |    6 +-
 drivers/media/platform/s5p-jpeg/jpeg-core.c       |   57 +++++++++++------=
-----
 drivers/media/platform/sh_veu.c                   |    4 -
 drivers/mmc/host/omap.c                           |    2=20
 drivers/net/ethernet/cisco/enic/enic_main.c       |    6 +-
 drivers/net/ethernet/intel/e1000e/netdev.c        |   19 +++----
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c |   17 ++++--
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c    |    4 -
 drivers/net/wireless/ath/wil6210/cfg80211.c       |   14 ++++-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c      |   11 +++-
 drivers/net/wireless/mediatek/mt7601u/eeprom.h    |    2=20
 drivers/net/wireless/ti/wlcore/main.c             |    7 +-
 drivers/pci/pcie/pme.c                            |   22 +++++---
 drivers/platform/x86/intel_pmc_core.c             |    3 -
 drivers/platform/x86/intel_pmc_core.h             |    2=20
 drivers/regulator/act8865-regulator.c             |    5 +
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                 |    2=20
 drivers/scsi/fcoe/fcoe.c                          |    2=20
 drivers/scsi/fcoe/fcoe_ctlr.c                     |    7 +-
 drivers/scsi/fcoe/fcoe_transport.c                |    2=20
 drivers/scsi/hisi_sas/hisi_sas_main.c             |   10 +++
 drivers/scsi/megaraid/megaraid_sas_base.c         |    1=20
 drivers/scsi/qedf/qedf_main.c                     |    2=20
 drivers/scsi/scsi_scan.c                          |    6 +-
 drivers/soc/qcom/qcom_gsbi.c                      |    7 +-
 drivers/soc/tegra/fuse/fuse-tegra.c               |   12 +++-
 drivers/tty/serial/8250/8250_pxa.c                |    4 +
 drivers/tty/serial/atmel_serial.c                 |   43 ++++++++++++----
 drivers/tty/tty_buffer.c                          |    2=20
 drivers/usb/chipidea/core.c                       |    9 +++
 drivers/usb/dwc3/gadget.c                         |    2=20
 drivers/usb/gadget/function/f_fs.c                |    1=20
 drivers/video/backlight/pwm_bl.c                  |    2=20
 drivers/video/fbdev/core/fbmem.c                  |    3 +
 fs/buffer.c                                       |    7 ++
 fs/cifs/cifs_dfs_ref.c                            |    4 -
 fs/cifs/connect.c                                 |    5 +
 fs/cifs/file.c                                    |   14 +++++
 fs/cifs/smb1ops.c                                 |    2=20
 fs/ext4/indirect.c                                |   47 ++++++++----------
 fs/f2fs/inline.c                                  |    8 ++-
 fs/f2fs/trace.c                                   |    8 ++-
 fs/file.c                                         |    1=20
 fs/jbd2/commit.c                                  |    6 +-
 fs/jbd2/journal.c                                 |   52 ++++++++++-------=
---
 fs/ocfs2/cluster/nodemanager.c                    |   14 +++--
 fs/read_write.c                                   |    6 ++
 include/linux/cgroup-defs.h                       |    2=20
 include/linux/cgroup.h                            |    2=20
 include/linux/clk-provider.h                      |    3 +
 include/linux/filter.h                            |    4 +
 include/linux/irqdesc.h                           |    1=20
 include/linux/relay.h                             |    2=20
 include/linux/ring_buffer.h                       |    2=20
 include/linux/sched/topology.h                    |    8 +--
 include/net/netfilter/br_netfilter.h              |    1=20
 include/scsi/libfcoe.h                            |    4 -
 kernel/cgroup/cgroup.c                            |   15 +++--
 kernel/cgroup/pids.c                              |    4 -
 kernel/cpu.c                                      |    9 +++
 kernel/exit.c                                     |    1=20
 kernel/irq/chip.c                                 |   12 +++-
 kernel/irq/internals.h                            |    8 ++-
 kernel/irq/irqdesc.c                              |    7 ++
 kernel/sched/debug.c                              |    4 +
 kernel/sched/topology.c                           |    2=20
 kernel/sysctl.c                                   |    3 +
 kernel/trace/ring_buffer.c                        |    5 +
 kernel/trace/trace.c                              |    6 +-
 kernel/trace/trace_kdb.c                          |    6 +-
 lib/bsearch.c                                     |    2=20
 lib/int_sqrt.c                                    |    6 --
 lib/raid6/Makefile                                |    2=20
 mm/cma.c                                          |    4 +
 mm/mempolicy.c                                    |   42 +++++++++++++---
 mm/page_alloc.c                                   |    2=20
 mm/page_ext.c                                     |    1=20
 mm/page_poison.c                                  |    4 +
 mm/slab.c                                         |   17 +++---
 mm/vmalloc.c                                      |    6 +-
 net/bridge/br_netfilter_hooks.c                   |    5 -
 net/netfilter/nf_conntrack_core.c                 |   14 ++++-
 net/netfilter/xt_physdev.c                        |    9 ++-
 security/selinux/hooks.c                          |    9 +++
 sound/core/pcm_native.c                           |    8 +++
 sound/soc/fsl/fsl-asoc-card.c                     |    1=20
 sound/soc/fsl/imx-sgtl5000.c                      |    1=20
 tools/lib/traceevent/event-parse.c                |    2=20
 tools/perf/builtin-c2c.c                          |    8 ++-
 tools/perf/tests/evsel-tp-sched.c                 |    6 +-
 151 files changed, 758 insertions(+), 377 deletions(-)

Aaro Koskinen (1):
      mmc: omap: fix the maximum timeout setting

Akinobu Mita (1):
      media: mt9m111: set initial frame size other than 0x0

Alexei Avshalom Lazar (1):
      wil6210: check null pointer in _wil_cfg80211_merge_extra_ies

Alexey Khoroshilov (1):
      soc: qcom: gsbi: Fix error handling in gsbi_probe()

Anders Roxell (1):
      dmaengine: imx-dma: fix warning comparison of distinct pointer types

Andrea Righi (1):
      kprobes: Prohibit probing on bsearch()

Aneesh Kumar K.V (1):
      powerpc/hugetlb: Handle mmap_min_addr correctly in get_unmapped_area =
callback

Ard Biesheuvel (2):
      efi/memattr: Don't bail on zero VA if it equals the region's PA
      efi/arm/arm64: Allow SetVirtualAddressMap() to be omitted

Arnd Bergmann (1):
      enic: fix build warning without CONFIG_CPUMASK_OFFSTACK

Aurelien Aptel (1):
      CIFS: fix POSIX lock leak and invalid ptr deref

Aurelien Jarno (1):
      vfs: fix preadv64v2 and pwritev64v2 compat syscalls with offset =3D=
=3D -1

Axel Lin (1):
      regulator: act8865: Fix act8600_sudcdc_voltage_ranges setting

Ben Dooks (1):
      dmaengine: tegra: avoid overflow of byte tracking

Benjamin Block (1):
      scsi: core: replace GFP_ATOMIC with GFP_KERNEL in scsi_scan.c

Buland Singh (1):
      hpet: Fix missing '=3D' character in the __setup() code of hpet_mmap_=
enable

Carlos Maiolino (1):
      fs: fix guard_bio_eod to check for real EOD errors

Chao Yu (1):
      f2fs: fix to avoid deadlock in f2fs_read_inline_dir()

Chen-Yu Tsai (1):
      backlight: pwm_bl: Use gpiod_get_value_cansleep() to get initial state

Chieh-Min Wang (1):
      netfilter: conntrack: fix cloned unconfirmed skb->_nfct race in __nf_=
conntrack_confirm

Christian Brauner (1):
      sysctl: handle overflow for file-max

Coly Li (3):
      bcache: fix input overflow to cache set sysfs file io_error_halflife
      bcache: fix input overflow to sequential_cutoff
      bcache: improve sysfs_strtoul_clamp()

Daniel Vetter (1):
      drm/nouveau: Stop using drm_crtc_force_disable

David Tolnay (1):
      hwrng: virtio - Avoid repeated init of completion

Douglas Anderson (1):
      tracing: kdb: Fix ftdump to not sleep

Eric Biggers (1):
      crypto: cavium/zip - fix collision with generic cra_driver_name

Erwan Velu (1):
      cpufreq: acpi-cpufreq: Report if CPU doesn't support boost technologi=
es

Ezequiel Garcia (5):
      media: sh_veu: Correct return type for mem2mem buffer helpers
      media: s5p-jpeg: Correct return type for mem2mem buffer helpers
      media: s5p-g2d: Correct return type for mem2mem buffer helpers
      media: mx2_emmaprp: Correct return type for mem2mem buffer helpers
      media: mtk-jpeg: Correct return type for mem2mem buffer helpers

Florian Fainelli (2):
      e1000e: Fix -Wformat-truncation warnings
      mlxsw: spectrum: Avoid -Wformat-truncation warnings

Florian Westphal (1):
      netfilter: physdev: relax br_netfilter dependency

George Rimar (1):
      x86/build: Specify elf_i386 linker emulation explicitly for i386 obje=
cts

Greg Kroah-Hartman (1):
      Linux 4.14.111

Guenter Roeck (1):
      cdrom: Fix race condition in cdrom_sysctl_register

Hans de Goede (2):
      ACPI / video: Refactor and fix dmi_is_desktop()
      ACPI / video: Extend chassis-type detection with a "Lunch Box" check

Hidetoshi Seto (1):
      sched/debug: Initialize sd_sysctl_cpus if !CONFIG_CPUMASK_OFFSTACK

Hong Liu (1):
      HID: intel-ish-hid: avoid binding wrong ishtp_cl_device

H=E5kon Bugge (1):
      IB/mlx4: Increase the timeout for CM cache

Jason Cai (Xiang Feng) (1):
      dm thin: add sanity checks to thin-pool and external snapshot creation

Jason Yan (1):
      scsi: megaraid_sas: return error when create DMA pool failed

Jia Guo (1):
      ocfs2: fix a panic problem caused by o2cb_ctl

Jiri Olsa (1):
      perf c2c: Fix c2c report for empty numa node

John Garry (1):
      scsi: hisi_sas: Set PHY linkrate when disconnected

John Stultz (1):
      usb: f_fs: Avoid crash due to out-of-scope stack ptr access

Julia Lawall (1):
      crypto: crypto4xx - add missing of_node_put after of_device_is_availa=
ble

Katsuhiro Suzuki (2):
      clk: fractional-divider: check parent rate only if flag is set
      clk: rockchip: fix frac settings of GPLL clock for rk3328

Konstantin Khlebnikov (1):
      e1000e: fix cyclic resets at link up with active tx

Linus Torvalds (1):
      iio: adc: fix warning in Qualcomm PM8xxx HK/XOADC driver

Louis Taylor (1):
      cifs: use correct format characters

Lubomir Rintel (1):
      serial: 8250_pxa: honor the port number from devicetree

Luc Van Oostenryck (2):
      include/linux/relay.h: fix percpu annotation in struct rchan
      sched/topology: Fix percpu data types in struct sd_data & struct s_da=
ta

Manfred Schlaegl (2):
      fbdev: fbmem: fix memory access if logo is bigger than the screen
      tty: increase the default flip buffer limit to 2*640K

Masahiro Yamada (1):
      h8300: use cc-cross-prefix instead of hardcoding h8300-unknown-linux-

Mathieu Malaterre (1):
      ARM: dts: lpc32xx: Remove leading 0x and 0s from bindings notation

Michal Kazior (1):
      leds: lp55xx: fix null deref on firmware load failure

Nathan Chancellor (2):
      powerpc/xmon: Fix opcode being uninitialized in print_insn_powerpc
      ARM: 8833/1: Ensure that NEON code always compiles with Clang

Nathan Fontenot (1):
      powerpc/pseries: Perform full re-add of CPU for topology update post-=
migration

Nicolas Boichat (1):
      iommu/io-pgtable-arm-v7s: Only kmemleak_ignore L2 tables

Oleg Nesterov (1):
      cgroup/pids: turn cgroup_subsys->free() into cgroup_subsys->release()=
 to fix the accounting

Ondrej Mosnacek (1):
      selinux: do not override context on context mounts

Paul Kocialkowski (2):
      usb: chipidea: Grab the (legacy) USB PHY by phandle first
      drm: Auto-set allow_fb_modifiers when given modifiers at plane init

Pawe? Chmiel (1):
      media: s5p-jpeg: Check for fmt_ver_flag when doing fmt enumeration

Peng Fan (1):
      mm/cma.c: cma_declare_contiguous: correct err handling

Peter Zijlstra (1):
      lib/int_sqrt: optimize initial value compute

Qian Cai (3):
      mm/page_ext.c: fix an imbalance with kmemleak
      mm/slab.c: kmemleak no scan alien caches
      page_poison: play nicely with KASAN

Rafael J. Wysocki (1):
      PCI/PME: Fix hotplug/sysfs remove deadlock in pcie_pme_remove()

Rafael =C1vila de Esp=EDndola (1):
      x86/build: Mark per-CPU symbols as absolute explicitly for LLD

Rajneesh Bhardwaj (1):
      platform/x86: intel_pmc_core: Fix PCH IP sts reading

Raju Rangoju (1):
      iw_cxgb4: fix srqidx leak during connection abort

Ranjani Sridharan (1):
      ALSA: PCM: check if ops are defined before suspending PCM

Razvan Stefanescu (2):
      tty/serial: atmel: Add is_half_duplex helper
      tty/serial: atmel: RS485 HD w/DMA: enable RX after TX is stopped

Roger Quadros (1):
      usb: dwc3: gadget: Fix OTG events when gadget driver isn't loaded

Ross Lagerwall (1):
      efi: cper: Fix possible out-of-bounds access

Russell King (2):
      gpio: gpio-omap: fix level interrupt idling
      ARM: avoid Cortex-A9 livelock on tight dmb loops

Sahitya Tummala (1):
      f2fs: do not use mutex lock in atomic context

Sai Prakash Ranjan (1):
      coresight: etm4x: Add support to enable ETMv4.2

Sara Sharon (1):
      iwlwifi: pcie: fix emergency path

Sebastian Andrzej Siewior (1):
      ARM: 8840/1: use a raw_spinlock_t in unwind

Sedat Dilek (1):
      scsi: fcoe: make use of fip_mode enum complete

Shunyong Yang (2):
      dmaengine: qcom_hidma: assign channel cookie correctly
      dmaengine: qcom_hidma: initialize tx flags in hidma_prep_dma_*

Shuriyc Chu (1):
      fs/file.c: initialize init_files.resize_wait

Song Hongyan (1):
      HID: intel-ish: ipc: handle PIMR before ish_wakeup also clear PISR bu=
sy_clear bit

Stanislaw Gruszka (1):
      mt7601u: bump supported EEPROM version

Theodore Ts'o (1):
      jbd2: fix race when writing superblock

Thomas Gleixner (1):
      genirq: Avoid summation loops for /proc/stat

Thomas Richter (1):
      perf test: Fix failure of 'evsel-tp-sched' test on s390

Timo Alho (1):
      soc/tegra: fuse: Fix illegal free of IO base address

Tonghao Zhang (2):
      net/mlx5: Avoid panic when setting vport rate
      net/mlx5: Avoid panic when setting vport mac, getting vport config

Tony Jones (1):
      tools lib traceevent: Fix buffer overflow in arg_eval

Uladzislau Rezki (Sony) (1):
      mm/vmalloc.c: fix kernel BUG at mm/vmalloc.c:512!

Valdis Kletnieks (1):
      bpf: fix missing prototype warnings

Valentin Schneider (1):
      cpu/hotplug: Mute hotplug lockdep during init

Ville Syrj=E4l=E4 (1):
      drm/dp/mst: Configure no_stop_bit correctly for remote i2c xfers

Vladimir Murzin (1):
      ARM: 8830/1: NOMMU: Toggle only bits in EXC_RETURN we are really care=
 of

Vlastimil Babka (1):
      mm, mempolicy: fix uninit memory access

Wen Yang (1):
      SoC: imx-sgtl5000: add missing put_device()

Will Deacon (1):
      arm64: debug: Don't propagate UNKNOWN FAR into si_code for debug sign=
als

Yang Shi (1):
      mm: mempolicy: make mbind() return -EIO when MPOL_MF_STRICT is specif=
ied

Yao Liu (1):
      cifs: Fix NULL pointer dereference of devname

Zumeng Chen (1):
      wlcore: Fix memory leak in case wl12xx_fetch_firmware failure

luojiajun (1):
      jbd2: fix invalid descriptor block checksum

wen yang (1):
      ASoC: fsl-asoc-card: fix object reference leaks in fsl_asoc_card_probe

zhangyi (F) (1):
      ext4: cleanup bh release code in ext4_ind_remove_space()


--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAly00IUACgkQONu9yGCS
aT4ETA//VH7bldXCgukRj4Frt7Uygig1Yc+0P1h2kI1MTVZNDHHxrviLAwPIvrtM
n9qmXKx67Ep7Q/xhs97wNNHEJJ7UPXp1WlvETHgzkTgDhltL9rbJAOqB/UeIeZND
etFOOKNRTqtJw/XSUVhnDVNQweeO2/4Nkoaza/ztPVRGSLKnay1bd0Ad6G4Ztz22
n06/LjpwCPCfJamO4pvZ3UCS6QPbi040OuvVhRdlAasil+21zVOi4q22ire3so4C
G0qPM4RTDnDXhzQhcTHdx3aCTMBeBcJiGVc2RAR8meij2cL8MCATn9Zj4xKlPUrc
R8/UCU8aCnYcp2hd+V/7zMJZj4Xf2VKZfUFyp7FBhG7fnGNwUpVuVY5pEjg8w/J8
59zXdyYsnSmat/DHmbVlEwlGrWT1uLbAjmpl0Tc1+7L/cIKIN1Io6iCX/tizlVOV
gFq+xR0x9Uc26LO75t4v+BWg6DowmET+RNmLF/WhZn2Y+GWLALLcEjEdR6ApiHAL
Oc3DAuPDhnjpKMbLr43Kn42uwau5a8h2J56keq7Z53zpm5XGyS9W4XjECHfC60Ui
0JQtQ9XI1EReenKcSTGm6GfXflbuA9VsOdqlokBRY+pgY0xitO8x4CmhswycG7LY
p0kflAw26gCzUYMcECMvBSTP3ERkfYWmqZCu9C3vGnwBv580oRE=
=RxP3
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
