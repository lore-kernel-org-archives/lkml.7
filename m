Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36178C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E4B21904
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556125944;
	bh=2+MzPH/ThWUjm3lAy3htM9uGUQN1yre5I/pGmNCXtHY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=rb3/wQeLOT1LMihglQhdnbzgeOjlbQBDn9oqy7NDZZRVP10YYwgPtBvib7S2IJk2p
	 it+ii9+yz0XADSpJUu4B4WhLy0lJ3gx/kjQDWvJm97CfEafgurVXHRtl5qDw1xGZHl
	 GE/7HeXc3638xLl40THI4siWJhuttINt0V41CZkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387622AbfDXRMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:12:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387609AbfDXRMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:12:21 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2B612190C;
        Wed, 24 Apr 2019 17:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556125939;
        bh=2+MzPH/ThWUjm3lAy3htM9uGUQN1yre5I/pGmNCXtHY=;
        h=From:To:Cc:Subject:Date:From;
        b=SZP741tF7niarq8QmY/HnFUAxqHqpZdsKcTbas+DOkPltW3F4jmre6ugP6+cbSy0B
         mwdXz6hcRtvKbR8G7LZrA9gKULa09TK/OjkfEfCqw/JAw0onLUU+HONZOEoxPvTAqi
         qS9o+jahIk6e+aJ7FYEE02w9SWwug4iq7mox0LoE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 000/104] 3.18.139-stable review
Date:   Wed, 24 Apr 2019 19:08:17 +0200
Message-Id: <20190424170839.996641496@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.139-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.139-rc1
X-KernelTest-Deadline: 2019-04-26T17:09+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.18.139 release.
There are 104 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri 26 Apr 2019 05:07:26 PM UTC.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.139-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.139-rc1

Jann Horn <jannh@google.com>
    device_cgroup: fix RCU imbalance in error case

Phil Auld <pauld@redhat.com>
    sched/fair: Limit sched_cfs_period_timer() loop to avoid hard lockup

Masami Hiramatsu <mhiramat@kernel.org>
    kprobes: Fix error check when reusing optimized probes

Masami Hiramatsu <mhiramat@kernel.org>
    x86/kprobes: Verify stack frame on kretprobe

Takashi Iwai <tiwai@suse.de>
    ALSA: core: Fix card races between register and disconnect

Ian Abbott <abbotti@mev.co.uk>
    staging: comedi: ni_usb6501: Fix possible double-free of ->usb_rx_buf

Ian Abbott <abbotti@mev.co.uk>
    staging: comedi: vmk80xx: Fix possible double-free of ->usb_rx_buf

Ian Abbott <abbotti@mev.co.uk>
    staging: comedi: vmk80xx: Fix use of uninitialized semaphore

Georg Ottinger <g.ottinger@abatec.at>
    iio: adc: at91: disable adc channel interrupt in timeout case

Dragos Bogdan <dragos.bogdan@analog.com>
    iio: ad_sigma_delta: select channel when reading register

Eric Dumazet <edumazet@google.com>
    tcp: tcp_grow_window() needs to respect tcp_space()

Eric Dumazet <edumazet@google.com>
    ipv4: ensure rcu_read_lock() in ipv4_link_failure()

Stephen Suryaputra <ssuryaextr@gmail.com>
    ipv4: recompile ip options in ipv4_link_failure

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    net: bridge: multicast: use rcu to access port list from br_multicast_start_querier

Sabrina Dubroca <sd@queasysnail.net>
    bonding: fix event handling for stacked bonds

Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
    tpm/tpm_i2c_atmel: Return -E2BIG when the transfer is incomplete

Christian Lamparter <chunkeey@gmail.com>
    crypto: crypto4xx - properly set IV after de- and encrypt

Arnd Bergmann <arnd@arndb.de>
    appletalk: Fix compile regression

Amit Klein <aksecurity@gmail.com>
    inet: update the IP ID generation algorithm to higher standards.

Pi-Hsun Shih <pihsun@chromium.org>
    include/linux/swap.h: use offsetof() instead of custom __swapoffset macro

