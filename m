Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4ED1C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84359218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354928;
	bh=gakHNXDfLEMCOfZzXNYqPgAeilqzyGkwNAordYagaNw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=nK3KcUKGfanqJ1ayptBXf3dRsZxUGPkov4WHllSDe6TLD9X9Bbr6XP1NPDr7Nnomh
	 2DRAC8W9hzBV/uqxJUfFhE5IWDPad7LIV+SJOLAbgZcVE7176WLL/Waxtflv0fHkeK
	 YEMM3Xty+IAjtWR3qtclVWgZQJnWw4C4WWNhE2KE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfDOTCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:02:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728419AbfDOTCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:02:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F22D8218FC;
        Mon, 15 Apr 2019 19:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354924;
        bh=gakHNXDfLEMCOfZzXNYqPgAeilqzyGkwNAordYagaNw=;
        h=From:To:Cc:Subject:Date:From;
        b=dH0REOcQp1jk/xkyOJtgeJj4AIEJ4eV5jbLhsnVe1HnQx2PixnaMx1jhswalAXSH+
         EVPoJvKy0csjca441svwyCBZJxSH0O7BhqsM2yinkEPg78yez2NnvBiOJKpcNI4qQM
         lTdJImpjibv8b+AfdJ7FTim2n8iqH5UGo8b9V6QQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 00/69] 4.14.112-stable review
Date:   Mon, 15 Apr 2019 20:58:18 +0200
Message-Id: <20190415183726.036654568@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.112-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.112-rc1
X-KernelTest-Deadline: 2019-04-17T18:37+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.112 release.
There are 69 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Apr 17 18:36:38 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.112-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.112-rc1

Tomohiro Mayama <parly-gh@iris.mystia.org>
    arm64: dts: rockchip: Fix vcc_host1_5v GPIO polarity on rk3328-rock64

Katsuhiro Suzuki <katsuhiro@katsuster.net>
    arm64: dts: rockchip: fix vcc_host1_5v pin assign on rk3328-rock64

Ilya Dryomov <idryomov@gmail.com>
    dm table: propagate BDI_CAP_STABLE_WRITES to fix sporadic checksum errors

Andre Przywara <andre.przywara@arm.com>
    PCI: Add function 1 DMA alias quirk for Marvell 9170 SATA controller

Lendacky, Thomas <Thomas.Lendacky@amd.com>
    x86/perf/amd: Remove need to check "running" bit in NMI handler

Lendacky, Thomas <Thomas.Lendacky@amd.com>
    x86/perf/amd: Resolve NMI latency issues for active PMCs

Lendacky, Thomas <Thomas.Lendacky@amd.com>
    x86/perf/amd: Resolve race condition when disabling PMC

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: fix return_address

Mel Gorman <mgorman@techsingularity.net>
    sched/fair: Do not re-read ->h_load_next during hierarchical load calculation

Dan Carpenter <dan.carpenter@oracle.com>
    xen: Prevent buffer overflow in privcmd ioctl

Will Deacon <will.deacon@arm.com>
    arm64: backtrace: Don't bother trying to unwind the userspace stack

Peter Geis <pgwipeout@gmail.com>
    arm64: dts: rockchip: fix rk3328 rgmii high tx error rate

Will Deacon <will.deacon@arm.com>
    arm64: futex: Fix FUTEX_WAKE_OP atomic ops with non-zero result value

David Engraf <david.engraf@sysgo.com>
    ARM: dts: at91: Fix typo in ISC_D0 on PC9

Peter Ujfalusi <peter.ujfalusi@ti.com>
    ARM: dts: am335x-evm: Correct the regulators for the audio codec

Peter Ujfalusi <peter.ujfalusi@ti.com>
    ARM: dts: am335x-evmsk: Correct the regulators for the audio codec

Cornelia Huck <cohuck@redhat.com>
    virtio: Honour 'may_reduce_num' in vring_create_virtqueue

Kefeng Wang <wangkefeng.wang@huawei.com>
    genirq: Initialize request_mutex if CONFIG_SPARSE_IRQ=n

Stephen Boyd <swboyd@chromium.org>
    genirq: Respect IRQCHIP_SKIP_SET_WAKE in irq_chip_set_wake_parent()

Jason Yan <yanaijie@huawei.com>
    block: fix the return errno for direct IO

Jérôme Glisse <jglisse@redhat.com>
    block: do not leak memory in bio_copy_user_iov()

Anand Jain <anand.jain@oracle.com>
    btrfs: prop: fix vanished compression property after failed set

Anand Jain <anand.jain@oracle.com>
    btrfs: prop: fix zstd compression parameter validation

Filipe Manana <fdmanana@suse.com>
    Btrfs: do not allow trimming when a fs is mounted with the nologreplay option

