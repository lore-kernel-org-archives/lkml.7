Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBD1C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512B32073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555500665;
	bh=v+fTgUrk4eqFmF/N2FLL9pbKtY/qGhbt5IBvCfRqJ0U=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=TzbRCpiOcjYbgipGCivaenG80M11GPzkVN4j4cr2gmjg3dLoSO4/ZEoEmOz+o9MT/
	 sqBWhYFx1k/KKXNuJI9BkBbpuNYJAeyTBv1ufWd7YBO0BU6YrJ5XGEXf4ApvkfPtPy
	 xnce+kIQS5hwh4oNDgLl5NIrzwl+L97devlpp2UA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731988AbfDQLbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:31:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731659AbfDQLbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:31:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 547782073F;
        Wed, 17 Apr 2019 11:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555500662;
        bh=v+fTgUrk4eqFmF/N2FLL9pbKtY/qGhbt5IBvCfRqJ0U=;
        h=Date:From:To:Cc:Subject:From;
        b=AdNcKOAVHnYZSZVD4uKKvWd0sWT6+/uAIomZsHLPnLKT6ype+dGLQdIyVDDgQMR+m
         wPPO2tqdkCU2X7UszporhFTxkPwaSlwmBFbysuCPhcboNdVBH/yTqLHuX2PTdRlPOb
         vvHn9S75k7tM2YgrEVvTyaEh9LqRFJagoYGeEy3s=
Date:   Wed, 17 Apr 2019 13:31:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.112
Message-ID: <20190417113100.GA9736@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.112 kernel.

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

 Makefile                                            |    4=20
 arch/arm/boot/dts/am335x-evm.dts                    |   26 +++
 arch/arm/boot/dts/am335x-evmsk.dts                  |   26 +++
 arch/arm/boot/dts/sama5d2-pinfunc.h                 |    2=20
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts      |    5=20
 arch/arm64/boot/dts/rockchip/rk3328.dtsi            |   58 ++++----
 arch/arm64/include/asm/futex.h                      |   16 +-
 arch/arm64/kernel/traps.c                           |   15 +-
 arch/arm64/mm/init.c                                |    2=20
 arch/parisc/include/asm/ptrace.h                    |    2=20
 arch/parisc/kernel/process.c                        |    6=20
 arch/parisc/kernel/setup.c                          |    3=20
 arch/powerpc/kernel/signal_64.c                     |   23 ++-
 arch/x86/entry/vdso/Makefile                        |   22 +--
 arch/x86/events/amd/core.c                          |  140 +++++++++++++++=
++++-
 arch/x86/events/core.c                              |   13 -
 arch/x86/include/asm/suspend_32.h                   |    8 +
 arch/x86/include/asm/suspend_64.h                   |   19 ++
 arch/x86/include/asm/xen/hypercall.h                |    3=20
 arch/x86/power/cpu.c                                |   96 +++++++------
 arch/xtensa/kernel/stacktrace.c                     |    6=20
 block/bio.c                                         |    5=20
 drivers/char/Kconfig                                |    2=20
 drivers/gpu/drm/i915/gvt/gtt.c                      |    2=20
 drivers/gpu/drm/udl/udl_drv.c                       |    1=20
 drivers/gpu/drm/udl/udl_drv.h                       |    1=20
 drivers/gpu/drm/udl/udl_main.c                      |    8 +
 drivers/md/dm-table.c                               |   39 +++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c           |   16 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_common.c |   13 +
 drivers/net/ethernet/mellanox/mlx5/core/main.c      |   20 --
 drivers/net/ethernet/netronome/nfp/nfp_net_repr.c   |    2=20
 drivers/net/hyperv/hyperv_net.h                     |    1=20
 drivers/net/hyperv/netvsc.c                         |    6=20
 drivers/net/hyperv/netvsc_drv.c                     |   32 +++-
 drivers/net/phy/sfp.c                               |    8 -
 drivers/net/usb/qmi_wwan.c                          |    1=20
 drivers/pci/quirks.c                                |    2=20
 drivers/staging/ccree/ssi_hash.c                    |   11 -
 drivers/tty/Kconfig                                 |   24 +++
 drivers/tty/tty_io.c                                |    3=20
 drivers/tty/tty_ldisc.c                             |   47 ++++++
 drivers/virtio/virtio_ring.c                        |    2=20
 fs/block_dev.c                                      |    8 -
 fs/btrfs/ioctl.c                                    |   10 +
 fs/btrfs/props.c                                    |    8 -
 include/linux/bitrev.h                              |   46 +++---
 include/linux/mlx5/driver.h                         |    2=20
 include/linux/string.h                              |    3=20
 include/linux/virtio_ring.h                         |    2=20
 include/net/ip.h                                    |    2=20
 include/net/net_namespace.h                         |    1=20
 include/net/netns/hash.h                            |   15 --
 kernel/irq/chip.c                                   |    4=20
 kernel/irq/irqdesc.c                                |    1=20
 kernel/sched/fair.c                                 |    6=20
 kernel/time/alarmtimer.c                            |    2=20
 lib/string.c                                        |   20 ++
 net/core/ethtool.c                                  |   41 +++--
 net/core/net_namespace.c                            |    1=20
 net/core/skbuff.c                                   |    2=20
 net/ipv4/ip_input.c                                 |    7 -
 net/ipv4/ip_options.c                               |    4=20
 net/ipv4/tcp_dctcp.c                                |   36 ++---
 net/ipv6/ip6_output.c                               |    4=20
 net/ipv6/ip6_tunnel.c                               |    4=20
 net/ipv6/sit.c                                      |    4=20
 net/kcm/kcmsock.c                                   |   16 +-
 net/openvswitch/flow_netlink.c                      |    4=20
 net/rds/tcp.c                                       |    2=20
 net/sched/act_sample.c                              |   10 +
 net/sched/cls_matchall.c                            |    5=20
 net/sctp/protocol.c                                 |    1=20
 sound/core/seq/seq_clientmgr.c                      |    6=20
 sound/soc/fsl/fsl_esai.c                            |   47 +++++-
 75 files changed, 748 insertions(+), 317 deletions(-)

