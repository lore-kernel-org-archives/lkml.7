Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB607C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7347D218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610681;
	bh=HzyoNmteyvcvopUvJRAF7/G/ZXJKewH1CUXokZjApuc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=FaDmaQx6xHuXE4sgZuVCVcv4kg++32ac39Kf8z5jMbzJ4jsWA0uXVEUibRZ+rRYkY
	 LfvRHPTv4mTOqf10lB4dCEEBaa5g2IHWZWi8t1Ao/2R8hPEAi16DbkBe7JOMsxsrbG
	 dhp2gmJBEvO7U/Im7iAXdeXuBfHEQLwpHFAl/lws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403768AbfDRSEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:04:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391125AbfDRSEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:04:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A63D42186A;
        Thu, 18 Apr 2019 18:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610675;
        bh=HzyoNmteyvcvopUvJRAF7/G/ZXJKewH1CUXokZjApuc=;
        h=From:To:Cc:Subject:Date:From;
        b=VyC3tIyy4cNO0kZC2bgFM+25M134yFDsEiRh3tEk2wCbFnYigRFeddWQwJmqNsdkD
         b27/puFfMnREzXAflaP9LBTvXjKV+9pevPfC/oTQaesmmczY/bwGKbc3IoQVJtzCdG
         8VQTIDhwMvVzdJjyt+r9t70OJob79AJw3zY7mqoc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 00/92] 4.14.113-stable review
Date:   Thu, 18 Apr 2019 19:56:18 +0200
Message-Id: <20190418160430.325165109@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.113-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.113-rc1
X-KernelTest-Deadline: 2019-04-20T16:04+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.113 release.
There are 92 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Apr 20 16:03:26 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.113-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.113-rc1

Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
    mm: hide incomplete nr_indirectly_reclaimable in sysfs

Lars Persson <lars.persson@axis.com>
    net: stmmac: Set dma ring length before enabling the DMA

Arnaldo Carvalho de Melo <acme@redhat.com>
    tools include: Adopt linux/bits.h

Balbir Singh <sblbir@amzn.com>
    bpf: Fix selftests are changes for CVE 2019-7308

Daniel Borkmann <daniel@iogearbox.net>
    bpf: fix sanitation rewrite in case of non-pointers

Xu Yu <xuyu@linux.alibaba.com>
    bpf: do not restore dst_reg when cur_state is freed

Daniel Borkmann <daniel@iogearbox.net>
    bpf: fix inner map masking to prevent oob under speculation

Daniel Borkmann <daniel@iogearbox.net>
    bpf: fix sanitation of alu op with pointer / scalar type from different paths

Daniel Borkmann <daniel@iogearbox.net>
    bpf: prevent out of bounds speculation on pointer arithmetic

Daniel Borkmann <daniel@iogearbox.net>
    bpf: fix check_map_access smin_value test when pointer contains offset

Daniel Borkmann <daniel@iogearbox.net>
    bpf: restrict unknown scalars of mixed signed bounds for unprivileged

Daniel Borkmann <daniel@iogearbox.net>
    bpf: restrict stack pointer arithmetic for unprivileged

Daniel Borkmann <daniel@iogearbox.net>
    bpf: restrict map value pointer arithmetic for unprivileged

Daniel Borkmann <daniel@iogearbox.net>
    bpf: enable access to ax register also from verifier rewrite

Daniel Borkmann <daniel@iogearbox.net>
    bpf: move tmp variable into ax register in interpreter

Daniel Borkmann <daniel@iogearbox.net>
    bpf: move {prev_,}insn_idx into verifier env

Alexei Starovoitov <ast@fb.com>
    bpf: fix stack state printing in verifier log

Craig Gallek <kraig@google.com>
    bpf: fix verifier NULL pointer dereference

Alexei Starovoitov <ast@fb.com>
    bpf: fix verifier memory leaks

Alexei Starovoitov <ast@fb.com>
    bpf: reduce verifier memory consumption

Mikulas Patocka <mpatocka@redhat.com>
    dm: disable CRYPTO_TFM_REQ_MAY_SLEEP to fix a GFP_KERNEL recursion deadlock

Daniel Borkmann <daniel@iogearbox.net>
    bpf: fix use after free in bpf_evict_inode

