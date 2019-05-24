Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF67C282E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A15620815
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558720962;
	bh=VHeempwt28i9rrl6q9bhRRomFDRg8pPniE3+bK+DSqQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Z0dfDHQk3G/opYbc0hQBWF2fzbKWl6hlTF7JvHwlhKDPzLv8OQRatMkQjib6USa10
	 NDYu/HzBV4gVrd+KeWmk3KiA81MzzJhQKjUGJ/DAEaL6QBAHyI985OYhGfRxYTWmV1
	 dJzSy/wHwnoumgY01CTfpfMUW7ohDTQEraIGFUDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731967AbfEXSCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 14:02:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbfEXSCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:02:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3C382070D;
        Fri, 24 May 2019 18:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558720956;
        bh=VHeempwt28i9rrl6q9bhRRomFDRg8pPniE3+bK+DSqQ=;
        h=Date:From:To:Cc:Subject:From;
        b=fmHJOgQ30J+06N+5LBezX4/wzd6B6B+AMWaYWDjo7sYY/0EK2QQLwuvQhEbG8h92T
         8qTYYhLh3rfQSEJqhYLEQQZXS48AIFULBm+sgK/tDSNR9JhuJ630np/wQwn8GiSUsr
         hdO/1gWhwrFmqnYi3fewkWHgCyZaYrrRtu3rsDNM=
Date:   Fri, 24 May 2019 20:02:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-spdx@vger.kernel.org
Subject: [GIT PULL] SPDX update for 5.2-rc1 - round 2
Message-ID: <20190524180233.GA28288@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2c1212de6f9794a7becba5f219fa6ce8a8222c90:

  Merge tag 'spdx-5.2-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core (2019-05-21 12:33:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/spdx-5.2-rc2-2

for you to fetch changes up to 060358de993f24562e884e265c4c57864a3a4141:

  treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 125 (2019-05-24 17:39:03 +0200)

----------------------------------------------------------------
SPDX update for 5.2-rc2, round 2

Here is another set of reviewed patches that adds SPDX tags to different
kernel files, based on a set of rules that are being used to parse the
comments to try to determine that the license of the file is
"GPL-2.0-or-later".  Only the "obvious" versions of these matches are
included here, a number of "non-obvious" variants of text have been
found but those have been postponed for later review and analysis.

