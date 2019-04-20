Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6197EC282E4
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 14:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EA62183F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 14:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555770773;
	bh=3rlbCTzlUmmyUxNqy9wj2GKZFn6pLoKSJH2M+W+gVHQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=bzSMtb9gGLsjqs7D04q2yjv2ALWtGIpaICmAKD7U8YnZ3/wwjHaGX/mHxvbZBCslr
	 2lieZ5oOVW6Jat8Yy2z9L04r1b9/c777ur/btlFR5OUaBY6YwThEf9w/nhatcx057t
	 pu0l7xzjLmwg1Vntfv5Q/0mfTMEj85iDyc9LvKl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbfDTOcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 10:32:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfDTOcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 10:32:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5378521479;
        Sat, 20 Apr 2019 14:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555770767;
        bh=3rlbCTzlUmmyUxNqy9wj2GKZFn6pLoKSJH2M+W+gVHQ=;
        h=Date:From:To:Cc:Subject:From;
        b=lD2F2B6rXefZvGjzemgrqxrYeSH/zm/78OraW+S8kr6j32t44Mrig6xuhHp4bbz0n
         rHjlgxgyArX74tfgGbVF+rZQD2uIIT63ttoIsF/8o5B95sNi6kwvmEPuZvYwWDyg+e
         V//hk7iqAY5VtbuehJxhR2D8Efi5YN1yIiZZayzI=
Date:   Sat, 20 Apr 2019 16:32:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 5.0.9
Message-ID: <20190420143245.GA11036@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 5.0.9 kernel.

All users of the 5.0 kernel series must upgrade.

The updated 5.0.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-5.0.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                                |    2=20
 arch/arc/configs/hsdk_defconfig                         |    1=20
 arch/arc/kernel/head.S                                  |    1=20
 arch/arc/kernel/setup.c                                 |    8 +
 arch/arm/kernel/patch.c                                 |    6=20
 arch/mips/bcm47xx/workarounds.c                         |    1=20
 arch/x86/hyperv/hv_init.c                               |    6=20
 arch/x86/kernel/aperture_64.c                           |   20 +-
 arch/x86/kernel/cpu/cyrix.c                             |   14 +-
 arch/x86/kernel/hpet.c                                  |    2=20
 arch/x86/kernel/hw_breakpoint.c                         |    1=20
 arch/x86/kernel/mpparse.c                               |    4=20
 block/blk-iolatency.c                                   |    1=20
 drivers/acpi/ec.c                                       |   53 +++++++
 drivers/acpi/utils.c                                    |    1=20
 drivers/auxdisplay/hd44780.c                            |    2=20
 drivers/base/power/domain.c                             |   13 -
 drivers/block/paride/pcd.c                              |   20 ++
 drivers/block/paride/pf.c                               |   26 +++
 drivers/crypto/axis/artpec6_crypto.c                    |   28 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                 |    2=20
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c        |   52 -------
 drivers/gpu/drm/exynos/exynos_mixer.c                   |  110 +++++++++--=
-----
 drivers/gpu/drm/nouveau/include/nvkm/subdev/volt.h      |    1=20
 drivers/gpu/drm/nouveau/nouveau_debugfs.c               |    2=20
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c       |    2=20
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/Kbuild         |    1=20
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gf117.c        |   60 ++++++++
 drivers/gpu/drm/panel/panel-innolux-p079zca.c           |   11 -
 drivers/gpu/drm/udl/udl_gem.c                           |    2=20
 drivers/hwtracing/coresight/coresight-cpu-debug.c       |    4=20
 drivers/infiniband/hw/hfi1/qp.c                         |    2=20
 drivers/infiniband/hw/hns/hns_roce_device.h             |   21 +++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c              |  103 +++++++++++=
