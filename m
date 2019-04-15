Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C291DC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6E521900
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355398;
	bh=TpNFh0KQc+SF6kTdVw4sH69NeKWnPDMKn8DyH8fZb5E=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=APyIkeGzusGqGoR4oQLYGDFz23XPdAY/Cwaf6qvKk4yzBpLejXQzxDPeTPpVA62oE
	 9cCfyW7ZWpgvGsY3enj6/tWz8a/iay9SkvkQ7a0xZK+dR3pKYtL77NdYGdNgp7Bftf
	 mM640omUvxEgfofDQpxW2ermUb1GTCYF52E6NBVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbfDOTJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:09:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730817AbfDOTJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:09:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7619820880;
        Mon, 15 Apr 2019 19:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355393;
        bh=TpNFh0KQc+SF6kTdVw4sH69NeKWnPDMKn8DyH8fZb5E=;
        h=From:To:Cc:Subject:Date:From;
        b=C0cEyCjafMNrE5TajePn8Sljip3ocIBj7u0ov+NxcEO33vH5RJ0zWIsXgGVZtiq9t
         dqWNtOzhHC3h58N2+iI++zNqDqQsxU0E76sB7wnUyJNd2Soaf3B7qmZmAirbXOtn7X
         nEXOBIPsmQau56p8Lrlt0ogNhvcehWkPbJ3q1sdc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 5.0 000/117] 5.0.8-stable review
Date:   Mon, 15 Apr 2019 20:59:30 +0200
Message-Id: <20190415183744.887851196@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-5.0.8-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.0.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.0.8-rc1
X-KernelTest-Deadline: 2019-04-17T18:37+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 5.0.8 release.
There are 117 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Apr 17 18:36:42 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.0.8-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.0.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.0.8-rc1

Gerd Hoffmann <kraxel@redhat.com>
    drm/virtio: do NOT reuse resource ids

Marc Orr <marcorr@google.com>
    KVM: x86: nVMX: fix x2APIC VTPR read intercept

Marc Orr <marcorr@google.com>
    KVM: x86: nVMX: close leak of L0's x2APIC MSRs (CVE-2019-3887)

Mikulas Patocka <mpatocka@redhat.com>
    dm integrity: fix deadlock with overlapping I/O

Mike Snitzer <snitzer@redhat.com>
    dm: disable DISCARD if the underlying storage no longer supports it

Ilya Dryomov <idryomov@gmail.com>
    dm table: propagate BDI_CAP_STABLE_WRITES to fix sporadic checksum errors

Mikulas Patocka <mpatocka@redhat.com>
    dm: revert 8f50e358153d ("dm: limit the max bio size as BIO_MAX_PAGES * PAGE_SIZE")

Mikulas Patocka <mpatocka@redhat.com>
    dm integrity: change memcmp to strncmp in dm_integrity_ctr

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64s/radix: Fix radix segment exception handling

Chuck Lever <chuck.lever@oracle.com>
    xprtrdma: Fix helper that drains the transport

Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
    PCI: pciehp: Ignore Link State Changes after powering off a slot

Andre Przywara <andre.przywara@arm.com>
    PCI: Add function 1 DMA alias quirk for Marvell 9170 SATA controller

Lendacky, Thomas <Thomas.Lendacky@amd.com>
    x86/perf/amd: Remove need to check "running" bit in NMI handler

Lendacky, Thomas <Thomas.Lendacky@amd.com>
    x86/perf/amd: Resolve NMI latency issues for active PMCs

Lendacky, Thomas <Thomas.Lendacky@amd.com>
    x86/perf/amd: Resolve race condition when disabling PMC

Alexander Potapenko <glider@google.com>
    x86/asm: Use stricter assembly constraints in bitops

Rasmus Villemoes <linux@rasmusvillemoes.dk>
    x86/asm: Remove dead __GNUC__ conditionals

Dmitry V. Levin <ldv@altlinux.org>
    csky: Fix syscall_get_arguments() and syscall_set_arguments()

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: fix return_address

Mel Gorman <mgorman@techsingularity.net>
    sched/fair: Do not re-read ->h_load_next during hierarchical load calculation

Dan Carpenter <dan.carpenter@oracle.com>
    xen: Prevent buffer overflow in privcmd ioctl

Moni Shoua <monis@mellanox.com>
    IB/mlx5: Reset access mask when looping inside page fault handler

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    arm64/ftrace: fix inadvertent BUG() in trampoline check

