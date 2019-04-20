Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE18C282E3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 14:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941FE21479
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 14:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555770666;
	bh=uv13S+6qpav4jGuQNGBFPsNYb5nTNU/f6+arArdqsUk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Jk05s+mRLVRmAryIoaaZNEWLgsf2VHFZWMsfP8zIa/6UFQGoZi9l0XNw55ExteGeW
	 omSY3nQBOfsocLsGEgNLRkvxrG+eBkZiOGOrTMdzuipSRVKN64qzeMrFw4nIcJG46K
	 bSpN5W8Im6ePDAv9K2PuWG25AZ1FD3WgUjVPTv7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfDTObF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 10:31:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfDTObF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 10:31:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0259D2087F;
        Sat, 20 Apr 2019 14:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555770663;
        bh=uv13S+6qpav4jGuQNGBFPsNYb5nTNU/f6+arArdqsUk=;
        h=Date:From:To:Cc:Subject:From;
        b=WCVvSqBEmupX5bW7k/fc8qbDkE7ym1uySUbhruuOxLmYi8+BjatDPO/63CdCAA1u5
         9dVI11T88pZoUZk+464SLzQZEf/Z/Qlkg3IafDspZ9GKX/dXiHkxjxrzQjqv4bQ+bo
         KDuC6E+CM2a/X6QCaoI4c/ODga9WBlhwQbPoxbVY=
Date:   Sat, 20 Apr 2019 16:31:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.113
Message-ID: <20190420143101.GA10597@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.113 kernel.

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

 Makefile                                           |    2=20
 arch/arc/configs/hsdk_defconfig                    |    1=20
 arch/arc/kernel/head.S                             |    1=20
 arch/arc/kernel/setup.c                            |    8=20
 arch/arm/crypto/sha256-armv4.pl                    |    3=20
 arch/arm/crypto/sha256-core.S_shipped              |    3=20
 arch/arm/crypto/sha512-armv4.pl                    |    3=20
 arch/arm/crypto/sha512-core.S_shipped              |    3=20
 arch/arm/kernel/patch.c                            |    6=20
 arch/arm/plat-samsung/Kconfig                      |    2=20
 arch/powerpc/kernel/rtasd.c                        |   17=20
 arch/x86/kernel/cpu/cyrix.c                        |   14=20
 arch/x86/kernel/hpet.c                             |    2=20
 arch/x86/kernel/hw_breakpoint.c                    |    1=20
 arch/x86/kernel/mpparse.c                          |    4=20
 arch/x86/kvm/vmx.c                                 |  173 ++
 drivers/acpi/ec.c                                  |   53=20
 drivers/acpi/sbs.c                                 |    8=20
 drivers/auxdisplay/hd44780.c                       |    2=20
 drivers/base/node.c                                |    7=20
 drivers/crypto/axis/artpec6_crypto.c               |   28=20
 drivers/gpio/gpio-pxa.c                            |    6=20
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c   |   52=20
 drivers/gpu/drm/nouveau/include/nvkm/subdev/volt.h |    1=20
 drivers/gpu/drm/nouveau/nouveau_debugfs.c          |    2=20
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  |    2=20
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/Kbuild    |    1=20
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gf117.c   |   60=20
 drivers/gpu/drm/panel/panel-innolux-p079zca.c      |   11=20
 drivers/hid/i2c-hid/Makefile                       |    3=20
 drivers/hid/i2c-hid/i2c-hid-core.c                 | 1299 ++++++++++++++++=
+++++
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c           |  376 ++++++
 drivers/hid/i2c-hid/i2c-hid.c                      | 1279 ----------------=
