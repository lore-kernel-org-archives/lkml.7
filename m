Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619F4C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B5620821
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555500645;
	bh=Klf6Kz3ix37AkM1BTBr9v15GDWl33T9wlIgmJI2U0Nk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=zWa3cZSJNwciQ7QWezLMWERNiE5aphzaKuPzdQYGjQ5BSc6o1LbAoLeSxgwmfYDNp
	 B59Ztb4aP3uohQJPss8fggCSXGvZiBM+daBF/ahdBi0Js1GDrPw4SNDpu4KLSZAfXX
	 5CXxP9LrnkvYjWUNODaxtlo380CXMcfO4dc7UKeE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731949AbfDQLan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:30:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731863AbfDQLan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:30:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F9DB2073F;
        Wed, 17 Apr 2019 11:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555500641;
        bh=Klf6Kz3ix37AkM1BTBr9v15GDWl33T9wlIgmJI2U0Nk=;
        h=Date:From:To:Cc:Subject:From;
        b=ZPRUiJKnDc0ZPiMkcKPQAshBhVB34OR6SSnrMUc6deb0W9Du544ZseqVhrRh1tEXH
         J4UZFa0bI9U5Hckrg60homGX8OhNakVE8eMRiDnVhWInp0+SdmM8VbexAG/rH9VvOO
         4St4lIrGW+1/E8MWMSB4+pubXEOwboxvBwRVZC5o=
Date:   Wed, 17 Apr 2019 13:30:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.169
Message-ID: <20190417113039.GA7192@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.169 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                            |    4=20
 arch/arm/boot/dts/sama5d2-pinfunc.h                 |    2=20
 arch/arm64/include/asm/futex.h                      |   16 -
 arch/arm64/mm/init.c                                |    2=20
 arch/parisc/include/asm/processor.h                 |    2=20
 arch/parisc/kernel/process.c                        |    6=20
 arch/parisc/kernel/setup.c                          |    3=20
 arch/parisc/kernel/time.c                           |    2=20
 arch/powerpc/Kconfig                                |    7=20
 arch/powerpc/include/asm/asm-prototypes.h           |    6=20
 arch/powerpc/include/asm/barrier.h                  |   21 +
 arch/powerpc/include/asm/code-patching-asm.h        |   18 +
 arch/powerpc/include/asm/code-patching.h            |    2=20
 arch/powerpc/include/asm/feature-fixups.h           |   21 +
 arch/powerpc/include/asm/hvcall.h                   |    2=20
 arch/powerpc/include/asm/ppc_asm.h                  |   23 ++
 arch/powerpc/include/asm/security_features.h        |    7=20
 arch/powerpc/include/asm/setup.h                    |   21 +
 arch/powerpc/include/asm/uaccess.h                  |   11 -
 arch/powerpc/kernel/Makefile                        |    3=20
 arch/powerpc/kernel/entry_32.S                      |   10=20
 arch/powerpc/kernel/entry_64.S                      |   69 ++++++
 arch/powerpc/kernel/exceptions-64e.S                |   27 ++
 arch/powerpc/kernel/head_booke.h                    |   12 +
 arch/powerpc/kernel/head_fsl_booke.S                |   15 +
 arch/powerpc/kernel/module.c                        |   10=20
 arch/powerpc/kernel/security.c                      |  216 +++++++++++++++=