These patches have been out for review on the linux-spdx@vger mailing
list, and while they were created by automatic tools, they were
hand-verified by a bunch of different people, all whom names are on the
patches are reviewers.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Thomas Gleixner (85):
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 26
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 27
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 28
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 29
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 30
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 31
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 32
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 33
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 34
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 35
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 36
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 37
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 38
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 39
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 40
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 41
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 42
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 44
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 45
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 46
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 47
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 48
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 49
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 50
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 51
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 52
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 53
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 54
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 55
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 56
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 57
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 59
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 60
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 61
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 62
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 63
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 64
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 65
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 67
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 68
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 69
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 70
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 71
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 72
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 73
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 74
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 75
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 76
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 77
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 78
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 79
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 81
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 82
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 83
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 84
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 86
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 88
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 89
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 90
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 91
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 93
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 94
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 95
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 96
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 97
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 98
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 101
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 102
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 103
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 104
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 105
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 106
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 110
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 111
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 112
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 113
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 114
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 116
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 118
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 119
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 120
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 121
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 122
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 123
      treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 125

 arch/alpha/include/asm/xor.h                        | 10 +---------
 arch/arm/mach-davinci/board-sffsdr.c                | 15 +--------------
 arch/arm/mach-davinci/serial.c                      | 16 +---------------
 arch/arm/mach-imx/iomux-v1.c                        | 15 +--------------
 arch/arm/mach-ixp4xx/include/mach/ixp46x_ts.h       | 15 +--------------
 arch/arm/mach-omap2/omap_phy_internal.c             | 16 +---------------
 arch/arm/nwfpe/double_cpdo.c                        | 14 +-------------
 arch/arm/nwfpe/entry.S                              | 14 +-------------
 arch/arm/nwfpe/extended_cpdo.c                      | 14 +-------------
 arch/arm/nwfpe/fpa11.c                              | 14 +-------------
 arch/arm/nwfpe/fpa11.h                              | 14 +-------------
 arch/arm/nwfpe/fpa11_cpdo.c                         | 14 +-------------
 arch/arm/nwfpe/fpa11_cpdt.c                         | 14 +-------------
 arch/arm/nwfpe/fpa11_cprt.c                         | 14 +-------------
 arch/arm/nwfpe/fpmodule.c                           | 14 +-------------
 arch/arm/nwfpe/fpmodule.h                           | 14 +-------------
 arch/arm/nwfpe/fpopcode.c                           | 14 +-------------
 arch/arm/nwfpe/fpopcode.h                           | 14 +-------------
 arch/arm/nwfpe/fpsr.h                               | 14 +-------------
 arch/arm/nwfpe/single_cpdo.c                        | 14 +-------------
 arch/c6x/include/asm/irqflags.h                     |  6 +-----
 arch/ia64/include/asm/xor.h                         | 10 +---------
 arch/ia64/lib/xor.S                                 | 10 +---------
 arch/m68k/math-emu/fp_arith.c                       |  4 +---
 arch/m68k/math-emu/fp_arith.h                       |  4 +---
 arch/m68k/math-emu/multi_arith.h                    |  5 ++---
 arch/mips/alchemy/board-gpr.c                       | 15 +--------------
 arch/mips/alchemy/board-mtx1.c                      | 15 +--------------
 arch/mips/alchemy/board-xxs1500.c                   | 15 +--------------
 arch/mips/alchemy/devboards/db1000.c                | 15 +--------------
 arch/mips/alchemy/devboards/db1200.c                | 15 +--------------
 arch/mips/ar7/clock.c                               | 15 +--------------
 arch/mips/ar7/gpio.c                                | 15 +--------------
 arch/mips/ar7/irq.c                                 | 15 +--------------
 arch/mips/ar7/memory.c                              | 15 +--------------
 arch/mips/ar7/platform.c                            | 15 +--------------
 arch/mips/cavium-octeon/crypto/octeon-sha512.c      |  6 +-----
 arch/mips/include/asm/mach-ar7/ar7.h                | 15 +--------------
 arch/mips/include/asm/mach-ar7/prom.h               | 15 +--------------
 arch/mips/include/asm/mach-pmcs-msp71xx/msp_pci.h   | 18 +-----------------
 arch/mips/include/asm/mach-pmcs-msp71xx/msp_usb.h   | 18 +-----------------
 arch/mips/include/asm/mach-pnx833x/gpio.h           | 15 +--------------
 arch/mips/include/asm/mach-pnx833x/irq-mapping.h    | 15 +--------------
 arch/mips/include/asm/mach-pnx833x/irq.h            | 15 +--------------
 arch/mips/include/asm/mach-pnx833x/pnx833x.h        | 15 +--------------
 arch/mips/lasat/serial.c                            | 15 +--------------
 arch/mips/pnx833x/common/interrupts.c               | 15 +--------------
 arch/mips/pnx833x/common/platform.c                 | 15 +--------------
 arch/mips/pnx833x/common/prom.c                     | 15 +--------------
 arch/mips/pnx833x/common/reset.c                    | 15 +--------------
 arch/mips/pnx833x/common/setup.c                    | 15 +--------------
 arch/mips/pnx833x/stb22x/board.c                    | 15 +--------------
 arch/powerpc/boot/cuboot-mpc7448hpc2.c              |  7 +------
 arch/powerpc/include/asm/async_tx.h                 | 18 +-----------------
 arch/powerpc/include/asm/fsl_85xx_cache_sram.h      | 15 +--------------
 arch/powerpc/include/asm/hmi.h                      | 14 +-------------
 arch/powerpc/include/asm/imc-pmu.h                  |  6 +-----
 arch/powerpc/include/asm/mpc5xxx.h                  |  7 +------
 arch/powerpc/include/asm/mpc85xx.h                  |  6 +-----
 arch/powerpc/include/asm/ppc4xx.h                   |  7 +------
 arch/powerpc/kernel/l2cr_6xx.S                      | 14 +-------------
 arch/powerpc/kvm/book3s.h                           |  7 +------
 arch/powerpc/kvm/book3s_hv_hmi.c                    | 14 +-------------
 arch/powerpc/perf/imc-pmu.c                         |  6 +-----
 arch/powerpc/perf/power9-pmu.c                      |  6 +-----
 arch/powerpc/platforms/512x/clock-commonclk.c       |  6 +-----
 arch/powerpc/platforms/512x/mpc5121_ads.c           |  7 +------
 arch/powerpc/platforms/512x/mpc5121_ads_cpld.c      |  6 +-----
 arch/powerpc/platforms/512x/mpc512x_generic.c       |  7 +------
 arch/powerpc/platforms/512x/mpc512x_shared.c        |  6 +-----
 arch/powerpc/platforms/512x/pdm360ng.c              |  7 +------
 arch/powerpc/platforms/cell/cell.h                  | 11 +----------
 arch/powerpc/platforms/powernv/opal-imc.c           |  6 +-----
 arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h           | 15 +--------------
 arch/powerpc/sysdev/fsl_85xx_cache_sram.c           | 15 +--------------
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c               | 15 +--------------
 arch/powerpc/xmon/ppc-dis.c                         | 15 ++-------------
 arch/powerpc/xmon/ppc-opc.c                         | 16 ++--------------
 arch/riscv/include/asm/atomic.h                     |  6 +-----
 arch/riscv/kernel/process.c                         | 15 +--------------
 arch/riscv/kernel/setup.c                           | 15 +--------------
 arch/riscv/kernel/signal.c                          | 15 +--------------
 arch/riscv/mm/extable.c                             | 15 +--------------
 arch/riscv/mm/fault.c                               | 15 +--------------
 arch/sparc/boot/piggyback.c                         | 15 ++-------------
 arch/sparc/include/asm/xor_32.h                     | 10 +---------
 arch/sparc/include/asm/xor_64.h                     | 10 +---------
 arch/x86/boot/bioscall.S                            |  5 +----
 arch/x86/boot/mkcpustr.c                            |  5 +----
 arch/x86/boot/regs.c                                |  5 +----
 arch/x86/boot/vesa.h                                |  7 +------
 arch/x86/include/asm/ist.h                          | 11 +----------
 arch/x86/include/asm/xor.h                          | 10 +---------
 arch/x86/include/asm/xor_32.h                       | 10 +---------
 arch/x86/kernel/apm_32.c                            | 11 +----------
 arch/x86/kernel/kgdb.c                              | 11 +----------
 arch/x86/kernel/paravirt.c                          | 14 +-------------
 arch/x86/kernel/pvclock.c                           | 14 +-------------
 arch/x86/kernel/smp.c                               |  4 +---
 arch/x86/kernel/smpboot.c                           |  4 +---
 arch/x86/platform/iris/iris.c                       | 15 +--------------
 arch/x86/platform/uv/tlb_uv.c                       |  4 +---
 certs/blacklist.c                                   |  6 +-----
 certs/system_keyring.c                              |  6 +-----
 crypto/ansi_cprng.c                                 |  8 +-------
 crypto/asymmetric_keys/asymmetric_keys.h            |  6 +-----
 crypto/asymmetric_keys/asymmetric_type.c            |  6 +-----
 crypto/asymmetric_keys/mscode_parser.c              |  6 +-----
 crypto/asymmetric_keys/pkcs7_key_type.c             |  6 +-----
 crypto/asymmetric_keys/pkcs7_parser.c               |  6 +-----
 crypto/asymmetric_keys/pkcs7_parser.h               |  6 +-----
 crypto/asymmetric_keys/pkcs7_trust.c                |  6 +-----
 crypto/asymmetric_keys/pkcs7_verify.c               |  6 +-----
 crypto/asymmetric_keys/pkcs8_parser.c               |  6 +-----
 crypto/asymmetric_keys/public_key.c                 |  6 +-----
 crypto/asymmetric_keys/restrict.c                   |  6 +-----
 crypto/asymmetric_keys/signature.c                  |  6 +-----
 crypto/asymmetric_keys/verify_pefile.c              |  6 +-----
 crypto/asymmetric_keys/verify_pefile.h              |  6 +-----
 crypto/asymmetric_keys/x509_cert_parser.c           |  6 +-----
 crypto/asymmetric_keys/x509_parser.h                |  6 +-----
 crypto/asymmetric_keys/x509_public_key.c            |  6 +-----
 crypto/async_tx/async_pq.c                          | 18 +-----------------
 crypto/async_tx/async_raid6_recov.c                 | 16 +---------------
 crypto/cast_common.c                                |  7 +------
 crypto/rsa.c                                        |  6 +-----
 crypto/sha512_generic.c                             |  7 +------
 crypto/xor.c                                        | 10 +---------
 drivers/accessibility/braille/braille_console.c     | 15 +--------------
 drivers/ata/ahci_brcm.c                             | 11 +----------
 drivers/ata/ahci_da850.c                            |  6 +-----
 drivers/ata/ahci_dm816.c                            |  6 +-----
 drivers/ata/ahci_platform.c                         |  6 +-----
 drivers/ata/ahci_qoriq.c                            |  6 +-----
 drivers/ata/libahci_platform.c                      |  6 +-----
 drivers/ata/pata_cs5520.c                           | 11 +----------
 drivers/ata/sata_qstor.c                            | 18 +-----------------
 drivers/ata/sata_sil24.c                            | 12 +-----------
 drivers/atm/ambassador.c                            | 17 +----------------
 drivers/atm/ambassador.h                            | 17 +----------------
 drivers/atm/firestream.c                            | 17 +----------------
 drivers/atm/firestream.h                            | 17 +----------------
 drivers/atm/horizon.c                               | 17 +----------------
 drivers/atm/horizon.h                               | 17 +----------------
 drivers/block/cryptoloop.c                          | 14 +-------------
 drivers/block/drbd/drbd_actlog.c                    | 14 +-------------
 drivers/block/drbd/drbd_bitmap.c                    | 14 +-------------
 drivers/block/drbd/drbd_int.h                       | 14 +-------------
 drivers/block/drbd/drbd_main.c                      | 14 +-------------
 drivers/block/drbd/drbd_nl.c                        | 14 +-------------
 drivers/block/drbd/drbd_proc.c                      | 14 +-------------
 drivers/block/drbd/drbd_receiver.c                  | 14 +-------------
 drivers/block/drbd/drbd_req.c                       | 14 +-------------
 drivers/block/drbd/drbd_req.h                       | 14 +-------------
 drivers/block/drbd/drbd_state.c                     | 14 +-------------
 drivers/block/drbd/drbd_strings.c                   | 14 +-------------
 drivers/block/drbd/drbd_vli.h                       | 14 +-------------
 drivers/block/drbd/drbd_worker.c                    | 14 +-------------
 drivers/char/hw_random/stm32-rng.c                  | 11 +----------
 drivers/char/hw_random/virtio-rng.c                 | 15 +--------------
 drivers/char/sonypi.c                               | 16 +---------------
 drivers/cpufreq/powernv-cpufreq.c                   | 12 +-----------
 drivers/dca/dca-core.c                              | 18 +-----------------
 drivers/dca/dca-sysfs.c                             | 18 +-----------------
 drivers/dma/fsldma.c                                |  7 +------
 drivers/dma/fsldma.h                                |  7 +------
 drivers/fmc/fmc-chardev.c                           |  3 +--
 drivers/fmc/fmc-core.c                              |  3 +--
 drivers/fmc/fmc-debug.c                             |  3 +--
 drivers/fmc/fmc-dump.c                              |  3 +--
 drivers/fmc/fmc-match.c                             |  3 +--
 drivers/fmc/fmc-private.h                           |  3 +--
 drivers/fmc/fmc-sdb.c                               |  3 +--
 drivers/fmc/fmc-write-eeprom.c                      |  3 +--
 drivers/fmc/fru-parse.c                             |  3 +--
 drivers/gpio/gpio-bt8xx.c                           | 14 +-------------
 drivers/gpio/gpio-pcf857x.c                         | 15 +--------------
 drivers/gpio/gpio-rdc321x.c                         | 16 +---------------
 drivers/gpio/gpio-tps65218.c                        |  6 +-----
 drivers/gpu/drm/bridge/sii9234.c                    | 15 +--------------
 drivers/gpu/drm/drm_edid_load.c                     | 14 +-------------
 drivers/hwmon/abituguru.c                           | 15 +--------------
 drivers/hwmon/abituguru3.c                          | 15 +--------------
 drivers/hwmon/adcxx.c                               | 15 +--------------
 drivers/hwmon/adm1021.c                             | 15 +--------------
 drivers/hwmon/adm1025.c                             | 15 +--------------
 drivers/hwmon/adm1026.c                             | 15 +--------------
 drivers/hwmon/adm1031.c                             | 15 +--------------
 drivers/hwmon/adm9240.c                             | 15 +--------------
 drivers/hwmon/ads1015.c                             | 15 +--------------
 drivers/hwmon/ads7828.c                             | 15 +--------------
 drivers/hwmon/ads7871.c                             | 10 +---------
 drivers/hwmon/adt7x10.c                             | 15 +--------------
 drivers/hwmon/amc6821.c                             | 15 +--------------
 drivers/hwmon/asb100.c                              | 15 +--------------
 drivers/hwmon/asc7621.c                             | 15 +--------------
 drivers/hwmon/dell-smm-hwmon.c                      | 11 +----------
 drivers/hwmon/dme1737.c                             | 15 +--------------
 drivers/hwmon/ds1621.c                              | 15 +--------------
 drivers/hwmon/ds620.c                               | 15 +--------------
 drivers/hwmon/emc2103.c                             | 15 +--------------
 drivers/hwmon/emc6w201.c                            | 15 +--------------
 drivers/hwmon/f71805f.c                             | 15 +--------------
 drivers/hwmon/f75375s.c                             | 16 +---------------
 drivers/hwmon/fam15h_power.c                        | 14 +-------------
 drivers/hwmon/fschmd.c                              | 15 +--------------
 drivers/hwmon/gl518sm.c                             | 15 +--------------
 drivers/hwmon/gl520sm.c                             | 16 +---------------
 drivers/hwmon/hih6130.c                             | 15 +--------------
 drivers/hwmon/hwmon-vid.c                           | 15 +--------------
 drivers/hwmon/ibmpowernv.c                          | 14 +-------------
 drivers/hwmon/jc42.c                                | 15 +--------------
 drivers/hwmon/k10temp.c                             | 14 +-------------
 drivers/hwmon/lineage-pem.c                         | 15 +--------------
 drivers/hwmon/lm63.c                                | 15 +--------------
 drivers/hwmon/lm70.c                                | 15 +--------------
 drivers/hwmon/lm75.c                                | 15 +--------------
 drivers/hwmon/lm75.h                                | 14 +-------------
 drivers/hwmon/lm78.c                                | 15 +--------------
 drivers/hwmon/lm80.c                                | 15 +--------------
 drivers/hwmon/lm85.c                                | 15 +--------------
 drivers/hwmon/lm87.c                                | 15 +--------------
 drivers/hwmon/lm90.c                                | 15 +--------------
 drivers/hwmon/lm93.c                                | 15 +--------------
 drivers/hwmon/ltc4151.c                             | 16 +---------------
 drivers/hwmon/ltc4261.c                             | 15 +--------------
 drivers/hwmon/max1668.c                             | 15 +--------------
 drivers/hwmon/max6639.c                             | 15 +--------------
 drivers/hwmon/max6642.c                             | 15 +--------------
 drivers/hwmon/max6650.c                             | 15 +--------------
 drivers/hwmon/nct6775.c                             | 16 +---------------
 drivers/hwmon/pc87360.c                             | 15 +--------------
 drivers/hwmon/pcf8591.c                             | 15 +--------------
 drivers/hwmon/pmbus/lm25066.c                       | 15 +--------------
 drivers/hwmon/pmbus/max16064.c                      | 15 +--------------
 drivers/hwmon/pmbus/max34440.c                      | 15 +--------------
 drivers/hwmon/pmbus/max8688.c                       | 15 +--------------
 drivers/hwmon/pmbus/pmbus.c                         | 15 +--------------
 drivers/hwmon/pmbus/pmbus.h                         | 15 +--------------
 drivers/hwmon/pmbus/pmbus_core.c                    | 15 +--------------
 drivers/hwmon/pmbus/ucd9000.c                       | 15 +--------------
 drivers/hwmon/pmbus/ucd9200.c                       | 15 +--------------
 drivers/hwmon/pmbus/zl6100.c                        | 15 +--------------
 drivers/hwmon/sht21.c                               | 15 +--------------
 drivers/hwmon/sis5595.c                             | 15 +--------------
 drivers/hwmon/smsc47b397.c                          | 15 +--------------
 drivers/hwmon/smsc47m1.c                            | 15 +--------------
 drivers/hwmon/smsc47m192.c                          | 15 +--------------
 drivers/hwmon/thmc50.c                              | 15 +--------------
 drivers/hwmon/tmp401.c                              | 15 +--------------
 drivers/hwmon/via686a.c                             | 15 +--------------
 drivers/hwmon/vt1211.c                              | 15 +--------------
 drivers/hwmon/vt8231.c                              | 15 +--------------
 drivers/hwmon/w83627ehf.c                           | 15 +--------------
 drivers/hwmon/w83627hf.c                            | 15 +--------------
 drivers/hwmon/w83781d.c                             | 15 +--------------
 drivers/hwmon/w83791d.c                             | 15 +--------------
 drivers/hwmon/w83792d.c                             | 15 +--------------
 drivers/hwmon/w83l785ts.c                           | 15 +--------------
 drivers/i2c/busses/i2c-opal.c                       | 14 +-------------
 drivers/i2c/busses/i2c-wmt.c                        |  6 +-----
 drivers/ide/ide-pnp.c                               | 10 +---------
 drivers/ide/palm_bk3710.c                           | 15 +--------------
 drivers/iio/adc/at91_adc.c                          |  3 +--
 drivers/iio/adc/exynos_adc.c                        | 15 +--------------
 drivers/iio/adc/nau7802.c                           |  3 +--
 drivers/iio/adc/vf610_adc.c                         | 15 +--------------
 drivers/iio/dac/max517.c                            | 15 +--------------
 drivers/input/gameport/fm801-gp.c                   | 17 +----------------
 drivers/input/joystick/stinger.c                    | 14 +-------------
 drivers/input/joystick/warrior.c                    | 14 +-------------
 drivers/input/keyboard/maple_keyb.c                 | 16 +---------------
 drivers/input/keyboard/qt1070.c                     | 15 +--------------
 drivers/input/keyboard/qt2160.c                     | 15 +--------------
 drivers/input/misc/bma150.c                         | 15 +--------------
 drivers/input/misc/mma8450.c                        | 15 +--------------
 drivers/input/mouse/appletouch.c                    | 16 +---------------
 drivers/input/mouse/bcm5974.c                       | 16 +---------------
 drivers/input/mouse/sentelic.c                      | 15 +--------------
 drivers/input/mouse/sentelic.h                      | 15 +--------------
 drivers/input/mouse/touchkit_ps2.c                  | 15 +--------------
 drivers/input/tablet/wacom_serial4.c                |  7 +------
 drivers/input/touchscreen/ad7877.c                  | 16 +---------------
 drivers/input/touchscreen/s3c2410_ts.c              | 15 +--------------
 drivers/input/touchscreen/usbtouchscreen.c          | 15 +--------------
 drivers/input/touchscreen/wacom_i2c.c               |  7 +------
 drivers/isdn/i4l/isdnhdlc.c                         | 15 +--------------
 drivers/isdn/mISDN/dsp_biquad.h                     | 16 +---------------
 drivers/isdn/mISDN/dsp_ecdis.h                      | 16 +---------------
 drivers/isdn/mISDN/dsp_hwec.c                       | 19 +------------------
 drivers/isdn/mISDN/dsp_pipeline.c                   | 19 +------------------
 drivers/leds/leds-blinkm.c                          | 15 +--------------
 drivers/leds/leds-cpcap.c                           | 10 +---------
 drivers/macintosh/apm_emu.c                         | 13 +------------
 drivers/md/md-cluster.c                             |  7 +------
 drivers/md/md-faulty.c                              | 11 +----------
 drivers/md/md-linear.c                              |  9 +--------
 drivers/md/md-multipath.c                           | 10 +---------
 drivers/md/md.c                                     |  9 +--------
 drivers/md/md.h                                     |  9 +--------
 drivers/md/raid0.c                                  |  9 +--------
 drivers/md/raid1.c                                  | 10 +---------
 drivers/md/raid10.c                                 | 11 +----------
 drivers/md/raid5.c                                  | 10 +---------
 drivers/media/common/saa7146/saa7146_core.c         | 14 +-------------
 drivers/media/dvb-core/dvb_ca_en50221.c             | 13 +------------
 drivers/media/dvb-core/dvb_frontend.c               | 14 +-------------
 drivers/media/dvb-core/dvb_net.c                    | 13 +------------
 drivers/media/dvb-frontends/as102_fe.c              | 11 +----------
 drivers/media/dvb-frontends/as102_fe.h              | 11 +----------
 drivers/media/dvb-frontends/as102_fe_types.h        | 11 +----------
 drivers/media/dvb-frontends/au8522.h                | 14 +-------------
 drivers/media/dvb-frontends/au8522_common.c         | 14 +-------------
 drivers/media/dvb-frontends/au8522_dig.c            | 14 +-------------
 drivers/media/dvb-frontends/au8522_priv.h           | 14 +-------------
 drivers/media/dvb-frontends/bsbe1-d01a.h            | 16 +---------------
 drivers/media/dvb-frontends/bsbe1.h                 | 16 +---------------
 drivers/media/dvb-frontends/bsru6.h                 | 16 +---------------
 drivers/media/dvb-frontends/cx22700.c               | 14 +-------------
 drivers/media/dvb-frontends/cx22700.h               | 14 +-------------
 drivers/media/dvb-frontends/cx22702.c               | 14 +-------------
 drivers/media/dvb-frontends/cx22702.h               | 14 +-------------
 drivers/media/dvb-frontends/cx24110.c               | 15 +--------------
 drivers/media/dvb-frontends/cx24110.h               | 15 +--------------
 drivers/media/dvb-frontends/cx24116.c               | 14 +-------------
 drivers/media/dvb-frontends/cx24116.h               | 14 +-------------
 drivers/media/dvb-frontends/cx24117.c               | 14 +-------------
 drivers/media/dvb-frontends/cx24117.h               | 14 +-------------
 drivers/media/dvb-frontends/cx24123.h               | 14 +-------------
 drivers/media/dvb-frontends/ds3000.c                | 14 +-------------
 drivers/media/dvb-frontends/ds3000.h                | 14 +-------------
 drivers/media/dvb-frontends/gp8psk-fe.h             | 11 +----------
 drivers/media/dvb-frontends/isl6405.c               | 16 +---------------
 drivers/media/dvb-frontends/isl6405.h               | 16 +---------------
 drivers/media/dvb-frontends/isl6421.c               | 16 +---------------
 drivers/media/dvb-frontends/isl6421.h               | 16 +---------------
 drivers/media/dvb-frontends/isl6423.c               | 14 +-------------
 drivers/media/dvb-frontends/isl6423.h               | 14 +-------------
 drivers/media/dvb-frontends/l64781.c                | 14 +-------------
 drivers/media/dvb-frontends/l64781.h                | 14 +-------------
 drivers/media/dvb-frontends/lgs8gl5.c               | 14 +-------------
 drivers/media/dvb-frontends/lgs8gl5.h               | 14 +-------------
 drivers/media/dvb-frontends/lnbp21.c                | 16 +---------------
 drivers/media/dvb-frontends/lnbp21.h                | 16 +---------------
 drivers/media/dvb-frontends/lnbp22.c                | 16 +---------------
 drivers/media/dvb-frontends/lnbp22.h                | 16 +---------------
 drivers/media/dvb-frontends/m88rs2000.c             | 14 +-------------
 drivers/media/dvb-frontends/m88rs2000.h             | 14 +-------------
 drivers/media/dvb-frontends/mb86a16.c               | 14 +-------------
 drivers/media/dvb-frontends/mb86a16.h               | 14 +-------------
 drivers/media/dvb-frontends/mb86a16_priv.h          | 14 +-------------
 drivers/media/dvb-frontends/mt312.c                 | 15 +--------------
 drivers/media/dvb-frontends/mt312.h                 | 15 +--------------
 drivers/media/dvb-frontends/mt312_priv.h            | 15 +--------------
 drivers/media/dvb-frontends/nxt6000.c               | 14 +-------------
 drivers/media/dvb-frontends/nxt6000.h               | 14 +-------------
 drivers/media/dvb-frontends/s5h1409.c               | 14 +-------------
 drivers/media/dvb-frontends/s5h1409.h               | 14 +-------------
 drivers/media/dvb-frontends/s5h1411.c               | 14 +-------------
 drivers/media/dvb-frontends/s5h1411.h               | 14 +-------------
 drivers/media/dvb-frontends/s5h1420_priv.h          | 16 +---------------
 drivers/media/dvb-frontends/sp8870.c                | 15 +--------------
 drivers/media/dvb-frontends/sp8870.h                | 15 +--------------
 drivers/media/dvb-frontends/stb0899_algo.c          | 14 +-------------
 drivers/media/dvb-frontends/stb0899_cfg.h           | 14 +-------------
 drivers/media/dvb-frontends/stb0899_drv.c           | 14 +-------------
 drivers/media/dvb-frontends/stb0899_drv.h           | 14 +-------------
 drivers/media/dvb-frontends/stb0899_priv.h          | 14 +-------------
 drivers/media/dvb-frontends/stb0899_reg.h           | 14 +-------------
 drivers/media/dvb-frontends/stb6000.c               | 15 +--------------
 drivers/media/dvb-frontends/stb6000.h               | 15 +--------------
 drivers/media/dvb-frontends/stb6100.c               | 14 +-------------
 drivers/media/dvb-frontends/stb6100.h               | 14 +-------------
 drivers/media/dvb-frontends/stb6100_cfg.h           | 14 +-------------
 drivers/media/dvb-frontends/stb6100_proc.h          | 14 +-------------
 drivers/media/dvb-frontends/stv0288.c               | 14 +-------------
 drivers/media/dvb-frontends/stv0288.h               | 14 +-------------
 drivers/media/dvb-frontends/stv0297.c               | 14 +-------------
 drivers/media/dvb-frontends/stv0297.h               | 14 +-------------
 drivers/media/dvb-frontends/stv0299.c               | 14 +-------------
 drivers/media/dvb-frontends/stv0299.h               | 14 +-------------
 drivers/media/dvb-frontends/stv090x.c               | 14 +-------------
 drivers/media/dvb-frontends/stv090x.h               | 14 +-------------
 drivers/media/dvb-frontends/stv090x_priv.h          | 14 +-------------
 drivers/media/dvb-frontends/stv090x_reg.h           | 14 +-------------
 drivers/media/dvb-frontends/stv6110x.c              | 14 +-------------
 drivers/media/dvb-frontends/stv6110x.h              | 14 +-------------
 drivers/media/dvb-frontends/stv6110x_priv.h         | 14 +-------------
 drivers/media/dvb-frontends/stv6110x_reg.h          | 14 +-------------
 drivers/media/dvb-frontends/tda10021.c              | 14 +-------------
 drivers/media/dvb-frontends/tda10023.c              | 14 +-------------
 drivers/media/dvb-frontends/tda1002x.h              | 14 +-------------
 drivers/media/dvb-frontends/tda10048.c              | 14 +-------------
 drivers/media/dvb-frontends/tda10048.h              | 14 +-------------
 drivers/media/dvb-frontends/tda1004x.c              | 15 +--------------
 drivers/media/dvb-frontends/tda1004x.h              | 15 +--------------
 drivers/media/dvb-frontends/tda10086.c              | 15 +--------------
 drivers/media/dvb-frontends/tda10086.h              | 15 +--------------
 drivers/media/dvb-frontends/tda665x.c               | 14 +-------------
 drivers/media/dvb-frontends/tda665x.h               | 14 +-------------
 drivers/media/dvb-frontends/tda8083.c               | 14 +-------------
 drivers/media/dvb-frontends/tda8083.h               | 14 +-------------
 drivers/media/dvb-frontends/tda8261.c               | 14 +-------------
 drivers/media/dvb-frontends/tda8261.h               | 14 +-------------
 drivers/media/dvb-frontends/tda8261_cfg.h           | 14 +-------------
 drivers/media/dvb-frontends/tda826x.c               | 15 +--------------
 drivers/media/dvb-frontends/tda826x.h               | 15 +--------------
 drivers/media/dvb-frontends/tdhd1.h                 | 15 +--------------
 drivers/media/dvb-frontends/ts2020.c                | 14 +-------------
 drivers/media/dvb-frontends/ts2020.h                | 14 +-------------
 drivers/media/dvb-frontends/ves1820.c               | 14 +-------------
 drivers/media/dvb-frontends/ves1820.h               | 14 +-------------
 drivers/media/dvb-frontends/ves1x93.c               | 15 +--------------
 drivers/media/dvb-frontends/ves1x93.h               | 15 +--------------
 drivers/media/dvb-frontends/zl10039.h               | 15 +--------------
 drivers/media/i2c/bt866.c                           | 14 +-------------
 drivers/media/i2c/saa6588.c                         | 14 +-------------
 drivers/media/i2c/saa6752hs.c                       | 14 +-------------
 drivers/media/i2c/tda9840.c                         | 14 +-------------
 drivers/media/i2c/tea6415c.c                        | 14 +-------------
 drivers/media/i2c/tea6420.c                         | 14 +-------------
 drivers/media/pci/bt8xx/bt848.h                     | 14 +-------------
 drivers/media/pci/bt8xx/bt878.c                     | 19 +------------------
 drivers/media/pci/bt8xx/bt878.h                     | 14 +-------------
 drivers/media/pci/bt8xx/btcx-risc.c                 | 14 +-------------
 drivers/media/pci/bt8xx/bttv-cards.c                | 14 +-------------
 drivers/media/pci/bt8xx/bttv-driver.c               | 14 +-------------
 drivers/media/pci/bt8xx/bttv-gpio.c                 | 14 +-------------
 drivers/media/pci/bt8xx/bttv-i2c.c                  | 14 +-------------
 drivers/media/pci/bt8xx/bttv-if.c                   | 14 +-------------
 drivers/media/pci/bt8xx/bttv-risc.c                 | 14 +-------------
 drivers/media/pci/bt8xx/bttv-vbi.c                  | 14 +-------------
 drivers/media/pci/bt8xx/bttvp.h                     | 14 +-------------
 drivers/media/pci/bt8xx/dst.c                       | 14 +-------------
 drivers/media/pci/bt8xx/dst_ca.c                    | 14 +-------------
 drivers/media/pci/bt8xx/dst_ca.h                    | 14 +-------------
 drivers/media/pci/bt8xx/dst_common.h                | 14 +-------------
 drivers/media/pci/mantis/hopper_cards.c             | 14 +-------------
 drivers/media/pci/mantis/hopper_vp3028.c            | 14 +-------------
 drivers/media/pci/mantis/hopper_vp3028.h            | 14 +-------------
 drivers/media/pci/mantis/mantis_ca.c                | 14 +-------------
 drivers/media/pci/mantis/mantis_ca.h                | 14 +-------------
 drivers/media/pci/mantis/mantis_cards.c             | 14 +-------------
 drivers/media/pci/mantis/mantis_common.h            | 14 +-------------
 drivers/media/pci/mantis/mantis_core.c              | 14 +-------------
 drivers/media/pci/mantis/mantis_core.h              | 14 +-------------
 drivers/media/pci/mantis/mantis_dma.c               | 14 +-------------
 drivers/media/pci/mantis/mantis_dma.h               | 14 +-------------
 drivers/media/pci/mantis/mantis_dvb.c               | 14 +-------------
 drivers/media/pci/mantis/mantis_dvb.h               | 14 +-------------
 drivers/media/pci/mantis/mantis_evm.c               | 14 +-------------
 drivers/media/pci/mantis/mantis_hif.c               | 14 +-------------
 drivers/media/pci/mantis/mantis_hif.h               | 14 +-------------
 drivers/media/pci/mantis/mantis_i2c.c               | 14 +-------------
 drivers/media/pci/mantis/mantis_i2c.h               | 14 +-------------
 drivers/media/pci/mantis/mantis_ioc.c               | 14 +-------------
 drivers/media/pci/mantis/mantis_ioc.h               | 14 +-------------
 drivers/media/pci/mantis/mantis_link.h              | 14 +-------------
 drivers/media/pci/mantis/mantis_pci.c               | 14 +-------------
 drivers/media/pci/mantis/mantis_pci.h               | 14 +-------------
 drivers/media/pci/mantis/mantis_pcmcia.c            | 14 +-------------
 drivers/media/pci/mantis/mantis_reg.h               | 14 +-------------
 drivers/media/pci/mantis/mantis_uart.c              | 14 +-------------
 drivers/media/pci/mantis/mantis_uart.h              | 14 +-------------
 drivers/media/pci/mantis/mantis_vp1033.c            | 14 +-------------
 drivers/media/pci/mantis/mantis_vp1033.h            | 14 +-------------
 drivers/media/pci/mantis/mantis_vp1034.c            | 14 +-------------
 drivers/media/pci/mantis/mantis_vp1034.h            | 14 +-------------
 drivers/media/pci/mantis/mantis_vp1041.c            | 14 +-------------
 drivers/media/pci/mantis/mantis_vp1041.h            | 14 +-------------
 drivers/media/pci/mantis/mantis_vp2033.c            | 14 +-------------
 drivers/media/pci/mantis/mantis_vp2033.h            | 14 +-------------
 drivers/media/pci/mantis/mantis_vp2040.c            | 14 +-------------
 drivers/media/pci/mantis/mantis_vp2040.h            | 14 +-------------
 drivers/media/pci/mantis/mantis_vp3030.c            | 14 +-------------
 drivers/media/pci/mantis/mantis_vp3030.h            | 14 +-------------
 drivers/media/pci/saa7146/hexium_gemini.c           | 14 +-------------
 drivers/media/pci/saa7146/hexium_orion.c            | 14 +-------------
 drivers/media/pci/saa7146/mxb.c                     | 14 +-------------
 drivers/media/pci/ttpci/av7110.c                    | 16 +---------------
 drivers/media/pci/ttpci/av7110_av.c                 | 16 +---------------
 drivers/media/pci/ttpci/av7110_ca.c                 | 16 +---------------
 drivers/media/pci/ttpci/av7110_hw.c                 | 13 +------------
 drivers/media/pci/ttpci/av7110_ir.c                 | 14 +-------------
 drivers/media/pci/ttpci/av7110_v4l.c                | 13 +------------
 drivers/media/pci/ttpci/budget-av.c                 | 16 +---------------
 drivers/media/pci/ttpci/budget-ci.c                 | 16 +---------------
 drivers/media/pci/ttpci/budget-core.c               | 16 +---------------
 drivers/media/pci/ttpci/budget-patch.c              | 16 +---------------
 drivers/media/pci/ttpci/budget.c                    | 16 +---------------
 drivers/media/pci/ttpci/ttpci-eeprom.c              | 14 +-------------
 drivers/media/pci/ttpci/ttpci-eeprom.h              | 14 +-------------
 drivers/media/rc/gpio-ir-tx.c                       | 10 +---------
 drivers/media/rc/pwm-ir-tx.c                        | 10 +---------
 drivers/media/tuners/mt20xx.h                       | 14 +-------------
 drivers/media/tuners/mxl5005s.h                     | 14 +-------------
 drivers/media/tuners/tda18271-common.c              | 14 +-------------
 drivers/media/tuners/tda18271-fe.c                  | 14 +-------------
 drivers/media/tuners/tda18271-maps.c                | 14 +-------------
 drivers/media/tuners/tda18271-priv.h                | 14 +-------------
 drivers/media/tuners/tda18271.h                     | 14 +-------------
 drivers/media/tuners/tda827x.h                      | 15 +--------------
 drivers/media/tuners/tda8290.c                      | 14 +-------------
 drivers/media/tuners/tda8290.h                      | 14 +-------------
 drivers/media/tuners/tda9887.h                      | 14 +-------------
 drivers/media/tuners/tea5761.h                      | 14 +-------------
 drivers/media/tuners/tea5767.h                      | 14 +-------------
 drivers/media/tuners/tuner-i2c.h                    | 14 +-------------
 drivers/media/tuners/tuner-simple.h                 | 14 +-------------
 drivers/media/usb/as102/as102_drv.c                 | 11 +----------
 drivers/media/usb/as102/as102_drv.h                 | 11 +----------
 drivers/media/usb/as102/as102_fw.c                  | 11 +----------
 drivers/media/usb/as102/as102_fw.h                  | 11 +----------
 drivers/media/usb/as102/as102_usb_drv.c             | 11 +----------
 drivers/media/usb/as102/as102_usb_drv.h             | 11 +----------
 drivers/media/usb/as102/as10x_cmd.c                 | 11 +----------
 drivers/media/usb/as102/as10x_cmd.h                 | 11 +----------
 drivers/media/usb/as102/as10x_cmd_cfg.c             | 11 +----------
 drivers/media/usb/as102/as10x_cmd_stream.c          | 11 +----------
 drivers/media/usb/as102/as10x_handle.h              | 11 +----------
 drivers/media/usb/cx231xx/cx231xx-avcore.c          | 14 +-------------
 drivers/media/usb/cx231xx/cx231xx-cards.c           | 14 +-------------
 drivers/media/usb/cx231xx/cx231xx-conf-reg.h        | 14 +-------------
 drivers/media/usb/cx231xx/cx231xx-core.c            | 14 +-------------
 drivers/media/usb/cx231xx/cx231xx-dvb.c             | 14 +-------------
 drivers/media/usb/cx231xx/cx231xx-i2c.c             | 14 +-------------
 drivers/media/usb/cx231xx/cx231xx-pcb-cfg.c         | 14 +-------------
 drivers/media/usb/cx231xx/cx231xx-pcb-cfg.h         | 14 +-------------
 drivers/media/usb/cx231xx/cx231xx-reg.h             | 14 +-------------
 drivers/media/usb/cx231xx/cx231xx-vbi.c             | 14 +-------------
 drivers/media/usb/cx231xx/cx231xx-vbi.h             | 14 +-------------
 drivers/media/usb/cx231xx/cx231xx-video.c           | 14 +-------------
 drivers/media/usb/cx231xx/cx231xx.h                 | 14 +-------------
 drivers/media/usb/gspca/gl860/gl860-mi1320.c        | 14 +-------------
 drivers/media/usb/gspca/gl860/gl860-mi2020.c        | 14 +-------------
 drivers/media/usb/gspca/gl860/gl860-ov2640.c        | 14 +-------------
 drivers/media/usb/gspca/gl860/gl860-ov9655.c        | 14 +-------------
 drivers/media/usb/gspca/gl860/gl860.c               | 14 +-------------
 drivers/media/usb/gspca/gl860/gl860.h               | 14 +-------------
 drivers/media/usb/pulse8-cec/pulse8-cec.c           |  7 +------
 drivers/media/usb/rainshadow-cec/rainshadow-cec.c   |  7 +------
 drivers/media/v4l2-core/v4l2-common.c               | 12 +-----------
 drivers/memory/fsl_ifc.c                            | 15 +--------------
 drivers/mfd/htc-i2cpld.c                            | 15 +--------------
 drivers/mfd/rdc321x-southbridge.c                   | 16 +---------------
 drivers/mfd/tps65010.c                              | 15 +--------------
 drivers/misc/altera-stapl/altera-comp.c             | 16 +---------------
 drivers/misc/altera-stapl/altera-exprt.h            | 16 +---------------
 drivers/misc/altera-stapl/altera-jtag.c             | 16 +---------------
 drivers/misc/altera-stapl/altera-jtag.h             | 16 +---------------
 drivers/misc/altera-stapl/altera-lpt.c              | 16 +---------------
 drivers/misc/altera-stapl/altera.c                  | 16 +---------------
 drivers/misc/genwqe/card_ddcb.h                     | 11 +----------
 drivers/misc/isl29003.c                             | 15 +--------------
 drivers/misc/tsl2550.c                              | 15 +--------------
 drivers/mmc/host/davinci_mmc.c                      | 15 +--------------
 drivers/mmc/host/sdricoh_cs.c                       | 16 +---------------
 drivers/mtd/ar7part.c                               | 16 +---------------
 drivers/mtd/bcm63xxpart.c                           | 16 +---------------
 drivers/mtd/cmdlinepart.c                           | 15 +--------------
 drivers/mtd/mtd_blkdevs.c                           | 16 +---------------
 drivers/mtd/mtdblock.c                              | 16 +---------------
 drivers/mtd/mtdblock_ro.c                           | 16 +---------------
 drivers/mtd/mtdchar.c                               | 16 +---------------
 drivers/mtd/mtdconcat.c                             | 16 +---------------
 drivers/mtd/mtdcore.c                               | 16 +---------------
 drivers/mtd/mtdpart.c                               | 16 +---------------
 drivers/mtd/nand/raw/davinci_nand.c                 | 15 +--------------
 drivers/mtd/nand/raw/nand_bch.c                     | 15 +--------------
 drivers/mtd/nand/raw/nand_ecc.c                     | 16 +---------------
 drivers/mtd/parsers/redboot.c                       | 16 +---------------
 drivers/net/bonding/bond_3ad.c                      | 19 +------------------
 drivers/net/ethernet/atheros/atlx/atl1.c            | 18 +-----------------
 drivers/net/ethernet/broadcom/bcm63xx_enet.c        | 15 +--------------
 drivers/net/ethernet/faraday/ftgmac100.c            | 15 +--------------
 drivers/net/ethernet/faraday/ftgmac100.h            | 15 +--------------
 drivers/net/ethernet/faraday/ftmac100.c             | 15 +--------------
 drivers/net/ethernet/faraday/ftmac100.h             | 15 +--------------
 drivers/net/ethernet/hp/hp100.c                     | 14 +-------------
 drivers/net/ethernet/hp/hp100.h                     |  6 +-----
 drivers/net/ethernet/ibm/ibmvnic.c                  | 13 +------------
 drivers/net/ethernet/ibm/ibmvnic.h                  | 13 +------------
 drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c |  2 +-
 drivers/net/hamradio/baycom_epp.c                   | 17 +----------------
 drivers/net/hamradio/baycom_par.c                   | 18 +-----------------
 drivers/net/hamradio/baycom_ser_fdx.c               | 17 +----------------
 drivers/net/hamradio/baycom_ser_hdx.c               | 18 +-----------------
 drivers/net/hamradio/bpqether.c                     |  7 +------
 drivers/net/hamradio/dmascc.c                       | 15 +--------------
 drivers/net/hamradio/hdlcdrv.c                      | 15 +--------------
 drivers/net/hamradio/yam.c                          | 17 +----------------
 drivers/net/wan/cosa.c                              | 15 +--------------
 drivers/net/wan/cosa.h                              | 15 +--------------
 drivers/net/wan/lapbether.c                         |  7 +------
 drivers/net/wireless/ath/carl9170/fw.c              | 15 +--------------
 drivers/net/wireless/atmel/atmel.h                  | 14 +-------------
 drivers/net/wireless/atmel/atmel_pci.c              | 14 +-------------
 drivers/nfc/s3fwrn5/core.c                          | 13 +------------
 drivers/nfc/s3fwrn5/firmware.c                      | 13 +------------
 drivers/nfc/s3fwrn5/firmware.h                      | 13 +------------
 drivers/nfc/s3fwrn5/i2c.c                           | 13 +------------
 drivers/nfc/s3fwrn5/nci.c                           | 13 +------------
 drivers/nfc/s3fwrn5/nci.h                           | 13 +------------
 drivers/nfc/s3fwrn5/s3fwrn5.h                       | 13 +------------
 drivers/phy/broadcom/phy-brcm-sata.c                | 11 +----------
 drivers/phy/ti/phy-twl4030-usb.c                    | 15 +--------------
 drivers/platform/olpc/olpc-ec.c                     |  3 +--
 drivers/platform/x86/sony-laptop.c                  | 16 +---------------
 drivers/pnp/isapnp/core.c                           | 16 +---------------
 drivers/pnp/isapnp/proc.c                           | 15 +--------------
 drivers/pnp/pnpacpi/rsparser.c                      | 11 +----------
 drivers/pps/clients/pps-gpio.c                      | 16 +---------------
 drivers/pps/clients/pps-ktimer.c                    | 16 +---------------
 drivers/pps/clients/pps-ldisc.c                     | 16 +---------------
 drivers/pps/clients/pps_parport.c                   | 16 +---------------
 drivers/pps/generators/pps_gen_parport.c            | 16 +---------------
 drivers/pps/kapi.c                                  | 16 +---------------
 drivers/pps/kc.c                                    | 15 +--------------
 drivers/pps/kc.h                                    | 15 +--------------
 drivers/pps/pps.c                                   | 16 +---------------
 drivers/pps/sysfs.c                                 | 16 +---------------
 drivers/ptp/ptp_chardev.c                           | 15 +--------------
 drivers/ptp/ptp_clock.c                             | 15 +--------------
 drivers/ptp/ptp_ixp46x.c                            | 15 +--------------
 drivers/ptp/ptp_private.h                           | 15 +--------------
 drivers/ptp/ptp_qoriq.c                             | 15 +--------------
 drivers/ptp/ptp_sysfs.c                             | 15 +--------------
 drivers/pwm/pwm-tiecap.c                            | 15 +--------------
 drivers/pwm/pwm-tiehrpwm.c                          | 15 +--------------
 drivers/pwm/sysfs.c                                 | 11 +----------
 drivers/rtc/rtc-opal.c                              | 14 +-------------
 drivers/rtc/rtc-st-lpc.c                            |  6 +-----
 drivers/sbus/char/openprom.c                        | 15 +--------------
 drivers/scsi/53c700.c                               | 14 +-------------
 drivers/scsi/aha152x.c                              | 13 +------------
 drivers/scsi/dmx3191d.c                             | 14 +-------------
 drivers/scsi/lasi700.c                              | 14 +-------------
 drivers/scsi/libsas/sas_init.c                      | 19 +------------------
 drivers/scsi/libsas/sas_internal.h                  | 19 +------------------
 drivers/scsi/libsas/sas_scsi_host.c                 | 19 +------------------
 drivers/scsi/ncr53c8xx.c                            | 14 +-------------
 drivers/scsi/ncr53c8xx.h                            | 14 +-------------
 drivers/scsi/nsp32.c                                | 12 +-----------
 drivers/scsi/nsp32.h                                | 11 +----------
 drivers/scsi/pcmcia/sym53c500_cs.c                  | 11 +----------
 drivers/scsi/qla1280.c                              | 11 +----------
 drivers/scsi/qla1280.h                              | 11 +----------
 drivers/scsi/script_asm.pl                          | 15 +--------------
 drivers/scsi/scsi_debug.c                           |  7 +------
 drivers/scsi/sg.c                                   |  7 +------
 drivers/scsi/sim710.c                               | 15 +--------------
 drivers/scsi/sni_53c710.c                           | 14 +-------------
 drivers/scsi/virtio_scsi.c                          |  5 +----
 drivers/scsi/wd33c93.c                              | 11 +----------
 drivers/scsi/wd33c93.h                              | 12 +-----------
 drivers/spi/spi-cadence.c                           |  6 +-----
 drivers/spi/spi-zynqmp-gqspi.c                      |  6 +-----
 drivers/uio/uio_mf624.c                             | 15 +--------------
 drivers/video/backlight/cr_bllcd.c                  | 16 +---------------
 drivers/video/backlight/hx8357.c                    |  3 +--
 drivers/video/backlight/jornada720_bl.c             |  6 +-----
 drivers/video/backlight/jornada720_lcd.c            |  6 +-----
 drivers/video/fbdev/pxa3xx-gcu.c                    | 15 +--------------
 drivers/video/fbdev/sis/initextlfb.c                | 15 +--------------
 drivers/video/fbdev/sis/sis.h                       | 15 +--------------
 drivers/video/fbdev/sis/sis_accel.c                 | 15 +--------------
 drivers/video/fbdev/sis/sis_accel.h                 | 15 +--------------
 drivers/video/fbdev/sis/sis_main.c                  | 16 +---------------
 drivers/video/fbdev/sis/sis_main.h                  | 15 +--------------
 drivers/video/fbdev/ssd1307fb.c                     |  3 +--
 drivers/video/fbdev/vermilion/cr_pll.c              | 16 +---------------
 drivers/video/fbdev/vermilion/vermilion.c           | 16 +---------------
 drivers/video/fbdev/vermilion/vermilion.h           | 16 +---------------
 drivers/video/fbdev/via/accel.c                     | 16 +---------------
 drivers/video/fbdev/via/accel.h                     | 16 +---------------
 drivers/video/fbdev/via/chip.h                      | 16 +---------------
 drivers/video/fbdev/via/debug.h                     | 16 +---------------
 drivers/video/fbdev/via/dvi.c                       | 16 +---------------
 drivers/video/fbdev/via/dvi.h                       | 16 +---------------
 drivers/video/fbdev/via/global.c                    | 16 +---------------
 drivers/video/fbdev/via/global.h                    | 16 +---------------
 drivers/video/fbdev/via/hw.c                        | 16 +---------------
 drivers/video/fbdev/via/hw.h                        | 16 +---------------
 drivers/video/fbdev/via/ioctl.c                     | 16 +---------------
 drivers/video/fbdev/via/ioctl.h                     | 16 +---------------
 drivers/video/fbdev/via/lcd.c                       | 16 +---------------
 drivers/video/fbdev/via/lcd.h                       | 16 +---------------
 drivers/video/fbdev/via/share.h                     | 16 +---------------
 drivers/video/fbdev/via/tblDPASetting.c             | 16 +---------------
 drivers/video/fbdev/via/tblDPASetting.h             | 16 +---------------
 drivers/video/fbdev/via/via_aux.c                   | 17 +----------------
 drivers/video/fbdev/via/via_aux.h                   | 17 +----------------
 drivers/video/fbdev/via/via_aux_ch7301.c            | 17 +----------------
 drivers/video/fbdev/via/via_aux_edid.c              | 17 +----------------
 drivers/video/fbdev/via/via_aux_sii164.c            | 17 +----------------
 drivers/video/fbdev/via/via_aux_vt1621.c            | 17 +----------------
 drivers/video/fbdev/via/via_aux_vt1622.c            | 17 +----------------
 drivers/video/fbdev/via/via_aux_vt1625.c            | 17 +----------------
 drivers/video/fbdev/via/via_aux_vt1631.c            | 17 +----------------
 drivers/video/fbdev/via/via_aux_vt1632.c            | 17 +----------------
 drivers/video/fbdev/via/via_aux_vt1636.c            | 17 +----------------
 drivers/video/fbdev/via/via_clock.c                 | 17 +----------------
 drivers/video/fbdev/via/via_clock.h                 | 17 +----------------
 drivers/video/fbdev/via/via_i2c.c                   | 16 +---------------
 drivers/video/fbdev/via/via_modesetting.c           | 17 +----------------
 drivers/video/fbdev/via/via_modesetting.h           | 17 +----------------
 drivers/video/fbdev/via/via_utility.c               | 16 +---------------
 drivers/video/fbdev/via/via_utility.h               | 16 +---------------
 drivers/video/fbdev/via/viafbdev.c                  | 16 +---------------
 drivers/video/fbdev/via/viafbdev.h                  | 16 +---------------
 drivers/video/fbdev/via/viamode.c                   | 16 +---------------
 drivers/video/fbdev/via/viamode.h                   | 16 +---------------
 drivers/video/fbdev/via/vt1636.c                    | 16 +---------------
 drivers/video/fbdev/via/vt1636.h                    | 16 +---------------
 drivers/virtio/virtio_balloon.c                     | 15 +--------------
 drivers/virtio/virtio_mmio.c                        |  6 +-----
 drivers/virtio/virtio_pci_common.c                  |  5 +----
 drivers/virtio/virtio_pci_common.h                  |  5 +----
 drivers/virtio/virtio_pci_legacy.c                  |  5 +----
 drivers/virtio/virtio_pci_modern.c                  |  5 +----
 drivers/virtio/virtio_ring.c                        | 15 +--------------
 drivers/vlynq/vlynq.c                               | 15 +--------------
 drivers/w1/slaves/w1_smem.c                         | 16 +---------------
 drivers/watchdog/cpu5wdt.c                          | 16 +---------------
 drivers/watchdog/rdc321x_wdt.c                      | 16 +---------------
 drivers/xen/events/events_internal.h                |  4 +---
 fs/afs/addr_list.c                                  |  6 +-----
 fs/afs/dir_edit.c                                   |  6 +-----
 fs/afs/dir_silly.c                                  |  6 +-----
 fs/afs/dynroot.c                                    |  6 +-----
 fs/afs/fs_probe.c                                   |  6 +-----
 fs/afs/protocol_yfs.h                               |  6 +-----
 fs/afs/rotate.c                                     |  6 +-----
 fs/afs/vl_probe.c                                   |  6 +-----
 fs/afs/vl_rotate.c                                  |  6 +-----
 fs/afs/xattr.c                                      |  6 +-----
 fs/afs/xdr_fs.h                                     |  6 +-----
 fs/afs/yfsclient.c                                  |  6 +-----
 fs/autofs/autofs_i.h                                |  5 +----
 fs/autofs/dev-ioctl.c                               |  5 +----
 fs/autofs/expire.c                                  |  5 +----
 fs/autofs/init.c                                    |  5 +----
 fs/autofs/inode.c                                   |  5 +----
 fs/autofs/root.c                                    |  5 +----
 fs/autofs/symlink.c                                 |  5 +----
 fs/autofs/waitq.c                                   |  5 +----
 fs/cachefiles/bind.c                                |  6 +-----
 fs/cachefiles/daemon.c                              |  6 +-----
 fs/cachefiles/interface.c                           |  6 +-----
 fs/cachefiles/internal.h                            |  6 +-----
 fs/cachefiles/key.c                                 |  6 +-----
 fs/cachefiles/main.c                                |  6 +-----
 fs/cachefiles/namei.c                               |  6 +-----
 fs/cachefiles/proc.c                                |  6 +-----
 fs/cachefiles/rdwr.c                                |  6 +-----
 fs/cachefiles/security.c                            |  6 +-----
 fs/cachefiles/xattr.c                               |  6 +-----
 fs/cifs/nterr.c                                     | 15 +--------------
 fs/cifs/nterr.h                                     | 14 +-------------
 fs/cifs/smbencrypt.c                                | 14 +-------------
 fs/devpts/inode.c                                   |  5 +----
 fs/fs_context.c                                     |  6 +-----
 fs/fs_parser.c                                      |  6 +-----
 fs/fscache/histogram.c                              |  6 +-----
 fs/fscache/netfs.c                                  |  6 +-----
 fs/fscache/object-list.c                            |  6 +-----
 fs/fsopen.c                                         |  6 +-----
 fs/nfs/fscache-index.c                              |  6 +-----
 fs/nfs/fscache.c                                    |  6 +-----
 fs/nfs/fscache.h                                    |  6 +-----
 fs/notify/dnotify/dnotify.c                         | 11 +----------
 fs/notify/inotify/inotify_fsnotify.c                | 11 +----------
 fs/notify/inotify/inotify_user.c                    | 11 +----------
 fs/ntfs/aops.c                                      | 16 +---------------
 fs/ntfs/aops.h                                      | 16 +---------------
 fs/ntfs/attrib.c                                    | 16 +---------------
 fs/ntfs/attrib.h                                    | 16 +---------------
 fs/ntfs/bitmap.c                                    | 16 +---------------
 fs/ntfs/bitmap.h                                    | 16 +---------------
 fs/ntfs/collate.c                                   | 16 +---------------
 fs/ntfs/collate.h                                   | 16 +---------------
 fs/ntfs/compress.c                                  | 16 +---------------
 fs/ntfs/debug.c                                     | 16 +---------------
 fs/ntfs/debug.h                                     | 16 +---------------
 fs/ntfs/dir.c                                       | 16 +---------------
 fs/ntfs/dir.h                                       | 16 +---------------
 fs/ntfs/endian.h                                    | 16 +---------------
 fs/ntfs/file.c                                      | 16 +---------------
 fs/ntfs/index.c                                     | 16 +---------------
 fs/ntfs/index.h                                     | 16 +---------------
 fs/ntfs/inode.c                                     | 16 +---------------
 fs/ntfs/inode.h                                     | 16 +---------------
 fs/ntfs/layout.h                                    | 16 +---------------
 fs/ntfs/lcnalloc.c                                  | 16 +---------------
 fs/ntfs/lcnalloc.h                                  | 16 +---------------
 fs/ntfs/logfile.c                                   | 16 +---------------
 fs/ntfs/logfile.h                                   | 16 +---------------
 fs/ntfs/malloc.h                                    | 16 +---------------
 fs/ntfs/mft.c                                       | 16 +---------------
 fs/ntfs/mft.h                                       | 16 +---------------
 fs/ntfs/mst.c                                       | 16 +---------------
 fs/ntfs/namei.c                                     | 16 +---------------
 fs/ntfs/ntfs.h                                      | 16 +---------------
 fs/ntfs/quota.c                                     | 16 +---------------
 fs/ntfs/quota.h                                     | 16 +---------------
 fs/ntfs/runlist.c                                   | 16 +---------------
 fs/ntfs/runlist.h                                   | 16 +---------------
 fs/ntfs/super.c                                     | 16 +---------------
 fs/ntfs/sysctl.c                                    | 16 +---------------
 fs/ntfs/sysctl.h                                    | 16 +---------------
 fs/ntfs/time.h                                      | 16 +---------------
 fs/ntfs/types.h                                     | 16 +---------------
 fs/ntfs/unistr.c                                    | 16 +---------------
 fs/ntfs/upcase.c                                    | 16 +---------------
 fs/ntfs/usnjrnl.c                                   | 16 +---------------
 fs/ntfs/usnjrnl.h                                   | 16 +---------------
 fs/ntfs/volume.h                                    | 16 +---------------
 fs/squashfs/block.c                                 | 15 +--------------
 fs/squashfs/cache.c                                 | 15 +--------------
 fs/squashfs/decompressor.c                          | 15 +--------------
 fs/squashfs/decompressor.h                          | 15 +--------------
 fs/squashfs/dir.c                                   | 15 +--------------
 fs/squashfs/export.c                                | 15 +--------------
 fs/squashfs/file.c                                  | 15 +--------------
 fs/squashfs/fragment.c                              | 15 +--------------
 fs/squashfs/id.c                                    | 15 +--------------
 fs/squashfs/inode.c                                 | 15 +--------------
 fs/squashfs/lzo_wrapper.c                           | 15 +--------------
 fs/squashfs/namei.c                                 | 15 +--------------
 fs/squashfs/squashfs.h                              | 15 +--------------
 fs/squashfs/squashfs_fs.h                           | 15 +--------------
 fs/squashfs/squashfs_fs_i.h                         | 15 +--------------
 fs/squashfs/squashfs_fs_sb.h                        | 15 +--------------
 fs/squashfs/super.c                                 | 15 +--------------
 fs/squashfs/symlink.c                               | 15 +--------------
 fs/squashfs/xattr.c                                 | 15 +--------------
 fs/squashfs/xattr.h                                 | 15 +--------------
 fs/squashfs/xattr_id.c                              | 15 +--------------
 fs/squashfs/xz_wrapper.c                            | 15 +--------------
 fs/squashfs/zlib_wrapper.c                          | 15 +--------------
 fs/squashfs/zstd_wrapper.c                          | 11 +----------
 include/asm-generic/atomic.h                        |  6 +-----
 include/asm-generic/barrier.h                       |  6 +-----
 include/asm-generic/exec.h                          |  6 +-----
 include/asm-generic/io.h                            |  6 +-----
 include/asm-generic/switch_to.h                     |  6 +-----
 include/asm-generic/xor.h                           | 10 +---------
 include/crypto/pkcs7.h                              |  6 +-----
 include/crypto/public_key.h                         |  6 +-----
 include/dt-bindings/media/tvp5150.h                 | 14 +-------------
 include/keys/asymmetric-parser.h                    |  6 +-----
 include/keys/asymmetric-subtype.h                   |  6 +-----
 include/keys/asymmetric-type.h                      |  6 +-----
 include/keys/request_key_auth-type.h                |  6 +-----
 include/keys/system_keyring.h                       |  6 +-----
 include/linux/ahci_platform.h                       |  6 +-----
 include/linux/apm_bios.h                            | 11 +----------
 include/linux/asn1.h                                |  6 +-----
 include/linux/asn1_ber_bytecode.h                   |  6 +-----
 include/linux/asn1_decoder.h                        |  6 +-----
 include/linux/assoc_array.h                         |  6 +-----
 include/linux/assoc_array_priv.h                    |  6 +-----
 include/linux/auto_dev-ioctl.h                      |  5 +----
 include/linux/auto_fs.h                             |  5 +----
 include/linux/bma150.h                              | 15 +--------------
 include/linux/count_zeros.h                         |  6 +-----
 include/linux/cred.h                                |  6 +-----
 include/linux/dca.h                                 | 18 +-----------------
 include/linux/devpts_fs.h                           |  5 +----
 include/linux/dma-contiguous.h                      |  6 +-----
 include/linux/dma/xilinx_dma.h                      |  6 +-----
 include/linux/drbd.h                                | 14 +-------------
 include/linux/fmc.h                                 |  3 +--
 include/linux/fs_context.h                          |  6 +-----
 include/linux/fs_parser.h                           |  6 +-----
 include/linux/fsldma.h                              |  5 +----
 include/linux/hwmon-sysfs.h                         | 15 +--------------
 include/linux/hwmon-vid.h                           | 14 +-------------
 include/linux/isapnp.h                              | 17 +----------------
 include/linux/isdn/hdlc.h                           | 15 +--------------
 include/linux/jbd2.h                                |  5 +----
 include/linux/key-type.h                            |  6 +-----
 include/linux/keyctl.h                              |  6 +-----
 include/linux/kfifo.h                               | 16 +---------------
 include/linux/kmod.h                                | 15 +--------------
 include/linux/libgcc.h                              | 15 +--------------
 include/linux/lru_cache.h                           | 14 +-------------
 include/linux/mfd/da9052/da9052.h                   | 16 +---------------
 include/linux/mfd/da9052/pdata.h                    | 16 +---------------
 include/linux/mfd/da9052/reg.h                      | 16 +---------------
 include/linux/mfd/da9055/core.h                     | 16 +---------------
 include/linux/mfd/da9055/reg.h                      | 16 +---------------
 include/linux/mfd/wm8400-audio.h                    | 15 +--------------
 include/linux/mfd/wm8400-private.h                  | 15 +--------------
 include/linux/mfd/wm8400.h                          | 15 +--------------
 include/linux/mpi.h                                 | 15 +--------------
 include/linux/mtd/bbm.h                             | 16 +---------------
 include/linux/mtd/blktrans.h                        | 16 +---------------
 include/linux/mtd/cfi.h                             | 16 +---------------
 include/linux/mtd/cfi_endian.h                      | 16 +---------------
 include/linux/mtd/concat.h                          | 16 +---------------
 include/linux/mtd/doc2000.h                         | 16 +---------------
 include/linux/mtd/flashchip.h                       | 16 +---------------
 include/linux/mtd/gen_probe.h                       | 16 +---------------
 include/linux/mtd/map.h                             | 16 +---------------
 include/linux/mtd/mtd.h                             | 16 +---------------
 include/linux/mtd/nftl.h                            | 16 +---------------
 include/linux/oid_registry.h                        |  6 +-----
 include/linux/platform_data/ads1015.h               | 15 +--------------
 include/linux/platform_data/at91_adc.h              |  3 +--
 include/linux/platform_data/media/camera-mx2.h      | 15 +--------------
 include/linux/platform_data/media/camera-pxa.h      | 14 +-------------
 include/linux/platform_data/mtd-davinci.h           | 15 +--------------
 include/linux/platform_data/spi-davinci.h           | 15 +--------------
 include/linux/pmbus.h                               | 15 +--------------
 include/linux/posix-clock.h                         | 15 +--------------
 include/linux/pps-gpio.h                            | 16 +---------------
 include/linux/pps_kernel.h                          | 15 +--------------
 include/linux/ptp_classify.h                        | 15 +--------------
 include/linux/ptp_clock_kernel.h                    | 15 +--------------
 include/linux/raid/md_u.h                           |  9 +--------
 include/linux/raid/pq.h                             |  7 +------
 include/linux/regulator/lp3971.h                    | 15 +--------------
 include/linux/regulator/lp3972.h                    | 15 +--------------
 include/linux/sctp.h                                | 17 +----------------
 include/linux/sonypi.h                              | 16 +---------------
 include/linux/toshiba.h                             | 12 +-----------
 include/linux/verification.h                        |  6 +-----
 include/linux/via-core.h                            | 17 +----------------
 include/linux/via_i2c.h                             | 16 +---------------
 include/linux/vlynq.h                               | 15 +--------------
 include/linux/yam.h                                 | 17 +----------------
 include/media/drv-intf/cx25840.h                    | 14 +-------------
 include/media/drv-intf/msp3400.h                    | 14 +-------------
 include/media/i2c/bt819.h                           | 14 +-------------
 include/media/i2c/cs5345.h                          | 14 +-------------
 include/media/i2c/cs53l32a.h                        | 14 +-------------
 include/media/i2c/m52790.h                          | 14 +-------------
 include/media/i2c/saa6588.h                         | 14 +-------------
 include/media/i2c/saa7115.h                         | 14 +-------------
 include/media/i2c/saa7127.h                         | 14 +-------------
 include/media/i2c/tvaudio.h                         | 14 +-------------
 include/media/i2c/wm8775.h                          | 14 +-------------
 include/misc/altera.h                               | 16 +---------------
 include/net/bond_3ad.h                              | 19 +------------------
 include/net/sctp/auth.h                             | 17 +----------------
 include/net/sctp/checksum.h                         | 17 +----------------
 include/net/sctp/command.h                          | 17 +----------------
 include/net/sctp/constants.h                        | 17 +----------------
 include/net/sctp/sctp.h                             | 17 +----------------
 include/net/sctp/sm.h                               | 17 +----------------
 include/net/sctp/stream_interleave.h                | 17 +----------------
 include/net/sctp/stream_sched.h                     | 17 +----------------
 include/net/sctp/structs.h                          | 17 +----------------
 include/net/sctp/tsnmap.h                           | 17 +----------------
 include/net/sctp/ulpevent.h                         | 17 +----------------
 include/net/sctp/ulpqueue.h                         | 17 +----------------
 include/scsi/libsas.h                               | 19 +------------------
 include/scsi/sas.h                                  | 19 +------------------
 include/sound/hda_hwdep.h                           | 15 +--------------
 include/sound/pcm-indirect.h                        | 15 +--------------
 include/trace/events/afs.h                          |  6 +-----
 include/trace/events/cachefiles.h                   |  6 +-----
 include/trace/events/fscache.h                      |  6 +-----
 include/trace/events/i2c.h                          |  6 +-----
 include/trace/events/rxrpc.h                        |  6 +-----
 include/trace/events/smbus.h                        |  6 +-----
 include/uapi/linux/rxrpc.h                          |  6 +-----
 include/video/sisfb.h                               | 15 +--------------
 ipc/msgutil.c                                       |  6 +-----
 kernel/cred.c                                       |  6 +-----
 kernel/module-internal.h                            |  6 +-----
 kernel/module_signing.c                             |  6 +-----
 kernel/stop_machine.c                               |  3 +--
 lib/ashldi3.c                                       | 14 +-------------
 lib/ashrdi3.c                                       | 14 +-------------
 lib/asn1_decoder.c                                  |  6 +-----
 lib/assoc_array.c                                   |  6 +-----
 lib/build_OID_registry                              |  6 +-----
 lib/cmpdi2.c                                        | 14 +-------------
 lib/decompress_unlzo.c                              | 16 +---------------
 lib/is_single_threaded.c                            |  6 +-----
 lib/kfifo.c                                         | 16 +---------------
 lib/lru_cache.c                                     | 14 +-------------
 lib/lshrdi3.c                                       | 15 +--------------
 lib/mpi/generic_mpih-add1.c                         | 15 +--------------
 lib/mpi/generic_mpih-lshift.c                       | 15 +--------------
 lib/mpi/generic_mpih-mul1.c                         | 15 +--------------
 lib/mpi/generic_mpih-mul2.c                         | 15 +--------------
 lib/mpi/generic_mpih-mul3.c                         | 15 +--------------
 lib/mpi/generic_mpih-rshift.c                       | 15 +--------------
 lib/mpi/generic_mpih-sub1.c                         | 15 +--------------
 lib/mpi/mpi-inline.h                                | 15 +--------------
 lib/mpi/mpi-internal.h                              | 15 +--------------
 lib/mpi/mpi-pow.c                                   | 15 +--------------
 lib/mpi/mpih-cmp.c                                  | 15 +--------------
 lib/mpi/mpih-div.c                                  | 15 +--------------
 lib/mpi/mpih-mul.c                                  | 15 +--------------
 lib/muldi3.c                                        | 14 +-------------
 lib/oid_registry.c                                  |  6 +-----
 lib/raid6/algos.c                                   |  7 +------
 lib/raid6/avx2.c                                    |  8 +-------
 lib/raid6/avx512.c                                  |  7 +------
 lib/raid6/mktables.c                                |  5 +----
 lib/raid6/mmx.c                                     |  7 +------
 lib/raid6/recov.c                                   |  7 +------
 lib/raid6/sse1.c                                    |  7 +------
 lib/raid6/sse2.c                                    |  7 +------
 lib/raid6/test/test.c                               |  5 +----
 lib/raid6/x86.h                                     |  7 +------
 lib/ucmpdi2.c                                       | 14 +-------------
 mm/cma.c                                            |  6 +-----
 net/core/timestamping.c                             | 15 +--------------
 net/dccp/ccids/ccid2.c                              | 15 +--------------
 net/dccp/ccids/ccid2.h                              | 15 +--------------
 net/decnet/netfilter/dn_rtmsg.c                     |  4 +---
 net/lapb/lapb_iface.c                               |  7 +------
 net/lapb/lapb_in.c                                  |  7 +------
 net/lapb/lapb_out.c                                 |  7 +------
 net/lapb/lapb_subr.c                                |  7 +------
 net/lapb/lapb_timer.c                               |  7 +------
 net/netfilter/ipvs/ip_vs_nfct.c                     | 18 +-----------------
 net/netfilter/nf_conntrack_timeout.c                |  5 +----
 net/netfilter/nf_conntrack_timestamp.c              |  5 +----
 net/netfilter/nfnetlink_acct.c                      |  5 +----
 net/netfilter/nfnetlink_cthelper.c                  |  5 +----
 net/netfilter/nfnetlink_cttimeout.c                 |  5 +----
 net/netfilter/xt_nfacct.c                           |  5 +----
 net/rxrpc/conn_client.c                             |  7 +------
 net/rxrpc/conn_service.c                            |  6 +-----
 net/rxrpc/insecure.c                                |  6 +-----
 net/rxrpc/local_object.c                            |  6 +-----
 net/rxrpc/misc.c                                    |  6 +-----
 net/rxrpc/net_ns.c                                  |  6 +-----
 net/rxrpc/sendmsg.c                                 |  6 +-----
 net/rxrpc/sysctl.c                                  |  6 +-----
 net/rxrpc/utils.c                                   |  6 +-----
 net/sctp/associola.c                                | 17 +----------------
 net/sctp/auth.c                                     | 17 +----------------
 net/sctp/bind_addr.c                                | 17 +----------------
 net/sctp/chunk.c                                    | 17 +----------------
 net/sctp/debug.c                                    | 17 +----------------
 net/sctp/diag.c                                     | 17 +----------------
 net/sctp/endpointola.c                              | 17 +----------------
 net/sctp/input.c                                    | 17 +----------------
 net/sctp/inqueue.c                                  | 17 +----------------
 net/sctp/ipv6.c                                     | 17 +----------------
 net/sctp/objcnt.c                                   | 17 +----------------
 net/sctp/output.c                                   | 17 +----------------
 net/sctp/outqueue.c                                 | 17 +----------------
 net/sctp/primitive.c                                | 17 +----------------
 net/sctp/proc.c                                     | 17 +----------------
 net/sctp/protocol.c                                 | 17 +----------------
 net/sctp/sm_make_chunk.c                            | 17 +----------------
 net/sctp/sm_sideeffect.c                            | 17 +----------------
 net/sctp/sm_statefuns.c                             | 17 +----------------
 net/sctp/sm_statetable.c                            | 17 +----------------
 net/sctp/socket.c                                   | 17 +----------------
 net/sctp/stream.c                                   | 17 +----------------
 net/sctp/stream_interleave.c                        | 17 +----------------
 net/sctp/stream_sched.c                             | 17 +----------------
 net/sctp/stream_sched_prio.c                        | 17 +----------------
 net/sctp/stream_sched_rr.c                          | 17 +----------------
 net/sctp/sysctl.c                                   | 17 +----------------
 net/sctp/transport.c                                | 17 +----------------
 net/sctp/tsnmap.c                                   | 17 +----------------
 net/sctp/ulpevent.c                                 | 17 +----------------
 net/sctp/ulpqueue.c                                 | 17 +----------------
 net/unix/garbage.c                                  |  7 +------
 net/x25/af_x25.c                                    |  7 +------
 net/x25/x25_dev.c                                   |  7 +------
 net/x25/x25_facilities.c                            |  7 +------
 net/x25/x25_forward.c                               |  7 +------
 net/x25/x25_in.c                                    |  7 +------
 net/x25/x25_link.c                                  |  7 +------
 net/x25/x25_out.c                                   |  7 +------
 net/x25/x25_proc.c                                  |  7 +------
 net/x25/x25_route.c                                 |  7 +------
 net/x25/x25_subr.c                                  |  7 +------
 net/x25/x25_timer.c                                 |  7 +------
 samples/vfs/test-fsmount.c                          |  6 +-----
 samples/vfs/test-statx.c                            |  6 +-----
 scripts/asn1_compiler.c                             |  6 +-----
 scripts/conmakehash.c                               |  5 +----
 scripts/get_dvb_firmware                            | 15 +--------------
 security/keys/big_key.c                             |  6 +-----
 security/keys/gc.c                                  |  6 +-----
 security/keys/keyctl_pkey.c                         |  6 +-----
 security/keys/persistent.c                          |  6 +-----
 security/keys/sysctl.c                              |  6 +-----
 sound/drivers/mts64.c                               | 16 +---------------
 sound/drivers/pcm-indirect2.c                       | 15 +--------------
 sound/drivers/pcm-indirect2.h                       | 15 +--------------
 sound/drivers/portman2x4.c                          | 15 +--------------
 sound/isa/msnd/msnd.c                               | 15 +--------------
 sound/isa/msnd/msnd.h                               | 15 +--------------
 sound/isa/msnd/msnd_classic.h                       | 15 +--------------
 sound/isa/msnd/msnd_pinnacle.c                      | 16 +---------------
 sound/isa/msnd/msnd_pinnacle.h                      | 15 +--------------
 sound/pci/ali5451/ali5451.c                         | 16 +---------------
 sound/pci/azt3328.c                                 | 16 +---------------
 sound/pci/bt87x.c                                   | 16 +---------------
 sound/pci/cs5530.c                                  | 11 +----------
 sound/pci/hda/ca0132_regs.h                         | 15 +--------------
 sound/pci/hda/hda_auto_parser.c                     |  6 +-----
 sound/pci/hda/hda_auto_parser.h                     |  6 +-----
 sound/pci/hda/hda_codec.c                           | 16 +---------------
 sound/pci/hda/hda_eld.c                             | 15 +--------------
 sound/pci/hda/hda_generic.c                         | 15 +--------------
 sound/pci/hda/hda_generic.h                         |  6 +-----
 sound/pci/hda/hda_hwdep.c                           | 15 +--------------
 sound/pci/hda/hda_jack.c                            |  6 +-----
 sound/pci/hda/hda_jack.h                            |  6 +-----
 sound/pci/hda/hda_proc.c                            | 16 +---------------
 sound/pci/hda/patch_analog.c                        | 15 +--------------
 sound/pci/hda/patch_ca0110.c                        | 15 +--------------
 sound/pci/hda/patch_ca0132.c                        | 15 +--------------
 sound/pci/hda/patch_cirrus.c                        | 15 +--------------
 sound/pci/hda/patch_cmedia.c                        | 16 +---------------
 sound/pci/hda/patch_conexant.c                      | 15 +--------------
 sound/pci/hda/patch_realtek.c                       | 15 +--------------
 sound/pci/hda/patch_si3054.c                        | 16 +---------------
 sound/pci/hda/patch_sigmatel.c                      | 15 +--------------
 sound/pci/hda/patch_via.c                           | 15 +--------------
 sound/pci/lx6464es/lx6464es.c                       | 18 +-----------------
 sound/pci/lx6464es/lx6464es.h                       | 18 +-----------------
 sound/pci/lx6464es/lx_core.c                        | 17 +----------------
 sound/pci/lx6464es/lx_core.h                        | 17 +----------------
 sound/pci/lx6464es/lx_defs.h                        | 17 +----------------
 sound/pci/rme32.c                                   | 16 +---------------
 sound/soc/codecs/ad73311.h                          | 17 +----------------
 sound/soc/codecs/ssm2602.h                          | 16 +---------------
 sound/soc/sunxi/sun4i-codec.c                       | 11 +----------
 sound/soc/sunxi/sun4i-spdif.c                       | 11 +----------
 sound/spi/at73c213.h                                | 19 +------------------
 sound/usb/usx2y/us122l.c                            | 15 +--------------
 sound/usb/usx2y/usb_stream.c                        | 15 +--------------
 tools/include/asm-generic/barrier.h                 |  6 +-----
 tools/testing/selftests/ptp/testptp.c               | 15 +--------------
 tools/thermal/tmon/pid.c                            | 13 +------------
 tools/thermal/tmon/sysfs.c                          | 11 +----------
 tools/thermal/tmon/tmon.c                           | 11 +----------
 tools/thermal/tmon/tmon.h                           | 11 +----------
 tools/thermal/tmon/tui.c                            | 11 +----------
 tools/usb/testusb.c                                 | 15 +--------------
 tools/usb/usbip/libsrc/names.c                      | 20 +-------------------
 tools/usb/usbip/libsrc/names.h                      | 17 +----------------
 1147 files changed, 1151 insertions(+), 13578 deletions(-)
