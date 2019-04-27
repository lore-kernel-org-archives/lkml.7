Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87ACEC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378482087F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556368982;
	bh=gpZCm7EnCApkLLtt4T0d4HdabkQ9oVClETNYa7Fadjs=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=AhWTxrA78Tc5jov0Q5Hs+DjZZlMkqJjUaG06yyBnIc/k4+Vv02Psa/ltNK0eSAKVf
	 RPFAenv2CsJBQdgRc32E69OjBHxRTkcjRR+YeLGsCYAb7VcFnS1EJRGoIYj8tcE/N7
	 yEnyLtFT/yH3KfwEtKeKqexuuKWwEv6B8Tbp/jMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfD0MnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:43:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD0MnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:43:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 275A62087F;
        Sat, 27 Apr 2019 12:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556368978;
        bh=gpZCm7EnCApkLLtt4T0d4HdabkQ9oVClETNYa7Fadjs=;
        h=Date:From:To:Cc:Subject:From;
        b=wYQDTX/y5l/srGiFjNTpBse8O2RR+WLuGRZv3OjXgE/o2hufYOzkZF8xbvklOeb+r
         ABvg37zYRTM3W51q6O3Jjjoee28ujtNfDkpIkKQGcKfcb2i2+hhUBlnTtdguMvLFHd
         vjiaiA3iAk1sfoJjRK94T8iqSAThwTCjMovyZ/oA=
Date:   Sat, 27 Apr 2019 14:42:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.179
Message-ID: <20190427124256.GA6920@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 4.4.179 kernel.

