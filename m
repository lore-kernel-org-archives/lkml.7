Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFBBC282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0894220821
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555500711;
	bh=NzMVJIeF93mGTQZqHQHjW/vDyLARQqL3CuSUI4/mD40=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=FwQ1+whHV0QU+e3CXqYcVkcBZb9cKk0piLwKXDiPWltMgiay/bsAcRwh69PFeTQzL
	 nX4+tZXccBK+pgpitClaV7wKEki1IKuE9Dn39v7X8RC4TfbSNOZkiKFXEXzTe7ghlN
	 3WybfvTd5zqGHH1CdkOauSx5wIolMZGOriDKDC5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbfDQLbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:31:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731975AbfDQLbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:31:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 259492073F;
        Wed, 17 Apr 2019 11:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555500707;
        bh=NzMVJIeF93mGTQZqHQHjW/vDyLARQqL3CuSUI4/mD40=;
        h=Date:From:To:Cc:Subject:From;
        b=aTkSnWRzFJ2afSxTIhauBjabd++WwUIPao30SjLqlA7/kDD2XUrnnG8r9ncOkMN+3
         eZgBAYYya0mT9Q9Zsxc6mj2GsonWs/T42uMLkxcljwtKBnmz/P3zy7bvX7FN4vO68n
         KcqqxzrzOQJe2o0Caxfmph4eRgvwLcE3OhD8up2c=