----
 drivers/hid/i2c-hid/i2c-hid.h                      |   20=20
 drivers/hwtracing/coresight/coresight-cpu-debug.c  |    4=20
 drivers/infiniband/hw/mlx4/alias_GUID.c            |    2=20
 drivers/iommu/dmar.c                               |    2=20
 drivers/iommu/intel-iommu.c                        |    3=20
 drivers/irqchip/irq-mbigen.c                       |    3=20
 drivers/md/dm-crypt.c                              |   10=20
 drivers/md/dm-integrity.c                          |    4=20
 drivers/media/usb/au0828/au0828-core.c             |    1=20
 drivers/misc/lkdtm.h                               |    2=20
 drivers/misc/lkdtm_core.c                          |    2=20
 drivers/misc/lkdtm_perms.c                         |   36=20
 drivers/mmc/host/davinci_mmc.c                     |    2=20
 drivers/net/ethernet/netronome/nfp/bpf/verifier.c  |    9=20
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |    6=20
 drivers/net/wireless/rsi/rsi_common.h              |    1=20
 drivers/scsi/scsi_transport_iscsi.c                |    2=20
 drivers/soc/tegra/pmc.c                            |    8=20
 drivers/thermal/broadcom/bcm2835_thermal.c         |    9=20
 drivers/thermal/int340x_thermal/int3400_thermal.c  |   21=20
 drivers/thermal/intel_powerclamp.c                 |    4=20
 drivers/tty/serial/xilinx_uartps.c                 |    2=20
 fs/9p/v9fs.c                                       |   21=20
 fs/9p/v9fs.h                                       |    1=20
 fs/9p/vfs_dir.c                                    |    8=20
 fs/9p/vfs_file.c                                   |    6=20
 fs/cifs/inode.c                                    |   67 -
 fs/cifs/smb2maperror.c                             |    3=20
 fs/ext4/ioctl.c                                    |    7=20
 fs/ext4/resize.c                                   |   17=20
 fs/f2fs/super.c                                    |   34=20
 include/linux/atalk.h                              |   20=20
 include/linux/bpf_verifier.h                       |   29=20
 include/linux/compiler.h                           |    5=20
 include/linux/filter.h                             |   10=20
 include/linux/swap.h                               |    4=20
 include/uapi/linux/netfilter/xt_cgroup.h           |   16=20
 kernel/bpf/core.c                                  |   51=20
 kernel/bpf/inode.c                                 |   32=20
 kernel/bpf/map_in_map.c                            |   17=20
 kernel/bpf/verifier.c                              |  804 +++++++++---
 kernel/events/core.c                               |    2=20
 kernel/hung_task.c                                 |   30=20
 lib/div64.c                                        |    4=20
 net/9p/protocol.c                                  |    3=20
 net/appletalk/atalk_proc.c                         |    2=20
 net/appletalk/ddp.c                                |   37=20
 net/appletalk/sysctl_net_atalk.c                   |    5=20
 net/netfilter/xt_cgroup.c                          |   72 +
 sound/drivers/opl3/opl3_voice.h                    |    2=20
 sound/isa/sb/sb8.c                                 |    4=20
 sound/pci/echoaudio/echoaudio.c                    |    5=20
 tools/perf/Documentation/perf-config.txt           |    2=20
 tools/perf/builtin-top.c                           |    5=20
 tools/perf/tests/evsel-tp-sched.c                  |    1=20
 tools/perf/tests/expr.c                            |    5=20
 tools/perf/tests/openat-syscall-all-cpus.c         |    4=20
 tools/perf/util/build-id.c                         |    1=20
 tools/perf/util/config.c                           |    3=20
 tools/perf/util/evsel.c                            |    1=20
 tools/perf/util/hist.c                             |    4=20
 tools/perf/util/parse-events.c                     |    2=20
 tools/power/x86/turbostat/turbostat.c              |    3=20
 tools/testing/selftests/bpf/test_verifier.c        |    6=20
 tools/usb/usbip/libsrc/vhci_driver.c               |    2=20
 98 files changed, 3184 insertions(+), 1759 deletions(-)

Aditya Pakki (1):
      x86/hpet: Prevent potential NULL pointer dereference

Alexei Starovoitov (3):
      bpf: reduce verifier memory consumption
      bpf: fix verifier memory leaks
      bpf: fix stack state printing in verifier log

Andy Shevchenko (1):
      auxdisplay: hd44780: Fix memory leak on ->remove()

Ard Biesheuvel (2):
      crypto: sha256/arm - fix crash bug in Thumb2 build
      crypto: sha512/arm - fix crash bug in Thumb2 build

Arnaldo Carvalho de Melo (1):
      perf evsel: Free evsel->counts in perf_evsel__exit()

Arnd Bergmann (2):
      mmc: davinci: remove extraneous __init annotation
      appletalk: Fix compile regression

Balbir Singh (1):
      bpf: Fix selftests are changes for CVE 2019-7308

Bartlomiej Zolnierkiewicz (1):
      ARM: samsung: Limit SAMSUNG_PM_CHECK config option to non-Exynos plat=
