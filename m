Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D5BC10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B47D021855
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552580790;
	bh=UE+jIJ5NrWanyIUMKF7ZUeJTHbeV9aRkAsV2ae9AwYg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=APeztxwipcG9PJJp2Vq5aWSpSewYoRFBEofu7FC12p3FSgyfO+lhRuGTYx9JNSvBm
	 aakJkRqaVhmmPbMjYce3sdl5sII46mE0MyTJr84ZtFA4bkEvIW95D3aKeRYv5D+R1m
	 DUGKKgiMeVDP9RFa1vRouMw+limBcNUj+B2NMUxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfCNQ03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:26:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbfCNQ03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:26:29 -0400
Received: from localhost (unknown [12.27.65.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AB9121855;
        Thu, 14 Mar 2019 16:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552580787;
        bh=UE+jIJ5NrWanyIUMKF7ZUeJTHbeV9aRkAsV2ae9AwYg=;
        h=Date:From:To:Cc:Subject:From;
        b=g4EyxqtLOK8hA4cyHrOhn+n73p2kE1FlDYOh1X5kOEQXK4OkUbzDQsX5XxY6Vzfof
         3cc7U48FbGw3GF+mu9L/d2sKOwqOeCUbUt2AHC/GoBS4fuDlAgp37LXL155yTFcCy2
         aFRfkILZK0ov+B0b3QWaqmI7LQHXQZqmFhHV+WKk=
Date:   Thu, 14 Mar 2019 09:26:26 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.106
Message-ID: <20190314162626.GA20334@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.106 kernel.

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

 Makefile                                               |    2=20
 arch/arm/boot/dts/exynos3250.dtsi                      |    3=20
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi        |   13=20
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi         |    2=20
 arch/arm/kernel/entry-common.S                         |    4=20
 arch/arm/plat-pxa/ssp.c                                |    3=20
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts         |    1=20
 arch/arm64/boot/dts/qcom/msm8996.dtsi                  |    2=20
 arch/arm64/boot/dts/renesas/r8a7796.dtsi               |    3=20
 arch/arm64/kernel/probes/kprobes.c                     |    6=20
 arch/mips/boot/dts/ingenic/ci20.dts                    |    8=20
 arch/mips/kernel/irq.c                                 |    4=20
 arch/mips/kernel/process.c                             |    7=20
 arch/x86/events/core.c                                 |   13=20
 arch/x86/events/intel/core.c                           |  154 ++-
 arch/x86/events/perf_event.h                           |   17=20
 arch/x86/include/asm/cpufeatures.h                     |    1=20
 arch/x86/include/asm/msr-index.h                       |    6=20
 arch/x86/include/asm/page_64_types.h                   |    4=20
 arch/x86/kernel/cpu/amd.c                              |    8=20
 arch/x86/kernel/cpu/microcode/amd.c                    |    2=20
 arch/x86/kernel/kexec-bzimage64.c                      |    3=20
 arch/xtensa/configs/smp_lx200_defconfig                |    1=20
 arch/xtensa/kernel/head.S                              |    5=20
 arch/xtensa/kernel/process.c                           |    4=20
 arch/xtensa/kernel/smp.c                               |   41=20
 arch/xtensa/kernel/time.c                              |    2=20
 drivers/base/dd.c                                      |    2=20
 drivers/char/applicom.c                                |   35=20
 drivers/cpufreq/cpufreq.c                              |    6=20
 drivers/cpufreq/intel_pstate.c                         |   18=20
 drivers/dma/at_xdmac.c                                 |   19=20
 drivers/dma/dmatest.c                                  |   28=20
 drivers/firmware/iscsi_ibft.c                          |    1=20
 drivers/gpio/gpio-vf610.c                              |    5=20
 drivers/gpu/drm/sun4i/sun4i_tcon.c                     |    2=20
 drivers/i2c/busses/i2c-omap.c                          |   13=20
 drivers/infiniband/hw/hfi1/ud.c                        |    1=20
 drivers/infiniband/hw/qib/qib_ud.c                     |    1=20
 drivers/input/mouse/elan_i2c_core.c                    |    1=20
 drivers/input/tablet/wacom_serial4.c                   |    2=20
 drivers/iommu/amd_iommu.c                              |   19=20
 drivers/irqchip/irq-mmp.c                              |    6=20
 drivers/media/usb/uvc/uvc_driver.c                     |   14=20
 drivers/net/dsa/mv88e6xxx/chip.c                       |    4=20
 drivers/net/dsa/mv88e6xxx/port.c                       |    2=20
 drivers/net/ethernet/altera/altera_msgdma.c            |    3=20
 drivers/net/ethernet/broadcom/bnxt/bnxt.c              |    6=20
 drivers/net/ethernet/hisilicon/hns/hns_enet.c          |    5=20
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c       |   16=20
 drivers/net/ethernet/hisilicon/hns_mdio.c              |    2=20
 drivers/net/ethernet/marvell/sky2.c                    |   24=20
 drivers/net/ethernet/qlogic/qed/qed_dev.c              |    8=20
 drivers/net/ethernet/qlogic/qed/qed_l2.c               |   17=20
 drivers/net/ethernet/qlogic/qed/qed_l2.h               |    3=20
 drivers/net/ethernet/qlogic/qed/qed_ll2.c              |   20=20
 drivers/net/ethernet/qlogic/qed/qed_sp.h               |    1=20
 drivers/net/ethernet/qlogic/qed/qed_spq.c              |   15=20
 drivers/net/ethernet/qlogic/qed/qed_sriov.c            |   10=20
 drivers/net/ethernet/qlogic/qed/qed_vf.c               |   10=20
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c         |    4=20
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |   14=20
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c      |   17=20
 drivers/net/geneve.c                                   |   11=20
 drivers/net/hyperv/netvsc_drv.c                        |   22=20
 drivers/net/phy/micrel.c                               |   13=20
 drivers/net/phy/phylink.c                              |    4=20
 drivers/net/team/team_mode_loadbalance.c               |   15=20
 drivers/net/tun.c                                      |    4=20
 drivers/net/wireless/ath/ath9k/init.c                  |    6=20
 drivers/net/xen-netback/hash.c                         |    2=20
 drivers/net/xen-netback/interface.c                    |    7=20
 drivers/net/xen-netback/netback.c                      |   10=20
 drivers/platform/x86/Kconfig                           |    1=20
 drivers/s390/net/qeth_core_main.c                      |   15=20
 drivers/scsi/53c700.c                                  |    2=20
 drivers/scsi/aacraid/commsup.c                         |    5=20
 drivers/scsi/libfc/fc_lport.c                          |    6=20
 drivers/scsi/scsi_lib.c                                |    1=20
 drivers/soc/fsl/qbman/qman.c                           |    9=20
 drivers/staging/android/ion/ion_system_heap.c          |    2=20
 drivers/staging/comedi/drivers/ni_660x.c               |    1=20
 drivers/staging/wilc1000/linux_wlan.c                  |    4=20
 drivers/usb/phy/Kconfig                                |    2=20
 drivers/usb/serial/cp210x.c                            |    1=20
 drivers/usb/serial/ftdi_sio.c                          |    2=20
 drivers/usb/serial/ftdi_sio_ids.h                      |    6=20
 drivers/usb/serial/option.c                            |    2=20
 fs/autofs4/expire.c                                    |    3=20
 fs/autofs4/inode.c                                     |    4=20
 fs/buffer.c                                            |   19=20
 fs/cifs/smb2pdu.h                                      |    4=20
 fs/drop_caches.c                                       |    8=20
 fs/exec.c                                              |    2=20
 fs/gfs2/glock.c                                        |    2=20
 fs/hugetlbfs/inode.c                                   |   12=20
 fs/nfs/super.c                                         |    5=20
 include/drm/drm_cache.h                                |   18=20
 include/linux/cpufreq.h                                |   12=20
 include/linux/irqchip/arm-gic-v3.h                     |    2=20
 include/linux/stmmac.h                                 |    1=20
 include/net/bluetooth/bluetooth.h                      |    2=20
 include/net/icmp.h                                     |    9=20
 include/net/ip.h                                       |    2=20
 kernel/bpf/hashtab.c                                   |    4=20
 kernel/bpf/percpu_freelist.c                           |   41=20
 kernel/bpf/percpu_freelist.h                           |    4=20
 kernel/events/core.c                                   |   14=20
 kernel/relay.c                                         |    4=20
 lib/test_kmod.c                                        |    2=20
 mm/hugetlb.c                                           |   16=20
 mm/memory_hotplug.c                                    |    6=20
 mm/migrate.c                                           |   11=20
 net/bluetooth/af_bluetooth.c                           |   16=20
 net/bluetooth/l2cap_sock.c                             |    2=20
 net/bluetooth/rfcomm/sock.c                            |    2=20
 net/bluetooth/sco.c                                    |    2=20
 net/bridge/netfilter/ebtables.c                        |    9=20
 net/core/filter.c                                      |    2=20
 net/core/net-sysfs.c                                   |    3=20
 net/ipv4/cipso_ipv4.c                                  |   20=20
 net/ipv4/fib_frontend.c                                |    4=20
 net/ipv4/icmp.c                                        |    7=20
 net/ipv4/ip_options.c                                  |   22=20
 net/ipv4/ip_vti.c                                      |   50 +
 net/ipv6/ip6mr.c                                       |    8=20
 net/ipv6/route.c                                       |    4=20
 net/ipv6/sit.c                                         |    1=20
 net/mpls/af_mpls.c                                     |    3=20
 net/netfilter/ipvs/ip_vs_ctl.c                         |   12=20
 net/netfilter/nf_conntrack_core.c                      |   16=20
 net/netlabel/netlabel_kapi.c                           |    3=20
 net/nfc/llcp_commands.c                                |   20=20
 net/nfc/llcp_core.c                                    |   24=20
 net/sched/sch_netem.c                                  |   10=20
 net/socket.c                                           |    1=20
 net/tipc/socket.c                                      |    2=20
 net/vmw_vsock/virtio_transport.c                       |   29=20
 security/apparmor/domain.c                             |    5=20
 tools/perf/builtin-trace.c                             |   25=20
 tools/perf/util/cpumap.c                               |   11=20
 tools/perf/util/symbol-elf.c                           |    9=20
 tools/testing/selftests/bpf/bpf_util.h                 |   30=20
 tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh |   13=20
 tools/testing/selftests/netfilter/Makefile             |    2=20
 tools/testing/selftests/netfilter/config               |    2=20
 tools/testing/selftests/netfilter/nft_nat.sh           |  762 ++++++++++++=
+++++
 tools/testing/selftests/timers/Makefile                |    2=20
 148 files changed, 1792 insertions(+), 374 deletions(-)

Ajay Singh (1):
      staging: wilc1000: fix to set correct value for 'vif_num'

Alexei Starovoitov (1):
      bpf: fix lockdep false positive in percpu_freelist

Alexey Khoroshilov (1):
      net: stmmac: dwmac-rk: fix error handling in rk_gmac_powerup()

Alistair Strachan (1):
      media: uvcvideo: Fix 'type' check leading to overflow

Anders Roxell (1):
      usb: phy: fix link errors

Andreas Gruenbacher (1):
      gfs2: Fix missed wakeups in find_insert_glock

Andrew Lunn (3):
      net: dsa: mv88e6xxx: Fix u64 statistics
      net: dsa: mv88e6xxx: Fix statistics on mv88e6161
      gpio: vf610: Mask all GPIO interrupts

Andy Shevchenko (1):
      dmaengine: dmatest: Abort test in case of mapping error

Ard Biesheuvel (1):
      drm: disable uncached DMA optimization for ARM and arm64

Arnaldo Carvalho de Melo (1):
      perf trace: Support multiple "vfs_getname" probes

Brian Welty (1):
      IB/{hfi1, qib}: Fix WC.byte_len calculation for UD_SEND_WITH_IMM

Codrin Ciubotariu (1):
      dmaengine: at_xdmac: Fix wrongfull report of a channel as in use

Colin Ian King (1):
      selftests: cpu-hotplug: fix case where CPUs offline > CPUs present

Dan Carpenter (2):
      scsi: 53c700: pass correct "dev" to dma_alloc_attrs()
      lib/test_kmod.c: potential double free in error handling

Daniel F. Dickinson (1):
      ath9k: Avoid OF no-EEPROM quirks without qca,no-eeprom

Daniele Palmas (1):
      USB: serial: option: add Telit ME910 ECM composition

David Ahern (3):
      ipv4: Return error for RTA_VIA attribute
      ipv6: Return error for RTA_VIA attribute
      mpls: Return error for RTA_GATEWAY attribute

Eric Biggers (1):
      net: socket: set sock->sk to NULL after calling proto_ops::release()

Erik Hugne (1):
      tipc: fix RDM/DGRAM connect() regression

Fathi Boudra (1):
      selftests: timers: use LDLIBS instead of LDFLAGS

Florian Westphal (2):
      netfilter: ebtables: compat: un-break 32bit setsockopt when no rules =
are present
      selftests: netfilter: add simple masq/redirect test cases

Geert Uytterhoeven (2):
      arm64: dts: renesas: r8a7796: Enable DMA for SCIF2
      driver core: Postpone DMA tear-down until after devres release

Greg Kroah-Hartman (2):
      relay: check return of create_buf_file() properly
      Linux 4.14.106

Gustavo A. R. Silva (4):
      staging: comedi: ni_660x: fix missing break in switch statement
      applicom: Fix potential Spectre v1 vulnerabilities
      iscsi_ibft: Fix missing break in switch statement
      scsi: aacraid: Fix missing break in switch statement

Haiyang Zhang (1):
      hv_netvsc: Fix IP header checksum for coalesced packets

Heiner Kallweit (2):
      net: dsa: mv88e6xxx: handle unknown duplex modes gracefully in mv88e6=
xxx_port_set_duplex
      net: phy: phylink: fix uninitialized variable in phylink_get_mac_state

Ian Kent (1):
      autofs: fix error return in autofs_fill_super()

Ido Schimmel (2):
      ip6mr: Do not call __IP6_INC_STATS() from preemptible context
      team: Free BPF filter when unregistering netdev

Igor Druzhinin (2):
      xen-netback: don't populate the hash cache on XenBus disconnect
      xen-netback: fix occasional leak of grant ref mappings under memory p=
ressure

Ivan Mironov (1):
      USB: serial: cp210x: add ID for Ingenico 3070

James Morse (1):
      arm64: kprobe: Always blacklist the KVM world-switch code

Jan Kara (1):
      fs/drop_caches.c: avoid softlockups in drop_pagecache_sb()

Jan Kiszka (1):
      arm64: dts: hikey: Give wifi some time after power-on

Jason Gerecke (1):
      Input: wacom_serial4 - add support for Wacom ArtPad II tablet

Jerry Snitselaar (2):
      iommu/amd: Call free_iova_fast with pfn in map_sg
      iommu/amd: Unmap all mapped pages in error path of map_sg

Jiaxun Yang (1):
      x86/CPU/AMD: Set the CPB bit unconditionally on F17h

Jiri Benc (1):
      geneve: correctly handle ipv6.disable module parameter

Jiri Olsa (1):
      perf symbols: Filter out hidden symbols from labels

John Johansen (1):
      apparmor: Fix aa_label_build() error handling for failed merges

Jose Abreu (3):
      net: stmmac: Fallback to Platform Data clock in Watchdog conversion
      net: stmmac: Send TSO packets always from Queue 0
      net: stmmac: Disable EEE mode earlier in XMIT callback

Julian Wiedmann (1):
      s390/qeth: fix use-after-free in error path

Jun-Ru Chang (1):
      MIPS: Remove function size check in get_frame_info()

Kai-Heng Feng (1):
      sky2: Disable MSI on Dell Inspiron 1545 and Gateway P-79

Kairui Song (1):
      x86/kexec: Don't setup EFI info if EFI runtime is not enabled

Liu Xiang (1):
      MIPS: irq: Allocate accurate order pages for irq stack

Lubomir Rintel (1):
      irqchip/mmp: Only touch the PJ4 IRQ & FIQ bits on enable/disable

Madalin Bucur (1):
      soc: fsl: qbman: avoid race in clearing QMan interrupt

Manish Chopra (6):
      qed: Fix bug in tx promiscuous mode settings
      qed: Fix LACP pdu drops for VFs
      qed: Fix VF probe failure while FLR
      qed: Fix system crash in ll2 xmit
      qed: Fix stack out of bounds bug
      qed: Fix EQ full firmware assert.

Mans Rullgard (1):
      USB: serial: ftdi_sio: add ID for Hjelmslund Electronics USB485

Mao Wenan (1):
      net: sit: fix memory leak in sit_init_net()

Marek Szyprowski (2):
      ARM: dts: exynos: Fix pinctrl definition for eMMC RTSN line on Odroid=
 X2/U3
      ARM: dts: exynos: Add minimal clkout parameters to Exynos3250 PMU

Martin Wilck (1):
      scsi: core: reset host byte in DID_NEXUS_FAILURE case

Martynas Pumputis (2):
      bpf, selftests: fix handling of sparse CPU allocations
      netfilter: nf_nat: skip nat clash resolution for same-origin entries

Matthias Kaehlcke (1):
      Bluetooth: Fix locking in bt_accept_enqueue() for BH context

Max Filippov (6):
      xtensa: fix get_wchan
      xtensa: SMP: fix ccount_timer_shutdown
      xtensa: SMP: fix secondary CPU initialization
      xtensa: smp_lx200_defconfig: fix vectors clash
      xtensa: SMP: mark each possible CPU as present
      xtensa: SMP: limit number of possible CPUs by NR_CPUS

Michael Chan (1):
      bnxt_en: Drop oversize TX packets to prevent errors.

Michal Hocko (1):
      mm, memory_hotplug: is_mem_section_removable do not pass the end of a=
 zone

Mike Kravetz (1):
      hugetlbfs: fix races and page leaks during migration

Mikhail Zaslonko (1):
      mm, memory_hotplug: test_pages_in_a_zone do not pass the end of zone

Ming Lu (1):
      scsi: libfc: free skb when receiving invalid flogi resp

Naresh Kamboju (1):
      selftests: netfilter: fix config fragment CONFIG_NF_TABLES_INET

Nazarov Sergey (2):
      net: Add __icmp_send helper.
      net: avoid use IPCB in cipso_v4_error

Pan Bian (1):
      autofs: drop dentry reference only when it is never used

Paul Kocialkowski (1):
      drm/sun4i: tcon: Prepare and enable TCON channel 0 clock at init

Paul Moore (1):
      netlabel: fix out-of-bounds memory accesses

Peng Hao (1):
      ARM: pxa: ssp: unneeded to free devm_ allocated data

Peter Zijlstra (Intel) (4):
      perf/x86/intel: Make cpuc allocations consistent
      perf/x86/intel: Generalize dynamic constraint creation
      x86: Add TSX Force Abort CPUID/MSR
      perf/x86/intel: Implement support for TSX Force Abort

Qian Cai (1):
      x86_64: increase stack size for KASAN_EXTRA

Qing Xia (1):
      staging: android: ion: fix sys heap pool's gfp_flags

Rajasingh Thavamani (1):
      net: phy: Micrel KSZ8061: link failure after cable connect

Ronnie Sahlberg (1):
      cifs: fix computation for MAX_SMB2_HDR_SIZE

Sheng Lan (1):
      net: netem: fix skb length BUG_ON in __skb_to_sgvec

Sinan Kaya (1):
      platform/x86: Fix unmet dependency warning for SAMSUNG_Q10

Srinivas Kandagatla (1):
      arm64: dts: add msm8996 compatible to gicv3

Stefano Garzarella (2):
      vsock/virtio: fix kernel panic after device hot-unplug
      vsock/virtio: reset connected sockets on device removal

Stephane Eranian (2):
      perf core: Fix perf_proc_update_handler() bug
      perf tools: Handle TOPOLOGY headers with no CPU

Su Yanjun (1):
      vti4: Fix a ipip packet processing bug in 'IPCOMP' virtual tunnel

Sudarsana Reddy Kalluru (1):
      qed: Consider TX tcs while deriving the max num_queues for PF.

Suravee Suthikulpanit (1):
      iommu/amd: Fix IOMMU page flush when detach device from a domain

Tetsuo Handa (1):
      fs: ratelimit __find_get_block_slow() failure message.

Thomas Lendacky (1):
      x86/microcode/amd: Don't falsely trick the late loading mechanism

Timur Celik (2):
      tun: fix blocking read
      tun: remove unnecessary memory barrier

Tomonori Sakita (1):
      net: altera_tse: fix msgdma_tx_completion on non-zero fill_level case

Tony Lindgren (2):
      ARM: dts: omap4-droid4: Fix typo in cpcap IRQ flags
      i2c: omap: Use noirq system sleep pm ops to idle device for suspend

Vincent Batts (1):
      Input: elan_i2c - add id for touchpad found in Lenovo s21e-20

Vincent Whitchurch (1):
      ARM: 8781/1: Fix Thumb-2 syscall return for binutils 2.29+

Viresh Kumar (1):
      cpufreq: Use struct kobj_attribute instead of struct global_attr

Yafang Shao (1):
      bpf: sock recvbuff must be limited by rmem_max in bpf_setsockopt()

Yao Liu (1):
      nfs: Fix NULL pointer dereference of dev_name

Yonglong Liu (3):
      net: hns: Fix for missing of_node_put() after of_parse_phandle()
      net: hns: Restart autoneg need return failed when autoneg off
      net: hns: Fix wrong read accesses via Clause 45 MDIO protocol

YueHaibing (3):
      net-sysfs: Fix mem leak in netdev_register_kobject
      net: nfc: Fix NULL dereference on nfc_llcp_build_tlv fails
      exec: Fix mem leak in kernel_read_file

Zenghui Yu (1):
      irqchip/gic-v3-its: Fix ITT_entry_size accessor

ZhangXiaoxu (1):
      ipvs: Fix signed integer overflow when setsockopt timeout

Zhou Yanjie (1):
      DTS: CI20: Fix bugs in ci20's device tree.


--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlyKgLAACgkQONu9yGCS
aT51pg/9F+DJZWzFm4ykcdeVYGY0y/PCg+g3NKEPID2Uiypqp34eCcC44BPFeaDL
5kp8PBRwQ7HeBsnATU/N7j1c4ryE8vtJopZclEXEdEFGJhUWpePw8XWLL5wbNa2x
jvQzVE7C0JwkVqSWx6/v9lDuBp0q1tn9GJ88qbBHSY0XYNKhp6pIAvdsmoMWA3S+
/lpAhxKnxa+eAZxapEbSH3bL0O5b/QtwnFOBOPY8GQk+ukeE5Kl70TrM9Mbp9UAR
G9fkcYkGe2DZblzUOs9Lo+JwFFyMPWsZw21KqbKhjDisiSf+32g20I4CA55SLYtc
enHf2v/KIbIdcn0VqRPDsGvSMZW0xkPQW/Fvxcc/yzx0IFRHSHuUDreQ2pIoTj6E
hSYz0cyVzq6fxJctzWZrce9wdgJVa6AMWT7cju3LPjAHUnYkdIGICQp8gWbt82iY
IlqHCmRCDjQ8v41ItGI3tZlJY7OOIsniVJlJ2HwNAX7VKcr2YqU4ZUYpcJ6SAlk6
3t0bireU0v8NeDx/7K5TJBn7uteBa2rYv63Ap6sz5zmaUdwYzvbkAZL8xBt09BYB
wQ6WGi/f/xlpmeqCtT5gUQiQeNs68VapGeaIGizRATN4u17fsPyPAy7zEQ7JMhU4
uWHYQaIHZkZaPI/Mq+Fo/LgFvXZEeOWz5UiksIx6pVfjGD/6Ruo=
=k1T3
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
