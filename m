Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4A6C282E3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 14:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528032087F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 14:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555770750;
	bh=7mLOWfUso5pcxCF7L23uIs4oW3ufLg7IJEsOwtjFdms=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=zOjqlmvuM+yLDz6fz7Pz+tHQzD8eyTLPWoDjqPruQUdNlfEDgBD5Xfgbrid6RLknE
	 h/1tlDwJpGGkPWTaug8bTN3Op06WfglwpeJk7/jCV4R8sal/iXRSU5ccoU55IvgWn4
	 gDxtkdAuBZ2DYreOmYWzKURow8760vmuRxvI9VSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbfDTOc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 10:32:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfDTOc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 10:32:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B58B92087F;
        Sat, 20 Apr 2019 14:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555770747;
        bh=7mLOWfUso5pcxCF7L23uIs4oW3ufLg7IJEsOwtjFdms=;
        h=Date:From:To:Cc:Subject:From;
        b=IYH/8oddwXnw1xzT5WdvhB4Zfmp15BUHMMWuqoH2Rb1ItXTpZ+Y19yjaWxlRWJZIV
         v93AzuopN+53umBZN8VNgkQXnaUqQah/+eCUyXvdlTwvSVTbqprvk3W5Ovf75NOXkx
         Jh1A1ei142osGEVLxXzKbiAcowKmiiwprca+RZww=
Date:   Sat, 20 Apr 2019 16:32:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.19.36
Message-ID: <20190420143224.GA10912@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.19.36 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.19.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 MAINTAINERS                                        |    6=20
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
 arch/x86/hyperv/hv_init.c                          |    6=20
 arch/x86/kernel/aperture_64.c                      |   20=20
 arch/x86/kernel/cpu/cyrix.c                        |   14=20
 arch/x86/kernel/hpet.c                             |    2=20
 arch/x86/kernel/hw_breakpoint.c                    |    1=20
 arch/x86/kernel/mpparse.c                          |    4=20
 arch/x86/kvm/vmx.c                                 |  173 ++
 block/blk-iolatency.c                              |    1=20
 drivers/acpi/ec.c                                  |   65 +
 drivers/acpi/internal.h                            |    2=20
 drivers/acpi/sbs.c                                 |    8=20
 drivers/acpi/sleep.c                               |   11=20
 drivers/acpi/utils.c                               |    1=20
 drivers/auxdisplay/hd44780.c                       |    2=20
 drivers/base/node.c                                |    7=20
 drivers/base/power/domain.c                        |   13=20
 drivers/crypto/axis/artpec6_crypto.c               |   28=20
 drivers/gpio/gpio-pxa.c                            |    6=20
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c   |   52=20
 drivers/gpu/drm/cirrus/cirrus_drv.h                |    2=20
 drivers/gpu/drm/cirrus/cirrus_fbdev.c              |   48=20
 drivers/gpu/drm/cirrus/cirrus_mode.c               |    2=20
 drivers/gpu/drm/exynos/exynos_mixer.c              |  110 +
 drivers/gpu/drm/nouveau/include/nvkm/subdev/volt.h |    1=20
 drivers/gpu/drm/nouveau/nouveau_debugfs.c          |    2=20
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  |    2=20
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/Kbuild    |    1=20
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gf117.c   |   60=20
 drivers/gpu/drm/panel/panel-innolux-p079zca.c      |   11=20
 drivers/gpu/drm/ttm/ttm_bo.c                       |    1=20
 drivers/gpu/drm/ttm/ttm_memory.c                   |    9=20
 drivers/gpu/drm/udl/udl_gem.c                      |    2=20
 drivers/hid/hid-ids.h                              |    1=20
 drivers/hid/hid-quirks.c                           |    1=20
 drivers/hid/i2c-hid/Makefile                       |    3=20
 drivers/hid/i2c-hid/i2c-hid-core.c                 | 1348 ++++++++++++++++=