Stanislaw Gruszka <sgruszka@redhat.com>
    lib/div64.c: off by one in shift

YueHaibing <yuehaibing@huawei.com>
    appletalk: Fix use-after-free in atalk_proc_exit

Julia Cartwright <julia@ni.com>
    iommu/dmar: Fix buffer overflow during PCI bus notification

Ronald Tschalär <ronald@innovation.ch>
    ACPI / SBS: Fix GPE storm on recent MacBookPro's

Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
    ARM: samsung: Limit SAMSUNG_PM_CHECK config option to non-Exynos platforms

Michal Simek <michal.simek@xilinx.com>
    serial: uartps: console_setup() can't be placed to init section

Dinu-Razvan Chis-Serban <justcsdr@gmail.com>
    9p locks: add mount option for lock retry interval

Gertjan Halkes <gertjan@google.com>
    9p: do not trust pdu content for stat item size

Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>
    rsi: improve kernel thread handling to fix kernel panic

Steve French <stfrench@microsoft.com>
    fix incorrect error code mapping for OBJECTID_NOT_FOUND

Lu Baolu <baolu.lu@linux.intel.com>
    iommu/vt-d: Check capability before disabling protected memory

Matthew Whitehead <tedheadster@gmail.com>
    x86/cpu/cyrix: Use correct macros for Cyrix calls on Geode processors

Aditya Pakki <pakki001@umn.edu>
    x86/hpet: Prevent potential NULL pointer dereference

Changbin Du <changbin.du@gmail.com>
    perf tests: Fix a memory leak in test__perf_evsel__tp_sched_test()

Changbin Du <changbin.du@gmail.com>
    perf top: Fix error handling in cmd_top()

David Arcari <darcari@redhat.com>
    tools/power turbostat: return the exit status of a command

Matthew Garrett <matthewgarrett@google.com>
    thermal/int340x_thermal: fix mode setting

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

Stephane Eranian <eranian@google.com>
    perf/core: Restore mmap record type correctly

Tejun Heo <tj@kernel.org>
    string: drop __must_check from strscpy() and restore strscpy() usages in cgroup

Andre Przywara <andre.przywara@arm.com>
    PCI: Add function 1 DMA alias quirk for Marvell 9170 SATA controller

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: fix return_address

Mel Gorman <mgorman@techsingularity.net>
    sched/fair: Do not re-read ->h_load_next during hierarchical load calculation

Dan Carpenter <dan.carpenter@oracle.com>
    xen: Prevent buffer overflow in privcmd ioctl

Will Deacon <will.deacon@arm.com>
    arm64: futex: Fix FUTEX_WAKE_OP atomic ops with non-zero result value

Jérôme Glisse <jglisse@redhat.com>
    block: do not leak memory in bio_copy_user_iov()

S.j. Wang <shengjiu.wang@nxp.com>
    ASoC: fsl_esai: fix channel swap issue when stream starts

Zubin Mithra <zsm@chromium.org>
    ALSA: seq: Fix OOB-reads from strlcpy

Sheena Mira-ato <sheena.mira-ato@alliedtelesis.co.nz>
    ip6_tunnel: Match to ARPHRD_TUNNEL6 for dev type

Li RongQing <lirongqing@baidu.com>
    net: ethtool: not call vzalloc for zero sized memory request

Eric Dumazet <edumazet@google.com>
    netns: provide pure entropy for net_hash_mix()

Xin Long <lucien.xin@gmail.com>
    sctp: initialize _pad of sockaddr_in before copying to user memory

Bjørn Mork <bjorn@mork.no>
    qmi_wwan: add Olicard 600

Andrea Righi <andrea.righi@canonical.com>
    openvswitch: fix flow actions reallocation

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    tty: ldisc: add sysctl to prevent autoloading of ldiscs

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    tty: mark Siemens R3964 line discipline as BROKEN

Nick Desaulniers <ndesaulniers@google.com>
    lib/string.c: implement a basic bcmp

Linus Torvalds <torvalds@linux-foundation.org>
    binfmt_elf: switch to new creds when switching to new mm

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/dp/mst: Configure no_stop_bit correctly for remote i2c xfers

