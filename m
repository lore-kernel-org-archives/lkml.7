Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89458C282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454EB2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555353774;
	bh=aVV9J8gL/ppBYBPj0h9pIn59IW9RAsN672u6xy/uFRY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=uXjb22fdwTOCJjicl6c84xrCnFq++ZC0fsdErjhFrneLSBWBdanCEGT1tPXumruN0
	 1y3mknACnJkLFgEcM6Bx/jXF6lQDfu0FdEIcAipRuHvsSjQjATEbkthOsvnmgMYn66
	 eaI1edEhEHHtqbimMl5lqR4yfqmtLBJq81bZO01E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfDOSmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:42:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbfDOSmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:42:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B464B2073F;
        Mon, 15 Apr 2019 18:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353770;
        bh=aVV9J8gL/ppBYBPj0h9pIn59IW9RAsN672u6xy/uFRY=;
        h=Date:From:To:Cc:Subject:From;
        b=H2bV1q99u8W/Y5MIP+Y1MLHt74qEdVWNPR8x+yMxu0YpJ15xHV6J6wwpdy6MZ3jqP
         H8GrYa3rpSaXIivwRzg+5JQOBAgiJBIcPfPNFGJSsyRyl9ALWYdmUlPh++TeKU7Kb1
         aWa9n6g8pm6YipkH5q03kV/8iMpuyuPFCJ6rDdT0=
Date:   Mon, 15 Apr 2019 20:42:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.168
Message-ID: <20190415184247.GA28849@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.168 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/arm/kernel_mode_neon.txt         |    4 -
 Makefile                                       |    2=20
 arch/arm/boot/dts/lpc32xx.dtsi                 |   18 +++----
 arch/arm/include/asm/barrier.h                 |    2=20
 arch/arm/include/asm/processor.h               |    6 ++
 arch/arm/kernel/machine_kexec.c                |    5 +-
 arch/arm/kernel/smp.c                          |    4 +
 arch/arm/kernel/unwind.c                       |   14 +++---
 arch/arm/lib/Makefile                          |    2=20
 arch/arm/lib/xor-neon.c                        |    2=20
 arch/arm/mach-omap2/prm_common.c               |    4 +
 arch/arm64/kernel/kgdb.c                       |   15 +++++-
 arch/arm64/kernel/probes/kprobes.c             |    6 ++
 arch/arm64/mm/fault.c                          |   11 ++--
 arch/h8300/Makefile                            |    2=20
 arch/powerpc/include/asm/topology.h            |    2=20
 arch/powerpc/mm/numa.c                         |    9 ---
 arch/powerpc/platforms/pseries/hotplug-cpu.c   |   19 ++++++++
 arch/x86/boot/Makefile                         |    2=20
 arch/x86/kernel/vmlinux.lds.S                  |    2=20
 arch/x86/realmode/rm/Makefile                  |    2=20
 drivers/acpi/acpi_video.c                      |   20 ++++++--
 drivers/cdrom/cdrom.c                          |    7 +--
 drivers/char/hpet.c                            |    2=20
 drivers/char/hw_random/virtio-rng.c            |    2=20
 drivers/crypto/amcc/crypto4xx_trng.c           |    4 +
 drivers/dma/imx-dma.c                          |    2=20
 drivers/dma/qcom/hidma.c                       |   17 +++----
 drivers/dma/tegra20-apb-dma.c                  |    5 +-
 drivers/firmware/efi/memattr.c                 |    2=20
 drivers/gpio/gpio-omap.c                       |   14 +++---
 drivers/gpu/drm/drm_dp_mst_topology.c          |    1=20
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c      |    4 +
 drivers/hid/intel-ish-hid/ipc/ipc.c            |    9 ++-
 drivers/hid/intel-ish-hid/ishtp/bus.c          |    4 +
 drivers/hwtracing/coresight/coresight-etm4x.c  |    3 -
 drivers/i2c/i2c-core.c                         |   12 ++---
 drivers/infiniband/hw/cxgb4/cm.c               |    5 +-
 drivers/infiniband/hw/mlx4/cm.c                |    2=20
 drivers/iommu/io-pgtable-arm-v7s.c             |    3 -
 drivers/leds/leds-lp55xx-common.c              |    4 -
 drivers/md/bcache/sysfs.c                      |   17 ++++++-
 drivers/md/bcache/sysfs.h                      |   13 ++++-
 drivers/md/dm-thin.c                           |   13 +++++
 drivers/media/i2c/mt9m111.c                    |    2=20
 drivers/media/platform/mx2_emmaprp.c           |    6 +-
 drivers/media/platform/s5p-g2d/g2d.c           |    6 +-
 drivers/media/platform/s5p-jpeg/jpeg-core.c    |   57 +++++++++++++-------=