All users of the 4.4 kernel series must upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.4.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/arm/kernel_mode_neon.txt            |    4 
 Makefile                                          |    6 
 arch/arm/boot/dts/sama5d2-pinfunc.h               |    2 
 arch/arm/crypto/sha256-armv4.pl                   |    3 
 arch/arm/crypto/sha256-core.S_shipped             |    3 
 arch/arm/crypto/sha512-armv4.pl                   |    3 
 arch/arm/crypto/sha512-core.S_shipped             |    3 
 arch/arm/include/asm/barrier.h                    |    2 
 arch/arm/include/asm/processor.h                  |    6 
 arch/arm/kernel/machine_kexec.c                   |    5 
 arch/arm/kernel/patch.c                           |    6 
 arch/arm/kernel/smp.c                             |    4 
 arch/arm/kernel/unwind.c                          |   14 +-
 arch/arm/lib/Makefile                             |    2 
 arch/arm/lib/xor-neon.c                           |    2 
 arch/arm/mach-omap2/prm_common.c                  |    4 
 arch/arm/plat-samsung/Kconfig                     |    2 
 arch/arm64/include/asm/futex.h                    |   14 +-
 arch/arm64/kernel/kgdb.c                          |   15 +-
 arch/arm64/mm/fault.c                             |    9 -
 arch/h8300/Makefile                               |    2 
 arch/x86/boot/Makefile                            |    2 
 arch/x86/crypto/poly1305-avx2-x86_64.S            |   14 +-
 arch/x86/crypto/poly1305-sse2-x86_64.S            |   22 ++-
 arch/x86/entry/vdso/Makefile                      |   22 +--
 arch/x86/include/asm/xen/hypercall.h              |    3 
 arch/x86/kernel/cpu/cyrix.c                       |   14 +-
 arch/x86/kernel/hpet.c                            |    2 
 arch/x86/kernel/hw_breakpoint.c                   |    1 
 arch/x86/kernel/kprobes/core.c                    |   26 ++++
 arch/x86/kernel/vmlinux.lds.S                     |    2 
 arch/x86/kvm/emulate.c                            |   21 +--
 arch/x86/realmode/rm/Makefile                     |    2 
 arch/xtensa/kernel/stacktrace.c                   |    6 
 block/bio.c                                       |    5 
 crypto/testmgr.h                                  |   44 ++++++
 drivers/acpi/sbs.c                                |    8 -
 drivers/cdrom/cdrom.c                             |    7 -
 drivers/char/Kconfig                              |    2 
 drivers/char/hpet.c                               |    2 
 drivers/char/hw_random/virtio-rng.c               |    2 
 drivers/char/tpm/tpm_crb.c                        |   22 ++-
 drivers/char/tpm/tpm_i2c_atmel.c                  |   10 +
 drivers/crypto/amcc/crypto4xx_alg.c               |    3 
 drivers/crypto/amcc/crypto4xx_core.c              |    9 +
 drivers/dma/imx-dma.c                             |    2 
 drivers/dma/tegra20-apb-dma.c                     |    5 
 drivers/gpio/gpio-omap.c                          |   14 +-
 drivers/gpu/drm/drm_dp_mst_topology.c             |    1 
 drivers/hwtracing/coresight/coresight-etm4x.c     |    3 
 drivers/i2c/i2c-core.c                            |   12 -
 drivers/iio/accel/kxcjk-1013.c                    |    2 
 drivers/iio/adc/ad_sigma_delta.c                  |    1 
 drivers/iio/adc/at91_adc.c                        |   28 ++--
 drivers/iio/gyro/bmg160_core.c                    |    6 
 drivers/infiniband/hw/mlx4/alias_GUID.c           |    2 
 drivers/infiniband/hw/mlx4/cm.c                   |    2 
 drivers/iommu/dmar.c                              |    2 
 drivers/iommu/intel-iommu.c                       |    3 
 drivers/leds/leds-lp55xx-common.c                 |    4 
 drivers/md/bcache/sysfs.c                         |   17 ++
 drivers/md/bcache/sysfs.h                         |   13 +-
 drivers/md/dm-thin.c                              |   13 ++
 drivers/media/i2c/soc_camera/mt9m111.c            |    2 
 drivers/media/platform/mx2_emmaprp.c              |    6 
 drivers/media/platform/s5p-g2d/g2d.c              |    6 
 drivers/media/platform/s5p-jpeg/jpeg-core.c       |   57 ++++----
 drivers/media/platform/sh_veu.c                   |    4 
 drivers/mmc/host/davinci_mmc.c                    |    2 
 drivers/mmc/host/omap.c                           |    2 
 drivers/net/bonding/bond_main.c                   |    6 
 drivers/net/ethernet/cisco/enic/enic_main.c       |    6 
 drivers/net/ethernet/intel/e1000e/netdev.c        |    4 
 drivers/net/usb/qmi_wwan.c                        |    1 
 drivers/net/wireless/mediatek/mt7601u/eeprom.h    |    2 
 drivers/net/wireless/rsi/rsi_common.h             |    1 
 drivers/net/wireless/ti/wlcore/main.c             |    7 -
 drivers/pci/quirks.c                              |    2 
 drivers/regulator/act8865-regulator.c             |    5 
 drivers/scsi/megaraid/megaraid_sas_base.c         |    1 
 drivers/scsi/scsi_scan.c                          |    6 
 drivers/soc/qcom/qcom_gsbi.c                      |    7 -
 drivers/soc/tegra/fuse/fuse-tegra.c               |   12 +
 drivers/staging/comedi/drivers/ni_usb6501.c       |   10 -
 drivers/staging/comedi/drivers/vmk80xx.c          |    8 -
 drivers/thermal/int340x_thermal/int3400_thermal.c |   21 ++-
 drivers/tty/Kconfig                               |   23 +++
 drivers/tty/serial/atmel_serial.c                 |   43 ++++--
 drivers/tty/serial/xilinx_uartps.c                |    2 
 drivers/tty/tty_buffer.c                          |    2 
 drivers/tty/tty_io.c                              |    3 
 drivers/tty/tty_ldisc.c                           |   47 +++++++
 drivers/usb/chipidea/core.c                       |    9 +
 drivers/video/fbdev/core/fbmem.c                  |    3 
 fs/9p/v9fs.c                                      |   21 +++
 fs/9p/v9fs.h                                      |    1 
 fs/9p/vfs_dir.c                                   |    8 -
 fs/9p/vfs_file.c                                  |    6 
 fs/binfmt_elf.c                                   |    2 
 fs/buffer.c                                       |    7 +
 fs/cifs/cifs_dfs_ref.c                            |    4 
 fs/cifs/connect.c                                 |    5 
 fs/cifs/file.c                                    |   14 ++
 fs/cifs/inode.c                                   |   69 +++++-----
 fs/cifs/smb1ops.c                                 |    2 
 fs/cifs/smb2maperror.c                            |    3 
 fs/ext4/indirect.c                                |   47 +++----
 fs/ext4/ioctl.c                                   |    7 +
 fs/ext4/resize.c                                  |   17 ++
 fs/f2fs/super.c                                   |   34 +++++
 fs/f2fs/trace.c                                   |    8 +
 fs/file.c                                         |    1 
 fs/ocfs2/cluster/nodemanager.c                    |   14 +-
 fs/overlayfs/dir.c                                |   13 +-
 include/linux/atalk.h                             |   20 ++-
 include/linux/bitrev.h                            |   36 ++---
 include/linux/kprobes.h                           |    1 
 include/linux/ring_buffer.h                       |    2 
 include/linux/string.h                            |    3 
 include/linux/swap.h                              |    4 
 include/net/net_namespace.h                       |    1 
 include/net/netfilter/br_netfilter.h              |    1 
 include/net/netns/hash.h                          |   15 --
 kernel/events/core.c                              |    2 
 kernel/irq/chip.c                                 |    4 
 kernel/kprobes.c                                  |    6 
 kernel/locking/lockdep.c                          |    3 
 kernel/sched/fair.c                               |   31 ++++
 kernel/sysctl.c                                   |    4 
 kernel/trace/ftrace.c                             |    6 
 kernel/trace/ring_buffer.c                        |    5 
 kernel/trace/trace.c                              |    6 
 kernel/trace/trace_kdb.c                          |    6 
 lib/bsearch.c                                     |    2 
 lib/div64.c                                       |    4 
 lib/int_sqrt.c                                    |    6 
 lib/raid6/Makefile                                |    2 
 lib/string.c                                      |   20 +++
 mm/cma.c                                          |    4 
 mm/mempolicy.c                                    |    8 -
 mm/page_ext.c                                     |    1 
 mm/slab.c                                         |   17 +-
 mm/vmalloc.c                                      |    6 
 mm/vmstat.c                                       |    5 
 net/9p/protocol.c                                 |    3 
 net/appletalk/atalk_proc.c                        |    2 
 net/appletalk/ddp.c                               |   37 ++++-
 net/appletalk/sysctl_net_atalk.c                  |    5 
 net/atm/lec.c                                     |    6 
 net/bluetooth/hci_sock.c                          |    3 
 net/bridge/br_multicast.c                         |    4 
 net/bridge/br_netfilter_hooks.c                   |    5 
 net/core/ethtool.c                                |   29 ++--
 net/core/net_namespace.c                          |    1 
 net/ipv4/fou.c                                    |    4 
 net/ipv4/route.c                                  |   16 ++
 net/ipv4/tcp_dctcp.c                              |   36 ++---
 net/ipv4/tcp_input.c                              |   10 -
 net/ipv6/ip6_output.c                             |    4 
 net/ipv6/ip6_tunnel.c                             |    4 
 net/ipv6/sit.c                                    |    4 
 net/mac80211/driver-ops.h                         |    3 
 net/netfilter/xt_physdev.c                        |    9 +
 net/openvswitch/flow_netlink.c                    |    4 
 net/rds/tcp.c                                     |    2 
 net/sctp/protocol.c                               |    1 
 scripts/mod/file2alias.c                          |  141 +++++++---------------
 security/device_cgroup.c                          |    2 
 sound/core/info.c                                 |   12 +
 sound/core/init.c                                 |   18 +-
 sound/core/pcm_native.c                           |    8 +
 sound/core/seq/seq_clientmgr.c                    |    6 
 sound/drivers/opl3/opl3_voice.h                   |    2 
 sound/isa/sb/sb8.c                                |    4 
 sound/pci/echoaudio/echoaudio.c                   |    5 
 sound/soc/fsl/fsl-asoc-card.c                     |    1 
 sound/soc/fsl/fsl_esai.c                          |   47 +++++--
 sound/soc/fsl/imx-sgtl5000.c                      |    1 
 tools/lib/traceevent/event-parse.c                |    2 
 tools/perf/builtin-top.c                          |    5 
 tools/perf/tests/evsel-tp-sched.c                 |    7 -
 tools/perf/tests/openat-syscall-all-cpus.c        |    4 
 tools/perf/util/evsel.c                           |    1 
 tools/power/x86/turbostat/turbostat.c             |    3 
 184 files changed, 1194 insertions(+), 583 deletions(-)