Pi-Hsun Shih <pihsun@chromium.org>
    include/linux/swap.h: use offsetof() instead of custom __swapoffset macro

Stanislaw Gruszka <sgruszka@redhat.com>
    lib/div64.c: off by one in shift

YueHaibing <yuehaibing@huawei.com>
    appletalk: Fix use-after-free in atalk_proc_exit

Kevin Wang <kevin1.wang@amd.com>
    drm/amdkfd: use init_mqd function to allocate object for hid_mqd (CI)

Yang Shi <yang.shi@linaro.org>
    ARM: 8839/1: kprobe: make patch_lock a raw_spinlock_t

Ilia Mirkin <imirkin@alum.mit.edu>
    drm/nouveau/volt/gf117: fix speedo readout register

Leo Yan <leo.yan@linaro.org>
    coresight: cpu-debug: Support for CA73 CPUs

Zhang Rui <rui.zhang@intel.com>
    Revert "ACPI / EC: Remove old CLEAR_ON_RESUME quirk"

Lars Persson <lars.persson@axis.com>
    crypto: axis - fix for recursive locking from bottom half

Hsin-Yi, Wang <hsinyi@chromium.org>
    drm/panel: panel-innolux: set display off in innolux_panel_unprepare

Christophe Leroy <christophe.leroy@c-s.fr>
    lkdtm: Add tests for NULL pointer dereference

Christophe Leroy <christophe.leroy@c-s.fr>
    lkdtm: Print real addresses

Dmitry Osipenko <digetx@gmail.com>
    soc/tegra: pmc: Drop locking from tegra_powergate_is_powered()

Julia Cartwright <julia@ni.com>
    iommu/dmar: Fix buffer overflow during PCI bus notification

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    crypto: sha512/arm - fix crash bug in Thumb2 build

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    crypto: sha256/arm - fix crash bug in Thumb2 build

Vitaly Kuznetsov <vkuznets@redhat.com>
    kernel: hung_task.c: disable on suspend

Steve French <stfrench@microsoft.com>
    cifs: fallback to older infolevels on findfirst queryinfo retry

ndesaulniers@google.com <ndesaulniers@google.com>
    compiler.h: update definition of unreachable()

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: nVMX: restore host state in nested_vmx_vmexit for VMFail

Ronald Tschalär <ronald@innovation.ch>
    ACPI / SBS: Fix GPE storm on recent MacBookPro's

Maciej Żenczykowski <maze@google.com>
    usbip: fix vhci_hcd controller counting

Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
    ARM: samsung: Limit SAMSUNG_PM_CHECK config option to non-Exynos platforms

Julian Sax <jsbc@gmx.de>
    HID: i2c-hid: override HID descriptors for certain devices

Brad Love <brad@nextdimension.cc>
    media: au0828: cannot kfree dev before usb disconnect

Nathan Fontenot <nfont@linux.vnet.ibm.com>
    powerpc/pseries: Remove prrn_work workqueue

Michal Simek <michal.simek@xilinx.com>
    serial: uartps: console_setup() can't be placed to init section

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: xt_cgroup: shrink size of v2 path

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to do sanity check with current segment number

Dinu-Razvan Chis-Serban <justcsdr@gmail.com>
    9p locks: add mount option for lock retry interval

Gertjan Halkes <gertjan@google.com>
    9p: do not trust pdu content for stat item size

Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>
    rsi: improve kernel thread handling to fix kernel panic

Robert Jarzmik <robert.jarzmik@free.fr>
    gpio: pxa: handle corner case of unprobed device

Darrick J. Wong <darrick.wong@oracle.com>
    ext4: prohibit fstrim in norecovery mode

Steve French <stfrench@microsoft.com>
    fix incorrect error code mapping for OBJECTID_NOT_FOUND

Nathan Chancellor <natechancellor@gmail.com>
    x86/hw_breakpoints: Make default case in hw_breakpoint_arch_parse() return an error

Lu Baolu <baolu.lu@linux.intel.com>
    iommu/vt-d: Check capability before disabling protected memory

YueHaibing <yuehaibing@huawei.com>
    drm/nouveau/debugfs: Fix check of pm_runtime_get_sync failure

Matthew Whitehead <tedheadster@gmail.com>
    x86/cpu/cyrix: Use correct macros for Cyrix calls on Geode processors