+++++
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c           |  376 +++++
 drivers/hid/i2c-hid/i2c-hid.c                      | 1328 ----------------=
----
 drivers/hid/i2c-hid/i2c-hid.h                      |   20=20
 drivers/hwtracing/coresight/coresight-cpu-debug.c  |    4=20
 drivers/infiniband/hw/hfi1/qp.c                    |    2=20
 drivers/infiniband/hw/i40iw/i40iw_utils.c          |   12=20
 drivers/infiniband/hw/mlx4/alias_GUID.c            |    2=20
 drivers/iommu/dmar.c                               |    2=20
 drivers/iommu/intel-iommu.c                        |    3=20
 drivers/irqchip/irq-mbigen.c                       |    3=20
 drivers/irqchip/irq-stm32-exti.c                   |    5=20
 drivers/media/usb/au0828/au0828-core.c             |    1=20
 drivers/misc/lkdtm/core.c                          |    2=20
 drivers/misc/lkdtm/lkdtm.h                         |    2=20
 drivers/misc/lkdtm/perms.c                         |   36=20
 drivers/mmc/host/davinci_mmc.c                     |    2=20
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c    |    4=20
 drivers/net/wireless/rsi/rsi_common.h              |    1=20
 drivers/pci/pci.c                                  |   22=20
 drivers/pinctrl/core.c                             |    4=20
 drivers/platform/x86/Kconfig                       |   12=20
 drivers/platform/x86/Makefile                      |    1=20
 drivers/platform/x86/intel_atomisp2_pm.c           |  119 +
 drivers/scsi/scsi_lib.c                            |    1=20
 drivers/scsi/scsi_transport_iscsi.c                |    2=20
 drivers/soc/tegra/pmc.c                            |    8=20
 drivers/thermal/broadcom/bcm2835_thermal.c         |    9=20
 drivers/thermal/int340x_thermal/int3400_thermal.c  |   21=20
 drivers/thermal/intel_powerclamp.c                 |    4=20
 drivers/thermal/samsung/exynos_tmu.c               |    2=20
 drivers/tty/serial/xilinx_uartps.c                 |    2=20
 fs/9p/v9fs.c                                       |   21=20
 fs/9p/v9fs.h                                       |    1=20
 fs/9p/vfs_dir.c                                    |    8=20
 fs/9p/vfs_file.c                                   |    6=20
 fs/cifs/inode.c                                    |   67 -
 fs/cifs/smb2maperror.c                             |    3=20
 fs/ext4/ioctl.c                                    |    7=20
 fs/ext4/resize.c                                   |   17=20
 fs/ext4/super.c                                    |   16=20
 fs/f2fs/debug.c                                    |    3=20
 fs/f2fs/f2fs.h                                     |   15=20
 fs/f2fs/file.c                                     |    7=20
 fs/f2fs/recovery.c                                 |   32=20
 fs/f2fs/segment.c                                  |   65 -
 fs/f2fs/super.c                                    |   65 -
 fs/notify/inotify/inotify_user.c                   |    7=20
 fs/proc/kcore.c                                    |   27=20
 include/linux/atalk.h                              |   20=20
 include/linux/compiler.h                           |    5=20
 include/linux/kcore.h                              |    2=20
 include/linux/swap.h                               |    4=20
 include/net/bluetooth/hci_core.h                   |    2=20
 include/net/xfrm.h                                 |   12=20
 include/trace/events/rxrpc.h                       |    2=20
 include/uapi/linux/netfilter/xt_cgroup.h           |   16=20
 kernel/bpf/inode.c                                 |   32=20
 kernel/events/core.c                               |    2=20
 kernel/hung_task.c                                 |   30=20
 kernel/sched/core.c                                |    2=20
 kernel/sched/cpufreq_schedutil.c                   |   59=20
 lib/div64.c                                        |    4=20
 mm/vmstat.c                                        |    4=20
 net/9p/protocol.c                                  |    3=20
 net/appletalk/atalk_proc.c                         |    2=20
 net/appletalk/ddp.c                                |   37=20
 net/appletalk/sysctl_net_atalk.c                   |    5=20
 net/bluetooth/hci_core.c                           |    2=20
 net/bluetooth/smp.c                                |   23=20
 net/ipv6/ip6_gre.c                                 |    3=20
 net/ipv6/xfrm6_tunnel.c                            |    2=20
 net/key/af_key.c                                   |    2=20
 net/netfilter/nf_tables_api.c                      |    3=20
 net/netfilter/xt_cgroup.c                          |   72 +
 net/rds/rdma.c                                     |   63=20
 net/rds/rds.h                                      |   20=20
 net/rds/send.c                                     |   50=20
 net/rxrpc/conn_client.c                            |   20=20
 net/xfrm/xfrm_state.c                              |   30=20
 net/xfrm/xfrm_user.c                               |    2=20
 sound/drivers/opl3/opl3_voice.h                    |    2=20
 sound/isa/sb/sb8.c                                 |    4=20
 sound/pci/echoaudio/echoaudio.c                    |    5=20
 sound/pci/hda/patch_realtek.c                      |   18=20
 sound/soc/soc-ops.c                                |    4=20
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
 tools/usb/usbip/libsrc/vhci_driver.c               |    2=20
 145 files changed, 3190 insertions(+), 1865 deletions(-)

