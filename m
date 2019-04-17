Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FCEC282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9004B2073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555500689;
	bh=/arbNshxmA5XdDqLG5MPGXjvJlO+P+vsCdbypL5CdNs=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=vvLTyquCnCsoQpgXFfsBSjbJDDsc+U1Rqgn6BlGz8/1Y78xMi9EXOk8/NafawUEQa
	 WCe2kXUXtZYum62fDHgINUg5k5gnZTEZM0mc/1vlL7A3efpP403yuj6F5v3PQP1HLe
	 JlfqiqqrVdbV6uOU0ZG5XlUBvZ/kQMJJ4p3/xZ1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732045AbfDQLb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:31:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731991AbfDQLb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:31:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 415382073F;
        Wed, 17 Apr 2019 11:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555500686;
        bh=/arbNshxmA5XdDqLG5MPGXjvJlO+P+vsCdbypL5CdNs=;
        h=Date:From:To:Cc:Subject:From;
        b=Ax4027O5tITu6M4vJcX4tRlnl7Qh/SNmhVsoDwqqNpcsy/QC9tAlrSAXLlAnTXcOz
         iAMJjDxKgw7KdtLYTHmry2dP6vASmBBq+M0YLXNfyEjksEdluMZZ/80L11sGBaQJwD
         Tg5N7DW+hPX1mRU0PSnRjeeXQ0pCvTYcVlYxYLSc=
Date:   Wed, 17 Apr 2019 13:31:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.19.35
Message-ID: <20190417113124.GA10977@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.19.35 kernel.

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

 Makefile                                                        |    4=20
 arch/arm/boot/dts/am335x-evm.dts                                |   26 +
 arch/arm/boot/dts/am335x-evmsk.dts                              |   26 +
 arch/arm/boot/dts/rk3288.dtsi                                   |    6=20
 arch/arm/boot/dts/sama5d2-pinfunc.h                             |    2=20
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts                  |    5=20
 arch/arm64/boot/dts/rockchip/rk3328.dtsi                        |   58 ++--
 arch/arm64/include/asm/futex.h                                  |   16 -
 arch/arm64/kernel/traps.c                                       |   15 -
 arch/arm64/mm/init.c                                            |    2=20
 arch/parisc/include/asm/ptrace.h                                |    5=20
 arch/parisc/kernel/process.c                                    |    6=20
 arch/parisc/kernel/setup.c                                      |    3=20
 arch/powerpc/kernel/signal_64.c                                 |   23 +
 arch/riscv/include/asm/syscall.h                                |   12=20
 arch/x86/entry/vdso/Makefile                                    |    4=20
 arch/x86/events/amd/core.c                                      |  140 +++=
++++++-
 arch/x86/events/core.c                                          |   13=20
 arch/x86/include/asm/bitops.h                                   |   47 +--
 arch/x86/include/asm/string_32.h                                |   20 -
 arch/x86/include/asm/string_64.h                                |   15 -
 arch/x86/include/asm/xen/hypercall.h                            |    3=20
 arch/x86/kvm/svm.c                                              |   10=20
 arch/x86/kvm/vmx.c                                              |   84 +++=