Aditya Pakki <pakki001@umn.edu>
    x86/hpet: Prevent potential NULL pointer dereference

Jianguo Chen <chenjianguo3@huawei.com>
    irqchip/mbigen: Don't clear eventid when freeing an MSI

Changbin Du <changbin.du@gmail.com>
    perf tests: Fix a memory leak in test__perf_evsel__tp_sched_test()

Changbin Du <changbin.du@gmail.com>
    perf tests: Fix memory leak by expr__find_other() in test__expr()

Changbin Du <changbin.du@gmail.com>
    perf tests: Fix a memory leak of cpu_map object in the openat_syscall_event_on_all_cpus test

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf evsel: Free evsel->counts in perf_evsel__exit()

Changbin Du <changbin.du@gmail.com>
    perf hist: Add missing map__put() in error case

Changbin Du <changbin.du@gmail.com>
    perf top: Fix error handling in cmd_top()

Changbin Du <changbin.du@gmail.com>
    perf build-id: Fix memory leak in print_sdt_events()

Changbin Du <changbin.du@gmail.com>
    perf config: Fix a memory leak in collect_config()

Changbin Du <changbin.du@gmail.com>
    perf config: Fix an error in the config template documentation

Changbin Du <changbin.du@gmail.com>
    perf list: Don't forget to drop the reference to the allocated thread_map

David Arcari <darcari@redhat.com>
    tools/power turbostat: return the exit status of a command

Matteo Croce <mcroce@redhat.com>
    x86/mm: Don't leak kernel addresses

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

Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
    thermal/intel_powerclamp: fix __percpu declaration of worker_data

Colin Ian King <colin.king@canonical.com>
    ALSA: opl3: fix mismatch between snd_opl3_drum_switch definition and declaration

Arnd Bergmann <arnd@arndb.de>
    mmc: davinci: remove extraneous __init annotation

Jack Morgenstein <jackm@dev.mellanox.co.il>
    IB/mlx4: Fix race condition between catas error reset and aliasguid flows

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

Stephane Eranian <eranian@google.com>
    perf/core: Restore mmap record type correctly