++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h              |    1=20
 drivers/infiniband/hw/i40iw/i40iw_utils.c               |   12 +
 drivers/infiniband/hw/mlx4/alias_GUID.c                 |    2=20
 drivers/iommu/intel-iommu.c                             |    5=20
 drivers/irqchip/irq-mbigen.c                            |    3=20
 drivers/irqchip/irq-stm32-exti.c                        |   10 -
 drivers/misc/lkdtm/core.c                               |    2=20
 drivers/misc/lkdtm/lkdtm.h                              |    2=20
 drivers/misc/lkdtm/perms.c                              |   36 +++--
 drivers/mmc/host/davinci_mmc.c                          |    2=20
 drivers/net/ethernet/hisilicon/hns3/hnae3.h             |    2=20
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c         |   28 ++++
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c |   20 --
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c |    8 -
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h |    4=20
 drivers/pci/pci.c                                       |   75 ++++++++++
 drivers/platform/x86/intel_pmc_core.c                   |   34 ++++
 drivers/platform/x86/intel_pmc_core.h                   |    5=20
 drivers/scsi/qla2xxx/qla_os.c                           |    2=20
 drivers/scsi/scsi_lib.c                                 |    9 +
 drivers/scsi/scsi_transport_iscsi.c                     |    2=20
 drivers/thermal/broadcom/bcm2835_thermal.c              |    9 -
 drivers/thermal/intel/int340x_thermal/int3400_thermal.c |   21 ++-
 drivers/thermal/intel/intel_powerclamp.c                |    4=20
 drivers/thermal/samsung/exynos_tmu.c                    |    2=20
 fs/cifs/cifsfs.c                                        |    2=20
 fs/cifs/smb2maperror.c                                  |    3=20
 fs/cifs/smb2ops.c                                       |   10 +
 fs/cifs/trace.h                                         |    6=20
 fs/ext4/ioctl.c                                         |    7 +
 fs/ext4/resize.c                                        |   17 ++
 fs/ext4/super.c                                         |   16 +-
 fs/f2fs/checkpoint.c                                    |    9 -
 fs/f2fs/data.c                                          |   21 +--
 fs/f2fs/dir.c                                           |    2=20
 fs/f2fs/f2fs.h                                          |   21 +++
 fs/f2fs/file.c                                          |    5=20
 fs/f2fs/node.c                                          |    6=20
 fs/f2fs/segment.c                                       |    9 -
 fs/f2fs/super.c                                         |   44 ++++--
 fs/f2fs/xattr.c                                         |   10 -
 fs/notify/inotify/inotify_user.c                        |    7 -
 fs/proc/kcore.c                                         |   27 +++
 include/linux/atalk.h                                   |    2=20
 include/linux/kcore.h                                   |    2=20
 include/linux/swap.h                                    |    4=20
 include/trace/events/rxrpc.h                            |    2=20
 kernel/bpf/inode.c                                      |   32 ++--
 kernel/events/core.c                                    |    2=20
 kernel/sched/core.c                                     |    2=20
 kernel/sched/cpufreq_schedutil.c                        |   59 +++-----
 lib/div64.c                                             |    4=20
 net/appletalk/atalk_proc.c                              |    2=20
 net/appletalk/ddp.c                                     |   37 ++++-
 net/appletalk/sysctl_net_atalk.c                        |    5=20
 net/rxrpc/conn_client.c                                 |   20 ++
 sound/drivers/opl3/opl3_voice.h                         |    2=20
 sound/isa/sb/sb8.c                                      |    4=20
 sound/pci/echoaudio/echoaudio.c                         |    5=20
 tools/lib/bpf/libbpf.c                                  |    2=20
 tools/perf/Documentation/perf-config.txt                |    2=20
 tools/perf/Documentation/perf-stat.txt                  |    5=20
 tools/perf/bench/epoll-ctl.c                            |    2=20
 tools/perf/bench/epoll-wait.c                           |    2=20
 tools/perf/builtin-stat.c                               |    3=20
 tools/perf/builtin-top.c                                |    5=20
 tools/perf/tests/backward-ring-buffer.c                 |    2=20
 tools/perf/tests/evsel-tp-sched.c                       |    1=20
 tools/perf/tests/expr.c                                 |    5=20
 tools/perf/tests/openat-syscall-all-cpus.c              |    4=20
 tools/perf/util/build-id.c                              |    1=20
 tools/perf/util/config.c                                |    3=20
 tools/perf/util/evsel.c                                 |    4=20
 tools/perf/util/hist.c                                  |    4=20
 tools/perf/util/map.c                                   |   18 ++
 tools/perf/util/ordered-events.c                        |    2=20
 tools/perf/util/parse-events.c                          |    2=20
 tools/perf/util/stat.c                                  |   12 -
 tools/power/x86/turbostat/turbostat.c                   |    3=20
 113 files changed, 998 insertions(+), 373 deletions(-)

Aditya Pakki (1):
      x86/hpet: Prevent potential NULL pointer dereference