Aaro Koskinen (1):
      mmc: omap: fix the maximum timeout setting

Aditya Pakki (1):
      x86/hpet: Prevent potential NULL pointer dereference

Akinobu Mita (1):
      media: mt9m111: set initial frame size other than 0x0

Alexey Khoroshilov (1):
      soc: qcom: gsbi: Fix error handling in gsbi_probe()

Alistair Strachan (1):
      x86: vdso: Use $LD instead of $CC to link

Anders Roxell (1):
      dmaengine: imx-dma: fix warning comparison of distinct pointer types

Andre Przywara (1):
      PCI: Add function 1 DMA alias quirk for Marvell 9170 SATA controller

Andrea Righi (2):
      kprobes: Prohibit probing on bsearch()
      openvswitch: fix flow actions reallocation

Ard Biesheuvel (2):
      crypto: sha256/arm - fix crash bug in Thumb2 build
      crypto: sha512/arm - fix crash bug in Thumb2 build

Arnaldo Carvalho de Melo (1):
      perf evsel: Free evsel->counts in perf_evsel__exit()

Arnd Bergmann (4):
      enic: fix build warning without CONFIG_CPUMASK_OFFSTACK
      include/linux/bitrev.h: fix constant bitrev
      mmc: davinci: remove extraneous __init annotation
      appletalk: Fix compile regression