Aditya Pakki (1):
      x86/hpet: Prevent potential NULL pointer dereference

Andrzej Hajda (1):
      drm/exynos/mixer: fix MIXER shadow registry synchronisation code

Andy Shevchenko (2):
      auxdisplay: hd44780: Fix memory leak on ->remove()
      ACPI / utils: Drop reference in test for device presence

Ard Biesheuvel (2):
      crypto: sha256/arm - fix crash bug in Thumb2 build
      crypto: sha512/arm - fix crash bug in Thumb2 build

Arnaldo Carvalho de Melo (1):
      perf evsel: Free evsel->counts in perf_evsel__exit()

Arnd Bergmann (2):
      mmc: davinci: remove extraneous __init annotation
      appletalk: Fix compile regression

Ayman Bagabas (1):
      ALSA: hda: fix front speakers on Huawei MBXP

Bart Van Assche (2):
      blk-iolatency: #include "blk.h"
      scsi: core: Avoid that system resume triggers a kernel warning

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

Chao Yu (3):
      f2fs: fix to avoid NULL pointer dereference on se->discard_map
      f2fs: fix to do sanity check with current segment number
      f2fs: fix to dirty inode for i_mode recovery

Christophe Leroy (2):
      lkdtm: Print real addresses
      lkdtm: Add tests for NULL pointer dereference

Colin Ian King (1):
      ALSA: opl3: fix mismatch between snd_opl3_drum_switch definition and =
declaration

Cong Wang (1):
      xfrm: destroy xfrm_state synchronously on net exit path

Corentin Labbe (1):
      arc: hsdk_defconfig: Enable CONFIG_BLK_DEV_RAM

Daniel Borkmann (1):
      bpf: fix use after free in bpf_evict_inode

Darrick J. Wong (1):
      ext4: prohibit fstrim in norecovery mode

Dave Airlie (1):
      drm/udl: use drm_gem_object_put_unlocked.

David Arcari (1):
      tools/power turbostat: return the exit status of a command

David Howells (1):
      rxrpc: Fix client call connect/disconnect race

Dinu-Razvan Chis-Serban (1):
      9p locks: add mount option for lock retry interval

Dmitry Osipenko (1):
      soc/tegra: pmc: Drop locking from tegra_powergate_is_powered()

Eugeniy Paltsev (1):
      ARC: u-boot args: check that magic number is correct

Fabien Dessenne (1):
      irqchip/stm32: Don't clear rising/falling config registers at init

Feng Tang (1):
      i40iw: Avoid panic when handling the inetdev event