---
 arch/xtensa/kernel/stacktrace.c                                 |    6=20
 block/bio.c                                                     |    5=20
 drivers/acpi/acpica/dsopcode.c                                  |    4=20
 drivers/acpi/acpica/evgpe.c                                     |    6=20
 drivers/acpi/acpica/nsobject.c                                  |    4=20
 drivers/char/Kconfig                                            |    2=20
 drivers/clk/meson/meson-aoclk.c                                 |   15 -
 drivers/gpu/drm/i915/gvt/gtt.c                                  |    2=20
 drivers/gpu/drm/i915/gvt/scheduler.c                            |    5=20
 drivers/gpu/drm/udl/udl_drv.c                                   |    1=20
 drivers/gpu/drm/udl/udl_drv.h                                   |    1=20
 drivers/gpu/drm/udl/udl_main.c                                  |    8=20
 drivers/hwmon/Kconfig                                           |    1=20
 drivers/md/dm-integrity.c                                       |   12=20
 drivers/md/dm-table.c                                           |   39 ++
 drivers/md/dm.c                                                 |   10=20
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                       |   16 -
 drivers/net/ethernet/ibm/ibmvnic.c                              |    5=20
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c        |   39 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_common.c             |   13=20
 drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c              |   14 -
 drivers/net/ethernet/mellanox/mlx5/core/main.c                  |   20 -
 drivers/net/ethernet/netronome/nfp/nfp_net_repr.c               |    4=20
 drivers/net/ethernet/realtek/r8169.c                            |    8=20
 drivers/net/hyperv/hyperv_net.h                                 |    1=20
 drivers/net/hyperv/netvsc.c                                     |    6=20
 drivers/net/hyperv/netvsc_drv.c                                 |   32 +-
 drivers/net/usb/qmi_wwan.c                                      |    1=20
 drivers/pci/hotplug/pciehp_ctrl.c                               |    4=20
 drivers/pci/quirks.c                                            |    2=20
 drivers/tty/Kconfig                                             |   24 +
 drivers/tty/tty_io.c                                            |    3=20
 drivers/tty/tty_ldisc.c                                         |   47 +++
 drivers/virtio/virtio_ring.c                                    |    2=20
 fs/block_dev.c                                                  |    8=20
 fs/btrfs/ioctl.c                                                |   10=20
 fs/btrfs/props.c                                                |    8=20
 include/linux/bitrev.h                                          |   46 +--
 include/linux/memcontrol.h                                      |    5=20
 include/linux/mlx5/driver.h                                     |    2=20
 include/linux/netfilter/nf_conntrack_proto_gre.h                |   13=20
 include/linux/string.h                                          |    3=20
 include/linux/virtio_ring.h                                     |    2=20
 include/net/ip.h                                                |    2=20
 include/net/net_namespace.h                                     |    1=20
 include/net/netns/hash.h                                        |   10=20
 kernel/irq/chip.c                                               |    4=20
 kernel/irq/irqdesc.c                                            |    1=20
 kernel/sched/fair.c                                             |    6=20
 kernel/time/alarmtimer.c                                        |    2=20
 lib/string.c                                                    |   20 +
 mm/huge_memory.c                                                |   36 ++
 mm/memcontrol.c                                                 |   20 +
 net/core/dev.c                                                  |    4=20
 net/core/ethtool.c                                              |   46 ++-
 net/core/net_namespace.c                                        |    1=20
 net/core/skbuff.c                                               |    2=20
 net/ipv4/ip_gre.c                                               |   15 -
 net/ipv4/ip_input.c                                             |    7=20
 net/ipv4/ip_options.c                                           |    4=20
 net/ipv4/tcp_dctcp.c                                            |   36 +-
 net/ipv4/tcp_ipv4.c                                             |    3=20
 net/ipv6/ip6_gre.c                                              |   21 -
 net/ipv6/ip6_output.c                                           |    4=20
 net/ipv6/ip6_tunnel.c                                           |    4=20
 net/ipv6/sit.c                                                  |    4=20
 net/kcm/kcmsock.c                                               |   16 -
 net/netfilter/nf_conntrack_proto_gre.c                          |   14 -
 net/netfilter/nfnetlink_cttimeout.c                             |   57 +++-
 net/openvswitch/flow_netlink.c                                  |    4=20
 net/rds/tcp.c                                                   |    2=20
 net/sched/act_sample.c                                          |   10=20
 net/sched/cls_matchall.c                                        |    5=20
 net/sctp/protocol.c                                             |    1=20
 scripts/package/builddeb                                        |    2=20
 sound/core/seq/seq_clientmgr.c                                  |    6=20
 sound/pci/hda/hda_intel.c                                       |    4=20
 sound/pci/hda/patch_realtek.c                                   |   31 +-
 sound/soc/fsl/fsl_esai.c                                        |   47 ++-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c                    |    8=20
 tools/testing/selftests/tc-testing/tc-tests/actions/sample.json |   24 +
 105 files changed, 1039 insertions(+), 449 deletions(-)

Aditya Pakki (1):
      net: mlx5: Add a missing check on idr_find, free buf

Alexander Lobakin (1):
      net: core: netif_receive_skb_list: unlist skb before passing to pt->f=
unc

Alexander Potapenko (1):
      x86/asm: Use stricter assembly constraints in bitops

Anand Jain (2):
      btrfs: prop: fix zstd compression parameter validation
      btrfs: prop: fix vanished compression property after failed set

Andre Przywara (1):
      PCI: Add function 1 DMA alias quirk for Marvell 9170 SATA controller

Andrea Righi (1):
      openvswitch: fix flow actions reallocation

Andrei Vagin (1):
      alarmtimer: Return correct remaining time

Aneesh Kumar K.V (1):
      mm/huge_memory.c: fix modifying of page protection by insert_pfn_pmd()

