Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4164C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F352087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354320;
	bh=IE2cAl5yeKbM3afhvy3IjpKI59Stlq7NUY7N2wUlOP4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=clrpADHBrkOqecprndWvuot6qSA7/c+QnH0LMeB2PJZgDhDkoYuTQ3A6AlZYH9GpC
	 x/rhso2hwQM8mfsmGTHMhZioxL0U9fW8kGxgIEOHT4bHc1h8tJLR0MSjflcAVFUKSe
	 h7YDRDGCoGMBZp3R3sOWTZH8t4rx48/f5sG2N7dw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbfDOSv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:51:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728200AbfDOSpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:45:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EC052087C;
        Mon, 15 Apr 2019 18:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353912;
        bh=IE2cAl5yeKbM3afhvy3IjpKI59Stlq7NUY7N2wUlOP4=;
        h=From:To:Cc:Subject:Date:From;
        b=KoTkNTSZ7QJWGi9E9+To5Qk5YISVa/AHHUvQVpEfHH9KEuviQAyX2IQlagNVzYW4H
         bDNEnxYxVDnqyX0bV9s5KNkSYhPufT9TZvtwjgRfZC35hqI6r2fxnfmRMf4yA7e/Mk
         5qZ+9h8NI9esS+Knr7xBsV7SDPkP5+kWtRHEQuts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/76] 4.9.169-stable review
Date:   Mon, 15 Apr 2019 20:43:24 +0200
Message-Id: <20190415183707.712011689@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.169-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.169-rc1
X-KernelTest-Deadline: 2019-04-17T18:37+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.169 release.
There are 76 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Apr 17 18:36:37 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.169-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.169-rc1

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

David Engraf <david.engraf@sysgo.com>
    ARM: dts: at91: Fix typo in ISC_D0 on PC9

Cornelia Huck <cohuck@redhat.com>
    virtio: Honour 'may_reduce_num' in vring_create_virtqueue

Stephen Boyd <swboyd@chromium.org>
    genirq: Respect IRQCHIP_SKIP_SET_WAKE in irq_chip_set_wake_parent()

Jérôme Glisse <jglisse@redhat.com>
    block: do not leak memory in bio_copy_user_iov()

Filipe Manana <fdmanana@suse.com>
    Btrfs: do not allow trimming when a fs is mounted with the nologreplay option

S.j. Wang <shengjiu.wang@nxp.com>
    ASoC: fsl_esai: fix channel swap issue when stream starts

Arnd Bergmann <arnd@arndb.de>
    include/linux/bitrev.h: fix constant bitrev

Helge Deller <deller@gmx.de>
    parisc: Detect QEMU earlier in boot process

Zubin Mithra <zsm@chromium.org>
    ALSA: seq: Fix OOB-reads from strlcpy

Sheena Mira-ato <sheena.mira-ato@alliedtelesis.co.nz>
    ip6_tunnel: Match to ARPHRD_TUNNEL6 for dev type

Li RongQing <lirongqing@baidu.com>
    net: ethtool: not call vzalloc for zero sized memory request

Eric Dumazet <edumazet@google.com>
    netns: provide pure entropy for net_hash_mix()

Yuval Avnery <yuvalav@mellanox.com>
    net/mlx5e: Add a lock on tir list

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Improve RX consumer index validity check.

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Reset device on RX buffer errors.

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

Mao Wenan <maowenan@huawei.com>
    net: rds: force to destroy connection if t_sock is NULL in rds_tcp_kill_sock().

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

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/security: Fix spectre_v2 reporting

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/fsl: Fix the flush of branch predictor.