Alistair Strachan (1):
      x86: vdso: Use $LD instead of $CC to link

Anand Jain (2):
      btrfs: prop: fix zstd compression parameter validation
      btrfs: prop: fix vanished compression property after failed set

Andre Przywara (1):
      PCI: Add function 1 DMA alias quirk for Marvell 9170 SATA controller

Andrea Righi (1):
      openvswitch: fix flow actions reallocation

Andrei Vagin (1):
      alarmtimer: Return correct remaining time

Andy Lutomirski (4):
      x86/power: Fix some ordering bugs in __restore_processor_context()
      x86/power/64: Use struct desc_ptr for the IDT in struct saved_context
      x86/power/32: Move SYSENTER MSR restoration to fix_processor_context()
      x86/power: Make restore_processor_context() sane

Arnd Bergmann (1):
      include/linux/bitrev.h: fix constant bitrev

Artemy Kovalyov (1):
      net/mlx5: Decrease default mr cache size

Bj=F8rn Mork (1):
      qmi_wwan: add Olicard 600

Breno Leitao (1):
      powerpc/tm: Limit TM code inside PPC_TRANSACTIONAL_MEM

Cornelia Huck (1):
      virtio: Honour 'may_reduce_num' in vring_create_virtqueue

Dan Carpenter (1):
      xen: Prevent buffer overflow in privcmd ioctl

Dave Airlie (1):
      drm/udl: add a release method and delay modeset teardown

David Engraf (1):
      ARM: dts: at91: Fix typo in ISC_D0 on PC9

Davide Caratti (1):
      net/sched: act_sample: fix divide by zero in the traffic path

Eric Dumazet (1):
      netns: provide pure entropy for net_hash_mix()

Filipe Manana (1):
      Btrfs: do not allow trimming when a fs is mounted with the nologrepla=
y option

Gavi Teitz (1):
      net/mlx5e: Fix error handling when refreshing TIRs

Gilad Ben-Yossef (1):
      stating: ccree: revert "staging: ccree: fix leak of import() after in=
it()"

Greg Kroah-Hartman (3):
      tty: mark Siemens R3964 line discipline as BROKEN
      tty: ldisc: add sysctl to prevent autoloading of ldiscs
      Linux 4.14.112

Haiyang Zhang (1):
      hv_netvsc: Fix unwanted wakeup after tx_disable

Helge Deller (1):
      parisc: Detect QEMU earlier in boot process

Ilya Dryomov (1):
      dm table: propagate BDI_CAP_STABLE_WRITES to fix sporadic checksum er=
rors

Jakub Kicinski (1):
      nfp: validate the return code from dev_queue_xmit()

Jason Yan (1):
      block: fix the return errno for direct IO

Jiri Slaby (1):
      kcm: switch order of device registration to fix a crash

Junwei Hu (1):
      ipv6: Fix dangling pointer when ipv6 fragment

J=E9r=F4me Glisse (1):
      block: do not leak memory in bio_copy_user_iov()

Katsuhiro Suzuki (1):
      arm64: dts: rockchip: fix vcc_host1_5v pin assign on rk3328-rock64

Kefeng Wang (1):
      genirq: Initialize request_mutex if CONFIG_SPARSE_IRQ=3Dn

Koen De Schepper (1):
      tcp: Ensure DCTCP reacts to losses