Arnd Bergmann (1):
      include/linux/bitrev.h: fix constant bitrev

Artemy Kovalyov (1):
      net/mlx5: Decrease default mr cache size

Axel Lin (1):
      hwmon: (w83773g) Select REGMAP_I2C to fix build error

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

David Rientjes (1):
      kvm: svm: fix potential get_num_contig_pages overflow

Davide Caratti (1):
      net/sched: act_sample: fix divide by zero in the traffic path

Dmitry V. Levin (1):
      riscv: Fix syscall_get_arguments() and syscall_set_arguments()

Dust Li (1):
      tcp: fix a potential NULL pointer dereference in tcp_sk_exit

Eric Dumazet (1):
      netns: provide pure entropy for net_hash_mix()

Erik Schmauss (2):
      ACPICA: Namespace: remove address node from global list after method =
termination
      ACPICA: AML interpreter: add region addresses in global list during i=
nitialization

Filipe Manana (1):
      Btrfs: do not allow trimming when a fs is mounted with the nologrepla=
y option

Florian Westphal (1):
      netfilter: nfnetlink_cttimeout: fetch timeouts for udplite and gre, t=
oo

Furquan Shaikh (1):
      ACPICA: Clear status of GPEs before enabling them

Gavi Teitz (1):
      net/mlx5e: Fix error handling when refreshing TIRs

Greg Kroah-Hartman (3):
      tty: mark Siemens R3964 line discipline as BROKEN
      tty: ldisc: add sysctl to prevent autoloading of ldiscs
      Linux 4.19.35

Greg Thelen (1):
      mm: writeback: use exact memcg dirty counts

Guenter Roeck (1):
      ASoC: intel: Fix crash at suspend/resume after failed codec registrat=
ion

Haiyang Zhang (1):
      hv_netvsc: Fix unwanted wakeup after tx_disable

Heiner Kallweit (2):
      r8169: disable ASPM again
      r8169: disable default rx interrupt coalescing on RTL8168

Helge Deller (1):
      parisc: Detect QEMU earlier in boot process

Hui Wang (1):
      ALSA: hda - Add two more machines to the power_save_blacklist

Huy Nguyen (2):
      net/mlx5e: Update xoff formula
      net/mlx5e: Update xon formula

Ilya Dryomov (1):
      dm table: propagate BDI_CAP_STABLE_WRITES to fix sporadic checksum er=
rors

Jakub Kicinski (2):
      nfp: validate the return code from dev_queue_xmit()
      nfp: disable netpoll on representors

Jason Yan (1):
      block: fix the return errno for direct IO

Jian-Hong Pan (1):
      ALSA: hda/realtek: Enable headset MIC of Acer TravelMate B114-21 with=
 ALC233

Jim Mattson (1):
      kvm: nVMX: NMI-window and interrupt-window exiting should wake L2 fro=
m HLT

Jiri Slaby (1):
      kcm: switch order of device registration to fix a crash

Jonas Karlman (1):
      ARM: dts: rockchip: fix rk3288 cpu opp node reference

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

Lorenzo Bianconi (3):
      ipv6: sit: reset ip header pointer in ipip6_rcv
      net: ip_gre: fix possible use-after-free in erspan_rcv
      net: ip6_gre: fix possible use-after-free in ip6erspan_rcv

Mao Wenan (1):
      net: rds: force to destroy connection if t_sock is NULL in rds_tcp_ki=
ll_sock().

Marc Orr (2):
      KVM: x86: nVMX: close leak of L0's x2APIC MSRs (CVE-2019-3887)
      KVM: x86: nVMX: fix x2APIC VTPR read intercept

Masahiro Yamada (1):
      kbuild: deb-pkg: fix bindeb-pkg breakage when O=3D is used

Max Filippov (1):
      xtensa: fix return_address

Mel Gorman (1):
      sched/fair: Do not re-read ->h_load_next during hierarchical load cal=
culation

Michael Chan (2):
      bnxt_en: Improve RX consumer index validity check.
      bnxt_en: Reset device on RX buffer errors.