-----
 drivers/media/platform/sh_veu.c                |    4 -
 drivers/mmc/host/omap.c                        |    2=20
 drivers/net/ethernet/cisco/enic/enic_main.c    |    6 +-
 drivers/net/ethernet/intel/e1000e/netdev.c     |   19 +++-----
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c |    4 -
 drivers/net/wireless/ath/wil6210/cfg80211.c    |   14 ++++--
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c   |   11 +++-
 drivers/net/wireless/mediatek/mt7601u/eeprom.h |    2=20
 drivers/net/wireless/ti/wlcore/main.c          |    7 ++-
 drivers/regulator/act8865-regulator.c          |    5 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c          |   10 ++++
 drivers/scsi/megaraid/megaraid_sas_base.c      |    1=20
 drivers/scsi/scsi_scan.c                       |    6 +-
 drivers/soc/qcom/qcom_gsbi.c                   |    7 ++-
 drivers/soc/tegra/fuse/fuse-tegra.c            |   12 +++--
 drivers/tty/serial/atmel_serial.c              |   43 ++++++++++++++----
 drivers/tty/tty_buffer.c                       |    2=20
 drivers/usb/chipidea/core.c                    |    9 +++
 drivers/usb/gadget/function/f_fs.c             |    1=20
 drivers/video/fbdev/core/fbmem.c               |    3 +
 fs/buffer.c                                    |    7 +++
 fs/cifs/cifs_dfs_ref.c                         |    4 -
 fs/cifs/connect.c                              |    5 ++
 fs/cifs/file.c                                 |   14 +++++-
 fs/cifs/smb1ops.c                              |    2=20
 fs/ext4/indirect.c                             |   47 +++++++++-----------
 fs/f2fs/trace.c                                |    8 +++
 fs/file.c                                      |    1=20
 fs/jbd2/commit.c                               |    6 +-
 fs/ocfs2/cluster/nodemanager.c                 |   14 +++---
 fs/read_write.c                                |    6 ++
 include/linux/irqdesc.h                        |    1=20
 include/linux/relay.h                          |    2=20
 include/linux/ring_buffer.h                    |    2=20
 include/net/netfilter/br_netfilter.h           |    1=20
 kernel/irq/chip.c                              |   12 ++++-
 kernel/irq/internals.h                         |    8 +++
 kernel/irq/irqdesc.c                           |    7 ++-
 kernel/sysctl.c                                |    3 +
 kernel/trace/ring_buffer.c                     |    5 +-
 kernel/trace/trace.c                           |    6 +-
 kernel/trace/trace_kdb.c                       |    6 +-
 lib/bsearch.c                                  |    2=20
 lib/int_sqrt.c                                 |    6 --
 lib/raid6/Makefile                             |    2=20
 mm/cma.c                                       |    4 +
 mm/mempolicy.c                                 |   18 ++++++-
 mm/page_ext.c                                  |    1=20
 mm/slab.c                                      |   17 +++----
 mm/vmalloc.c                                   |    6 ++
 net/bridge/br_netfilter_hooks.c                |    5 --
 net/netfilter/xt_physdev.c                     |    9 +++
 security/selinux/hooks.c                       |    9 +++
 sound/core/pcm_native.c                        |    8 +++
 sound/soc/fsl/fsl-asoc-card.c                  |    1=20
 sound/soc/fsl/imx-sgtl5000.c                   |    1=20
 tools/lib/traceevent/event-parse.c             |    2=20
 tools/perf/tests/evsel-tp-sched.c              |    6 +-
 106 files changed, 536 insertions(+), 265 deletions(-)

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

