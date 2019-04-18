Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E808BC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B76C21871
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611039;
	bh=gDTvrHyC/54nKDcTpq6N7EP1YOdsGm0538bktKFcOWw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=V3yKtfIuIlFJvE8euYVP3mWhL3F5TPHYSXUWfpHjy8qcAUJ/vW7XQSpc1Cc0gRUqa
	 mWwMVztnD6M42+ERlS1eAr8zFxiQ1R1xRjVMuevPuMTl+uEBwx7E/+49zkcq1aLAWy
	 vGSymvtuTipn7NplJSMJNfdeZIHpI377/MKFcwMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391735AbfDRSKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:10:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391486AbfDRSKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:10:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A578B206B6;
        Thu, 18 Apr 2019 18:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611034;
        bh=gDTvrHyC/54nKDcTpq6N7EP1YOdsGm0538bktKFcOWw=;
        h=From:To:Cc:Subject:Date:From;
        b=ACBTyufS6tsyWLw7kBYm+Zuc2SWpt+iewsR3YCUPlgtN6PwEh32v8f3XGd0DOAhyw
         GDeDjjIl9cD16tsr+MLbL9U8aHNL2sN7AJ+/SMQxMK+H6W480NoohZc8Yyd2gkRMU7
         51psBOtuxykp3iDHDb2/zMZvB9TkIIEs2CXxh9n4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 5.0 00/93] 5.0.9-stable review
Date:   Thu, 18 Apr 2019 19:56:38 +0200
Message-Id: <20190418160436.781762249@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-5.0.9-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.0.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.0.9-rc1
X-KernelTest-Deadline: 2019-04-20T16:04+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 5.0.9 release.
There are 93 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Apr 20 16:03:33 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.9-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.0.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.0.9-rc1

Kaike Wan <kaike.wan@intel.com>
    IB/hfi1: Failed to drain send queue when QP is put into error state

Daniel Borkmann <daniel@iogearbox.net>
    bpf: fix use after free in bpf_evict_inode

Pi-Hsun Shih <pihsun@chromium.org>
    include/linux/swap.h: use offsetof() instead of custom __swapoffset macro

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to add refcount once page is tagged PG_private

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to use kvfree instead of kzfree

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to dirty inode for i_mode recovery

David Howells <dhowells@redhat.com>
    rxrpc: Fix client call connect/disconnect race

Stanislaw Gruszka <sgruszka@redhat.com>
    lib/div64.c: off by one in shift

Ronnie Sahlberg <lsahlber@redhat.com>
    cifs: return -ENODATA when deleting an xattr that does not exist

YueHaibing <yuehaibing@huawei.com>
    appletalk: Fix use-after-free in atalk_proc_exit

Kevin Wang <kevin1.wang@amd.com>
    drm/amdkfd: use init_mqd function to allocate object for hid_mqd (CI)

Yang Shi <yang.shi@linaro.org>
    ARM: 8839/1: kprobe: make patch_lock a raw_spinlock_t

Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
    platform/x86: intel_pmc_core: Quirk to ignore XTAL shutdown

Ilia Mirkin <imirkin@alum.mit.edu>
    drm/nouveau/volt/gf117: fix speedo readout register

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: sync filesystem after roll-forward recovery

Bjorn Helgaas <bhelgaas@google.com>
    PCI/ASPM: Save LTR Capability for suspend/resume

Mika Westerberg <mika.westerberg@linux.intel.com>
    PCI: Blacklist power management of Gigabyte X299 DESIGNARE EX PCIe ports

Leo Yan <leo.yan@linaro.org>
    coresight: cpu-debug: Support for CA73 CPUs

Wei Hu (Xavier) <xavier.huwei@huawei.com>
    RDMA/hns: Fix the Oops during rmmod or insmod ko when reset occurs

Zhang Rui <rui.zhang@intel.com>
    Revert "ACPI / EC: Remove old CLEAR_ON_RESUME quirk"

Lars Persson <lars.persson@axis.com>
    crypto: axis - fix for recursive locking from bottom half

Huazhong Tan <tanhuazhong@huawei.com>
    net: hns3: Fix NULL deref when unloading driver

Hsin-Yi, Wang <hsinyi@chromium.org>
    drm/panel: panel-innolux: set display off in innolux_panel_unprepare

wentalou <Wentao.Lou@amd.com>
    drm/amdgpu: psp_ring_destroy cause psp->km_ring.ring_mem NULL

Christophe Leroy <christophe.leroy@c-s.fr>
    lkdtm: Add tests for NULL pointer dereference

Christophe Leroy <christophe.leroy@c-s.fr>
    lkdtm: Print real addresses

Darrick J. Wong <darrick.wong@oracle.com>
    ext4: prohibit fstrim in norecovery mode