Lendacky, Thomas (3):
      x86/perf/amd: Resolve race condition when disabling PMC
      x86/perf/amd: Resolve NMI latency issues for active PMCs
      x86/perf/amd: Remove need to check "running" bit in NMI handler

Li RongQing (1):
      net: ethtool: not call vzalloc for zero sized memory request

Lorenzo Bianconi (1):
      ipv6: sit: reset ip header pointer in ipip6_rcv

Mao Wenan (1):
      net: rds: force to destroy connection if t_sock is NULL in rds_tcp_ki=
ll_sock().

Marek Beh=FAn (1):
      net: sfp: move sfp_register_socket call from sfp_remove to sfp_probe

Max Filippov (1):
      xtensa: fix return_address

Mel Gorman (1):
      sched/fair: Do not re-read ->h_load_next during hierarchical load cal=
culation

Michael Chan (2):
      bnxt_en: Improve RX consumer index validity check.
      bnxt_en: Reset device on RX buffer errors.

Nick Desaulniers (3):
      kbuild: clang: choose GCC_TOOLCHAIN_DIR not on LD
      x86/vdso: Drop implicit common-page-size linker flag
      lib/string.c: implement a basic bcmp

Nicolas Dichtel (1):
      net/sched: fix ->get helper of the matchall cls

Peter Geis (2):
      arm64: dts: rockchip: fix rk3328 sdmmc0 write errors
      arm64: dts: rockchip: fix rk3328 rgmii high tx error rate

Peter Ujfalusi (2):
      ARM: dts: am335x-evmsk: Correct the regulators for the audio codec
      ARM: dts: am335x-evm: Correct the regulators for the audio codec

S.j. Wang (1):
      ASoC: fsl_esai: fix channel swap issue when stream starts

Sheena Mira-ato (1):
      ip6_tunnel: Match to ARPHRD_TUNNEL6 for dev type

Steffen Klassert (1):
      net-gro: Fix GRO flush when receiving a GSO packet.

Stephen Boyd (1):
      genirq: Respect IRQCHIP_SKIP_SET_WAKE in irq_chip_set_wake_parent()

Stephen Suryaputra (1):
      vrf: check accept_source_route on the original netdevice

Sven Schnelle (1):
      parisc: regs_return_value() should return gpr28

Tomohiro Mayama (1):
      arm64: dts: rockchip: Fix vcc_host1_5v GPIO polarity on rk3328-rock64

Will Deacon (2):
      arm64: futex: Fix FUTEX_WAKE_OP atomic ops with non-zero result value
      arm64: backtrace: Don't bother trying to unwind the userspace stack

Xin Long (1):
      sctp: initialize _pad of sockaddr_in before copying to user memory

Yan Zhao (1):
      drm/i915/gvt: do not let pin count of shadow mm go negative

Yueyi Li (1):
      arm64: kaslr: Reserve size of ARM64_MEMSTART_ALIGN in linear region

Yuval Avnery (1):
      net/mlx5e: Add a lock on tir list

Zubin Mithra (1):
      ALSA: seq: Fix OOB-reads from strlcpy


--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAly3DnQACgkQONu9yGCS
aT6m0xAAll9PqvNB2IUUdUuqyARagDmliElpfYsn1SYnhMnQd+gTxyMy1Qpr+1sJ
PfSvWBYyRoU87xL+TeU77E9YzCTuwwluwUoO7LXTLPYMtkqLaj2g4zckXxChNpzX
OsUrvRl/L3qCrjqqK1XluKUd2NvXwXDvu25WNiYEjCglXuMISwQQoNsPDRIX2+bv
crs7dfRCy8+fXlLRnIRj7rYWxRKp1X+PxFmu3ZRz2R2dDOVQxIH1WPGtb5zv3CoQ
Yx3NOLFRHkH07oMn9kKDIByKJd40VDPM8fiD7H/Zjz9J1vMpym2FXvuEOLXOtBji
jDgpO2hOgz4xw+ISUQ22z5Gx6HES44f7JOpd4mZCkDJVSBJKrux05w5m+vyJe3av
3vhBPgIQkEx7Epk+VrSr7+a/bN+G6TSmNiZxZveMHkrHkm4m5aKjh6GEqZ+7w84D
1pXO/6hv6LvUBM832ja17jAVWWp4GmvbLImfnOoKZBpsD1iF0Dj+k29OC8hFkwa8
qrm0NEhJi5KnJh/K7ncbOP0cnVzBVHA5wA1zrGRvRugm/cQF1w5NDzh5ZUVIRW/l
j/A+HkazEC/nTwUZycSPp4/xwmQmKclBGQx28NDINE+bTi5r9irMvIT0mV6I2TX0
CVdnso4+RjjEy+oJl7V7L1S9u73dI6tDxVefRqK8ANuGfJv2mQU=
=E0z4
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