Andi Kleen (1):
      perf stat: Fix --no-scale

Andrzej Hajda (1):
      drm/exynos/mixer: fix MIXER shadow registry synchronisation code

Andy Shevchenko (2):
      auxdisplay: hd44780: Fix memory leak on ->remove()
      ACPI / utils: Drop reference in test for device presence

Arnaldo Carvalho de Melo (1):
      perf evsel: Free evsel->counts in perf_evsel__exit()

Arnd Bergmann (1):
      mmc: davinci: remove extraneous __init annotation

Bart Van Assche (2):
      scsi: core: Also call destroy_rcu_head() for passthrough requests
      blk-iolatency: #include "blk.h"

Bjorn Helgaas (1):
      PCI/ASPM: Save LTR Capability for suspend/resume

Changbin Du (13):
      perf list: Don't forget to drop the reference to the allocated thread=
_map
      perf tools: Fix errors under optimization level '-Og'
      perf config: Fix an error in the config template documentation
      perf config: Fix a memory leak in collect_config()
      perf build-id: Fix memory leak in print_sdt_events()
      perf top: Fix error handling in cmd_top()
      perf hist: Add missing map__put() in error case
      perf map: Remove map from 'names' tree in __maps__remove()
      perf maps: Purge all maps from the 'names' tree
      perf top: Fix global-buffer-overflow issue
      perf tests: Fix a memory leak of cpu_map object in the openat_syscall=
_event_on_all_cpus test
      perf tests: Fix memory leak by expr__find_other() in test__expr()
      perf tests: Fix a memory leak in test__perf_evsel__tp_sched_test()

Chao Yu (3):
      f2fs: fix to dirty inode for i_mode recovery
      f2fs: fix to use kvfree instead of kzfree
      f2fs: fix to add refcount once page is tagged PG_private

Christophe Leroy (2):
      lkdtm: Print real addresses
      lkdtm: Add tests for NULL pointer dereference

Colin Ian King (1):
      ALSA: opl3: fix mismatch between snd_opl3_drum_switch definition and =
declaration

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

Eugeniy Paltsev (1):
      ARC: u-boot args: check that magic number is correct

Fabien Dessenne (2):
      irqchip/stm32: Don't clear rising/falling config registers at init
      irqchip/stm32: Don't set rising configuration registers at init

Feng Tang (1):
      i40iw: Avoid panic when handling the inetdev event

Greg Kroah-Hartman (1):
      Linux 5.0.9

Himanshu Madhani (1):
      scsi: qla2xxx: Fix NULL pointer crash due to stale CPUID

Hsin-Yi, Wang (1):
      drm/panel: panel-innolux: set display off in innolux_panel_unprepare

Huazhong Tan (1):
      net: hns3: Fix NULL deref when unloading driver

Ilia Mirkin (1):
      drm/nouveau/volt/gf117: fix speedo readout register

Jack Morgenstein (1):
      IB/mlx4: Fix race condition between catas error reset and aliasguid f=
lows

Jaegeuk Kim (1):
      f2fs: sync filesystem after roll-forward recovery

Jan Kara (1):
      ext4: avoid panic during forced reboot

Jens Axboe (2):
      paride/pf: cleanup queues when detection fails
      paride/pcd: cleanup queues when detection fails

Jiada Wang (1):
      PM / Domains: Avoid a potential deadlock

Jianguo Chen (1):
      irqchip/mbigen: Don't clear eventid when freeing an MSI

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

Konstantin Khlebnikov (1):
      sched/core: Fix buffer overflow in cgroup2 property cpu.max

Lars Persson (1):
      crypto: axis - fix for recursive locking from bottom half

Leo Yan (1):
      coresight: cpu-debug: Support for CA73 CPUs

Lu Baolu (2):
      iommu/vt-d: Check capability before disabling protected memory
      iommu/vt-d: Save the right domain ID used by hardware

Luc Van Oostenryck (1):
      thermal/intel_powerclamp: fix __percpu declaration of worker_data

Lukas Czerner (2):
      ext4: add missing brelse() in add_new_gdb_meta_bg()
      ext4: report real fs size after failed resize

Marek Szyprowski (1):
      thermal: samsung: Fix incorrect check after code merge

Matteo Croce (1):
      x86/mm: Don't leak kernel addresses

Matthew Garrett (2):
      thermal/int340x_thermal: Add additional UUIDs
      thermal/int340x_thermal: fix mode setting