Kairui Song <kasong@redhat.com>
    x86/gart: Exclude GART aperture from kcore

Paulo Alcantara (SUSE) <paulo@paulo.ac>
    cifs: Fix slab-out-of-bounds when tracing SMB tcon

Steve French <stfrench@microsoft.com>
    fix incorrect error code mapping for OBJECTID_NOT_FOUND

Xiaoli Feng <fengxiaoli0714@gmail.com>
    cifs: fix that return -EINVAL when do dedupe operation

Nathan Chancellor <natechancellor@gmail.com>
    x86/hw_breakpoints: Make default case in hw_breakpoint_arch_parse() return an error

Lu Baolu <baolu.lu@linux.intel.com>
    iommu/vt-d: Save the right domain ID used by hardware

Lu Baolu <baolu.lu@linux.intel.com>
    iommu/vt-d: Check capability before disabling protected memory

YueHaibing <yuehaibing@huawei.com>
    drm/nouveau/debugfs: Fix check of pm_runtime_get_sync failure

Matthew Whitehead <tedheadster@gmail.com>
    x86/cpu/cyrix: Use correct macros for Cyrix calls on Geode processors

Kangjie Lu <kjlu@umn.edu>
    x86/hyperv: Prevent potential NULL pointer dereference

Aditya Pakki <pakki001@umn.edu>
    x86/hpet: Prevent potential NULL pointer dereference

Jianguo Chen <chenjianguo3@huawei.com>
    irqchip/mbigen: Don't clear eventid when freeing an MSI

Fabien Dessenne <fabien.dessenne@st.com>
    irqchip/stm32: Don't set rising configuration registers at init

Fabien Dessenne <fabien.dessenne@st.com>
    irqchip/stm32: Don't clear rising/falling config registers at init

Andrzej Hajda <a.hajda@samsung.com>
    drm/exynos/mixer: fix MIXER shadow registry synchronisation code

Bart Van Assche <bvanassche@acm.org>
    blk-iolatency: #include "blk.h"

Jiada Wang <jiada_wang@mentor.com>
    PM / Domains: Avoid a potential deadlock

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    ACPI / utils: Drop reference in test for device presence

Changbin Du <changbin.du@gmail.com>
    perf tests: Fix a memory leak in test__perf_evsel__tp_sched_test()

Changbin Du <changbin.du@gmail.com>
    perf tests: Fix memory leak by expr__find_other() in test__expr()

Changbin Du <changbin.du@gmail.com>
    perf tests: Fix a memory leak of cpu_map object in the openat_syscall_event_on_all_cpus test

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf evsel: Free evsel->counts in perf_evsel__exit()

Changbin Du <changbin.du@gmail.com>
    perf top: Fix global-buffer-overflow issue

Changbin Du <changbin.du@gmail.com>
    perf maps: Purge all maps from the 'names' tree

Changbin Du <changbin.du@gmail.com>
    perf map: Remove map from 'names' tree in __maps__remove()

Changbin Du <changbin.du@gmail.com>
    perf hist: Add missing map__put() in error case

Changbin Du <changbin.du@gmail.com>
    perf top: Fix error handling in cmd_top()

Changbin Du <changbin.du@gmail.com>
    perf top: Delete the evlist before perf_session, fixing heap-use-after-free issue

Changbin Du <changbin.du@gmail.com>
    perf build-id: Fix memory leak in print_sdt_events()

Changbin Du <changbin.du@gmail.com>
    perf config: Fix a memory leak in collect_config()

Changbin Du <changbin.du@gmail.com>
    perf config: Fix an error in the config template documentation

Changbin Du <changbin.du@gmail.com>
    perf tools: Fix errors under optimization level '-Og'

Changbin Du <changbin.du@gmail.com>
    perf list: Don't forget to drop the reference to the allocated thread_map

Andi Kleen <ak@linux.intel.com>
    perf stat: Fix --no-scale

Himanshu Madhani <hmadhani@marvell.com>
    scsi: qla2xxx: Fix NULL pointer crash due to stale CPUID

Bart Van Assche <bvanassche@acm.org>
    scsi: core: Also call destroy_rcu_head() for passthrough requests

David Arcari <darcari@redhat.com>
    tools/power turbostat: return the exit status of a command

Matteo Croce <mcroce@redhat.com>
    x86/mm: Don't leak kernel addresses

Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
    sched/core: Fix buffer overflow in cgroup2 property cpu.max

Peter Zijlstra <peterz@infradead.org>
    sched/cpufreq: Fix 32-bit math overflow

Maurizio Lombardi <mlombard@redhat.com>
    scsi: iscsi: flush running unbind operations when removing a session

Zhang Rui <rui.zhang@intel.com>
    thermal/intel_powerclamp: fix truncated kthread name