Aurelien Aptel (1):
      CIFS: fix POSIX lock leak and invalid ptr deref

Axel Lin (1):
      regulator: act8865: Fix act8600_sudcdc_voltage_ranges setting

Bartlomiej Zolnierkiewicz (1):
      ARM: samsung: Limit SAMSUNG_PM_CHECK config option to non-Exynos platforms

Ben Dooks (1):
      dmaengine: tegra: avoid overflow of byte tracking

Benjamin Block (1):
      scsi: core: replace GFP_ATOMIC with GFP_KERNEL in scsi_scan.c

Bjørn Mork (1):
      qmi_wwan: add Olicard 600

Buland Singh (1):
      hpet: Fix missing '=' character in the __setup() code of hpet_mmap_enable

Carlos Maiolino (1):
      fs: fix guard_bio_eod to check for real EOD errors

Changbin Du (3):
      perf top: Fix error handling in cmd_top()
      perf tests: Fix a memory leak of cpu_map object in the openat_syscall_event_on_all_cpus test
      perf tests: Fix a memory leak in test__perf_evsel__tp_sched_test()

Chao Yu (1):
      f2fs: fix to do sanity check with current segment number

Christian Brauner (1):
      sysctl: handle overflow for file-max

Christian Lamparter (1):
      crypto: crypto4xx - properly set IV after de- and encrypt

Colin Ian King (1):
      ALSA: opl3: fix mismatch between snd_opl3_drum_switch definition and declaration

Coly Li (3):
      bcache: fix input overflow to cache set sysfs file io_error_halflife
      bcache: fix input overflow to sequential_cutoff
      bcache: improve sysfs_strtoul_clamp()

Dan Carpenter (1):
      xen: Prevent buffer overflow in privcmd ioctl

Darrick J. Wong (1):
      ext4: prohibit fstrim in norecovery mode