Date:   Wed, 17 Apr 2019 13:31:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 5.0.8
Message-ID: <20190417113145.GA12023@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 5.0.8 kernel.

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

 Makefile                                                 |    4=20
 arch/arm/boot/dts/am335x-evm.dts                         |   26 +
 arch/arm/boot/dts/am335x-evmsk.dts                       |   26 +
 arch/arm/boot/dts/rk3288-tinker.dtsi                     |    3=20
 arch/arm/boot/dts/rk3288.dtsi                            |    6=20
 arch/arm/boot/dts/sama5d2-pinfunc.h                      |    2=20
 arch/arm/mach-omap1/board-ams-delta.c                    |    2=20
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts           |    3=20
 arch/arm64/boot/dts/rockchip/rk3328.dtsi                 |   58 +--
 arch/arm64/include/asm/futex.h                           |   16=20
 arch/arm64/include/asm/module.h                          |    5=20
 arch/arm64/kernel/ftrace.c                               |    3=20
 arch/arm64/kernel/traps.c                                |   15=20
 arch/csky/include/asm/syscall.h                          |   10=20
 arch/parisc/include/asm/ptrace.h                         |    5=20
 arch/parisc/kernel/process.c                             |    6=20
 arch/parisc/kernel/setup.c                               |    3=20
 arch/powerpc/kernel/exceptions-64s.S                     |   12=20
 arch/riscv/include/asm/syscall.h                         |   12=20
 arch/x86/events/amd/core.c                               |  140 +++++++
 arch/x86/events/core.c                                   |   13=20
 arch/x86/include/asm/bitops.h                            |   47 --
 arch/x86/include/asm/string_32.h                         |   20 -
 arch/x86/include/asm/string_64.h                         |   15=20
 arch/x86/include/asm/xen/hypercall.h                     |    3=20
 arch/x86/kvm/svm.c                                       |   10=20
 arch/x86/kvm/vmx/nested.c                                |   74 ++-
 arch/xtensa/kernel/stacktrace.c                          |    6=20
 block/bio.c                                              |    5=20
 block/blk-core.c                                         |    4=20
 block/blk-mq-sched.c                                     |    8=20
 block/blk-mq.c                                           |  122 +++---
 block/blk-mq.h                                           |    6=20
 drivers/acpi/acpica/evgpe.c                              |    6=20
 drivers/acpi/acpica/nsobject.c                           |    4=20
 drivers/char/Kconfig                                     |    2=20
 drivers/clk/meson/meson-aoclk.c                          |   15=20
 drivers/gpu/drm/i915/gvt/gtt.c                           |    2=20
 drivers/gpu/drm/i915/gvt/scheduler.c                     |    5=20
 drivers/gpu/drm/i915/intel_dp.c                          |   69 ---
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c                    |    9=20
 drivers/gpu/drm/udl/udl_drv.c                            |    1=20
 drivers/gpu/drm/udl/udl_drv.h                            |    1=20
 drivers/gpu/drm/udl/udl_main.c                           |    8=20
 drivers/gpu/drm/virtio/virtgpu_object.c                  |   13=20
 drivers/hid/hid-logitech-hidpp.c                         |    5=20
 drivers/hwmon/Kconfig                                    |    1=20
 drivers/hwmon/occ/common.c                               |    6=20
 drivers/infiniband/hw/mlx5/odp.c                         |    3=20
 drivers/md/dm-core.h                                     |    1=20
 drivers/md/dm-integrity.c                                |   12=20
 drivers/md/dm-rq.c                                       |   11=20
 drivers/md/dm-table.c                                    |   39 ++
 drivers/md/dm.c                                          |   30 -
 drivers/mmc/host/alcor.c                                 |   34 -
 drivers/mmc/host/sdhci-omap.c                            |   38 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                |   16=20
 drivers/net/ethernet/cavium/thunder/nicvf_main.c         |   20 -
 drivers/net/ethernet/ibm/ibmvnic.c                       |    5=20
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c |   39 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_common.c      |   13=20
 drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c       |   14=20
 drivers/net/ethernet/mellanox/mlx5/core/main.c           |   20 -
 drivers/net/ethernet/netronome/nfp/nfp_net_repr.c        |    4=20
 drivers/net/ethernet/realtek/r8169.c                     |    8=20
 drivers/net/hyperv/hyperv_net.h                          |    1=20
 drivers/net/hyperv/netvsc.c                              |    6=20
 drivers/net/hyperv/netvsc_drv.c                          |   32 +
 drivers/net/usb/qmi_wwan.c                               |    1=20
 drivers/net/vrf.c                                        |    8=20
 drivers/pci/hotplug/pciehp_ctrl.c                        |    4=20
 drivers/pci/quirks.c                                     |    2=20
 drivers/tty/Kconfig                                      |   24 +
 drivers/tty/tty_io.c                                     |    3=20
 drivers/tty/tty_ldisc.c                                  |   47 ++
 drivers/virtio/virtio_ring.c                             |    2=20
 fs/block_dev.c                                           |    8=20
 fs/btrfs/ioctl.c                                         |   10=20
 fs/btrfs/props.c                                         |    8=20
 fs/cifs/cifsfs.c                                         |    2=20
 fs/cifs/cifsglob.h                                       |    8=20
 fs/cifs/connect.c                                        |   30 +
 fs/cifs/smb2file.c                                       |    4=20
 fs/cifs/smb2pdu.c                                        |   14=20
 include/linux/bitrev.h                                   |   46 +-
 include/linux/memcontrol.h                               |    5=20
 include/linux/mlx5/driver.h                              |    2=20
 include/linux/string.h                                   |    3=20
 include/linux/virtio_ring.h                              |    2=20
 include/net/ip.h                                         |    2=20
 include/net/net_namespace.h                              |    1=20
 include/net/netfilter/nf_tables.h                        |    3=20
 include/net/netns/hash.h                                 |   10=20
 kernel/irq/chip.c                                        |    4=20
 kernel/irq/irqdesc.c                                     |    1=20
 kernel/sched/fair.c                                      |    6=20
 kernel/time/alarmtimer.c                                 |    2=20
 lib/string.c                                             |   20 +
 mm/huge_memory.c                                         |   36 +
 mm/memcontrol.c                                          |   20 -
 net/bridge/br_multicast.c                                |    3=20
 net/core/dev.c                                           |    4=20
 net/core/ethtool.c                                       |   46 +-
 net/core/net_namespace.c                                 |    1=20
 net/core/skbuff.c                                        |    2=20
 net/ipv4/ip_gre.c                                        |   15=20
 net/ipv4/ip_input.c                                      |    7=20
 net/ipv4/ip_options.c                                    |    4=20
 net/ipv4/tcp_dctcp.c                                     |   36 -
 net/ipv4/tcp_ipv4.c                                      |    3=20
 net/ipv6/ip6_gre.c                                       |   21 -
 net/ipv6/ip6_output.c                                    |    4=20
 net/ipv6/ip6_tunnel.c                                    |    4=20
 net/ipv6/sit.c                                           |    4=20
 net/kcm/kcmsock.c                                        |   16=20
 net/netfilter/nf_tables_api.c                            |   16=20
 net/netfilter/nft_compat.c                               |  281 ++--------=