Gertjan Halkes (1):
      9p: do not trust pdu content for stat item size

Greg Kroah-Hartman (1):
      Linux 4.19.36

Hans de Goede (1):
      platform/x86: Add Intel AtomISP2 dummy / power-management driver

Hsin-Yi, Wang (1):
      drm/panel: panel-innolux: set display off in innolux_panel_unprepare

Ilia Mirkin (1):
      drm/nouveau/volt/gf117: fix speedo readout register

Jack Morgenstein (1):
      IB/mlx4: Fix race condition between catas error reset and aliasguid f=
lows

Jan Kara (1):
      ext4: avoid panic during forced reboot

Jiada Wang (1):
      PM / Domains: Avoid a potential deadlock

Jianguo Chen (1):
      irqchip/mbigen: Don't clear eventid when freeing an MSI

Julia Cartwright (1):
      iommu/dmar: Fix buffer overflow during PCI bus notification

Julian Sax (1):
      HID: i2c-hid: override HID descriptors for certain devices

Kai-Heng Feng (1):
      HID: usbhid: Add quirk for Redragon/Dragonrise Seymur 2

Kaike Wan (1):
      IB/hfi1: Failed to drain send queue when QP is put into error state

Kairui Song (1):
      x86/gart: Exclude GART aperture from kcore

Kangjie Lu (3):
      ALSA: echoaudio: add a check for ioremap_nocache
      ALSA: sb8: add a check for request_region
      x86/hyperv: Prevent potential NULL pointer dereference

Kevin Wang (1):
      drm/amdkfd: use init_mqd function to allocate object for hid_mqd (CI)

Konstantin Khlebnikov (2):
      sched/core: Fix buffer overflow in cgroup2 property cpu.max
      mm: hide incomplete nr_indirectly_reclaimable in sysfs

Lars Persson (1):
      crypto: axis - fix for recursive locking from bottom half

Leo Yan (1):
      coresight: cpu-debug: Support for CA73 CPUs

Lorenzo Bianconi (1):
      net: ip6_gre: fix possible NULL pointer dereference in ip6erspan_set_=
version

Lu Baolu (1):
      iommu/vt-d: Check capability before disabling protected memory

Luc Van Oostenryck (1):
      thermal/intel_powerclamp: fix __percpu declaration of worker_data

Lukas Czerner (2):
      ext4: add missing brelse() in add_new_gdb_meta_bg()
      ext4: report real fs size after failed resize

Maciej =C5=BBenczykowski (1):
      usbip: fix vhci_hcd controller counting

Marek Szyprowski (1):
      thermal: samsung: Fix incorrect check after code merge

Matias Karhumaa (1):
      Bluetooth: Fix debugfs NULL pointer dereference

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

Mika Westerberg (1):
      PCI: Blacklist power management of Gigabyte X299 DESIGNARE EX PCIe po=
rts

Nathan Chancellor (1):
      x86/hw_breakpoints: Make default case in hw_breakpoint_arch_parse() r=
eturn an error

Nathan Fontenot (1):
      powerpc/pseries: Remove prrn_work workqueue

Pablo Neira Ayuso (1):
      netfilter: xt_cgroup: shrink size of v2 path

Peter Zijlstra (1):
      sched/cpufreq: Fix 32-bit math overflow

Phil Elwell (1):
      thermal: bcm2835: Fix crash in bcm2835_thermal_debugfs

Pi-Hsun Shih (1):
      include/linux/swap.h: use offsetof() instead of custom __swapoffset m=
acro

Rafael J. Wysocki (1):
      ACPI: EC / PM: Disable non-wakeup GPEs for suspend-to-idle

Robert Jarzmik (1):
      gpio: pxa: handle corner case of unprobed device

Rohit kumar (1):
      ASoC: Fix UBSAN warning at snd_soc_get/put_volsw_sx()

Roman Gushchin (1):
      mm: hide incomplete nr_indirectly_reclaimable in /proc/zoneinfo