S.j. Wang <shengjiu.wang@nxp.com>
    ASoC: fsl_esai: fix channel swap issue when stream starts

Arnd Bergmann <arnd@arndb.de>
    include/linux/bitrev.h: fix constant bitrev

Dave Airlie <airlied@redhat.com>
    drm/udl: add a release method and delay modeset teardown

Andrei Vagin <avagin@gmail.com>
    alarmtimer: Return correct remaining time

Sven Schnelle <svens@stackframe.org>
    parisc: regs_return_value() should return gpr28

Helge Deller <deller@gmx.de>
    parisc: Detect QEMU earlier in boot process

Peter Geis <pgwipeout@gmail.com>
    arm64: dts: rockchip: fix rk3328 sdmmc0 write errors

Haiyang Zhang <haiyangz@microsoft.com>
    hv_netvsc: Fix unwanted wakeup after tx_disable

Sheena Mira-ato <sheena.mira-ato@alliedtelesis.co.nz>
    ip6_tunnel: Match to ARPHRD_TUNNEL6 for dev type

Zubin Mithra <zsm@chromium.org>
    ALSA: seq: Fix OOB-reads from strlcpy

Li RongQing <lirongqing@baidu.com>
    net: ethtool: not call vzalloc for zero sized memory request

Eric Dumazet <edumazet@google.com>
    netns: provide pure entropy for net_hash_mix()

Davide Caratti <dcaratti@redhat.com>
    net/sched: act_sample: fix divide by zero in the traffic path

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Reset device on RX buffer errors.

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Improve RX consumer index validity check.

Jakub Kicinski <jakub.kicinski@netronome.com>
    nfp: validate the return code from dev_queue_xmit()

Yuval Avnery <yuvalav@mellanox.com>
    net/mlx5e: Add a lock on tir list

Gavi Teitz <gavi@mellanox.com>
    net/mlx5e: Fix error handling when refreshing TIRs

Stephen Suryaputra <ssuryaextr@gmail.com>
    vrf: check accept_source_route on the original netdevice

Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
    tcp: Ensure DCTCP reacts to losses

Xin Long <lucien.xin@gmail.com>
    sctp: initialize _pad of sockaddr_in before copying to user memory

Bjørn Mork <bjorn@mork.no>
    qmi_wwan: add Olicard 600

Andrea Righi <andrea.righi@canonical.com>
    openvswitch: fix flow actions reallocation

Nicolas Dichtel <nicolas.dichtel@6wind.com>
    net/sched: fix ->get helper of the matchall cls

Mao Wenan <maowenan@huawei.com>
    net: rds: force to destroy connection if t_sock is NULL in rds_tcp_kill_sock().

Artemy Kovalyov <artemyko@mellanox.com>
    net/mlx5: Decrease default mr cache size

Steffen Klassert <steffen.klassert@secunet.com>
    net-gro: Fix GRO flush when receiving a GSO packet.

Jiri Slaby <jslaby@suse.cz>
    kcm: switch order of device registration to fix a crash

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    ipv6: sit: reset ip header pointer in ipip6_rcv

Junwei Hu <hujunwei4@huawei.com>
    ipv6: Fix dangling pointer when ipv6 fragment

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    tty: ldisc: add sysctl to prevent autoloading of ldiscs

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    tty: mark Siemens R3964 line discipline as BROKEN

Yueyi Li <liyueyi@live.com>
    arm64: kaslr: Reserve size of ARM64_MEMSTART_ALIGN in linear region

Gilad Ben-Yossef <gilad@benyossef.com>
    stating: ccree: revert "staging: ccree: fix leak of import() after init()"

Nick Desaulniers <ndesaulniers@google.com>
    lib/string.c: implement a basic bcmp

Nick Desaulniers <ndesaulniers@google.com>
    x86/vdso: Drop implicit common-page-size linker flag

Alistair Strachan <astrachan@google.com>
    x86: vdso: Use $LD instead of $CC to link

Nick Desaulniers <ndesaulniers@google.com>
    kbuild: clang: choose GCC_TOOLCHAIN_DIR not on LD

Breno Leitao <leitao@debian.org>
    powerpc/tm: Limit TM code inside PPC_TRANSACTIONAL_MEM

Yan Zhao <yan.y.zhao@intel.com>
    drm/i915/gvt: do not let pin count of shadow mm go negative

Andy Lutomirski <luto@kernel.org>
    x86/power: Make restore_processor_context() sane

Andy Lutomirski <luto@kernel.org>
    x86/power/32: Move SYSENTER MSR restoration to fix_processor_context()

Andy Lutomirski <luto@kernel.org>
    x86/power/64: Use struct desc_ptr for the IDT in struct saved_context

Andy Lutomirski <luto@kernel.org>
    x86/power: Fix some ordering bugs in __restore_processor_context()