-----
 net/openvswitch/flow_netlink.c                           |    4=20
 net/rds/tcp.c                                            |    2=20
 net/sched/act_sample.c                                   |   10=20
 net/sched/cls_matchall.c                                 |    5=20
 net/sctp/protocol.c                                      |    1=20
 net/sunrpc/xprtrdma/verbs.c                              |    2=20
 scripts/package/Makefile                                 |    4=20
 scripts/package/builddeb                                 |   10=20
 scripts/package/buildtar                                 |    2=20
 scripts/package/mkdebian                                 |    6=20
 sound/core/seq/seq_clientmgr.c                           |    6=20
 sound/pci/hda/hda_intel.c                                |    4=20
 sound/pci/hda/patch_realtek.c                            |   31 +
 sound/soc/fsl/fsl_esai.c                                 |   47 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c             |    8=20
 sound/xen/xen_snd_front_alsa.c                           |    2=20
 133 files changed, 1286 insertions(+), 846 deletions(-)

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

Ard Biesheuvel (1):
      arm64/ftrace: fix inadvertent BUG() in trampoline check

Arnd Bergmann (1):
      include/linux/bitrev.h: fix constant bitrev

Artemy Kovalyov (1):
      net/mlx5: Decrease default mr cache size

Axel Lin (1):
      hwmon: (w83773g) Select REGMAP_I2C to fix build error

Bart Van Assche (1):
      block: Revert v5.0 blk_mq_request_issue_directly() changes

Bj=F8rn Mork (1):
      qmi_wwan: add Olicard 600

Chuck Lever (1):
      xprtrdma: Fix helper that drains the transport

Cornelia Huck (1):
      virtio: Honour 'may_reduce_num' in vring_create_virtqueue

Dan Carpenter (1):
      xen: Prevent buffer overflow in privcmd ioctl

Daniel Drake (1):
      mmc: alcor: don't write data before command has completed

Dave Airlie (1):
      drm/udl: add a release method and delay modeset teardown

David Engraf (1):
      ARM: dts: at91: Fix typo in ISC_D0 on PC9

David Rientjes (1):
      kvm: svm: fix potential get_num_contig_pages overflow

David Summers (1):
      ARM: dts: rockchip: Fix SD card detection on rk3288-tinker

Davide Caratti (1):
      net/sched: act_sample: fix divide by zero in the traffic path

Dmitry V. Levin (2):
      riscv: Fix syscall_get_arguments() and syscall_set_arguments()
      csky: Fix syscall_get_arguments() and syscall_set_arguments()

Dust Li (1):
      tcp: fix a potential NULL pointer dereference in tcp_sk_exit

Eddie James (1):
      hwmon: (occ) Fix power sensor indexing

Eric Dumazet (1):
      netns: provide pure entropy for net_hash_mix()

Erik Schmauss (1):
      ACPICA: Namespace: remove address node from global list after method =
termination

Faiz Abbas (1):
      mmc: sdhci-omap: Don't finish_mrq() on a command error during tuning

Filipe Manana (1):
      Btrfs: do not allow trimming when a fs is mounted with the nologrepla=
y option

Furquan Shaikh (1):
      ACPICA: Clear status of GPEs before enabling them

Gavi Teitz (1):
      net/mlx5e: Fix error handling when refreshing TIRs

Gerd Hoffmann (1):
      drm/virtio: do NOT reuse resource ids

Greg Kroah-Hartman (3):
      tty: mark Siemens R3964 line discipline as BROKEN
      tty: ldisc: add sysctl to prevent autoloading of ldiscs
      Linux 5.0.8

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

Jani Nikula (1):
      drm/i915/dp: revert back to max link rate and lane count on eDP

Janusz Krzysztofik (1):
      ARM: OMAP1: ams-delta: Fix broken GPIO ID allocation

Jason Yan (1):
      block: fix the return errno for direct IO

Jernej Skrabec (1):
      drm/sun4i: DW HDMI: Lower max. supported rate for H6

Jian-Hong Pan (1):
      ALSA: hda/realtek: Enable headset MIC of Acer TravelMate B114-21 with=
 ALC233

Jiri Slaby (1):
      kcm: switch order of device registration to fix a crash

Jonas Karlman (1):
      ARM: dts: rockchip: fix rk3288 cpu opp node reference

Junwei Hu (1):
      ipv6: Fix dangling pointer when ipv6 fragment

J=E9r=F4me Glisse (1):
      block: do not leak memory in bio_copy_user_iov()

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

Lorenzo Bianconi (4):
      ipv6: sit: reset ip header pointer in ipip6_rcv
      net: ip_gre: fix possible use-after-free in erspan_rcv
      net: ip6_gre: fix possible use-after-free in ip6erspan_rcv
      net: thunderx: fix NULL pointer dereference in nicvf_open/nicvf_stop

Mao Wenan (1):
      net: rds: force to destroy connection if t_sock is NULL in rds_tcp_ki=
ll_sock().