Ard Biesheuvel (1):
      efi/memattr: Don't bail on zero VA if it equals the region's PA

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

Ezequiel Garcia (4):
      media: sh_veu: Correct return type for mem2mem buffer helpers
      media: s5p-jpeg: Correct return type for mem2mem buffer helpers
      media: s5p-g2d: Correct return type for mem2mem buffer helpers
      media: mx2_emmaprp: Correct return type for mem2mem buffer helpers

Florian Fainelli (2):
      e1000e: Fix -Wformat-truncation warnings
      mlxsw: spectrum: Avoid -Wformat-truncation warnings

Florian Westphal (1):
      netfilter: physdev: relax br_netfilter dependency

George Rimar (1):
      x86/build: Specify elf_i386 linker emulation explicitly for i386 obje=
cts

Greg Kroah-Hartman (1):
      Linux 4.9.168

Guenter Roeck (1):
      cdrom: Fix race condition in cdrom_sysctl_register

Hans de Goede (2):
      ACPI / video: Refactor and fix dmi_is_desktop()
      ACPI / video: Extend chassis-type detection with a "Lunch Box" check

Hong Liu (1):
      HID: intel-ish-hid: avoid binding wrong ishtp_cl_device

H=E5kon Bugge (1):
      IB/mlx4: Increase the timeout for CM cache

Jason Cai (Xiang Feng) (1):
      dm thin: add sanity checks to thin-pool and external snapshot creation

Jason Yan (1):
      scsi: megaraid_sas: return error when create DMA pool failed

Jeremy Compostella (1):
      i2c: core-smbus: prevent stack corruption on read I2C_BLOCK_DATA

Jia Guo (1):
      ocfs2: fix a panic problem caused by o2cb_ctl

John Garry (1):
      scsi: hisi_sas: Set PHY linkrate when disconnected

John Stultz (1):
      usb: f_fs: Avoid crash due to out-of-scope stack ptr access

Julia Lawall (1):
      crypto: crypto4xx - add missing of_node_put after of_device_is_availa=
ble

Konstantin Khlebnikov (1):
      e1000e: fix cyclic resets at link up with active tx

Louis Taylor (1):
      cifs: use correct format characters

Luc Van Oostenryck (1):
      include/linux/relay.h: fix percpu annotation in struct rchan

Manfred Schlaegl (2):
      fbdev: fbmem: fix memory access if logo is bigger than the screen
      tty: increase the default flip buffer limit to 2*640K

Masahiro Yamada (1):
      h8300: use cc-cross-prefix instead of hardcoding h8300-unknown-linux-

Mathieu Malaterre (1):
      ARM: dts: lpc32xx: Remove leading 0x and 0s from bindings notation

Michal Kazior (1):
      leds: lp55xx: fix null deref on firmware load failure

Nathan Chancellor (1):
      ARM: 8833/1: Ensure that NEON code always compiles with Clang

Nathan Fontenot (1):
      powerpc/pseries: Perform full re-add of CPU for topology update post-=
migration

Nicolas Boichat (1):
      iommu/io-pgtable-arm-v7s: Only kmemleak_ignore L2 tables

Ondrej Mosnacek (1):
      selinux: do not override context on context mounts

Paul Kocialkowski (1):
      usb: chipidea: Grab the (legacy) USB PHY by phandle first

Pawe? Chmiel (1):
      media: s5p-jpeg: Check for fmt_ver_flag when doing fmt enumeration