Marek Behún <marek.behun@nic.cz>
    net: sfp: move sfp_register_socket call from sfp_remove to sfp_probe


-------------

Diffstat:

 Makefile                                           |   6 +-
 arch/arm/boot/dts/am335x-evm.dts                   |  26 +++-
 arch/arm/boot/dts/am335x-evmsk.dts                 |  26 +++-
 arch/arm/boot/dts/sama5d2-pinfunc.h                |   2 +-
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts     |   5 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  58 ++++-----
 arch/arm64/include/asm/futex.h                     |  16 +--
 arch/arm64/kernel/traps.c                          |  15 ++-
 arch/arm64/mm/init.c                               |   2 +-
 arch/parisc/include/asm/ptrace.h                   |   2 +-
 arch/parisc/kernel/process.c                       |   6 -
 arch/parisc/kernel/setup.c                         |   3 +
 arch/powerpc/kernel/signal_64.c                    |  23 +++-
 arch/x86/entry/vdso/Makefile                       |  22 ++--
 arch/x86/events/amd/core.c                         | 140 ++++++++++++++++++++-
 arch/x86/events/core.c                             |  13 +-
 arch/x86/include/asm/suspend_32.h                  |   8 +-
 arch/x86/include/asm/suspend_64.h                  |  19 ++-
 arch/x86/include/asm/xen/hypercall.h               |   3 +
 arch/x86/power/cpu.c                               |  96 +++++++-------
 arch/xtensa/kernel/stacktrace.c                    |   6 +-
 block/bio.c                                        |   5 +-
 drivers/char/Kconfig                               |   2 +-
 drivers/gpu/drm/i915/gvt/gtt.c                     |   2 +-
 drivers/gpu/drm/udl/udl_drv.c                      |   1 +
 drivers/gpu/drm/udl/udl_drv.h                      |   1 +
 drivers/gpu/drm/udl/udl_main.c                     |   8 +-
 drivers/md/dm-table.c                              |  39 ++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  16 ++-
 .../net/ethernet/mellanox/mlx5/core/en_common.c    |  13 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |  20 ---
 drivers/net/ethernet/netronome/nfp/nfp_net_repr.c  |   2 +-
 drivers/net/hyperv/hyperv_net.h                    |   1 +
 drivers/net/hyperv/netvsc.c                        |   6 +-
 drivers/net/hyperv/netvsc_drv.c                    |  32 ++++-
 drivers/net/phy/sfp.c                              |   8 +-
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/pci/quirks.c                               |   2 +
 drivers/staging/ccree/ssi_hash.c                   |  11 +-
 drivers/tty/Kconfig                                |  24 ++++
 drivers/tty/tty_io.c                               |   3 +
 drivers/tty/tty_ldisc.c                            |  47 +++++++
 drivers/virtio/virtio_ring.c                       |   2 +
 fs/block_dev.c                                     |   8 +-
 fs/btrfs/ioctl.c                                   |  10 ++
 fs/btrfs/props.c                                   |   8 +-
 include/linux/bitrev.h                             |  46 +++----
 include/linux/mlx5/driver.h                        |   2 +
 include/linux/string.h                             |   3 +
 include/linux/virtio_ring.h                        |   2 +-
 include/net/ip.h                                   |   2 +-
 include/net/net_namespace.h                        |   1 +
 include/net/netns/hash.h                           |  15 +--
 kernel/irq/chip.c                                  |   4 +
 kernel/irq/irqdesc.c                               |   1 +
 kernel/sched/fair.c                                |   6 +-
 kernel/time/alarmtimer.c                           |   2 +-
 lib/string.c                                       |  20 +++
 net/core/ethtool.c                                 |  41 +++---
 net/core/net_namespace.c                           |   1 +
 net/core/skbuff.c                                  |   2 +-
 net/ipv4/ip_input.c                                |   7 +-
 net/ipv4/ip_options.c                              |   4 +-
 net/ipv4/tcp_dctcp.c                               |  36 +++---
 net/ipv6/ip6_output.c                              |   4 +-
 net/ipv6/ip6_tunnel.c                              |   4 +-
 net/ipv6/sit.c                                     |   4 +
 net/kcm/kcmsock.c                                  |  16 +--
 net/openvswitch/flow_netlink.c                     |   4 +-
 net/rds/tcp.c                                      |   2 +-
 net/sched/act_sample.c                             |  10 +-
 net/sched/cls_matchall.c                           |   5 +
 net/sctp/protocol.c                                |   1 +
 sound/core/seq/seq_clientmgr.c                     |   6 +-
 sound/soc/fsl/fsl_esai.c                           |  47 +++++--
 75 files changed, 749 insertions(+), 318 deletions(-)