forms

Brad Love (1):
      media: au0828: cannot kfree dev before usb disconnect

Changbin Du (9):
      perf list: Don't forget to drop the reference to the allocated thread=
_map
      perf config: Fix an error in the config template documentation
      perf config: Fix a memory leak in collect_config()
      perf build-id: Fix memory leak in print_sdt_events()
      perf top: Fix error handling in cmd_top()
      perf hist: Add missing map__put() in error case
      perf tests: Fix a memory leak of cpu_map object in the openat_syscall=
_event_on_all_cpus test
      perf tests: Fix memory leak by expr__find_other() in test__expr()
      perf tests: Fix a memory leak in test__perf_evsel__tp_sched_test()

Chao Yu (1):
      f2fs: fix to do sanity check with current segment number

Christophe Leroy (2):
      lkdtm: Print real addresses
      lkdtm: Add tests for NULL pointer dereference

Colin Ian King (1):
      ALSA: opl3: fix mismatch between snd_opl3_drum_switch definition and =
declaration

Corentin Labbe (1):
      arc: hsdk_defconfig: Enable CONFIG_BLK_DEV_RAM

Craig Gallek (1):
      bpf: fix verifier NULL pointer dereference

Daniel Borkmann (12):
      bpf: fix use after free in bpf_evict_inode
      bpf: move {prev_,}insn_idx into verifier env
      bpf: move tmp variable into ax register in interpreter
      bpf: enable access to ax register also from verifier rewrite
      bpf: restrict map value pointer arithmetic for unprivileged
      bpf: restrict stack pointer arithmetic for unprivileged
      bpf: restrict unknown scalars of mixed signed bounds for unprivileged
      bpf: fix check_map_access smin_value test when pointer contains offset
      bpf: prevent out of bounds speculation on pointer arithmetic
      bpf: fix sanitation of alu op with pointer / scalar type from differe=
nt paths
      bpf: fix inner map masking to prevent oob under speculation
      bpf: fix sanitation rewrite in case of non-pointers

Darrick J. Wong (1):
      ext4: prohibit fstrim in norecovery mode

David Arcari (1):
      tools/power turbostat: return the exit status of a command

Dinu-Razvan Chis-Serban (1):
      9p locks: add mount option for lock retry interval

Dmitry Osipenko (1):
      soc/tegra: pmc: Drop locking from tegra_powergate_is_powered()

Eugeniy Paltsev (1):
      ARC: u-boot args: check that magic number is correct

Gertjan Halkes (1):
      9p: do not trust pdu content for stat item size

Greg Kroah-Hartman (1):
      Linux 4.14.113

Hsin-Yi, Wang (1):
      drm/panel: panel-innolux: set display off in innolux_panel_unprepare

Ilia Mirkin (1):
      drm/nouveau/volt/gf117: fix speedo readout register

Jack Morgenstein (1):
      IB/mlx4: Fix race condition between catas error reset and aliasguid f=
lows

Jianguo Chen (1):
      irqchip/mbigen: Don't clear eventid when freeing an MSI

Julia Cartwright (1):
      iommu/dmar: Fix buffer overflow during PCI bus notification

Julian Sax (1):
      HID: i2c-hid: override HID descriptors for certain devices

Kangjie Lu (2):
      ALSA: echoaudio: add a check for ioremap_nocache
      ALSA: sb8: add a check for request_region

Kevin Wang (1):
      drm/amdkfd: use init_mqd function to allocate object for hid_mqd (CI)

Konstantin Khlebnikov (1):
      mm: hide incomplete nr_indirectly_reclaimable in sysfs

Lars Persson (2):
      crypto: axis - fix for recursive locking from bottom half
      net: stmmac: Set dma ring length before enabling the DMA

Leo Yan (1):
      coresight: cpu-debug: Support for CA73 CPUs

Lu Baolu (1):
      iommu/vt-d: Check capability before disabling protected memory

Luc Van Oostenryck (1):
      thermal/intel_powerclamp: fix __percpu declaration of worker_data

Lukas Czerner (2):
      ext4: add missing brelse() in add_new_gdb_meta_bg()
      ext4: report real fs size after failed resize

Maciej =C5=BBenczykowski (1):
      usbip: fix vhci_hcd controller counting

Matteo Croce (1):
      x86/mm: Don't leak kernel addresses

