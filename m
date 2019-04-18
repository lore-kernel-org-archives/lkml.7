Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC4DC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8E5218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610896;
	bh=DBnQ4szIpoQUFU+eGDdcQxfjFzxpWdSwtnTqodU9Z8w=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=a1/mbko3zMmH3cC2uFYxc/H/ewugRfsrslbkqlxiFy3CU1lD+aRxOMXZxcpt+Xzk7
	 hfzUYZgoChy1S3w485Gw+Tg0swQ3rnQ68SJhH1MsF1AdUespUaaIkUtjaa1513kWX7
	 8K7gta/44ZKsmM2HTZDkz6LaI4xowfCzI5pq71BU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391750AbfDRSIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:08:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391734AbfDRSIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:08:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 960B7217FA;
        Thu, 18 Apr 2019 18:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610889;
        bh=DBnQ4szIpoQUFU+eGDdcQxfjFzxpWdSwtnTqodU9Z8w=;
        h=From:To:Cc:Subject:Date:From;
        b=bBMW+CORS0wCaB7jlCmPOWntFA4UaRatU0EDwGz7jFdmwHoGwHOjkBcc1yAZOP11O
         CuQTMX8xzhqcCmPO7MlfOzshoBtzpj9G5mAB21tRdqxtd+T1GpXwBM46WItKZqLF+H
         pZKZALCqwLYE6HKYqqVFVJ4pXnv3dSczpz9Z0x7M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/50] 4.9.170-stable review
Date:   Thu, 18 Apr 2019 19:57:11 +0200
Message-Id: <20190418160422.455656724@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.170-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.170-rc1
X-KernelTest-Deadline: 2019-04-20T16:04+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.170 release.
There are 50 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Apr 20 16:03:22 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.170-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.170-rc1

Lars Persson <lars.persson@axis.com>
    net: stmmac: Set dma ring length before enabling the DMA

Arnaldo Carvalho de Melo <acme@redhat.com>
    tools include: Adopt linux/bits.h

Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
    tpm/tpm_crb: Avoid unaligned reads in crb_recv()

Pi-Hsun Shih <pihsun@chromium.org>
    include/linux/swap.h: use offsetof() instead of custom __swapoffset macro

Stanislaw Gruszka <sgruszka@redhat.com>
    lib/div64.c: off by one in shift

YueHaibing <yuehaibing@huawei.com>
    appletalk: Fix use-after-free in atalk_proc_exit

Yang Shi <yang.shi@linaro.org>
    ARM: 8839/1: kprobe: make patch_lock a raw_spinlock_t

Christophe Leroy <christophe.leroy@c-s.fr>
    lkdtm: Add tests for NULL pointer dereference

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

Ronald Tschalär <ronald@innovation.ch>
    ACPI / SBS: Fix GPE storm on recent MacBookPro's

Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
    ARM: samsung: Limit SAMSUNG_PM_CHECK config option to non-Exynos platforms

Julian Sax <jsbc@gmx.de>
    HID: i2c-hid: override HID descriptors for certain devices

Michal Simek <michal.simek@xilinx.com>
    serial: uartps: console_setup() can't be placed to init section

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

Matthew Whitehead <tedheadster@gmail.com>
    x86/cpu/cyrix: Use correct macros for Cyrix calls on Geode processors

Aditya Pakki <pakki001@umn.edu>
    x86/hpet: Prevent potential NULL pointer dereference

Jianguo Chen <chenjianguo3@huawei.com>
    irqchip/mbigen: Don't clear eventid when freeing an MSI

Changbin Du <changbin.du@gmail.com>
    perf tests: Fix a memory leak in test__perf_evsel__tp_sched_test()

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

David Arcari <darcari@redhat.com>
    tools/power turbostat: return the exit status of a command

Matthew Garrett <matthewgarrett@google.com>
    thermal/int340x_thermal: fix mode setting

Matthew Garrett <matthewgarrett@google.com>
    thermal/int340x_thermal: Add additional UUIDs

Colin Ian King <colin.king@canonical.com>
    ALSA: opl3: fix mismatch between snd_opl3_drum_switch definition and declaration

Arnd Bergmann <arnd@arndb.de>
    mmc: davinci: remove extraneous __init annotation

Jack Morgenstein <jackm@dev.mellanox.co.il>
    IB/mlx4: Fix race condition between catas error reset and aliasguid flows

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

Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    ARC: u-boot args: check that magic number is correct