Mikulas Patocka (3):
      dm integrity: change memcmp to strncmp in dm_integrity_ctr
      dm: revert 8f50e358153d ("dm: limit the max bio size as BIO_MAX_PAGES=
 * PAGE_SIZE")
      dm integrity: fix deadlock with overlapping I/O

Neil Armstrong (1):
      Revert "clk: meson: clean-up clock registration"

Nick Desaulniers (3):
      kbuild: clang: choose GCC_TOOLCHAIN_DIR not on LD
      x86/vdso: Drop implicit common-page-size linker flag
      lib/string.c: implement a basic bcmp

Nicolas Dichtel (1):
      net/sched: fix ->get helper of the matchall cls

Pablo Neira Ayuso (1):
      netfilter: nfnetlink_cttimeout: pass default timeout policy to obj_to=
_nlattr

Peter Geis (2):
      arm64: dts: rockchip: fix rk3328 sdmmc0 write errors
      arm64: dts: rockchip: fix rk3328 rgmii high tx error rate

Peter Ujfalusi (2):
      ARM: dts: am335x-evmsk: Correct the regulators for the audio codec
      ARM: dts: am335x-evm: Correct the regulators for the audio codec

Rasmus Villemoes (1):
      x86/asm: Remove dead __GNUC__ conditionals

Richard Sailer (1):
      ALSA: hda/realtek - Add quirk for Tuxedo XC 1509

S.j. Wang (1):
      ASoC: fsl_esai: fix channel swap issue when stream starts

Sergey Miroshnichenko (1):
      PCI: pciehp: Ignore Link State Changes after powering off a slot

Sheena Mira-ato (1):
      ip6_tunnel: Match to ARPHRD_TUNNEL6 for dev type

Steffen Klassert (1):
      net-gro: Fix GRO flush when receiving a GSO packet.

Stephen Boyd (1):
      genirq: Respect IRQCHIP_SKIP_SET_WAKE in irq_chip_set_wake_parent()

Stephen Suryaputra (1):
      vrf: check accept_source_route on the original netdevice

Sven Schnelle (2):
      parisc: regs_return_value() should return gpr28
      parisc: also set iaoq_b in instruction_pointer_set()

Thomas Falcon (1):
      ibmvnic: Fix completion structure initialization

Tomohiro Mayama (1):
      arm64: dts: rockchip: Fix vcc_host1_5v GPIO polarity on rk3328-rock64

Will Deacon (2):
      arm64: futex: Fix FUTEX_WAKE_OP atomic ops with non-zero result value
      arm64: backtrace: Don't bother trying to unwind the userspace stack

Xin Long (1):
      sctp: initialize _pad of sockaddr_in before copying to user memory

Yan Zhao (2):
      drm/i915/gvt: do not let pin count of shadow mm go negative
      drm/i915/gvt: do not deliver a workload if its creation fails

Yueyi Li (1):
      arm64: kaslr: Reserve size of ARM64_MEMSTART_ALIGN in linear region

Yuval Avnery (1):
      net/mlx5e: Add a lock on tir list

Zubin Mithra (1):
      ALSA: seq: Fix OOB-reads from strlcpy


--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAly3DosACgkQONu9yGCS
aT7NXg//TT7HE0llOnYPaMx897WZ9iKg1ApTjDxJhVPzPYmZ7u/swSaHLUgivPER
dAo/MZbXPZUE85VoaxnxTBBpYEyceDeayA61+uQ8czt0zUL5JTJaOY7SSPZgvpg1
fLt2pZP5X6qWAEpDGAdULnXIx7zx3Phpi/rfgB0xorQEBl67pEvpizHKX27jiO6f
TLhUMohuI95nGRhd9AhBxswbYg2WQRSMr0JfarNFYwNLGVfugIwgQHNDE8J39FKz
o9t965miTOIv7rBBHKiGgPqP+mXrpEhDvUg3z7pe14oFhqF7K9AfFQ9aJxmCEuPB
1ii41ck7hYJbI3fPbY5VIsN3/sAPcm0ZDmAeuu4LFHGQnNaOWi5NqclnM4s64TDb
99ba5a2K49rpE8SgxYESFCC7xiRyq2t6iMIQDRKjz9Wq5LN27F/gNa4Cxq0pzDK+
cGWZbzjwrL8u5LJDXJ38IU1c9kYdeCBcNBJCfEX3GfPDwyM1rsdz7POLNBGjppIp
OvDv5vDqmBZu3v5o2OAZRv+Rr6jzipCdd/b+IDlX+Xjv8sxNHQopZdv/xmFYrUnF
TxnuQ3Rcy50Mjn3TllSSmN5f5dmED5s2fQc4Xq3lbNZTXtararZeQvYjv1TP80UD
cROH1DwJ07GNp3bMZc1gI7vx888asfIu7AEgWBhRcNOvrDHEQfo=
=lyqj
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