Diana Craciun <diana.craciun@nxp.com>
    powerpc/fsl: Fixed warning: orphan section `__btb_flush_fixup'

Diana Craciun <diana.craciun@nxp.com>
    powerpc/fsl: Update Spectre v2 reporting

Diana Craciun <diana.craciun@nxp.com>
    powerpc/fsl: Enable runtime patching if nospectre_v2 boot arg is used

Diana Craciun <diana.craciun@nxp.com>
    powerpc/fsl: Flush branch predictor when entering KVM

Diana Craciun <diana.craciun@nxp.com>
    powerpc/fsl: Flush the branch predictor at each kernel entry (32 bit)

Diana Craciun <diana.craciun@nxp.com>
    powerpc/fsl: Flush the branch predictor at each kernel entry (64bit)

Diana Craciun <diana.craciun@nxp.com>
    powerpc/fsl: Add nospectre_v2 command line argument

Diana Craciun <diana.craciun@nxp.com>
    powerpc/fsl: Emulate SPRN_BUCSR register

Diana Craciun <diana.craciun@nxp.com>
    powerpc/fsl: Fix spectre_v2 mitigations reporting

Diana Craciun <diana.craciun@nxp.com>
    powerpc/fsl: Add macro to flush the branch predictor

Diana Craciun <diana.craciun@nxp.com>
    powerpc/fsl: Add infrastructure to fixup branch predictor flush

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/powernv: Query firmware for count cache flush settings

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/pseries: Query hypervisor for count cache flush settings

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Add support for software count cache flush

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Add new security feature flags for count cache flush

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/asm: Add a patch_site macro & helpers for patching instructions

Diana Craciun <diana.craciun@nxp.com>
    powerpc/fsl: Sanitize the syscall table for NXP PowerPC 32 bit platforms

Diana Craciun <diana.craciun@nxp.com>
    powerpc/fsl: Add barrier_nospec implementation for NXP PowerPC Book3E

Diana Craciun <diana.craciun@nxp.com>
    powerpc/64: Make meltdown reporting Book3S 64 specific

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64: Call setup_barrier_nospec() from setup_arch()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64: Add CONFIG_PPC_BARRIER_NOSPEC

Diana Craciun <diana.craciun@nxp.com>
    powerpc/64: Make stf barrier PPC_BOOK3S_64 specific.

Diana Craciun <diana.craciun@nxp.com>
    powerpc/64: Disable the speculation barrier from the command line

Michael Ellerman <mpe@ellerman.id.au>
    powerpc64s: Show ori31 availability in spectre_v1 sysfs file not v2

Michal Suchanek <msuchanek@suse.de>
    powerpc/64s: Enhance the information in cpu_show_spectre_v1()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64: Use barrier_nospec in syscall entry

Michael Ellerman <mpe@ellerman.id.au>
    powerpc: Use barrier_nospec in copy_from_user()

Michal Suchanek <msuchanek@suse.de>
    powerpc/64s: Enable barrier_nospec based on firmware settings

Michal Suchanek <msuchanek@suse.de>
    powerpc/64s: Patch barrier_nospec in modules

Michael Neuling <mikey@neuling.org>
    powerpc: Avoid code patching freed init sections

Michal Suchanek <msuchanek@suse.de>
    powerpc/64s: Add support for ori barrier_nospec patching

Michal Suchanek <msuchanek@suse.de>
    powerpc/64s: Add barrier_nospec

Andreas Schwab <schwab@linux-m68k.org>
    powerpc: Fix invalid use of register expressions

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

Andy Lutomirski <luto@kernel.org>
    x86/power: Make restore_processor_context() sane

Andy Lutomirski <luto@kernel.org>
    x86/power/32: Move SYSENTER MSR restoration to fix_processor_context()

Andy Lutomirski <luto@kernel.org>
    x86/power/64: Use struct desc_ptr for the IDT in struct saved_context

Andy Lutomirski <luto@kernel.org>
    x86/power: Fix some ordering bugs in __restore_processor_context()


-------------

Diffstat:

 Makefile                                           |   6 +-
 arch/arm/boot/dts/sama5d2-pinfunc.h                |   2 +-
 arch/arm64/include/asm/futex.h                     |  16 +-
 arch/arm64/mm/init.c                               |   2 +-
 arch/parisc/kernel/process.c                       |   6 -
 arch/parisc/kernel/setup.c                         |   3 +
 arch/powerpc/Kconfig                               |   7 +-
 arch/powerpc/include/asm/asm-prototypes.h          |   6 +
 arch/powerpc/include/asm/barrier.h                 |  21 ++
 arch/powerpc/include/asm/code-patching-asm.h       |  18 ++
 arch/powerpc/include/asm/code-patching.h           |   2 +
 arch/powerpc/include/asm/feature-fixups.h          |  21 ++
 arch/powerpc/include/asm/hvcall.h                  |   2 +
 arch/powerpc/include/asm/ppc_asm.h                 |  23 ++-
 arch/powerpc/include/asm/security_features.h       |   7 +
 arch/powerpc/include/asm/setup.h                   |  21 ++
 arch/powerpc/include/asm/uaccess.h                 |  11 +-
 arch/powerpc/kernel/Makefile                       |   3 +-
 arch/powerpc/kernel/entry_32.S                     |  10 +
 arch/powerpc/kernel/entry_64.S                     |  69 +++++++
 arch/powerpc/kernel/exceptions-64e.S               |  27 ++-
 arch/powerpc/kernel/head_booke.h                   |  12 ++
 arch/powerpc/kernel/head_fsl_booke.S               |  15 ++
 arch/powerpc/kernel/module.c                       |  10 +-
 arch/powerpc/kernel/security.c                     | 216 ++++++++++++++++++++-
 arch/powerpc/kernel/setup-common.c                 |   3 +
 arch/powerpc/kernel/signal_64.c                    |  23 ++-
 arch/powerpc/kernel/swsusp_asm64.S                 |   2 +-
 arch/powerpc/kernel/vmlinux.lds.S                  |  19 +-
 arch/powerpc/kvm/bookehv_interrupts.S              |   4 +
 arch/powerpc/kvm/e500_emulate.c                    |   7 +
 arch/powerpc/lib/code-patching.c                   |  24 +++
 arch/powerpc/lib/copypage_power7.S                 |  14 +-
 arch/powerpc/lib/copyuser_power7.S                 |  66 +++----
 arch/powerpc/lib/feature-fixups.c                  |  93 +++++++++
 arch/powerpc/lib/memcpy_power7.S                   |  66 +++----
 arch/powerpc/lib/string_64.S                       |   2 +-
 arch/powerpc/mm/mem.c                              |   2 +
 arch/powerpc/mm/tlb_low_64e.S                      |   7 +
 arch/powerpc/platforms/powernv/setup.c             |   7 +
 arch/powerpc/platforms/pseries/setup.c             |   7 +
 arch/x86/entry/vdso/Makefile                       |  22 +--
 arch/x86/include/asm/suspend_32.h                  |   8 +-
 arch/x86/include/asm/suspend_64.h                  |  19 +-
 arch/x86/include/asm/xen/hypercall.h               |   3 +
 arch/x86/power/cpu.c                               |  96 ++++-----
 arch/xtensa/kernel/stacktrace.c                    |   6 +-
 block/bio.c                                        |   5 +-
 drivers/char/Kconfig                               |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  14 +-
 .../net/ethernet/mellanox/mlx5/core/en_common.c    |   7 +
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/pci/quirks.c                               |   2 +
 drivers/tty/Kconfig                                |  23 +++
 drivers/tty/tty_io.c                               |   3 +
 drivers/tty/tty_ldisc.c                            |  47 +++++
 drivers/virtio/virtio_ring.c                       |   2 +
 fs/btrfs/ioctl.c                                   |  10 +
 include/linux/bitrev.h                             |  36 ++--
 include/linux/mlx5/driver.h                        |   2 +
 include/linux/string.h                             |   3 +
 include/linux/virtio_ring.h                        |   2 +-
 include/net/ip.h                                   |   2 +-
 include/net/net_namespace.h                        |   1 +
 include/net/netns/hash.h                           |  15 +-
 kernel/irq/chip.c                                  |   4 +
 kernel/sched/fair.c                                |   6 +-
 lib/string.c                                       |  20 ++
 net/core/ethtool.c                                 |  47 +++--
 net/core/net_namespace.c                           |   1 +
 net/ipv4/ip_input.c                                |   7 +-
 net/ipv4/ip_options.c                              |   4 +-
 net/ipv4/tcp_dctcp.c                               |  36 ++--
 net/ipv6/ip6_output.c                              |   4 +-
 net/ipv6/ip6_tunnel.c                              |   4 +-
 net/ipv6/sit.c                                     |   4 +
 net/kcm/kcmsock.c                                  |  16 +-
 net/openvswitch/flow_netlink.c                     |   4 +-
 net/rds/tcp.c                                      |   2 +-
 net/sctp/protocol.c                                |   1 +
 sound/core/seq/seq_clientmgr.c                     |   6 +-
 sound/soc/fsl/fsl_esai.c                           |  47 ++++-
 82 files changed, 1138 insertions(+), 288 deletions(-)