++++-
 arch/powerpc/kernel/setup-common.c                  |    3=20
 arch/powerpc/kernel/signal_64.c                     |   23 +-
 arch/powerpc/kernel/swsusp_asm64.S                  |    2=20
 arch/powerpc/kernel/vmlinux.lds.S                   |   19 +
 arch/powerpc/kvm/bookehv_interrupts.S               |    4=20
 arch/powerpc/kvm/e500_emulate.c                     |    7=20
 arch/powerpc/lib/code-patching.c                    |   24 ++
 arch/powerpc/lib/copypage_power7.S                  |   14 -
 arch/powerpc/lib/copyuser_power7.S                  |   66 +++---
 arch/powerpc/lib/feature-fixups.c                   |   93 ++++++++
 arch/powerpc/lib/memcpy_power7.S                    |   66 +++---
 arch/powerpc/lib/string_64.S                        |    2=20
 arch/powerpc/mm/mem.c                               |    2=20
 arch/powerpc/mm/tlb_low_64e.S                       |    7=20
 arch/powerpc/platforms/powernv/setup.c              |    7=20
 arch/powerpc/platforms/pseries/setup.c              |    7=20
 arch/x86/entry/vdso/Makefile                        |   22 --
 arch/x86/include/asm/suspend_32.h                   |    8=20
 arch/x86/include/asm/suspend_64.h                   |   19 +
 arch/x86/include/asm/xen/hypercall.h                |    3=20
 arch/x86/power/cpu.c                                |   96 ++++----
 arch/xtensa/kernel/stacktrace.c                     |    6=20
 block/bio.c                                         |    5=20
 drivers/char/Kconfig                                |    2=20
 drivers/net/ethernet/broadcom/bnxt/bnxt.c           |   14 +
 drivers/net/ethernet/mellanox/mlx5/core/en_common.c |    7=20
 drivers/net/usb/qmi_wwan.c                          |    1=20
 drivers/pci/quirks.c                                |    2=20
 drivers/tty/Kconfig                                 |   23 ++
 drivers/tty/tty_io.c                                |    3=20
 drivers/tty/tty_ldisc.c                             |   47 ++++
 drivers/virtio/virtio_ring.c                        |    2=20
 fs/btrfs/ioctl.c                                    |   10=20
 include/linux/bitrev.h                              |   36 +--
 include/linux/mlx5/driver.h                         |    2=20
 include/linux/string.h                              |    3=20
 include/linux/virtio_ring.h                         |    2=20
 include/net/ip.h                                    |    2=20
 include/net/net_namespace.h                         |    1=20
 include/net/netns/hash.h                            |   15 -
 kernel/irq/chip.c                                   |    4=20
 kernel/sched/fair.c                                 |    6=20
 lib/string.c                                        |   20 +
 net/core/ethtool.c                                  |   47 ++--
 net/core/net_namespace.c                            |    1=20
 net/ipv4/ip_input.c                                 |    7=20
 net/ipv4/ip_options.c                               |    4=20
 net/ipv4/tcp_dctcp.c                                |   36 +--
 net/ipv6/ip6_output.c                               |    4=20
 net/ipv6/ip6_tunnel.c                               |    4=20
 net/ipv6/sit.c                                      |    4=20
 net/kcm/kcmsock.c                                   |   16 -
 net/openvswitch/flow_netlink.c                      |    4=20
 net/rds/tcp.c                                       |    2=20
 net/sctp/protocol.c                                 |    1=20
 sound/core/seq/seq_clientmgr.c                      |    6=20
 sound/soc/fsl/fsl_esai.c                            |   47 +++-
 84 files changed, 1140 insertions(+), 288 deletions(-)

Alistair Strachan (1):
      x86: vdso: Use $LD instead of $CC to link

Andre Przywara (1):
      PCI: Add function 1 DMA alias quirk for Marvell 9170 SATA controller

Andrea Righi (1):
      openvswitch: fix flow actions reallocation

Andreas Schwab (1):
      powerpc: Fix invalid use of register expressions

Andy Lutomirski (4):
      x86/power: Fix some ordering bugs in __restore_processor_context()
      x86/power/64: Use struct desc_ptr for the IDT in struct saved_context
      x86/power/32: Move SYSENTER MSR restoration to fix_processor_context()
      x86/power: Make restore_processor_context() sane

Arnd Bergmann (1):
      include/linux/bitrev.h: fix constant bitrev

Bj=F8rn Mork (1):
      qmi_wwan: add Olicard 600

Breno Leitao (1):
      powerpc/tm: Limit TM code inside PPC_TRANSACTIONAL_MEM

Christophe Leroy (1):
      powerpc/fsl: Fix the flush of branch predictor.

Cornelia Huck (1):
      virtio: Honour 'may_reduce_num' in vring_create_virtqueue

Dan Carpenter (1):
      xen: Prevent buffer overflow in privcmd ioctl

David Engraf (1):
      ARM: dts: at91: Fix typo in ISC_D0 on PC9

Diana Craciun (16):
      powerpc/64: Disable the speculation barrier from the command line
      powerpc/64: Make stf barrier PPC_BOOK3S_64 specific.
      powerpc/64: Make meltdown reporting Book3S 64 specific
      powerpc/fsl: Add barrier_nospec implementation for NXP PowerPC Book3E
      powerpc/fsl: Sanitize the syscall table for NXP PowerPC 32 bit platfo=
