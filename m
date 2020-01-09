Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16354C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 22:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6AB82077B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 22:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbgAIWTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 17:19:15 -0500
Received: from inva020.nxp.com ([92.121.34.13]:56632 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgAIWTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 17:19:15 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E1AA81A0531;
        Thu,  9 Jan 2020 23:19:12 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 88A6F1A052F;
        Thu,  9 Jan 2020 23:19:12 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id BF10B40CD4;
        Thu,  9 Jan 2020 15:19:11 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     arm@kernel.org, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Subject: [GIT PULL] soc/fsl drivers changes for next(v5.6)
Date:   Thu,  9 Jan 2020 16:19:11 -0600
Message-Id: <1578608351-23289-1-git-send-email-leoyang.li@nxp.com>
X-Mailer: git-send-email 1.9.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi soc maintainers,

Please merge the following new changes for soc/fsl drivers.

Regards,
Leo


The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-next-v5.6

for you to fetch changes up to 6e62bd36e9ad85a22d92b1adce6a0336ea549733:

  soc: fsl: qe: remove set but not used variable 'mm_gc' (2020-01-08 16:02:48 -0600)

----------------------------------------------------------------
NXP/FSL SoC driver updates for v5.6

QUICC Engine drivers
- Improve the QE drivers to be compatible with ARM/ARM64/PPC64
architectures
- Various cleanups to the QE drivers

----------------------------------------------------------------
Rasmus Villemoes (48):
      soc: fsl: qe: remove space-before-tab
      soc: fsl: qe: drop volatile qualifier of struct qe_ic::regs
      soc: fsl: qe: rename qe_(clr/set/clrset)bit* helpers
      soc: fsl: qe: introduce qe_io{read,write}* wrappers
      soc: fsl: qe: avoid ppc-specific io accessors
      soc: fsl: qe: replace spin_event_timeout by readx_poll_timeout_atomic
      soc: fsl: qe: qe.c: guard use of pvr_version_is() with CONFIG_PPC32
      soc: fsl: qe: drop unneeded #includes
      soc: fsl: qe: drop assign-only high_active in qe_ic_init
      soc: fsl: qe: remove pointless sysfs registration in qe_ic.c
      soc: fsl: qe: use qe_ic_cascade_{low, high}_mpic also on 83xx
      soc: fsl: qe: move calls of qe_ic_init out of arch/powerpc/
      powerpc/83xx: remove mpc83xx_ipic_and_qe_init_IRQ
      soc: fsl: qe: move qe_ic_cascade_* functions to qe_ic.c
      soc: fsl: qe: rename qe_ic_cascade_low_mpic -> qe_ic_cascade_low
      soc: fsl: qe: remove unused qe_ic_set_* functions
      soc: fsl: qe: don't use NO_IRQ in qe_ic.c
      soc: fsl: qe: make qe_ic_get_{low,high}_irq static
      soc: fsl: qe: simplify qe_ic_init()
      soc: fsl: qe: merge qe_ic.h headers into qe_ic.c
      soc: fsl: qe: qe.c: use of_property_read_* helpers
      soc: fsl: qe: qe_io.c: don't open-code of_parse_phandle()
      soc: fsl: qe: qe_io.c: access device tree property using be32_to_cpu
      soc: fsl: qe: qe_io.c: use of_property_read_u32() in par_io_init()
      soc: fsl: move cpm.h from powerpc/include/asm to include/soc/fsl
      soc/fsl/qe/qe.h: update include path for cpm.h
      serial: ucc_uart: explicitly include soc/fsl/cpm.h
      serial: ucc_uart: replace ppc-specific IO accessors
      serial: ucc_uart: factor out soft_uart initialization
      serial: ucc_uart: stub out soft_uart_init for !CONFIG_PPC32
      serial: ucc_uart: use of_property_read_u32() in ucc_uart_probe()
      serial: ucc_uart: limit brg-frequency workaround to PPC32
      serial: ucc_uart: access __be32 field using be32_to_cpu
      soc: fsl: qe: change return type of cpm_muram_alloc() to s32
      soc: fsl: qe: make cpm_muram_free() return void
      soc: fsl: qe: make cpm_muram_free() ignore a negative offset
      soc: fsl: qe: drop broken lazy call of cpm_muram_init()
      soc: fsl: qe: refactor cpm_muram_alloc_common to prevent BUG on error path
      soc: fsl: qe: avoid IS_ERR_VALUE in ucc_slow.c
      soc: fsl: qe: drop use of IS_ERR_VALUE in qe_sdma_init()
      soc: fsl: qe: drop pointless check in qe_sdma_init()
      soc: fsl: qe: avoid IS_ERR_VALUE in ucc_fast.c
      net/wan/fsl_ucc_hdlc: avoid use of IS_ERR_VALUE()
      net/wan/fsl_ucc_hdlc: fix reading of __be16 registers
      net/wan/fsl_ucc_hdlc: reject muram offsets above 64K
      net: ethernet: freescale: make UCC_GETH explicitly depend on PPC32
      soc: fsl: qe: remove unused #include of asm/irq.h from ucc.c
      soc: fsl: qe: remove PPC32 dependency from CONFIG_QUICC_ENGINE

YueHaibing (1):
      soc: fsl: qe: remove set but not used variable 'mm_gc'

 arch/powerpc/include/asm/cpm.h                | 172 +-----------
 arch/powerpc/platforms/83xx/km83xx.c          |   3 +-
 arch/powerpc/platforms/83xx/misc.c            |  23 --
 arch/powerpc/platforms/83xx/mpc832x_mds.c     |   3 +-
 arch/powerpc/platforms/83xx/mpc832x_rdb.c     |   3 +-
 arch/powerpc/platforms/83xx/mpc836x_mds.c     |   3 +-
 arch/powerpc/platforms/83xx/mpc836x_rdk.c     |   3 +-
 arch/powerpc/platforms/83xx/mpc83xx.h         |   7 -
 arch/powerpc/platforms/85xx/corenet_generic.c |  10 -
 arch/powerpc/platforms/85xx/mpc85xx_mds.c     |  27 --
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c     |  17 --
 arch/powerpc/platforms/85xx/twr_p102x.c       |  15 -
 drivers/net/ethernet/freescale/Kconfig        |   2 +-
 drivers/net/wan/fsl_ucc_hdlc.c                |  23 +-
 drivers/net/wan/fsl_ucc_hdlc.h                |   2 +-
 drivers/soc/fsl/qe/Kconfig                    |   3 +-
 drivers/soc/fsl/qe/gpio.c                     |  36 +--
 drivers/soc/fsl/qe/qe.c                       | 104 +++----
 drivers/soc/fsl/qe/qe_common.c                |  50 ++--
 drivers/soc/fsl/qe/qe_ic.c                    | 285 +++++++++----------
 drivers/soc/fsl/qe/qe_ic.h                    |  99 -------
 drivers/soc/fsl/qe/qe_io.c                    |  70 +++--
 drivers/soc/fsl/qe/qe_tdm.c                   |   8 +-
 drivers/soc/fsl/qe/ucc.c                      |  27 +-
 drivers/soc/fsl/qe/ucc_fast.c                 |  86 +++---
 drivers/soc/fsl/qe/ucc_slow.c                 |  60 ++--
 drivers/soc/fsl/qe/usb.c                      |   2 +-
 drivers/tty/serial/ucc_uart.c                 | 385 ++++++++++++++------------
 include/soc/fsl/cpm.h                         | 171 ++++++++++++
 include/soc/fsl/qe/qe.h                       |  59 ++--
 include/soc/fsl/qe/qe_ic.h                    | 135 ---------
 include/soc/fsl/qe/ucc_fast.h                 |   4 +-
 include/soc/fsl/qe/ucc_slow.h                 |   6 +-
 33 files changed, 775 insertions(+), 1128 deletions(-)
 delete mode 100644 drivers/soc/fsl/qe/qe_ic.h
 create mode 100644 include/soc/fsl/cpm.h
 delete mode 100644 include/soc/fsl/qe/qe_ic.h