-------------

Diffstat:

 Makefile                                          |   4 +-
 arch/arc/kernel/head.S                            |   1 +
 arch/arc/kernel/setup.c                           |   8 +
 arch/arm/crypto/sha256-armv4.pl                   |   3 +-
 arch/arm/crypto/sha256-core.S_shipped             |   3 +-
 arch/arm/crypto/sha512-armv4.pl                   |   3 +-
 arch/arm/crypto/sha512-core.S_shipped             |   3 +-
 arch/arm/kernel/patch.c                           |   6 +-
 arch/arm/plat-samsung/Kconfig                     |   2 +-
 arch/x86/kernel/cpu/cyrix.c                       |  14 +-
 arch/x86/kernel/hpet.c                            |   2 +
 arch/x86/kernel/hw_breakpoint.c                   |   1 +
 drivers/acpi/sbs.c                                |   8 +-
 drivers/char/tpm/tpm_crb.c                        |  22 +-
 drivers/gpio/gpio-pxa.c                           |   6 +
 drivers/hid/i2c-hid/Makefile                      |   3 +
 drivers/hid/i2c-hid/{i2c-hid.c => i2c-hid-core.c} |  56 ++--
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c          | 376 ++++++++++++++++++++++
 drivers/hid/i2c-hid/i2c-hid.h                     |  20 ++
 drivers/infiniband/hw/mlx4/alias_GUID.c           |   2 +-
 drivers/iommu/dmar.c                              |   2 +-
 drivers/iommu/intel-iommu.c                       |   3 +
 drivers/irqchip/irq-mbigen.c                      |   3 +
 drivers/misc/lkdtm.h                              |   2 +
 drivers/misc/lkdtm_core.c                         |   2 +
 drivers/misc/lkdtm_perms.c                        |  18 ++
 drivers/mmc/host/davinci_mmc.c                    |   2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  10 +-
 drivers/net/wireless/rsi/rsi_common.h             |   1 -
 drivers/soc/tegra/pmc.c                           |   8 +-
 drivers/thermal/int340x_thermal/int3400_thermal.c |  21 +-
 drivers/tty/serial/xilinx_uartps.c                |   2 +-
 fs/9p/v9fs.c                                      |  21 ++
 fs/9p/v9fs.h                                      |   1 +
 fs/9p/vfs_dir.c                                   |   8 +-
 fs/9p/vfs_file.c                                  |   6 +-
 fs/cifs/inode.c                                   |  67 ++--
 fs/cifs/smb2maperror.c                            |   3 +-
 fs/ext4/ioctl.c                                   |   7 +
 fs/ext4/resize.c                                  |  17 +-
 fs/f2fs/super.c                                   |  34 +-
 include/linux/atalk.h                             |   2 +-
 include/linux/swap.h                              |   4 +-
 kernel/events/core.c                              |   2 +
 kernel/hung_task.c                                |  30 +-
 lib/div64.c                                       |   4 +-
 net/9p/protocol.c                                 |   3 +-
 net/appletalk/atalk_proc.c                        |   2 +-
 net/appletalk/ddp.c                               |  37 ++-
 net/appletalk/sysctl_net_atalk.c                  |   5 +-
 sound/drivers/opl3/opl3_voice.h                   |   2 +-
 sound/isa/sb/sb8.c                                |   4 +
 sound/pci/echoaudio/echoaudio.c                   |   5 +
 tools/include/linux/bitops.h                      |   6 +-
 tools/include/linux/bits.h                        |  26 ++
 tools/perf/Documentation/perf-config.txt          |   2 +-
 tools/perf/builtin-top.c                          |   5 +-
 tools/perf/check-headers.sh                       |   1 +
 tools/perf/tests/evsel-tp-sched.c                 |   1 +
 tools/perf/tests/openat-syscall-all-cpus.c        |   4 +-
 tools/perf/util/build-id.c                        |   1 +
 tools/perf/util/config.c                          |   3 +-
 tools/perf/util/evsel.c                           |   1 +
 tools/perf/util/hist.c                            |   4 +-
 tools/perf/util/parse-events.c                    |   1 +
 tools/power/x86/turbostat/turbostat.c             |   3 +
 66 files changed, 807 insertions(+), 132 deletions(-)