rms
      powerpc/fsl: Add infrastructure to fixup branch predictor flush
      powerpc/fsl: Add macro to flush the branch predictor
      powerpc/fsl: Fix spectre_v2 mitigations reporting
      powerpc/fsl: Emulate SPRN_BUCSR register
      powerpc/fsl: Add nospectre_v2 command line argument
      powerpc/fsl: Flush the branch predictor at each kernel entry (64bit)
      powerpc/fsl: Flush the branch predictor at each kernel entry (32 bit)
      powerpc/fsl: Flush branch predictor when entering KVM
      powerpc/fsl: Enable runtime patching if nospectre_v2 boot arg is used
      powerpc/fsl: Update Spectre v2 reporting
      powerpc/fsl: Fixed warning: orphan section `__btb_flush_fixup'

Eric Dumazet (1):
      netns: provide pure entropy for net_hash_mix()

Filipe Manana (1):
      Btrfs: do not allow trimming when a fs is mounted with the nologrepla=
y option

Greg Kroah-Hartman (3):
      tty: mark Siemens R3964 line discipline as BROKEN
      tty: ldisc: add sysctl to prevent autoloading of ldiscs
      Linux 4.9.169

Helge Deller (2):
      parisc: Detect QEMU earlier in boot process
      parisc: Use cr16 interval timers unconditionally on qemu

Jiri Slaby (1):
      kcm: switch order of device registration to fix a crash

Junwei Hu (1):
      ipv6: Fix dangling pointer when ipv6 fragment

J=E9r=F4me Glisse (1):
      block: do not leak memory in bio_copy_user_iov()

Koen De Schepper (1):
      tcp: Ensure DCTCP reacts to losses

Li RongQing (1):
      net: ethtool: not call vzalloc for zero sized memory request

Lorenzo Bianconi (1):
      ipv6: sit: reset ip header pointer in ipip6_rcv

Mao Wenan (1):
      net: rds: force to destroy connection if t_sock is NULL in rds_tcp_ki=
ll_sock().

Max Filippov (1):
      xtensa: fix return_address

Mel Gorman (1):
      sched/fair: Do not re-read ->h_load_next during hierarchical load cal=
culation

Michael Chan (2):
      bnxt_en: Reset device on RX buffer errors.
      bnxt_en: Improve RX consumer index validity check.

Michael Ellerman (11):
      powerpc: Use barrier_nospec in copy_from_user()
      powerpc/64: Use barrier_nospec in syscall entry
      powerpc64s: Show ori31 availability in spectre_v1 sysfs file not v2
      powerpc/64: Add CONFIG_PPC_BARRIER_NOSPEC
      powerpc/64: Call setup_barrier_nospec() from setup_arch()
      powerpc/asm: Add a patch_site macro & helpers for patching instructio=
ns
      powerpc/64s: Add new security feature flags for count cache flush
      powerpc/64s: Add support for software count cache flush
      powerpc/pseries: Query hypervisor for count cache flush settings
      powerpc/powernv: Query firmware for count cache flush settings
      powerpc/security: Fix spectre_v2 reporting

Michael Neuling (1):
      powerpc: Avoid code patching freed init sections

Michal Suchanek (5):
      powerpc/64s: Add barrier_nospec
      powerpc/64s: Add support for ori barrier_nospec patching
      powerpc/64s: Patch barrier_nospec in modules
      powerpc/64s: Enable barrier_nospec based on firmware settings
      powerpc/64s: Enhance the information in cpu_show_spectre_v1()

Nick Desaulniers (3):
      kbuild: clang: choose GCC_TOOLCHAIN_DIR not on LD
      x86/vdso: Drop implicit common-page-size linker flag
      lib/string.c: implement a basic bcmp

S.j. Wang (1):
      ASoC: fsl_esai: fix channel swap issue when stream starts

Sheena Mira-ato (1):
      ip6_tunnel: Match to ARPHRD_TUNNEL6 for dev type

Stephen Boyd (1):
      genirq: Respect IRQCHIP_SKIP_SET_WAKE in irq_chip_set_wake_parent()

Stephen Suryaputra (1):
      vrf: check accept_source_route on the original netdevice

Will Deacon (1):
      arm64: futex: Fix FUTEX_WAKE_OP atomic ops with non-zero result value

Xin Long (1):
      sctp: initialize _pad of sockaddr_in before copying to user memory

Yueyi Li (1):
      arm64: kaslr: Reserve size of ARM64_MEMSTART_ALIGN in linear region

Yuval Avnery (1):
      net/mlx5e: Add a lock on tir list

Zubin Mithra (1):
      ALSA: seq: Fix OOB-reads from strlcpy


--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAly3DlwACgkQONu9yGCS
aT5jtw/9FAtxvWgTwrd5+z3FUVFZwLCQfZ57mUBzJ3oePj19uM/rYr2ffDkf1WaO
Rc9RHiUkbUpMXdSdzZK+QsKnXNcf1nBorNLgcz3lhZxUVI4UQNJsSbzRoTV6lJlD
livFoSJQwKOAyjRhz/Nk7SVZMKbmguevRmKm8HIio3TDtWHniO+lYboIZR0iNlwM
3TnlmLQh7Pd2xDOeKHew9b1j7KVw33MmJ+20OoPRWqAgexVqp8TZbkHMNzZAmKa7
11Zt2OelhQaXFHSfdJMuG916jHvfDqAckEbe7WDm97xSiKWtJDIY7bZORYbBPPfz
pfYzcgzFkq3N8GLnR1yc267fO9nLnigutDkElaRJcWYGbQfhS2lXAY27zZP42ZtH
EgKlvJEUXghH0eLJp0rJcOCWVKzbnpFIgR93vTTpraE0BHM59J1Ldc9vubtwnVnU
ZNbM2uEeiM+ohHrxnP4Y6nfVncjIdvwOdWNhhLyKuaMYpPSw16SwOa7mFra06lO5
ShRXBad80gd/ULA2cY0jaqWsQyuqny19yl7u4tTWvXjS9dBexx1gMljDnGcZvsWT
EK9S64EfH99E2e2gZAuAul5h+hzqkdYnMD0aPur/A1HGl1uQHMlTZu8WsGuEv8Ol
jrueoUyQPBxEeeGH1dqYX/p/W1JKVdVmoY5K3IH5V5s7H20tzwQ=
=SiSN
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