Marc Orr (2):
      KVM: x86: nVMX: close leak of L0's x2APIC MSRs (CVE-2019-3887)
      KVM: x86: nVMX: fix x2APIC VTPR read intercept

Masahiro Yamada (1):
      kbuild: pkg: use -f $(srctree)/Makefile to recurse to top Makefile

Max Filippov (1):
      xtensa: fix return_address

Mel Gorman (1):
      sched/fair: Do not re-read ->h_load_next during hierarchical load cal=
culation

Miaohe Lin (1):
      net: vrf: Fix ping failed when vrf mtu is set to 0

Michael Chan (2):
      bnxt_en: Improve RX consumer index validity check.
      bnxt_en: Reset device on RX buffer errors.

Mike Snitzer (1):
      dm: disable DISCARD if the underlying storage no longer supports it

Mikulas Patocka (3):
      dm integrity: change memcmp to strncmp in dm_integrity_ctr
      dm: revert 8f50e358153d ("dm: limit the max bio size as BIO_MAX_PAGES=
 * PAGE_SIZE")
      dm integrity: fix deadlock with overlapping I/O

Moni Shoua (1):
      IB/mlx5: Reset access mask when looping inside page fault handler

Neil Armstrong (1):
      Revert "clk: meson: clean-up clock registration"

Nicholas Piggin (1):
      powerpc/64s/radix: Fix radix segment exception handling

Nick Desaulniers (2):
      kbuild: clang: choose GCC_TOOLCHAIN_DIR not on LD
      lib/string.c: implement a basic bcmp

Nicolas Dichtel (1):
      net/sched: fix ->get helper of the matchall cls

Nikolay Aleksandrov (1):
      net: bridge: always clear mcast matching struct on reports and leaves

Oleksandr Andrushchenko (1):
      ALSA: xen-front: Do not use stream buffer size before it is set

Pablo Neira Ayuso (2):
      netfilter: nft_compat: use .release_ops and remove list of extension
      netfilter: nf_tables: use-after-free in dynamic operations

Peter Geis (2):
      arm64: dts: rockchip: fix rk3328 sdmmc0 write errors
      arm64: dts: rockchip: fix rk3328 rgmii high tx error rate

Peter Hutterer (1):
      HID: logitech: Handle 0 scroll events for the m560

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

Steve French (1):
      SMB3: Allow persistent handle timeout to be configurable on mount

Sven Schnelle (2):
      parisc: regs_return_value() should return gpr28
      parisc: also set iaoq_b in instruction_pointer_set()

Taehee Yoo (1):
      netfilter: nf_tables: add missing ->release_ops() in error path of ne=
wrule()

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

Yuval Avnery (1):
      net/mlx5e: Add a lock on tir list

Zubin Mithra (1):
      ALSA: seq: Fix OOB-reads from strlcpy


--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAly3DqAACgkQONu9yGCS
aT49Gw//ZTd0+3sIoyTqcUkXJYI5+WNQdG36odUMs3O8VMgqxGy7NjwfTAkQiG8p
DPJT0h1VZX/I9LmTs2V74Qz5PEH3HAP3reU8IAblfBBCYTHkypfXadAVHbRd7jwg
ZiiOZDI33k76DGh4qp6eDY12YnmIHvCYwjSXsTPaoeI4499ahXYZ9H/tUaQX0CTv
O0ki79eUzPuL3rfqz+WIRF8xz4XzLFsFJj7renYOD95FZCtzERp+Y+hEqOJSBVcc
HykDBwgOC/QIZylYnBiIZQLLEs0pskSKdVb6Eap5U7qP+waMB6oOw+jIg3RMmwm6
3D0bvD03HHlB0fEspY0cDsi6fY4Yf7obYbEEMHmV2xw2D6qZCmPhd0py4Jl30AXq
wxE7Zl87ZQJn2OPVLoNfeoUwnUaGDIhgxEgURbtIl4eugtHs+2DLZK+Y70vDI5eI
e4fx9nnzgMXaTPcy8FI2pUZ9zbN5IIsUx1Q0B5+TgVOkxeCDAYRbx3Ojll56QCQY
RDPrKHbMawGZLsXvaI5ZdFJRO41umTwR96fG/o1MTGaJPyEKtqJCYLD3x8Vzs6KW
p8yaZjCLQz9jRCaJ7+Qb9/l6Ergvv109nLAtt+xBZQWwGSkr3I5ZIyZzaLSycI7r
iHBe7whT7oI2gRWtS69hFhP2j5pr650/yaSPIAeH4QWVngpn2u4=
=h3u+
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