Matthew Garrett (2):
      thermal/int340x_thermal: Add additional UUIDs
      thermal/int340x_thermal: fix mode setting

Matthew Whitehead (1):
      x86/cpu/cyrix: Use correct macros for Cyrix calls on Geode processors

Maurizio Lombardi (1):
      scsi: iscsi: flush running unbind operations when removing a session

Michal Simek (1):
      serial: uartps: console_setup() can't be placed to init section

Mikulas Patocka (1):
      dm: disable CRYPTO_TFM_REQ_MAY_SLEEP to fix a GFP_KERNEL recursion de=
adlock

Nathan Chancellor (1):
      x86/hw_breakpoints: Make default case in hw_breakpoint_arch_parse() r=
eturn an error

Nathan Fontenot (1):
      powerpc/pseries: Remove prrn_work workqueue

Pablo Neira Ayuso (1):
      netfilter: xt_cgroup: shrink size of v2 path

Phil Elwell (1):
      thermal: bcm2835: Fix crash in bcm2835_thermal_debugfs

Pi-Hsun Shih (1):
      include/linux/swap.h: use offsetof() instead of custom __swapoffset m=
acro

Robert Jarzmik (1):
      gpio: pxa: handle corner case of unprobed device

Ronald Tschal=C3=A4r (1):
      ACPI / SBS: Fix GPE storm on recent MacBookPro's

Sean Christopherson (1):
      KVM: nVMX: restore host state in nested_vmx_vmexit for VMFail

Siva Rebbagondla (1):
      rsi: improve kernel thread handling to fix kernel panic

Stanislaw Gruszka (1):
      lib/div64.c: off by one in shift

Stephane Eranian (1):
      perf/core: Restore mmap record type correctly

Steve French (2):
      fix incorrect error code mapping for OBJECTID_NOT_FOUND
      cifs: fallback to older infolevels on findfirst queryinfo retry

Vitaly Kuznetsov (1):
      kernel: hung_task.c: disable on suspend

Xu Yu (1):
      bpf: do not restore dst_reg when cur_state is freed

Yang Shi (1):
      ARM: 8839/1: kprobe: make patch_lock a raw_spinlock_t

YueHaibing (2):
      drm/nouveau/debugfs: Fix check of pm_runtime_get_sync failure
      appletalk: Fix use-after-free in atalk_proc_exit

Zhang Rui (2):
      thermal/intel_powerclamp: fix truncated kthread name
      Revert "ACPI / EC: Remove old CLEAR_ON_RESUME quirk"

ndesaulniers@google.com (1):
      compiler.h: update definition of unreachable()


--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAly7LSUACgkQONu9yGCS
aT5AWBAAhXe9Nk0v+hs9R8enhpJoyn3VbuN/O+Eo3NIbNHcOI+zro6ICn2U0IJEe
NeQPRjloSGqe4Ol/5b7hMEp3IhLH9mLHmqJhUt63VqqgePpmm77pkFzF0+FEcIOI
UuCm7zpdyWyyK+vY/uUDDkb6lFLe9R8/SukvbNSHA/haAWa5RIMYU4FCWzmB/OAi
1Yu4VzDX8Y4mmqWizjqkra8hTzuBUO7CGxVzbQ6zJfYbZxUZdma+8tAmVPAZP4hh
1R79gEffuW32+MdO4K7Y/Re7Tr1JQEa9Il1ACqVMiwTErVuZjfhH40xUodM3PNVJ
6pdbWNVT3oEMvG0dpsZeZFypUFxQdZJbMDAGX70Fi2YgMFJAe4b4iX3MYGmDRBZb
eCDm8h1uj+iXSSrqs6hw46+6b0WiccVZz6kPS+qzKjdFG/hhhfn2FYaYHkorcQSj
xj0bdewy11F+J2Ho1T8hUWF5XBjHUn8raODojCT5zLnQFYwf1Zb0B6XuGyBoSazn
m5FK0XkGVWqZJpdKWqSDeMxiTJmDVbvQYOTApXTvShNBh9/QLivaCU3YdFXAEMon
w8yuoGTawgOp4RIqibrNq3ffJuFN286zChnBah714/AYOfNZRTtJhmVFpaDllZPV
zJuSGOpUUJr4/jzRGpvD1JToZ5U+/16ge/XVrgG96n8iybJxq7I=
=/fgK
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