David Arcari (1):
      tools/power turbostat: return the exit status of a command

David Engraf (1):
      ARM: dts: at91: Fix typo in ISC_D0 on PC9

David Tolnay (1):
      hwrng: virtio - Avoid repeated init of completion

Dinu-Razvan Chis-Serban (1):
      9p locks: add mount option for lock retry interval

Douglas Anderson (1):
      tracing: kdb: Fix ftdump to not sleep

Dragos Bogdan (1):
      iio: ad_sigma_delta: select channel when reading register

Eric Biggers (1):
      crypto: x86/poly1305 - fix overflow during partial reduction

Eric Dumazet (3):
      netns: provide pure entropy for net_hash_mix()
      tcp: tcp_grow_window() needs to respect tcp_space()
      ipv4: ensure rcu_read_lock() in ipv4_link_failure()

Ezequiel Garcia (4):
      media: sh_veu: Correct return type for mem2mem buffer helpers
      media: s5p-jpeg: Correct return type for mem2mem buffer helpers
      media: s5p-g2d: Correct return type for mem2mem buffer helpers
      media: mx2_emmaprp: Correct return type for mem2mem buffer helpers

Felix Fietkau (1):
      mac80211: do not call driver wake_tx_queue op during reconfig

Florian Fainelli (1):
      e1000e: Fix -Wformat-truncation warnings

Florian Westphal (1):
      netfilter: physdev: relax br_netfilter dependency

Georg Ottinger (1):
      iio: adc: at91: disable adc channel interrupt in timeout case

George Rimar (1):
      x86/build: Specify elf_i386 linker emulation explicitly for i386 objects

Gertjan Halkes (1):
      9p: do not trust pdu content for stat item size

Greg Kroah-Hartman (4):
      tty: mark Siemens R3964 line discipline as BROKEN
      tty: ldisc: add sysctl to prevent autoloading of ldiscs
      Revert "locking/lockdep: Add debug_locks check in __lock_downgrade()"
      Linux 4.4.179

Guenter Roeck (1):
      cdrom: Fix race condition in cdrom_sysctl_register

Gustavo A. R. Silva (1):
      net: atm: Fix potential Spectre v1 vulnerabilities

Håkon Bugge (1):
      IB/mlx4: Increase the timeout for CM cache

Ian Abbott (4):
      staging: comedi: vmk80xx: Fix use of uninitialized semaphore
      staging: comedi: vmk80xx: Fix possible double-free of ->usb_rx_buf
      staging: comedi: ni_usb6501: Fix use of uninitialized mutex
      staging: comedi: ni_usb6501: Fix possible double-free of ->usb_rx_buf

Jack Morgenstein (1):
      IB/mlx4: Fix race condition between catas error reset and aliasguid flows

Jann Horn (1):
      device_cgroup: fix RCU imbalance in error case

Jarkko Sakkinen (2):
      tpm/tpm_crb: Avoid unaligned reads in crb_recv()
      tpm/tpm_i2c_atmel: Return -E2BIG when the transfer is incomplete

Jason Cai (Xiang Feng) (1):
      dm thin: add sanity checks to thin-pool and external snapshot creation

Jason Yan (1):
      scsi: megaraid_sas: return error when create DMA pool failed

Jeremy Compostella (1):
      i2c: core-smbus: prevent stack corruption on read I2C_BLOCK_DATA

Jia Guo (1):
      ocfs2: fix a panic problem caused by o2cb_ctl

Julia Cartwright (1):
      iommu/dmar: Fix buffer overflow during PCI bus notification

Junwei Hu (1):
      ipv6: Fix dangling pointer when ipv6 fragment

Jérôme Glisse (1):
      block: do not leak memory in bio_copy_user_iov()

Kangjie Lu (2):
      ALSA: echoaudio: add a check for ioremap_nocache
      ALSA: sb8: add a check for request_region

Koen De Schepper (1):
      tcp: Ensure DCTCP reacts to losses

