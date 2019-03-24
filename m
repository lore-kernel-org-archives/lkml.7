Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C8BC10F11
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 08:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653D4218AC
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 08:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553417089;
	bh=wc5vmzRCMzDSl5LkcfBm24t2dSmVh5aWqWxbavCuSRE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=WWsLbb8+DvMTn0Jxdrb3zSCUzEYjWGnPnpJpIxesoA8gwog2EWekdyUlnamB8kbTw
	 v8/4FJO3MIWm4/Q5YSL5J33VkGmS0tTgcnFobXe0rle+//yf2nWT9TJXRCzhun1Ejx
	 /uDF36Llhru/V7RSWT0GWGzCgw2VQAjpPI2qxbXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfCXIos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 04:44:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbfCXIoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 04:44:46 -0400
Received: from localhost (unknown [89.248.140.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0C20213F2;
        Sun, 24 Mar 2019 08:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553417084;
        bh=wc5vmzRCMzDSl5LkcfBm24t2dSmVh5aWqWxbavCuSRE=;
        h=Date:From:To:Cc:Subject:From;
        b=ccJnGuNy248MIJPI3/yX+izWwRK6t37xE1FbhZc687n9HzvUpyzl7hFHaBQVLVK3E
         J4BIQxIl8uATE/1w1xoUxU0Bv9o8gCijbSfG91zeCeo8EN5NSs6tY0QMmPFI8Q8J85
         JuFUtZCxru6M3ZEEaUlU+CUxoXhqiGlnOuPhf22k=
Date:   Sun, 24 Mar 2019 09:44:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.165
Message-ID: <20190324084441.GA6165@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.165 kernel.

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

 Makefile                                            |    2=20
 arch/arc/include/asm/uaccess.h                      |    8=20
 arch/arc/lib/memcpy-archs.S                         |   14 -
 arch/arm/Kconfig                                    |    1=20
 arch/arm/include/asm/irq.h                          |    1=20
 arch/arm/kernel/irq.c                               |   62 -------
 arch/arm/kernel/smp.c                               |    2=20
 arch/arm/mach-omap2/display.c                       |    7=20
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c             |    8=20
 arch/arm64/crypto/aes-ce-ccm-core.S                 |    5=20
 arch/arm64/kernel/head.S                            |    3=20
 arch/m68k/Makefile                                  |    5=20
 arch/powerpc/kernel/entry_32.S                      |    9 +
 arch/powerpc/kernel/process.c                       |    2=20
 arch/powerpc/kernel/ptrace.c                        |   10 -
 arch/powerpc/platforms/83xx/suspend-asm.S           |   34 +++
 arch/powerpc/platforms/embedded6xx/wii.c            |    4=20
 arch/powerpc/platforms/powernv/opal-msglog.c        |    2=20
 arch/x86/kvm/vmx.c                                  |   17 +
 arch/x86/kvm/x86.c                                  |    1=20
 crypto/ahash.c                                      |   42 ++--
 crypto/pcbc.c                                       |   14 -
 crypto/shash.c                                      |   18 +-
 drivers/acpi/device_sysfs.c                         |    6=20
 drivers/acpi/nfit/core.c                            |   14 -
 drivers/base/power/wakeup.c                         |    8=20
 drivers/block/floppy.c                              |    2=20
 drivers/clk/clk-twl6040.c                           |   53 +++++-
 drivers/clk/ingenic/cgu.c                           |   10 -
 drivers/clk/ingenic/cgu.h                           |    2=20
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c                |    4=20
 drivers/clocksource/exynos_mct.c                    |   23 +-
 drivers/cpufreq/pxa2xx-cpufreq.c                    |    4=20
 drivers/cpufreq/tegra124-cpufreq.c                  |    2=20
 drivers/crypto/caam/caamalg.c                       |    1=20
 drivers/gpu/drm/i915/i915_gem.c                     |    3=20
 drivers/gpu/drm/radeon/evergreen_cs.c               |    1=20
 drivers/gpu/ipu-v3/ipu-common.c                     |    8=20
 drivers/hwtracing/intel_th/gth.c                    |    4=20
 drivers/hwtracing/stm/core.c                        |   11 -
 drivers/i2c/busses/i2c-cadence.c                    |    9 -
 drivers/i2c/busses/i2c-tegra.c                      |    2=20
 drivers/iio/adc/exynos_adc.c                        |    2=20
 drivers/input/keyboard/cap11xx.c                    |   35 +---
 drivers/input/keyboard/matrix_keypad.c              |    2=20
 drivers/input/keyboard/st-keyscan.c                 |    4=20
 drivers/md/bcache/writeback.h                       |    3=20
 drivers/md/raid10.c                                 |    2=20
 drivers/md/raid5.c                                  |    2=20
 drivers/media/usb/uvc/uvc_video.c                   |    8=20
 drivers/media/v4l2-core/videobuf2-v4l2.c            |    1=20
 drivers/net/ethernet/atheros/atlx/atl2.c            |    4=20
 drivers/net/ethernet/broadcom/bcmsysport.c          |    4=20
 drivers/net/ethernet/cavium/thunder/nic_main.c      |    2=20
 drivers/net/ethernet/cavium/thunder/nicvf_main.c    |   15 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c  |    2=20
 drivers/net/ethernet/marvell/mv643xx_eth.c          |    7=20
 drivers/net/ethernet/marvell/mvneta.c               |    2=20
 drivers/net/ethernet/netronome/nfp/nfp_bpf_jit.c    |   17 -
 drivers/net/usb/qmi_wwan.c                          |    4=20
 drivers/net/wireless/mac80211_hwsim.c               |    2=20
 drivers/net/wireless/marvell/libertas_tf/if_usb.c   |    2=20
 drivers/nvdimm/label.c                              |   23 ++
 drivers/nvdimm/namespace_devs.c                     |    4=20
 drivers/nvdimm/pfn_devs.c                           |    2=20
 drivers/parport/parport_pc.c                        |    2=20
 drivers/pinctrl/meson/pinctrl-meson8b.c             |    2=20
 drivers/regulator/s2mpa01.c                         |   10 -
 drivers/regulator/s2mps11.c                         |    6=20
 drivers/s390/block/dasd_eckd.c                      |    8=20
 drivers/s390/virtio/virtio_ccw.c                    |    4=20
 drivers/scsi/libiscsi.c                             |    6=20
 drivers/scsi/sd.c                                   |   59 +++++-
 drivers/scsi/virtio_scsi.c                          |    2=20
 drivers/spi/spi-pxa2xx.c                            |    1=20
 drivers/spi/spi-ti-qspi.c                           |    6=20
 drivers/target/iscsi/iscsi_target.c                 |    4=20
 drivers/tty/serial/8250/8250_of.c                   |    4=20
 drivers/tty/serial/8250/8250_pci.c                  |  175 +++++++++++++++=
++---
 drivers/tty/serial/xilinx_uartps.c                  |    8=20
 fs/9p/v9fs_vfs.h                                    |   23 ++
 fs/9p/vfs_file.c                                    |    6=20
 fs/9p/vfs_inode.c                                   |   23 +-
 fs/9p/vfs_inode_dotl.c                              |   27 +--
 fs/9p/vfs_super.c                                   |    4=20
 fs/btrfs/extent_io.c                                |    4=20
 fs/btrfs/volumes.c                                  |    4=20
 fs/cifs/file.c                                      |   12 -
 fs/cifs/smb2misc.c                                  |   17 +
 fs/cifs/smb2ops.c                                   |   15 +
 fs/devpts/inode.c                                   |    1=20
 fs/ext2/super.c                                     |   39 ++--
 fs/ext4/resize.c                                    |    3=20
 fs/jbd2/transaction.c                               |   33 ++-
 fs/nfs/pagelist.c                                   |   29 ++-
 fs/nfsd/nfs3proc.c                                  |   16 +
 fs/nfsd/nfs3xdr.c                                   |    1=20
 fs/nfsd/nfsctl.c                                    |    2=20
 fs/pipe.c                                           |   14 +
 fs/splice.c                                         |    4=20
 include/linux/device-mapper.h                       |    2=20
 include/linux/pipe_fs_i.h                           |    1=20
 include/linux/property.h                            |    2=20
 include/net/phonet/pep.h                            |    5=20
 kernel/rcu/tree.c                                   |   20 +-
 kernel/sysctl.c                                     |   11 +
 kernel/trace/trace.c                                |    1=20
 kernel/trace/trace_events_hist.c                    |    5=20
 lib/assoc_array.c                                   |    8=20
 mm/gup.c                                            |    3=20
 mm/memory-failure.c                                 |   14 -
 mm/page_alloc.c                                     |    8=20
 mm/shmem.c                                          |   12 -
 mm/vmalloc.c                                        |    2=20
 net/9p/client.c                                     |    2=20
 net/phonet/pep.c                                    |   32 +--
 sound/soc/fsl/fsl_esai.c                            |    7=20
 sound/soc/soc-topology.c                            |    8=20
 tools/perf/util/auxtrace.c                          |    4=20
 tools/perf/util/auxtrace.h                          |    3=20
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c |   37 +++-
 tools/perf/util/intel-pt.c                          |    2=20
 122 files changed, 918 insertions(+), 432 deletions(-)

Aditya Pakki (1):
      md: Fix failed allocation of md_register_thread

Adrian Hunter (4):
      perf intel-pt: Fix CYC timestamp calculation after OVF
      perf auxtrace: Define auxtrace record alignment
      perf intel-pt: Fix overlap calculation for padding
      perf intel-pt: Fix divide by zero when TSC is not available

Alexander Shishkin (2):
      stm class: Prevent division by zero
      intel_th: Don't reference unassigned outputs

Alexander Shiyan (1):
      gpu: ipu-v3: Fix i.MX51 CSI control registers offset

Alexey Khoroshilov (1):
      net: mv643xx_eth: disable clk on error path in mv643xx_eth_shared_pro=
be()

Andre Przywara (1):
      clk: sunxi: A31: Fix wrong AHB gate number

Andy Shevchenko (2):
      ACPI / device_sysfs: Avoid OF modalias creation for removed device
      spi: pxa2xx: Setup maximum supported DMA transfer length

Angelo Butti (1):
      8250: FIX Fourth port offset of Pericom PI7C9X7954 boards

Anoob Soman (1):
      scsi: libiscsi: Fix race between iscsi_xmit_task and iscsi_complete_t=
ask

Anssi Hannula (1):
      serial: uartps: Fix stuck ISR if RX disabled with non-empty FIFO

Ard Biesheuvel (1):
      crypto: arm64/aes-ccm - fix logical bug in AAD MAC handling

Arnd Bergmann (2):
      phonet: fix building with clang
      cpufreq: pxa2xx: remove incorrect __init annotation

Bard liao (1):
      ASoC: topology: free created components in tplg load error

Bart Van Assche (1):
      scsi: target/iscsi: Avoid iscsit_release_commands_from_conn() deadlock

Beniamino Galvani (1):
      qmi_wwan: apply SET_DTR quirk to Sierra WP7607

Christophe Leroy (3):
      powerpc/32: Clear on-stack exception marker upon exception return
      powerpc/wii: properly disable use of BATs when requested.
      powerpc/83xx: Also save/restore SPRG4-7 during suspend

Dan Williams (2):
      libnvdimm/label: Clear 'updating' flag after label-set update
      libnvdimm/pmem: Honor force_raw for legacy pmem regions

Daniel Axtens (1):
      bcache: never writeback a discard operation

Darrick J. Wong (2):
      tmpfs: fix link accounting when a tmpfile is linked in
      tmpfs: fix uninitialized return value in shmem_link

David Howells (1):
      assoc_array: Fix shortcut creation

Dexuan Cui (1):
      nfit: acpi_nfit_ctl(): Check out_obj->type in the right place

Dietmar Eggemann (1):
      ARM: 8824/1: fix a migrating irq bug when hotplug cpu

Dmitry Torokhov (2):
      Input: cap11xx - switch to using set_brightness_blocking()
      Input: matrix_keypad - use flush_delayed_work()

Eric Biggers (3):
      crypto: ahash - fix another early termination in hash walk
      crypto: hash - set CRYPTO_TFM_NEED_KEY if ->setkey() fails
      crypto: pcbc - remove bogus memcpy()s with src =3D=3D dest

Eugeniy Paltsev (1):
      ARCv2: lib: memcpy: fix doing prefetchw outside of buffer

Felipe Franciosi (1):
      scsi: virtio_scsi: don't send sc payload with tmfs

Filipe Manana (1):
      Btrfs: fix corruption reading shared and compressed extents after hol=
e punching

Finn Thain (1):
      m68k: Add -ffreestanding to CFLAGS

Florian Fainelli (1):
      net: systemport: Fix reception of BPDUs

Gabriel Fernandez (1):
      Input: st-keyscan - fix potential zalloc NULL dereference

Greg Kroah-Hartman (1):
      Linux 4.9.165

Gustavo A. R. Silva (2):
      ARM: s3c24xx: Fix boolean expressions in osiris_dvs_notify
      drm/radeon/evergreen_cs: fix missing break in switch statement

Halil Pasic (1):
      s390/virtio: handle find on invalid queue gracefully

Hans Verkuil (1):
      media: videobuf2-v4l2: drop WARN_ON in vb2_warn_zero_bytesused()

Heikki Krogerus (1):
      device property: Fix the length used in PROPERTY_ENTRY_STRING()

Hou Tao (1):
      9p: use inode->i_lock to protect i_size_write() under 32-bit

Huang Zijiang (1):
      net: hns: Fix object reference leaks in hns_dsaf_roce_reset()

Jan Kara (2):
      ext4: fix crash during online resizing
      ext2: Fix underflow in ext2_max_size()

Jann Horn (2):
      mm: page_alloc: fix ref bias in page_frag_alloc() for 1-byte allocs
      splice: don't merge into linked buffers

Jay Dolan (2):
      serial: 8250_pci: Fix number of ports for ACCES serial cards
      serial: 8250_pci: Have ACCES cards that use the four port Pericom PI7=
C9X7954 chip use the pci_pericom_setup()

Jiong Wang (2):
      nfp: bpf: fix code-gen bug on BPF_ALU | BPF_XOR | BPF_K
      nfp: bpf: fix ALU32 high bits clearance bug

Johannes Thumshirn (1):
      btrfs: ensure that a DUP or RAID1 block group has exactly two stripes

Jordan Niethe (1):
      powerpc/powernv: Make opal log only readable by root

Krzysztof Kozlowski (2):
      iio: adc: exynos-adc: Fix NULL pointer exception on unbind
      regulator: s2mps11: Fix steps for buck7, buck8 and LDO35

Li RongQing (1):
      mac80211_hwsim: propagate genlmsg_reply return code

Lubomir Rintel (2):
      libertas_tf: don't set URB_ZERO_PACKET on IN USB transfer
      serial: 8250_of: assume reg-shift of 2 for mrvl,mmp-uart

Mao Wenan (1):
      net: set static variable an initial value in atl2_probe()

Mark Cave-Ayland (1):
      powerpc: Fix 32-bit KVM-PR lockup and host crash with MacOS guest

Martin Blumenstingl (1):
      pinctrl: meson: meson8b: fix the sdxc_a data 1..3 pins

Martin K. Petersen (1):
      scsi: sd: Optimal I/O size should be a multiple of physical block size

Michael Ellerman (1):
      powerpc/ptrace: Simplify vr_get/set() to avoid GCC warning

NeilBrown (2):
      dm: fix to_sector() for 32bit
      nfsd: fix memory corruption caused by readdir

Oliver O'Halloran (1):
      libnvdimm: Fix altmap reservation size calculation

Pankaj Gupta (1):
      crypto: caam - fixed handling of sg list

Paul Cercueil (2):
      clk: ingenic: Fix round_rate misbehaving with non-integer dividers
      clk: ingenic: Fix doc of ingenic_cgu_div_info

Pavel Shilovsky (2):
      CIFS: Do not reset lease state to NONE on lease break
      CIFS: Fix read after write for files with read caching

QiaoChong (1):
      parport_pc: fix find_superio io compare code, should use equal test.

Roman Penyaev (1):
      mm/vmalloc: fix size check for remap_vmalloc_range_partial()

Russell King (1):
      net: marvell: mvneta: fix DMA debug warning

S.j. Wang (1):
      ASoC: fsl_esai: fix register setting issue in RIGHT_J mode

Sakari Ailus (1):
      media: uvcvideo: Avoid NULL pointer dereference at the end of streami=
ng

Sean Christopherson (2):
      KVM: nVMX: Sign extend displacements of VMX instr's mem operands
      KVM: nVMX: Ignore limit checks on VMX instructions using flat segments

Shubhrajyoti Datta (1):
      i2c: cadence: Fix the hold bit setting

Sowjanya Komatineni (1):
      i2c: tegra: fix maximum transfer size

Stefan Haberland (1):
      s390/dasd: fix using offset into zero size array error

Steve Longerbeam (1):
      gpu: ipu-v3: Fix CSI offsets for imx53

Stuart Menefy (3):
      regulator: s2mpa01: Fix step values for some LDOs
      clocksource/drivers/exynos_mct: Move one-shot check from tick clear t=
o ISR
      clocksource/drivers/exynos_mct: Clear timer interrupt when shutdown

Tom Zanussi (1):
      tracing: Use strncpy instead of memcpy for string keys in hist trigge=
rs

Tony Lindgren (1):
      clk: clk-twl6040: Fix imprecise external abort for pdmclk

Trond Myklebust (3):
      NFS: Fix I/O request leakages
      NFS: Fix an I/O request leakage in nfs_do_recoalesce
      NFS: Don't recoalesce on error in nfs_pageio_complete_mirror()

Tvrtko Ursulin (1):
      drm/i915: Relax mmap VMA check

Vadim Lomovtsev (1):
      net: thunderx: make CFG_DONE message to run through generic send-ack =
sequence

Varad Gautam (1):
      fs/devpts: always delete dcache dentry-s in dput()

Vignesh R (1):
      spi: ti-qspi: Fix mmap read when more than one CS in use

Vineet Gupta (1):
      ARC: uacces: remove lp_start, lp_end from clobber list

Viresh Kumar (1):
      PM / wakeup: Rework wakeup source timer cancellation

Vladimir Murzin (1):
      arm64: Relax GIC version check during early boot

Wanpeng Li (1):
      KVM: X86: Fix residual mmio emulation request to userspace

Yangtao Li (1):
      cpufreq: tegra124: add missing of_node_put()

Yihao Wu (1):
      nfsd: fix wrong check in write_v4_end_grace()

Yizhuo (1):
      ARM: OMAP2+: Variable "reg" in function omap4_dsi_mux_pads() could be=
 uninitialized

Yu Zhao (1):
      mm/gup: fix gup_pmd_range() for dax

Yufen Yu (1):
      floppy: check_events callback should not return a negative number

Zev Weiss (1):
      kernel/sysctl.c: add missing range check in do_proc_dointvec_minmax_c=
onv

Zhang, Jun (1):
      rcu: Do RCU GP kthread self-wakeup from softirq and interrupt

Zhi Jin (1):
      stm class: Fix an endless loop in channel allocation

zhangyi (F) (3):
      tracing: Do not free iter->trace in fail path of tracing_open_pipe()
      jbd2: clear dirty flag when revoking a buffer from an older transacti=
on
      jbd2: fix compile warning when using JBUFFER_TRACE

zhengbin (1):
      9p/net: fix memory leak in p9_client_create

zhongjiang (1):
      mm: hwpoison: fix thp split handing in soft_offline_in_use_page()


--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlyXQ3kACgkQONu9yGCS
aT6aYA//QmHr8DDhH+Mop6eYZ5fPd9sCPOV/0F+n28iGWikC+vMoxr7RJtpsuiKF
DS4DLcYWBFph6cftGiMN8tGQMb4/Zl4sutJ9AMTGO2uAD0JJnrsAohyoRF/Yhw/H
cZCSBCTNZXzDduzGYBfyVmJch2f0wQcgYr/ABJk03nzGGMrcKT4v8qusvPP2/qcz
KTS1yQl6w5uTaXyIWeAa/N0gvS4sJ3z3a5MDQMkvnnUhonGjGhfeAl9P5jcGosHK
jrTq++jl+TVVOAZp69yq1QIYBuNJNougmHJ3ISiPGsetkAPzMX/xfS0YKzXanu8e
wVmQ83vglD6015CUkef8k4niMJN+TdcVsxS7wBm6YHTcpb0BrO6PYGrXJr0/pNFx
x/BQQfzRWAR719f6Bv0FA5NrkArqEei01cCfuWCaP0se7P1nl0mjRJMALGD7vHuj
dLj9DSjMXUE39fhWrT4uNAvpeaTUwKEOCaEEwBf3mTKLPhTD6gdAmkTmH3KCcFAH
Bh1FDx63Q5WXABU7xqvKQz/dMjn6T0pYwaocqHgycBuWJhZqAXJ1p/WLGPH6gvbD
gXutVRBo6eONAfia9B5hswdwACJ4guCBb6Xsenh4P0y2Ns5raA6Mn6hJjTRHMyLJ
MrEEsSLvC+oNMFg6yKKI14WJXlFFI9sABVccNMgoE9Bb9EcwxIY=
=WcpP
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