Will Deacon <will.deacon@arm.com>
    arm64: backtrace: Don't bother trying to unwind the userspace stack

Peter Geis <pgwipeout@gmail.com>
    arm64: dts: rockchip: fix rk3328 rgmii high tx error rate

Tomohiro Mayama <parly-gh@iris.mystia.org>
    arm64: dts: rockchip: Fix vcc_host1_5v GPIO polarity on rk3328-rock64

Will Deacon <will.deacon@arm.com>
    arm64: futex: Fix FUTEX_WAKE_OP atomic ops with non-zero result value

David Engraf <david.engraf@sysgo.com>
    ARM: dts: at91: Fix typo in ISC_D0 on PC9

David Summers <beagleboard@davidjohnsummers.uk>
    ARM: dts: rockchip: Fix SD card detection on rk3288-tinker

Peter Ujfalusi <peter.ujfalusi@ti.com>
    ARM: dts: am335x-evm: Correct the regulators for the audio codec

Peter Ujfalusi <peter.ujfalusi@ti.com>
    ARM: dts: am335x-evmsk: Correct the regulators for the audio codec

Jonas Karlman <jonas@kwiboo.se>
    ARM: dts: rockchip: fix rk3288 cpu opp node reference

Janusz Krzysztofik <jmkrzyszt@gmail.com>
    ARM: OMAP1: ams-delta: Fix broken GPIO ID allocation

Jani Nikula <jani.nikula@intel.com>
    drm/i915/dp: revert back to max link rate and lane count on eDP

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

Bart Van Assche <bvanassche@acm.org>
    block: Revert v5.0 blk_mq_request_issue_directly() changes

Dmitry V. Levin <ldv@altlinux.org>
    riscv: Fix syscall_get_arguments() and syscall_set_arguments()

Anand Jain <anand.jain@oracle.com>
    btrfs: prop: fix vanished compression property after failed set

Anand Jain <anand.jain@oracle.com>
    btrfs: prop: fix zstd compression parameter validation

Filipe Manana <fdmanana@suse.com>
    Btrfs: do not allow trimming when a fs is mounted with the nologreplay option

S.j. Wang <shengjiu.wang@nxp.com>
    ASoC: fsl_esai: fix channel swap issue when stream starts

Guenter Roeck <linux@roeck-us.net>
    ASoC: intel: Fix crash at suspend/resume after failed codec registration

Greg Thelen <gthelen@google.com>
    mm: writeback: use exact memcg dirty counts

Arnd Bergmann <arnd@arndb.de>
    include/linux/bitrev.h: fix constant bitrev

David Rientjes <rientjes@google.com>
    kvm: svm: fix potential get_num_contig_pages overflow

Dave Airlie <airlied@redhat.com>
    drm/udl: add a release method and delay modeset teardown

Jernej Skrabec <jernej.skrabec@siol.net>
    drm/sun4i: DW HDMI: Lower max. supported rate for H6

Yan Zhao <yan.y.zhao@intel.com>
    drm/i915/gvt: do not deliver a workload if its creation fails

Andrei Vagin <avagin@gmail.com>
    alarmtimer: Return correct remaining time

Sven Schnelle <svens@stackframe.org>
    parisc: also set iaoq_b in instruction_pointer_set()

Sven Schnelle <svens@stackframe.org>
    parisc: regs_return_value() should return gpr28

Helge Deller <deller@gmx.de>
    parisc: Detect QEMU earlier in boot process

Faiz Abbas <faiz_abbas@ti.com>
    mmc: sdhci-omap: Don't finish_mrq() on a command error during tuning

Daniel Drake <drake@endlessm.com>
    mmc: alcor: don't write data before command has completed

Peter Geis <pgwipeout@gmail.com>
    arm64: dts: rockchip: fix rk3328 sdmmc0 write errors

Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
    mm/huge_memory.c: fix modifying of page protection by insert_pfn_pmd()

Hui Wang <hui.wang@canonical.com>
    ALSA: hda - Add two more machines to the power_save_blacklist

Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
    ALSA: xen-front: Do not use stream buffer size before it is set

Richard Sailer <rs@tuxedocomputers.com>
    ALSA: hda/realtek - Add quirk for Tuxedo XC 1509

Jian-Hong Pan <jian-hong@endlessm.com>
    ALSA: hda/realtek: Enable headset MIC of Acer TravelMate B114-21 with ALC233

Zubin Mithra <zsm@chromium.org>
    ALSA: seq: Fix OOB-reads from strlcpy