Peng Fan (1):
      mm/cma.c: cma_declare_contiguous: correct err handling

Peter Zijlstra (1):
      lib/int_sqrt: optimize initial value compute

Qian Cai (2):
      mm/page_ext.c: fix an imbalance with kmemleak
      mm/slab.c: kmemleak no scan alien caches

Rafael =C1vila de Esp=EDndola (1):
      x86/build: Mark per-CPU symbols as absolute explicitly for LLD

Raju Rangoju (1):
      iw_cxgb4: fix srqidx leak during connection abort

Ranjani Sridharan (1):
      ALSA: PCM: check if ops are defined before suspending PCM

Razvan Stefanescu (2):
      tty/serial: atmel: Add is_half_duplex helper
      tty/serial: atmel: RS485 HD w/DMA: enable RX after TX is stopped

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

Shunyong Yang (1):
      dmaengine: qcom_hidma: assign channel cookie correctly

Shuriyc Chu (1):
      fs/file.c: initialize init_files.resize_wait

Song Hongyan (1):
      HID: intel-ish: ipc: handle PIMR before ish_wakeup also clear PISR bu=
sy_clear bit

Stanislaw Gruszka (1):
      mt7601u: bump supported EEPROM version

Thomas Gleixner (1):
      genirq: Avoid summation loops for /proc/stat

Thomas Richter (1):
      perf test: Fix failure of 'evsel-tp-sched' test on s390

Timo Alho (1):
      soc/tegra: fuse: Fix illegal free of IO base address

Tony Jones (1):
      tools lib traceevent: Fix buffer overflow in arg_eval

Uladzislau Rezki (Sony) (1):
      mm/vmalloc.c: fix kernel BUG at mm/vmalloc.c:512!

Ville Syrj=E4l=E4 (1):
      drm/dp/mst: Configure no_stop_bit correctly for remote i2c xfers

Wen Yang (1):
      SoC: imx-sgtl5000: add missing put_device()

Will Deacon (2):
      arm64: debug: Don't propagate UNKNOWN FAR into si_code for debug sign=
als
      arm64: debug: Ensure debug handlers check triggering exception level

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


--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAly00KcACgkQONu9yGCS
aT5l1w/6ApzLBqHG1UqcmB9YwwUID0LunCRjb/724R30i9WwQ9/ELcSRRZWHuWi7
y21eLEuVnOjFgEQAv5zMPn/9rP96k9WrU1gjOACrHCRh6xFZGuyhdD+JKMX/3TY2
MM7L4Q74ldR1Lldo43MulhhAq9vEUXnVcBdM3/bGQQ/1AKnj4uN13OVhWGVSNui4
/peqloF9IscvpHwBAvx2XKaLa4BqwVBDvloD7KOEifyZ12UaScryr35f58wLtWUN
IRvH8aGrkD9VEAONST/xin1R9SmfWPoWRyIRwUZZtH10vrw0LEglicIr2M7rQoNj
d3Pi789XJpnFptDGmU8TSso7kh6xPlEpHUXabIePI24W9ghLuonRBDtzsGhZjBL1
5hWrNUwTq8yMj9spsBBLzlTHVBmhSQ4FRQxKLCBmMpTBIOQSfW3p82zmHdtAcMDw
Bo7JZO5XGMzbCovNsv5mvFsG7dvevMw1HDwbNSrpNRuRh7zxtRFGRaluwvej5x8g
N7GcfPATmOeTjg0mKUuCke3x7PutpwVxq6pgMWVLyO98lBy4AuNcSUc7489mwvaN
IGBqZAta4iy8Melq5FenuF88RuO3z4wntaoHqveQKjJ8k5uemg5Fo06LiGQc+HHX
bOZZlK3X4ylpp4a2gfNcS3bIl/zYhtAdMS6SOmhzTYHOEoCG7HE=
=fv/b
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