Ronald Tschal=C3=A4r (1):
      ACPI / SBS: Fix GPE storm on recent MacBookPro's

Sean Christopherson (1):
      KVM: nVMX: restore host state in nested_vmx_vmexit for VMFail

Sheng Yong (1):
      f2fs: cleanup dirty pages if recover failed

Siva Rebbagondla (1):
      rsi: improve kernel thread handling to fix kernel panic

Stanislaw Gruszka (1):
      lib/div64.c: off by one in shift

Stephane Eranian (1):
      perf/core: Restore mmap record type correctly

Steve French (2):
      fix incorrect error code mapping for OBJECTID_NOT_FOUND
      cifs: fallback to older infolevels on findfirst queryinfo retry

Taehee Yoo (1):
      netfilter: nf_flow_table: remove flowtable hook flush routine in netn=
s exit routine

Thomas Zimmermann (1):
      drm/cirrus: Use drm_framebuffer_put to avoid kernel oops in clean-up

Thor Thayer (1):
      net: stmmac: Set OWN bit for jumbo frames

Trigger Huang (1):
      drm/ttm: Fix bo_global and mem_global kfree error

Vitaly Kuznetsov (1):
      kernel: hung_task.c: disable on suspend

Yang Shi (1):
      ARM: 8839/1: kprobe: make patch_lock a raw_spinlock_t

Yanjiang Jin (1):
      pinctrl: core: make sure strcmp() doesn't get a null parameter

YueHaibing (2):
      drm/nouveau/debugfs: Fix check of pm_runtime_get_sync failure
      appletalk: Fix use-after-free in atalk_proc_exit

Zhang Rui (2):
      thermal/intel_powerclamp: fix truncated kthread name
      Revert "ACPI / EC: Remove old CLEAR_ON_RESUME quirk"

ZhangXiaoxu (1):
      inotify: Fix fsnotify_mark refcount leak in inotify_update_existing_w=
atch()

ndesaulniers@google.com (1):
      compiler.h: update definition of unreachable()

shamir rabinovitch (1):
      net/rds: fix warn in rds_message_alloc_sgs


--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAly7LXgACgkQONu9yGCS
aT5YGg//fKHBcw6of/8Qz98nsxevG6cjvlDzZpVzbjpSg649p8jy/FtLTpz3D6Gw
3KQFxGujfR1RYu/HE4uxEb7z5fDqPVgko3y7+EYxWBxfDy94v8u5PgiIAhqcofuv
8xs+IyPKI7hCO16vobWm8IRCv1iTzfUUcpvNhKn2TJSYkecVjJrPeZG7JDU27768
YclNesCRDrvrmpqNnmKd1QoOm8VCMsXTZUPDTKYFKqzKFUx4ukdTLPd4SqGA+a+/
GBu1oucaiTivXRgoC+ASI/hsQKAlBgdi8JMpZPX2YpQ+4nbxDJHSt+jdjRYFuVXQ
cznMgloTdnNMqdxKgyVLhAB/ndDPVxkQu02adPTxSE6yaugaU6qGXMvjrtWqT3rE
ig/XgTLlpe1M41qpcITVkIrB6sePiUqan7plnKB12ea4i9hkXz+mpJnWCeV9jXPd
RcpXN94QeHMtyd3JsKaYF9C5Zp+d2l8iMH0E1ji2/1cL8uSNSkSmHxLeKqw4OJfm
EA/cFm+wVH0G1ZwYyEMvlilzRB/vc2PK3B5k2v0RTpBlURjS8kB6gj4rPzmyytmr
V8Z0SdnNpvjK7V996CoeA8AKo6bDYW+/oYkY9nwckStPdQ8jNh2IH9+7RPdEEkKi
PiE3dFVeF3Uyio8O1gZe0yDxkfnPOFLAZW/u2bi/QKiFNwlYXV0=
=UX17
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