Erik Schmauss <erik.schmauss@intel.com>
    ACPICA: Namespace: remove address node from global list after method termination

Furquan Shaikh <furquan@google.com>
    ACPICA: Clear status of GPEs before enabling them

Peter Hutterer <peter.hutterer@who-t.net>
    HID: logitech: Handle 0 scroll events for the m560

Steve French <stfrench@microsoft.com>
    SMB3: Allow persistent handle timeout to be configurable on mount

Eddie James <eajames@linux.ibm.com>
    hwmon: (occ) Fix power sensor indexing

Axel Lin <axel.lin@ingics.com>
    hwmon: (w83773g) Select REGMAP_I2C to fix build error

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    tty: ldisc: add sysctl to prevent autoloading of ldiscs

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    tty: mark Siemens R3964 line discipline as BROKEN

Neil Armstrong <narmstrong@baylibre.com>
    Revert "clk: meson: clean-up clock registration"

Nick Desaulniers <ndesaulniers@google.com>
    lib/string.c: implement a basic bcmp

Nick Desaulniers <ndesaulniers@google.com>
    kbuild: clang: choose GCC_TOOLCHAIN_DIR not on LD

Huy Nguyen <huyn@mellanox.com>
    net/mlx5e: Update xon formula

Huy Nguyen <huyn@mellanox.com>
    net/mlx5e: Update xoff formula

Aditya Pakki <pakki001@umn.edu>
    net: mlx5: Add a missing check on idr_find, free buf

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: disable default rx interrupt coalescing on RTL8168

Alexander Lobakin <alobakin@dlink.ru>
    net: core: netif_receive_skb_list: unlist skb before passing to pt->func

Miaohe Lin <linmiaohe@huawei.com>
    net: vrf: Fix ping failed when vrf mtu is set to 0

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    net: thunderx: fix NULL pointer dereference in nicvf_open/nicvf_stop

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    net: bridge: always clear mcast matching struct on reports and leaves

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    net: ip6_gre: fix possible use-after-free in ip6erspan_rcv

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    net: ip_gre: fix possible use-after-free in erspan_rcv

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Reset device on RX buffer errors.

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Improve RX consumer index validity check.

Jakub Kicinski <jakub.kicinski@netronome.com>
    nfp: disable netpoll on representors

Jakub Kicinski <jakub.kicinski@netronome.com>
    nfp: validate the return code from dev_queue_xmit()

Yuval Avnery <yuvalav@mellanox.com>
    net/mlx5e: Add a lock on tir list

Gavi Teitz <gavi@mellanox.com>
    net/mlx5e: Fix error handling when refreshing TIRs

Stephen Suryaputra <ssuryaextr@gmail.com>
    vrf: check accept_source_route on the original netdevice

Dust Li <dust.li@linux.alibaba.com>
    tcp: fix a potential NULL pointer dereference in tcp_sk_exit

Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
    tcp: Ensure DCTCP reacts to losses

Xin Long <lucien.xin@gmail.com>
    sctp: initialize _pad of sockaddr_in before copying to user memory

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: disable ASPM again

Bjørn Mork <bjorn@mork.no>
    qmi_wwan: add Olicard 600

Andrea Righi <andrea.righi@canonical.com>
    openvswitch: fix flow actions reallocation

Nicolas Dichtel <nicolas.dichtel@6wind.com>
    net/sched: fix ->get helper of the matchall cls

Davide Caratti <dcaratti@redhat.com>
    net/sched: act_sample: fix divide by zero in the traffic path

Mao Wenan <maowenan@huawei.com>
    net: rds: force to destroy connection if t_sock is NULL in rds_tcp_kill_sock().

Eric Dumazet <edumazet@google.com>
    netns: provide pure entropy for net_hash_mix()

Artemy Kovalyov <artemyko@mellanox.com>
    net/mlx5: Decrease default mr cache size

Steffen Klassert <steffen.klassert@secunet.com>
    net-gro: Fix GRO flush when receiving a GSO packet.

Li RongQing <lirongqing@baidu.com>
    net: ethtool: not call vzalloc for zero sized memory request

Jiri Slaby <jslaby@suse.cz>
    kcm: switch order of device registration to fix a crash

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    ipv6: sit: reset ip header pointer in ipip6_rcv

Junwei Hu <hujunwei4@huawei.com>
    ipv6: Fix dangling pointer when ipv6 fragment

Sheena Mira-ato <sheena.mira-ato@alliedtelesis.co.nz>
    ip6_tunnel: Match to ARPHRD_TUNNEL6 for dev type