Matthew Garrett <matthewgarrett@google.com>
    thermal/int340x_thermal: fix mode setting

Matthew Garrett <matthewgarrett@google.com>
    thermal/int340x_thermal: Add additional UUIDs

Phil Elwell <phil@raspberrypi.org>
    thermal: bcm2835: Fix crash in bcm2835_thermal_debugfs

Marek Szyprowski <m.szyprowski@samsung.com>
    thermal: samsung: Fix incorrect check after code merge

Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
    thermal/intel_powerclamp: fix __percpu declaration of worker_data

Jens Axboe <axboe@kernel.dk>
    paride/pcd: cleanup queues when detection fails

Jens Axboe <axboe@kernel.dk>
    paride/pf: cleanup queues when detection fails

Colin Ian King <colin.king@canonical.com>
    ALSA: opl3: fix mismatch between snd_opl3_drum_switch definition and declaration

Arnd Bergmann <arnd@arndb.de>
    mmc: davinci: remove extraneous __init annotation

Feng Tang <feng.tang@intel.com>
    i40iw: Avoid panic when handling the inetdev event

Jack Morgenstein <jackm@dev.mellanox.co.il>
    IB/mlx4: Fix race condition between catas error reset and aliasguid flows

Dave Airlie <airlied@redhat.com>
    drm/udl: use drm_gem_object_put_unlocked.

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    auxdisplay: hd44780: Fix memory leak on ->remove()

Kangjie Lu <kjlu@umn.edu>
    ALSA: sb8: add a check for request_region

Kangjie Lu <kjlu@umn.edu>
    ALSA: echoaudio: add a check for ioremap_nocache

Lukas Czerner <lczerner@redhat.com>
    ext4: report real fs size after failed resize

Lukas Czerner <lczerner@redhat.com>
    ext4: add missing brelse() in add_new_gdb_meta_bg()

Jan Kara <jack@suse.cz>
    ext4: avoid panic during forced reboot

Petr Štetiar <ynezz@true.cz>
    mips: bcm47xx: Enable USB power on Netgear WNDR3400v2

Jiri Olsa <jolsa@kernel.org>
    perf data: Don't store auxtrace index for directory data file

Stephane Eranian <eranian@google.com>
    perf/core: Restore mmap record type correctly

ZhangXiaoxu <zhangxiaoxu5@huawei.com>
    inotify: Fix fsnotify_mark refcount leak in inotify_update_existing_watch()