Matthew Whitehead (1):
      x86/cpu/cyrix: Use correct macros for Cyrix calls on Geode processors

Maurizio Lombardi (1):
      scsi: iscsi: flush running unbind operations when removing a session

Mika Westerberg (1):
      PCI: Blacklist power management of Gigabyte X299 DESIGNARE EX PCIe po=
rts

Nathan Chancellor (1):
      x86/hw_breakpoints: Make default case in hw_breakpoint_arch_parse() r=
eturn an error

Paulo Alcantara (SUSE) (1):
      cifs: Fix slab-out-of-bounds when tracing SMB tcon

Peter Zijlstra (1):
      sched/cpufreq: Fix 32-bit math overflow

Petr =C5=A0tetiar (1):
      mips: bcm47xx: Enable USB power on Netgear WNDR3400v2

Phil Elwell (1):
      thermal: bcm2835: Fix crash in bcm2835_thermal_debugfs

Pi-Hsun Shih (1):
      include/linux/swap.h: use offsetof() instead of custom __swapoffset m=
acro

Rajneesh Bhardwaj (1):
      platform/x86: intel_pmc_core: Quirk to ignore XTAL shutdown

Ronnie Sahlberg (1):
      cifs: return -ENODATA when deleting an xattr that does not exist

Stanislaw Gruszka (1):
      lib/div64.c: off by one in shift

Stephane Eranian (1):
      perf/core: Restore mmap record type correctly

Steve French (1):
      fix incorrect error code mapping for OBJECTID_NOT_FOUND

Wei Hu (Xavier) (1):
      RDMA/hns: Fix the Oops during rmmod or insmod ko when reset occurs

Xiaoli Feng (1):
      cifs: fix that return -EINVAL when do dedupe operation

Yang Shi (1):
      ARM: 8839/1: kprobe: make patch_lock a raw_spinlock_t

YueHaibing (4):
      drm/nouveau/debugfs: Fix check of pm_runtime_get_sync failure
      appletalk: Fix use-after-free in atalk_proc_exit
      paride/pf: Fix potential NULL pointer dereference
      paride/pcd: Fix potential NULL pointer dereference and mem leak

Zhang Rui (2):
      thermal/intel_powerclamp: fix truncated kthread name
      Revert "ACPI / EC: Remove old CLEAR_ON_RESUME quirk"

ZhangXiaoxu (1):
      inotify: Fix fsnotify_mark refcount leak in inotify_update_existing_w=
atch()

wentalou (1):
      drm/amdgpu: psp_ring_destroy cause psp->km_ring.ring_mem NULL


--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAly7LY0ACgkQONu9yGCS
aT7MgRAA04xgPGmX10aWg6+8HfVegW34ZlsX7ht08AioF6fzOQP6gmTvtKT5AKi1
EizKsMLRDTRvd0T+qA5N8SzdeK/xNCYF9lasDiiO0vtmp/eL0aIyok2j1YFqfeF5
XxYKpBsl05SEWl8UD1LfpPTFRC/dPAajADRyW01/Ko6bNXmvvHYQINjMcw96FAWI
z6cAFgWAKOE9a/JA3UlZgPowddAQ0ImbYKKAkVtlwHzJMdEHJ4YIUu2ME4/R+Fq7
vj2DVUo0EyagbhKnmlKgCl3vb9iw6BLbw9tVtoYhWntnlX3nAayxjKCy9/oEeZ44
cUmCz2LbpuOGNQ4gbuoraHIy+xCTuilDgwxZ9TjjVtKZzcs9W/izB9Tf7S4fg0Y/
Wu+OupdqNIIXSSTKtetD9LJ8mJkwcwskI6zwUJz7S9Hlq74/vlx2fN8do2Zp1QGO
FcR4OyHRD78j+JJ33wiDgDXNT18bhu1x+zqvNVGQedlUVDoGW8QaCqD0v2yvWcam
VQtlCNxyPRe3MB2ep/eOJA2iZGjlSDzXX656upOuiLv0jkRsJcQn9anzj9N9VD8R
txsJyBLgAuA1IUThUGhVWMSCYZzK8nbly3vmI4ZFkXBizOtQDmrsTz7yIYKGqWi1
IRrEUjThzPR6ZiAafXFFkW8NQDGUzbOyg0CTKSVeCWmc3axGqmk=
=XEzh
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
