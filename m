Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2DCC00319
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C1C20675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfCEIHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 03:07:32 -0500
Received: from mout.gmx.net ([212.227.17.22]:56821 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfCEIHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 03:07:32 -0500
Received: from ls3530.dellerweb.de ([92.116.130.110]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MEKZg-1gleku28oC-00FOkL; Tue, 05 Mar 2019 09:07:24 +0100
Date:   Tue, 5 Mar 2019 09:07:21 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture updates for kernel v5.1
Message-ID: <20190305080721.GA15719@ls3530.dellerweb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Provags-ID: V03:K1:9OUymPM+Z7CE68WJEtmN9wahJmPkH/eRoe0r+H26kp/rCpenIes
 hvtCEg7o4tqBTe28abyMOVmdyqJ157xOS+/570q1gLoHAhrGzx/e1xVixRO5zQX+ke+Ziac
 tu18vAciftJxcJt249+eiwsZLyo744HQ/mOpi4kXVHvWgC5zrpn/JRNhQsBDQ82n4mgqw8E
 5GOqyAz+KuxG1Js5kH/Gg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xGW/N0LXc6E=:3EgIKKsCmVmu/zhVYFn7OK
 LaAfCU9dy9hiryLmqx0uVir91DqSTSyJlb7I1RL6W0RMGc1NxCfBwpyMQkt0PZkMgnpqpZkX1
 tr7KtrXCxrH/mA56xSSCSSzgNUfs+g410Jncz6FsVk/wIPjbA5f+dfhkkSY+9X3DnG2iQrK6L
 YdYZuSBFNdmFCN3uS7UkpcaRS8ZhV7UUx3ti9Sw7ImOdKcucq2XIIrN7fJZ5XhTzuW3UNXoY6
 P7v6xgX7CvcgA7RdsR73LztrvfGliFUMkSQxo/ETzuMr38RjIUNAp90+9In1+jx4aqDIhyz10
 R7z0NFt+iPSCW2YFyk/RUledqdnCwL16nyAu4vVHuM4QJDuKFmwKGJbIOab1MnMies1qOPRhr
 MadfQsvksWHOWf6BSfX+ejo36omw+kDvZxNMpqzENlXudcQAXnVaE25lvkIUFaj16AbyHwuOt
 b9i9WUxsFVMUucu5LhR2fUmcFy6PmGYbSkxDojXjMy2Wy5F54ANH+UF9/jD0MAGx43BDzBOdj
 RlrBGxS/eb5AduoXJYOVrvjPpcpBTaqAgFTMq5V47CjN+uM+2kMK3NERPYhLCxuqoYfFRruXV
 PNLkR3OcwVadnFVnvrEO+VgZjvMVMJOILO+ZNKlLxYkaPgzib6rySWaL1DxsnxDxnmfNRuLi3
 lGs9yzIDdvf7FrdkZzDT+eKaBK8wRg6P7k/d+5H0G3b2+ywHKRvgell/BUY0P9TbBFxl7XyCC
 zrE3z+emuEzSjtoZrTp2wgdIqNDsKkQEfl613lNg6vGHPeGJ5fkYFnGW8edHt0KdZkbeYgwdb
 TgwOCxi3gFTgPVYLxllEj3nxAd73lfGDEgralw2BitekuTRdXjSDZNFCQ4DkcOlr7b4EFxmWK
 9drL/gzkn9eM+ZeQau3aHLXxWMvXo+uwBwFSARPQyiW5e6ATI30p+m11A33gjk
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull parisc architecture fixes and updates for kernel 5.1:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.1-1

Most important changes in this patch set:
- DMA-related cleanups for parisc with the aim to move anything not required by
  drivers out of <asm/dma-mapping.h>, by Christoph Hellwig 
- Switch to memblock_alloc(), by Mike Rapoport
- Makefile cleanups by Masahiro Yamada
- Switch to bust_spinlocks(), by Sergey Senozhatsky
- Improved initial SMP affinity selection for IRQs
- Added IPI- and rescheduling interrupts in /proc/interrupts output

Thanks,
Helge

----------------------------------------------------------------
Christoph Hellwig (8):
      parisc: don't include <asm/cacheflush.h> in <asm/dma-mapping.h>
      parisc: move internal implementation details out of <asm/dma-mapping.h>
      parisc: turn GET_IOC into an inline function
      parisc: properly type the iommu field in struct pci_hba_data
      parisc: properly type the return value of parisc_walk_tree
      parisc/dino: use container_of in DINO_DEV
      parisc/lba_pci: use container_of in LBA_DEV
      parisc: remove the HBA_DATA macro

Helge Deller (9):
      parisc: Hide built-in serial aux port of Tosca GSP card
      parisc: Show rescheduling interrupts on SMP machines only
      parisc: Count IPI function call interrupts
      parisc: Improve initial IRQ to CPU assignment
      parisc: Use F_EXTEND() macro in iosapic code
      parisc: Add constants for PDC_RELOCATE PDC call
      parisc: Show machine product number during boot
      parisc: Add constant for PDC_PAT_COMPLEX firmware call
      parisc: Add constants for various PDC firmware calls

Masahiro Yamada (1):
      parisc: remove meaningless ccflags-y in arch/parisc/boot/Makefile

Mike Rapoport (1):
      parisc: use memblock_alloc() instead of custom get_memblock()

Sergey Senozhatsky (1):
      parisc: replace oops_in_progress manipulation with bust_spinlocks()

Sven Schnelle (1):
      parisc: Add PDC_CRASH_PREP PDC function number

 arch/parisc/boot/Makefile             |  6 ----
 arch/parisc/include/asm/dma-mapping.h | 46 -----------------------------
 arch/parisc/include/asm/hardirq.h     |  1 +
 arch/parisc/include/asm/pci.h         |  4 +--
 arch/parisc/include/asm/pdc.h         |  1 +
 arch/parisc/include/asm/pdcpat.h      |  4 +++
 arch/parisc/include/uapi/asm/pdc.h    | 26 +++++++++++++++--
 arch/parisc/kernel/firmware.c         | 24 +++++++++++++++
 arch/parisc/kernel/irq.c              | 19 ++++++++----
 arch/parisc/kernel/processor.c        |  9 ++++++
 arch/parisc/kernel/setup.c            |  1 +
 arch/parisc/kernel/smp.c              |  1 +
 arch/parisc/kernel/traps.c            |  4 +--
 arch/parisc/mm/init.c                 | 52 ++++++++++++---------------------
 drivers/parisc/ccio-dma.c             | 11 +++++--
 drivers/parisc/dino.c                 | 11 ++++---
 drivers/parisc/eisa.c                 |  2 ++
 drivers/parisc/hppb.c                 |  2 ++
 drivers/parisc/iommu.h                | 55 +++++++++++++++++++++++++++++++++++
 drivers/parisc/iosapic.c              | 17 +----------
 drivers/parisc/lba_pci.c              | 30 +++++++++++++------
 drivers/parisc/sba_iommu.c            |  2 ++
 22 files changed, 197 insertions(+), 131 deletions(-)
 create mode 100644 drivers/parisc/iommu.h