Corentin Labbe <clabbe@baylibre.com>
    arc: hsdk_defconfig: Enable CONFIG_BLK_DEV_RAM

Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    ARC: u-boot args: check that magic number is correct


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arc/configs/hsdk_defconfig                    |   1 +
 arch/arc/kernel/head.S                             |   1 +
 arch/arc/kernel/setup.c                            |   8 ++
 arch/arm/kernel/patch.c                            |   6 +-
 arch/mips/bcm47xx/workarounds.c                    |   1 +
 arch/x86/hyperv/hv_init.c                          |   6 +-
 arch/x86/kernel/aperture_64.c                      |  20 ++--
 arch/x86/kernel/cpu/cyrix.c                        |  14 +--
 arch/x86/kernel/hpet.c                             |   2 +
 arch/x86/kernel/hw_breakpoint.c                    |   1 +
 arch/x86/kernel/mpparse.c                          |   4 +-
 block/blk-iolatency.c                              |   1 +
 drivers/acpi/ec.c                                  |  53 ++++++++++
 drivers/acpi/utils.c                               |   1 +
 drivers/auxdisplay/hd44780.c                       |   2 +
 drivers/base/power/domain.c                        |  13 ++-
 drivers/block/paride/pcd.c                         |   6 +-
 drivers/block/paride/pf.c                          |  16 ++-
 drivers/crypto/axis/artpec6_crypto.c               |  28 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c   |  52 +---------
 drivers/gpu/drm/exynos/exynos_mixer.c              | 110 ++++++++++++---------
 drivers/gpu/drm/nouveau/include/nvkm/subdev/volt.h |   1 +
 drivers/gpu/drm/nouveau/nouveau_debugfs.c          |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/Kbuild    |   1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gf117.c   |  60 +++++++++++
 drivers/gpu/drm/panel/panel-innolux-p079zca.c      |  11 +--
 drivers/gpu/drm/udl/udl_gem.c                      |   2 +-
 drivers/hwtracing/coresight/coresight-cpu-debug.c  |   4 +
 drivers/infiniband/hw/hfi1/qp.c                    |   2 +-
 drivers/infiniband/hw/hns/hns_roce_device.h        |  21 ++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         | 103 ++++++++++++++++---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h         |   1 +
 drivers/infiniband/hw/i40iw/i40iw_utils.c          |  12 ++-
 drivers/infiniband/hw/mlx4/alias_GUID.c            |   2 +-
 drivers/iommu/intel-iommu.c                        |   5 +-
 drivers/irqchip/irq-mbigen.c                       |   3 +
 drivers/irqchip/irq-stm32-exti.c                   |  10 --
 drivers/misc/lkdtm/core.c                          |   2 +
 drivers/misc/lkdtm/lkdtm.h                         |   2 +
 drivers/misc/lkdtm/perms.c                         |  36 +++++--
 drivers/mmc/host/davinci_mmc.c                     |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   2 +
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  28 ++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  20 +---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c    |   8 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_mdio.h    |   4 +-
 drivers/pci/pci.c                                  |  75 +++++++++++++-
 drivers/platform/x86/intel_pmc_core.c              |  34 +++++++
 drivers/platform/x86/intel_pmc_core.h              |   5 +
 drivers/scsi/qla2xxx/qla_os.c                      |   2 +-
 drivers/scsi/scsi_lib.c                            |   9 +-
 drivers/scsi/scsi_transport_iscsi.c                |   2 +
 drivers/thermal/broadcom/bcm2835_thermal.c         |   9 +-
 .../intel/int340x_thermal/int3400_thermal.c        |  21 +++-
 drivers/thermal/intel/intel_powerclamp.c           |   4 +-
 drivers/thermal/samsung/exynos_tmu.c               |   2 +-
 fs/cifs/cifsfs.c                                   |   2 +-
 fs/cifs/smb2maperror.c                             |   3 +-
 fs/cifs/smb2ops.c                                  |  10 ++
 fs/cifs/trace.h                                    |   6 +-
 fs/ext4/ioctl.c                                    |   7 ++
 fs/ext4/resize.c                                   |  17 +++-
 fs/ext4/super.c                                    |  16 ++-
 fs/f2fs/checkpoint.c                               |   9 +-
 fs/f2fs/data.c                                     |  21 ++--
 fs/f2fs/dir.c                                      |   2 +-
 fs/f2fs/f2fs.h                                     |  21 ++++
 fs/f2fs/file.c                                     |   5 +-
 fs/f2fs/node.c                                     |   6 +-
 fs/f2fs/segment.c                                  |   9 +-
 fs/f2fs/super.c                                    |  44 ++++++---
 fs/f2fs/xattr.c                                    |  10 +-
 fs/notify/inotify/inotify_user.c                   |   7 +-
 fs/proc/kcore.c                                    |  27 +++++
 include/linux/atalk.h                              |   2 +-
 include/linux/kcore.h                              |   2 +
 include/linux/swap.h                               |   4 +-
 include/trace/events/rxrpc.h                       |   2 +
 kernel/bpf/inode.c                                 |  32 +++---
 kernel/events/core.c                               |   2 +
 kernel/sched/core.c                                |   2 +-
 kernel/sched/cpufreq_schedutil.c                   |  59 +++++------
 lib/div64.c                                        |   4 +-
 net/appletalk/atalk_proc.c                         |   2 +-
 net/appletalk/ddp.c                                |  37 +++++--
 net/appletalk/sysctl_net_atalk.c                   |   5 +-
 net/rxrpc/conn_client.c                            |  20 +++-
 sound/drivers/opl3/opl3_voice.h                    |   2 +-
 sound/isa/sb/sb8.c                                 |   4 +
 sound/pci/echoaudio/echoaudio.c                    |   5 +
 tools/lib/bpf/libbpf.c                             |   2 +-
 tools/perf/Documentation/perf-config.txt           |   2 +-
 tools/perf/Documentation/perf-stat.txt             |   5 +-
 tools/perf/bench/epoll-ctl.c                       |   2 +-
 tools/perf/bench/epoll-wait.c                      |   2 +-
 tools/perf/builtin-record.c                        |   2 +-
 tools/perf/builtin-stat.c                          |   3 +-
 tools/perf/builtin-top.c                           |  47 +++++----
 tools/perf/tests/backward-ring-buffer.c            |   2 +-
 tools/perf/tests/evsel-tp-sched.c                  |   1 +
 tools/perf/tests/expr.c                            |   5 +-
 tools/perf/tests/openat-syscall-all-cpus.c         |   4 +-
 tools/perf/util/build-id.c                         |   1 +
 tools/perf/util/config.c                           |   3 +-
 tools/perf/util/evsel.c                            |   4 +-
 tools/perf/util/hist.c                             |   4 +-
 tools/perf/util/map.c                              |  18 ++++
 tools/perf/util/ordered-events.c                   |   2 +
 tools/perf/util/parse-events.c                     |   2 +
 tools/perf/util/stat.c                             |  12 +--
 tools/power/x86/turbostat/turbostat.c              |   3 +
 114 files changed, 996 insertions(+), 397 deletions(-)