Thomas Falcon <tlfalcon@linux.ibm.com>
    ibmvnic: Fix completion structure initialization

Haiyang Zhang <haiyangz@microsoft.com>
    hv_netvsc: Fix unwanted wakeup after tx_disable

Taehee Yoo <ap420073@gmail.com>
    netfilter: nf_tables: add missing ->release_ops() in error path of newrule()

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: use-after-free in dynamic operations

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_compat: use .release_ops and remove list of extension

Masahiro Yamada <yamada.masahiro@socionext.com>
    kbuild: pkg: use -f $(srctree)/Makefile to recurse to top Makefile

Yan Zhao <yan.y.zhao@intel.com>
    drm/i915/gvt: do not let pin count of shadow mm go negative


-------------

Diffstat:

 Makefile                                           |   6 +-
 arch/arm/boot/dts/am335x-evm.dts                   |  26 +-
 arch/arm/boot/dts/am335x-evmsk.dts                 |  26 +-
 arch/arm/boot/dts/rk3288-tinker.dtsi               |   3 +-
 arch/arm/boot/dts/rk3288.dtsi                      |   6 +-
 arch/arm/boot/dts/sama5d2-pinfunc.h                |   2 +-
 arch/arm/mach-omap1/board-ams-delta.c              |   2 +
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts     |   3 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  58 ++---
 arch/arm64/include/asm/futex.h                     |  16 +-
 arch/arm64/include/asm/module.h                    |   5 +
 arch/arm64/kernel/ftrace.c                         |   3 +-
 arch/arm64/kernel/traps.c                          |  15 +-
 arch/csky/include/asm/syscall.h                    |  10 +-
 arch/parisc/include/asm/ptrace.h                   |   5 +-
 arch/parisc/kernel/process.c                       |   6 -
 arch/parisc/kernel/setup.c                         |   3 +
 arch/powerpc/kernel/exceptions-64s.S               |  12 +
 arch/riscv/include/asm/syscall.h                   |  12 +-
 arch/x86/events/amd/core.c                         | 140 +++++++++-
 arch/x86/events/core.c                             |  13 +-
 arch/x86/include/asm/bitops.h                      |  47 ++--
 arch/x86/include/asm/string_32.h                   |  20 --
 arch/x86/include/asm/string_64.h                   |  15 --
 arch/x86/include/asm/xen/hypercall.h               |   3 +
 arch/x86/kvm/svm.c                                 |  10 +-
 arch/x86/kvm/vmx/nested.c                          |  74 +++---
 arch/xtensa/kernel/stacktrace.c                    |   6 +-
 block/bio.c                                        |   5 +-
 block/blk-core.c                                   |   4 +-
 block/blk-mq-sched.c                               |   8 +-
 block/blk-mq.c                                     | 122 ++++-----
 block/blk-mq.h                                     |   6 +-
 drivers/acpi/acpica/evgpe.c                        |   6 +-
 drivers/acpi/acpica/nsobject.c                     |   4 +
 drivers/char/Kconfig                               |   2 +-
 drivers/clk/meson/meson-aoclk.c                    |  15 +-
 drivers/gpu/drm/i915/gvt/gtt.c                     |   2 +-
 drivers/gpu/drm/i915/gvt/scheduler.c               |   5 +-
 drivers/gpu/drm/i915/intel_dp.c                    |  69 +----
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c              |   9 +-
 drivers/gpu/drm/udl/udl_drv.c                      |   1 +
 drivers/gpu/drm/udl/udl_drv.h                      |   1 +
 drivers/gpu/drm/udl/udl_main.c                     |   8 +-
 drivers/gpu/drm/virtio/virtgpu_object.c            |  13 +
 drivers/hid/hid-logitech-hidpp.c                   |   5 +-
 drivers/hwmon/Kconfig                              |   1 +
 drivers/hwmon/occ/common.c                         |   6 +-
 drivers/infiniband/hw/mlx5/odp.c                   |   3 +-
 drivers/md/dm-core.h                               |   1 +
 drivers/md/dm-integrity.c                          |  12 +-
 drivers/md/dm-rq.c                                 |  11 +-
 drivers/md/dm-table.c                              |  39 +++
 drivers/md/dm.c                                    |  30 ++-
 drivers/mmc/host/alcor.c                           |  34 +--
 drivers/mmc/host/sdhci-omap.c                      |  38 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  16 +-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   |  20 +-
 drivers/net/ethernet/ibm/ibmvnic.c                 |   5 +-
 .../ethernet/mellanox/mlx5/core/en/port_buffer.c   |  39 +--
 .../net/ethernet/mellanox/mlx5/core/en_common.c    |  13 +-
 drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c |  14 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |  20 --
 drivers/net/ethernet/netronome/nfp/nfp_net_repr.c  |   4 +-
 drivers/net/ethernet/realtek/r8169.c               |   8 +-
 drivers/net/hyperv/hyperv_net.h                    |   1 +
 drivers/net/hyperv/netvsc.c                        |   6 +-
 drivers/net/hyperv/netvsc_drv.c                    |  32 ++-
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/net/vrf.c                                  |   8 +-
 drivers/pci/hotplug/pciehp_ctrl.c                  |   4 +
 drivers/pci/quirks.c                               |   2 +
 drivers/tty/Kconfig                                |  24 ++
 drivers/tty/tty_io.c                               |   3 +
 drivers/tty/tty_ldisc.c                            |  47 ++++
 drivers/virtio/virtio_ring.c                       |   2 +
 fs/block_dev.c                                     |   8 +-
 fs/btrfs/ioctl.c                                   |  10 +
 fs/btrfs/props.c                                   |   8 +-
 fs/cifs/cifsfs.c                                   |   2 +
 fs/cifs/cifsglob.h                                 |   8 +
 fs/cifs/connect.c                                  |  30 ++-
 fs/cifs/smb2file.c                                 |   4 +-
 fs/cifs/smb2pdu.c                                  |  14 +-
 include/linux/bitrev.h                             |  46 ++--
 include/linux/memcontrol.h                         |   5 +-
 include/linux/mlx5/driver.h                        |   2 +
 include/linux/string.h                             |   3 +
 include/linux/virtio_ring.h                        |   2 +-
 include/net/ip.h                                   |   2 +-
 include/net/net_namespace.h                        |   1 +
 include/net/netfilter/nf_tables.h                  |   3 +
 include/net/netns/hash.h                           |  10 +-
 kernel/irq/chip.c                                  |   4 +
 kernel/irq/irqdesc.c                               |   1 +
 kernel/sched/fair.c                                |   6 +-
 kernel/time/alarmtimer.c                           |   2 +-
 lib/string.c                                       |  20 ++
 mm/huge_memory.c                                   |  36 +++
 mm/memcontrol.c                                    |  20 +-
 net/bridge/br_multicast.c                          |   3 +
 net/core/dev.c                                     |   4 +-
 net/core/ethtool.c                                 |  46 ++--
 net/core/net_namespace.c                           |   1 +
 net/core/skbuff.c                                  |   2 +-
 net/ipv4/ip_gre.c                                  |  15 +-
 net/ipv4/ip_input.c                                |   7 +-
 net/ipv4/ip_options.c                              |   4 +-
 net/ipv4/tcp_dctcp.c                               |  36 +--
 net/ipv4/tcp_ipv4.c                                |   3 +-
 net/ipv6/ip6_gre.c                                 |  21 +-
 net/ipv6/ip6_output.c                              |   4 +-
 net/ipv6/ip6_tunnel.c                              |   4 +-
 net/ipv6/sit.c                                     |   4 +
 net/kcm/kcmsock.c                                  |  16 +-
 net/netfilter/nf_tables_api.c                      |  16 +-
 net/netfilter/nft_compat.c                         | 281 ++++-----------------
 net/openvswitch/flow_netlink.c                     |   4 +-
 net/rds/tcp.c                                      |   2 +-
 net/sched/act_sample.c                             |  10 +-
 net/sched/cls_matchall.c                           |   5 +
 net/sctp/protocol.c                                |   1 +
 net/sunrpc/xprtrdma/verbs.c                        |   2 +-
 scripts/package/Makefile                           |   4 +-
 scripts/package/builddeb                           |  10 +-
 scripts/package/buildtar                           |   2 +-
 scripts/package/mkdebian                           |   6 +-
 sound/core/seq/seq_clientmgr.c                     |   6 +-
 sound/pci/hda/hda_intel.c                          |   4 +
 sound/pci/hda/patch_realtek.c                      |  31 ++-
 sound/soc/fsl/fsl_esai.c                           |  47 +++-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c       |   8 +
 sound/xen/xen_snd_front_alsa.c                     |   2 +-
 133 files changed, 1287 insertions(+), 847 deletions(-)