Ben Dooks <ben.dooks@codethink.co.uk>
    dmaengine: tegra: avoid overflow of byte tracking

Rafael Ávila de Espíndola <rafael@espindo.la>
    x86/build: Mark per-CPU symbols as absolute explicitly for LLD

Zumeng Chen <zumeng.chen@gmail.com>
    wlcore: Fix memory leak in case wl12xx_fetch_firmware failure

Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
    media: s5p-jpeg: Check for fmt_ver_flag when doing fmt enumeration

Anders Roxell <anders.roxell@linaro.org>
    dmaengine: imx-dma: fix warning comparison of distinct pointer types

Buland Singh <bsingh@redhat.com>
    hpet: Fix missing '=' character in the __setup() code of hpet_mmap_enable

David Tolnay <dtolnay@gmail.com>
    hwrng: virtio - Avoid repeated init of completion

Akinobu Mita <akinobu.mita@gmail.com>
    media: mt9m111: set initial frame size other than 0x0

Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
    tty: increase the default flip buffer limit to 2*640K

Waiman Long <longman@redhat.com>
    locking/lockdep: Add debug_locks check in __lock_downgrade()

Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
    e1000e: fix cyclic resets at link up with active tx

Guenter Roeck <linux@roeck-us.net>
    cdrom: Fix race condition in cdrom_sysctl_register

Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
    fbdev: fbmem: fix memory access if logo is bigger than the screen

Coly Li <colyli@suse.de>
    bcache: improve sysfs_strtoul_clamp()

Coly Li <colyli@suse.de>
    bcache: fix input overflow to sequential_cutoff

Coly Li <colyli@suse.de>
    bcache: fix input overflow to cache set sysfs file io_error_halflife

Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
    ALSA: PCM: check if ops are defined before suspending PCM

Nathan Chancellor <natechancellor@gmail.com>
    ARM: 8833/1: Ensure that NEON code always compiles with Clang

Andrea Righi <righi.andrea@gmail.com>
    kprobes: Prohibit probing on bsearch()

Michal Kazior <michal@plume.com>
    leds: lp55xx: fix null deref on firmware load failure

Wen Yang <yellowriver2010@hotmail.com>
    SoC: imx-sgtl5000: add missing put_device()

Jason Yan <yanaijie@huawei.com>
    scsi: megaraid_sas: return error when create DMA pool failed

Håkon Bugge <haakon.bugge@oracle.com>
    IB/mlx4: Increase the timeout for CM cache

Florian Fainelli <f.fainelli@gmail.com>
    e1000e: Fix -Wformat-truncation warnings

Aaro Koskinen <aaro.koskinen@iki.fi>
    mmc: omap: fix the maximum timeout setting

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    ARM: 8840/1: use a raw_spinlock_t in unwind

Benjamin Block <bblock@linux.ibm.com>
    scsi: core: replace GFP_ATOMIC with GFP_KERNEL in scsi_scan.c

Tony Jones <tonyj@suse.de>
    tools lib traceevent: Fix buffer overflow in arg_eval

Carlos Maiolino <cmaiolino@redhat.com>
    fs: fix guard_bio_eod to check for real EOD errors

Yao Liu <yotta.liu@ucloud.cn>
    cifs: Fix NULL pointer dereference of devname

Jason Cai (Xiang Feng) <jason.cai.kern@gmail.com>
    dm thin: add sanity checks to thin-pool and external snapshot creation

Louis Taylor <louis@kragniz.eu>
    cifs: use correct format characters

Jia Guo <guojia12@huawei.com>
    ocfs2: fix a panic problem caused by o2cb_ctl

Qian Cai <cai@lca.pw>
    mm/slab.c: kmemleak no scan alien caches

Uladzislau Rezki (Sony) <urezki@gmail.com>
    mm/vmalloc.c: fix kernel BUG at mm/vmalloc.c:512!

Peng Fan <peng.fan@nxp.com>
    mm/cma.c: cma_declare_contiguous: correct err handling

Christian Brauner <christian@brauner.io>
    sysctl: handle overflow for file-max