Konstantin Khlebnikov (1):
      mm/vmstat.c: fix /proc/vmstat format for CONFIG_DEBUG_TLBFLUSH=y CONFIG_SMP=n

Li RongQing (1):
      net: ethtool: not call vzalloc for zero sized memory request

Linus Torvalds (1):
      binfmt_elf: switch to new creds when switching to new mm

Lorenzo Bianconi (2):
      ipv6: sit: reset ip header pointer in ipip6_rcv
      net: fou: do not use guehdr after iptunnel_pull_offloads in gue_udp_recv

Louis Taylor (1):
      cifs: use correct format characters

Lu Baolu (1):
      iommu/vt-d: Check capability before disabling protected memory

Lukas Czerner (2):
      ext4: add missing brelse() in add_new_gdb_meta_bg()
      ext4: report real fs size after failed resize

Manfred Schlaegl (2):
      fbdev: fbmem: fix memory access if logo is bigger than the screen
      tty: increase the default flip buffer limit to 2*640K

Mao Wenan (1):
      net: rds: force to destroy connection if t_sock is NULL in rds_tcp_kill_sock().

Masahiro Yamada (3):
      h8300: use cc-cross-prefix instead of hardcoding h8300-unknown-linux-
      modpost: file2alias: go back to simple devtable lookup
      modpost: file2alias: check prototype of handler

Masami Hiramatsu (3):
      x86/kprobes: Verify stack frame on kretprobe
      kprobes: Mark ftrace mcount handler functions nokprobe
      kprobes: Fix error check when reusing optimized probes

Matthew Garrett (2):
      thermal/int340x_thermal: Add additional UUIDs
      thermal/int340x_thermal: fix mode setting

Matthew Whitehead (1):
      x86/cpu/cyrix: Use correct macros for Cyrix calls on Geode processors

Matthias Kaehlcke (1):
      Revert "kbuild: use -Oz instead of -Os when using clang"

Max Filippov (1):
      xtensa: fix return_address

Mel Gorman (1):
      sched/fair: Do not re-read ->h_load_next during hierarchical load calculation

Michal Kazior (1):
      leds: lp55xx: fix null deref on firmware load failure

Michal Simek (1):
      serial: uartps: console_setup() can't be placed to init section

Mike Looijmans (1):
      iio/gyro/bmg160: Use millidegrees for temperature scale

Miklos Szeredi (1):
      ovl: fix uid/gid when creating over whiteout

Myungho Jung (1):
      Bluetooth: Fix decrementing reference count twice in releasing socket

Nathan Chancellor (3):
      ARM: 8833/1: Ensure that NEON code always compiles with Clang
      x86/hw_breakpoints: Make default case in hw_breakpoint_arch_parse() return an error
      arm64: futex: Restore oldval initialization to work around buggy compilers

Nick Desaulniers (3):
      kbuild: clang: choose GCC_TOOLCHAIN_DIR not on LD
      x86/vdso: Drop implicit common-page-size linker flag
      lib/string.c: implement a basic bcmp

Nikolay Aleksandrov (1):
      net: bridge: multicast: use rcu to access port list from br_multicast_start_querier

Paul Kocialkowski (1):
      usb: chipidea: Grab the (legacy) USB PHY by phandle first

Pawe? Chmiel (1):
      media: s5p-jpeg: Check for fmt_ver_flag when doing fmt enumeration

Peng Fan (1):
      mm/cma.c: cma_declare_contiguous: correct err handling

Peter Zijlstra (1):
      lib/int_sqrt: optimize initial value compute

Phil Auld (1):
      sched/fair: Limit sched_cfs_period_timer() loop to avoid hard lockup

Pi-Hsun Shih (1):
      include/linux/swap.h: use offsetof() instead of custom __swapoffset macro

Qian Cai (2):
      mm/page_ext.c: fix an imbalance with kmemleak
      mm/slab.c: kmemleak no scan alien caches

Rafael Ávila de Espíndola (1):
      x86/build: Mark per-CPU symbols as absolute explicitly for LLD

Ranjani Sridharan (1):
      ALSA: PCM: check if ops are defined before suspending PCM