Corentin Labbe <clabbe@baylibre.com>
    arc: hsdk_defconfig: Enable CONFIG_BLK_DEV_RAM

Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    ARC: u-boot args: check that magic number is correct


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arc/configs/hsdk_defconfig                    |   1 +
 arch/arc/kernel/head.S                             |   1 +
 arch/arc/kernel/setup.c                            |   8 +
 arch/arm/crypto/sha256-armv4.pl                    |   3 +-
 arch/arm/crypto/sha256-core.S_shipped              |   3 +-
 arch/arm/crypto/sha512-armv4.pl                    |   3 +-
 arch/arm/crypto/sha512-core.S_shipped              |   3 +-
 arch/arm/kernel/patch.c                            |   6 +-
 arch/arm/plat-samsung/Kconfig                      |   2 +-
 arch/powerpc/kernel/rtasd.c                        |  17 +-
 arch/x86/kernel/cpu/cyrix.c                        |  14 +-
 arch/x86/kernel/hpet.c                             |   2 +
 arch/x86/kernel/hw_breakpoint.c                    |   1 +
 arch/x86/kernel/mpparse.c                          |   4 +-
 arch/x86/kvm/vmx.c                                 | 173 ++++-
 drivers/acpi/ec.c                                  |  53 ++
 drivers/acpi/sbs.c                                 |   8 +-
 drivers/auxdisplay/hd44780.c                       |   2 +
 drivers/base/node.c                                |   7 +-
 drivers/crypto/axis/artpec6_crypto.c               |  28 +-
 drivers/gpio/gpio-pxa.c                            |   6 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c   |  52 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/volt.h |   1 +
 drivers/gpu/drm/nouveau/nouveau_debugfs.c          |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/Kbuild    |   1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gf117.c   |  60 ++
 drivers/gpu/drm/panel/panel-innolux-p079zca.c      |  11 +-
 drivers/hid/i2c-hid/Makefile                       |   3 +
 drivers/hid/i2c-hid/{i2c-hid.c => i2c-hid-core.c}  |  56 +-
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c           | 376 ++++++++++
 drivers/hid/i2c-hid/i2c-hid.h                      |  20 +
 drivers/hwtracing/coresight/coresight-cpu-debug.c  |   4 +
 drivers/infiniband/hw/mlx4/alias_GUID.c            |   2 +-
 drivers/iommu/dmar.c                               |   2 +-
 drivers/iommu/intel-iommu.c                        |   3 +
 drivers/irqchip/irq-mbigen.c                       |   3 +
 drivers/md/dm-crypt.c                              |  10 +-
 drivers/md/dm-integrity.c                          |   4 +-
 drivers/media/usb/au0828/au0828-core.c             |   1 -
 drivers/misc/lkdtm.h                               |   2 +
 drivers/misc/lkdtm_core.c                          |   2 +
 drivers/misc/lkdtm_perms.c                         |  36 +-
 drivers/mmc/host/davinci_mmc.c                     |   2 +-
 drivers/net/ethernet/netronome/nfp/bpf/verifier.c  |   9 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   6 +-
 drivers/net/wireless/rsi/rsi_common.h              |   1 -
 drivers/scsi/scsi_transport_iscsi.c                |   2 +
 drivers/soc/tegra/pmc.c                            |   8 +-
 drivers/thermal/broadcom/bcm2835_thermal.c         |   9 +-
 drivers/thermal/int340x_thermal/int3400_thermal.c  |  21 +-
 drivers/thermal/intel_powerclamp.c                 |   4 +-
 drivers/tty/serial/xilinx_uartps.c                 |   2 +-
 fs/9p/v9fs.c                                       |  21 +
 fs/9p/v9fs.h                                       |   1 +
 fs/9p/vfs_dir.c                                    |   8 +-
 fs/9p/vfs_file.c                                   |   6 +-
 fs/cifs/inode.c                                    |  67 +-
 fs/cifs/smb2maperror.c                             |   3 +-
 fs/ext4/ioctl.c                                    |   7 +
 fs/ext4/resize.c                                   |  17 +-
 fs/f2fs/super.c                                    |  34 +-
 include/linux/atalk.h                              |   2 +-
 include/linux/bpf_verifier.h                       |  29 +-
 include/linux/compiler.h                           |   5 +-
 include/linux/filter.h                             |  10 +-
 include/linux/swap.h                               |   4 +-
 include/uapi/linux/netfilter/xt_cgroup.h           |  16 +
 kernel/bpf/core.c                                  |  51 +-
 kernel/bpf/inode.c                                 |  32 +-
 kernel/bpf/map_in_map.c                            |  17 +-
 kernel/bpf/verifier.c                              | 804 +++++++++++++++------
 kernel/events/core.c                               |   2 +
 kernel/hung_task.c                                 |  30 +-
 lib/div64.c                                        |   4 +-
 net/9p/protocol.c                                  |   3 +-
 net/appletalk/atalk_proc.c                         |   2 +-
 net/appletalk/ddp.c                                |  37 +-
 net/appletalk/sysctl_net_atalk.c                   |   5 +-
 net/netfilter/xt_cgroup.c                          |  72 ++
 sound/drivers/opl3/opl3_voice.h                    |   2 +-
 sound/isa/sb/sb8.c                                 |   4 +
 sound/pci/echoaudio/echoaudio.c                    |   5 +
 tools/include/linux/bitops.h                       |   7 +-
 tools/include/linux/bits.h                         |  26 +
 tools/perf/Documentation/perf-config.txt           |   2 +-
 tools/perf/builtin-top.c                           |   5 +-
 tools/perf/check-headers.sh                        |   1 +
 tools/perf/tests/evsel-tp-sched.c                  |   1 +
 tools/perf/tests/expr.c                            |   5 +-
 tools/perf/tests/openat-syscall-all-cpus.c         |   4 +-
 tools/perf/util/build-id.c                         |   1 +
 tools/perf/util/config.c                           |   3 +-
 tools/perf/util/evsel.c                            |   1 +
 tools/perf/util/hist.c                             |   4 +-
 tools/perf/util/parse-events.c                     |   2 +
 tools/power/x86/turbostat/turbostat.c              |   3 +
 tools/testing/selftests/bpf/test_verifier.c        |   6 +
 tools/usb/usbip/libsrc/vhci_driver.c               |   2 +-
 100 files changed, 1939 insertions(+), 500 deletions(-)