Douglas Anderson <dianders@chromium.org>
    tracing: kdb: Fix ftdump to not sleep

Jeremy Compostella <jeremy.compostella@intel.com>
    i2c: core-smbus: prevent stack corruption on read I2C_BLOCK_DATA

zhangyi (F) <yi.zhang@huawei.com>
    ext4: cleanup bh release code in ext4_ind_remove_space()


-------------

Diffstat:

 Documentation/arm/kernel_mode_neon.txt            |  4 +-
 Makefile                                          |  4 +-
 arch/arm/kernel/unwind.c                          | 14 +++----
 arch/arm/lib/Makefile                             |  2 +-
 arch/arm/lib/xor-neon.c                           |  2 +-
 arch/arm/plat-samsung/Kconfig                     |  2 +-
 arch/arm64/include/asm/futex.h                    | 16 ++++----
 arch/x86/include/asm/xen/hypercall.h              |  3 ++
 arch/x86/kernel/cpu/cyrix.c                       | 14 +++----
 arch/x86/kernel/hpet.c                            |  2 +
 arch/x86/kernel/kprobes/core.c                    | 26 +++++++++++++
 arch/x86/kernel/vmlinux.lds.S                     |  2 +-
 arch/xtensa/kernel/stacktrace.c                   |  6 ++-
 block/bio.c                                       |  5 ++-
 drivers/acpi/sbs.c                                |  8 +++-
 drivers/cdrom/cdrom.c                             |  7 ++--
 drivers/char/Kconfig                              |  2 +-
 drivers/char/hpet.c                               |  2 +-
 drivers/char/hw_random/virtio-rng.c               |  2 +-
 drivers/char/tpm/tpm_i2c_atmel.c                  | 10 ++++-
 drivers/crypto/amcc/crypto4xx_alg.c               |  3 +-
 drivers/crypto/amcc/crypto4xx_core.c              |  9 +++++
 drivers/dma/imx-dma.c                             |  2 +-
 drivers/dma/tegra20-apb-dma.c                     |  5 ++-
 drivers/gpu/drm/drm_dp_mst_topology.c             |  1 +
 drivers/i2c/i2c-core.c                            | 12 +++---
 drivers/iio/adc/ad_sigma_delta.c                  |  1 +
 drivers/iio/adc/at91_adc.c                        | 28 ++++++++------
 drivers/infiniband/hw/mlx4/alias_GUID.c           |  2 +-
 drivers/infiniband/hw/mlx4/cm.c                   |  2 +-
 drivers/iommu/dmar.c                              |  2 +-
 drivers/iommu/intel-iommu.c                       |  3 ++
 drivers/leds/leds-lp55xx-common.c                 |  4 +-
 drivers/md/bcache/sysfs.c                         | 17 ++++++--
 drivers/md/bcache/sysfs.h                         | 13 +++++--
 drivers/md/dm-thin.c                              | 13 +++++++
 drivers/media/i2c/soc_camera/mt9m111.c            |  2 +
 drivers/media/platform/s5p-jpeg/jpeg-core.c       | 19 +++++----
 drivers/mmc/host/davinci_mmc.c                    |  2 +-
 drivers/mmc/host/omap.c                           |  2 +-
 drivers/net/bonding/bond_main.c                   |  6 ++-
 drivers/net/ethernet/intel/e1000e/netdev.c        | 19 ++++-----
 drivers/net/usb/qmi_wwan.c                        |  1 +
 drivers/net/wireless/rsi/rsi_common.h             |  1 -
 drivers/net/wireless/ti/wlcore/main.c             |  7 +++-
 drivers/pci/quirks.c                              |  2 +
 drivers/scsi/megaraid/megaraid_sas_base.c         |  1 +
 drivers/scsi/scsi_scan.c                          |  6 +--
 drivers/staging/comedi/drivers/ni_usb6501.c       |  4 +-
 drivers/staging/comedi/drivers/vmk80xx.c          |  8 ++--
 drivers/thermal/int340x_thermal/int3400_thermal.c |  7 ++--
 drivers/tty/Kconfig                               | 23 +++++++++++
 drivers/tty/serial/xilinx_uartps.c                |  2 +-
 drivers/tty/tty_buffer.c                          |  2 +-
 drivers/tty/tty_io.c                              |  3 ++
 drivers/tty/tty_ldisc.c                           | 47 +++++++++++++++++++++++
 drivers/video/fbdev/core/fbmem.c                  |  3 ++
 fs/9p/v9fs.c                                      | 21 ++++++++++
 fs/9p/v9fs.h                                      |  1 +
 fs/9p/vfs_dir.c                                   |  8 ++--
 fs/9p/vfs_file.c                                  |  6 ++-
 fs/binfmt_elf.c                                   |  2 +-
 fs/buffer.c                                       |  7 ++++
 fs/cifs/cifs_dfs_ref.c                            |  4 +-
 fs/cifs/connect.c                                 |  5 +++
 fs/cifs/smb1ops.c                                 |  2 +-
 fs/cifs/smb2maperror.c                            |  3 +-
 fs/ext4/indirect.c                                | 47 +++++++++++------------
 fs/ext4/resize.c                                  |  6 ++-
 fs/ocfs2/cluster/nodemanager.c                    | 14 ++++---
 include/linux/atalk.h                             | 20 +++++++---
 include/linux/kprobes.h                           |  1 +
 include/linux/ring_buffer.h                       |  2 +-
 include/linux/string.h                            |  5 ++-
 include/linux/swap.h                              |  4 +-
 include/net/net_namespace.h                       |  2 +
 include/net/netns/hash.h                          | 15 +-------
 kernel/events/core.c                              |  2 +
 kernel/kprobes.c                                  |  6 +--
 kernel/locking/lockdep.c                          |  3 ++
 kernel/sched/fair.c                               | 31 +++++++++++++--
 kernel/sysctl.c                                   |  3 ++
 kernel/trace/ring_buffer.c                        |  5 ++-
 kernel/trace/trace.c                              |  6 ++-
 kernel/trace/trace_kdb.c                          |  6 ++-
 lib/bsearch.c                                     |  2 +
 lib/div64.c                                       |  4 +-
 lib/raid6/Makefile                                |  2 +-
 lib/string.c                                      | 20 ++++++++++
 mm/cma.c                                          |  4 +-
 mm/slab.c                                         | 17 ++++----
 mm/vmalloc.c                                      |  6 ++-
 net/9p/protocol.c                                 |  3 +-
 net/appletalk/atalk_proc.c                        |  2 +-
 net/appletalk/ddp.c                               | 37 +++++++++++++++---
 net/appletalk/sysctl_net_atalk.c                  |  5 ++-
 net/bridge/br_multicast.c                         |  4 +-
 net/core/ethtool.c                                | 29 +++++++++-----
 net/core/net_namespace.c                          |  1 +
 net/ipv4/route.c                                  | 20 +++++++++-
 net/ipv4/tcp_input.c                              | 10 ++---
 net/ipv6/ip6_output.c                             |  3 ++
 net/ipv6/ip6_tunnel.c                             |  4 +-
 net/openvswitch/flow_netlink.c                    |  4 +-
 net/sctp/protocol.c                               |  1 +
 security/device_cgroup.c                          |  2 +-
 sound/core/init.c                                 | 18 ++++-----
 sound/core/pcm_native.c                           |  8 ++++
 sound/core/seq/seq_clientmgr.c                    |  6 +--
 sound/drivers/opl3/opl3_voice.h                   |  2 +-
 sound/isa/sb/sb8.c                                |  4 ++
 sound/pci/echoaudio/echoaudio.c                   |  5 +++
 sound/soc/fsl/fsl_esai.c                          | 47 ++++++++++++++++++-----
 sound/soc/fsl/imx-sgtl5000.c                      |  1 +
 tools/lib/traceevent/event-parse.c                |  2 +-
 tools/perf/builtin-top.c                          |  5 ++-
 tools/perf/tests/evsel-tp-sched.c                 |  1 +
 tools/power/x86/turbostat/turbostat.c             |  3 ++
 118 files changed, 672 insertions(+), 264 deletions(-)