Razvan Stefanescu (2):
      tty/serial: atmel: Add is_half_duplex helper
      tty/serial: atmel: RS485 HD w/DMA: enable RX after TX is stopped

Ronald Tschalär (1):
      ACPI / SBS: Fix GPE storm on recent MacBookPro's

Russell King (2):
      gpio: gpio-omap: fix level interrupt idling
      ARM: avoid Cortex-A9 livelock on tight dmb loops

S.j. Wang (1):
      ASoC: fsl_esai: fix channel swap issue when stream starts

Sabrina Dubroca (1):
      bonding: fix event handling for stacked bonds

Sahitya Tummala (1):
      f2fs: do not use mutex lock in atomic context

Sai Prakash Ranjan (1):
      coresight: etm4x: Add support to enable ETMv4.2

Sean Christopherson (1):
      KVM: x86: Don't clear EFER during SMM transitions for 32-bit vCPU

Sebastian Andrzej Siewior (1):
      ARM: 8840/1: use a raw_spinlock_t in unwind

Sheena Mira-ato (1):
      ip6_tunnel: Match to ARPHRD_TUNNEL6 for dev type

Shuriyc Chu (1):
      fs/file.c: initialize init_files.resize_wait

Siva Rebbagondla (1):
      rsi: improve kernel thread handling to fix kernel panic

Stanislaw Gruszka (2):
      mt7601u: bump supported EEPROM version
      lib/div64.c: off by one in shift

Stephane Eranian (1):
      perf/core: Restore mmap record type correctly

Stephen Boyd (1):
      genirq: Respect IRQCHIP_SKIP_SET_WAKE in irq_chip_set_wake_parent()

Stephen Suryaputra (1):
      ipv4: recompile ip options in ipv4_link_failure

Steve French (2):
      fix incorrect error code mapping for OBJECTID_NOT_FOUND
      cifs: fallback to older infolevels on findfirst queryinfo retry

Takashi Iwai (2):
      ALSA: core: Fix card races between register and disconnect
      ALSA: info: Fix racy addition/deletion of nodes

Thomas Richter (1):
      perf test: Fix failure of 'evsel-tp-sched' test on s390

Timo Alho (1):
      soc/tegra: fuse: Fix illegal free of IO base address

Tony Jones (1):
      tools lib traceevent: Fix buffer overflow in arg_eval

Uladzislau Rezki (Sony) (1):
      mm/vmalloc.c: fix kernel BUG at mm/vmalloc.c:512!

Ville Syrjälä (1):
      drm/dp/mst: Configure no_stop_bit correctly for remote i2c xfers

Wen Yang (1):
      SoC: imx-sgtl5000: add missing put_device()

Will Deacon (4):
      arm64: debug: Don't propagate UNKNOWN FAR into si_code for debug signals
      arm64: debug: Ensure debug handlers check triggering exception level
      arm64: futex: Fix FUTEX_WAKE_OP atomic ops with non-zero result value
      kernel/sysctl.c: fix out-of-bounds access when setting file-max

Xin Long (1):
      sctp: initialize _pad of sockaddr_in before copying to user memory

Yang Shi (2):
      mm: mempolicy: make mbind() return -EIO when MPOL_MF_STRICT is specified
      ARM: 8839/1: kprobe: make patch_lock a raw_spinlock_t

Yao Liu (1):
      cifs: Fix NULL pointer dereference of devname

YueHaibing (1):
      appletalk: Fix use-after-free in atalk_proc_exit

Zubin Mithra (1):
      ALSA: seq: Fix OOB-reads from strlcpy

Zumeng Chen (1):
      wlcore: Fix memory leak in case wl12xx_fetch_firmware failure

he, bo (1):
      io: accel: kxcjk1013: restore the range after resume.

wen yang (1):
      ASoC: fsl-asoc-card: fix object reference leaks in fsl_asoc_card_probe

zhangyi (F) (1):
      ext4: cleanup bh release code in ext4_ind_remove_space()

