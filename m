Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925DBC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B37920840
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfCFPiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 10:38:24 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35475 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCFPiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 10:38:24 -0500
Received: by mail-qk1-f194.google.com with SMTP id z13so7029957qki.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 07:38:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vb/51HfBRNvH5tlNql7v+bee6R5v2plRzp+9JvaJ5os=;
        b=fgLrnADRN5weRV8g5Hi2iDeHo76f1g05Hr+CCo9bt3SyNHA0y93nLxs7c+jvlV/zUo
         mybxTsV+T3R/uYhkwGvRnfwoQPip418Uktjgpt3ZQdaeNM+OWg/mDX+JFobXrlomFW7r
         giniWMjK23iP0CrbE868lm+vcmlgeAdvyzjRmbtjEIfczbyq4OTrfiNdVSRxdcyL040D
         xBa7fWTrHNSwPzueSnwq2DkrDnXXG53IoP8xfUr1y65t0ZMLQIFkmNSBCBDu5/su+WRq
         JV9xpZMOMsqB7Su7k5MDR4JG1WrznetVGGC7boLiQzUwtNwY6+w55g0Z3iSG/Lms3hZk
         Rc5Q==
X-Gm-Message-State: APjAAAVPQGDYRe4Tpwxn0k8SuvkkpsBh0xJqnDqbN1TBtvKtuAKzb/xZ
        e2MFxhCKbQx3wpsDhXPtcDXo846DoaEJjuVMF1+M60Bx
X-Google-Smtp-Source: APXvYqzraQrDz6klirIWQ6N0kDyca8I5mFa2H+ZApKjtg8F10n6MOBpz06COiOd1nBJr6/mihpptmvdvA0sJMGD2r7s=
X-Received: by 2002:a37:8dc5:: with SMTP id p188mr5996763qkd.330.1551886702857;
 Wed, 06 Mar 2019 07:38:22 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a1mnNrpf5moqi4x9BaTNpE9ZUgs-VBjXoG7=AxENwYtbQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1mnNrpf5moqi4x9BaTNpE9ZUgs-VBjXoG7=AxENwYtbQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 6 Mar 2019 16:38:06 +0100
Message-ID: <CAK8P3a3Daeqb3hfYvR0P=mjyONZVavfMbK8As8X5G+n4+k6sSQ@mail.gmail.com>
Subject: [GIT PULL 6/6] ARM: SoC late updates for 5.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f17b5f06cb92ef2250513a1e154c47b78df07d40:

  Linux 5.0-rc4 (2019-01-27 15:18:05 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-late

for you to fetch changes up to 2547635054af399303f8b91292ea121e13b84bb1:

  Merge tag 'omap-for-v5.1/cpsw-signed' of
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into
arm/late (2019-02-22 22:13:46 +0100)

----------------------------------------------------------------
ARM: SoC: late updates for 5.1

Here are two branches that came relatively late during the linux-5.0
development cycle and have dependencies on the other branches:

- On the TI OMAP platform, the CPSW Ethernet PHY mode selection driver
  is being replaced, this puts the final pieces in place

- On the DaVinci platform, the interrupt handling code in arch/arm
  gets moved into a regular device driver in drivers/irqchip.

Since they both had some time in linux-next after the 5.0-rc8
release, I'm sending them along with the other updates.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------

Arnd Bergmann (3):
      Merge tag 'davinci-for-v5.1/soc-part3' of
git://git.kernel.org/.../nsekhar/linux-davinci into arm/late
      Merge tag 'omap-for-v5.1/cpsw-signed' of
git://git.kernel.org/.../tmlind/linux-omap into arm/late
      Merge tag 'armsoc-late' into HEAD

Bartosz Golaszewski (37):
      input: davinci_keyscan: remove unnecessary includes
      ARM: davinci: remove intc_host_map from davinci_soc_info struct
      ARM: davinci: aintc: use irq domain
      ARM: davinci: select GENERIC_IRQ_MULTI_HANDLER
      ARM: davinci: remove davinci_intc_type
      ARM: davinci: pull davinci_intc_base into the respective intc drivers
      ARM: davinci: wrap HW interrupt numbers with a macro
      ARM: davinci: select SPARSE_IRQ
      ARM: davinci: make irqs.h a local header
      ARM: davinci: aintc: drop GPL license boilerplate
      ARM: davinci: aintc: wrap davinci_irq_init() with a helper
      ARM: davinci: aintc: use a common prefix for symbols in the driver
      ARM: davinci: aintc: drop the 00 prefix from register offsets
      ARM: davinci: aintc: use writel_relaxed()
      irqchip: davinci-aintc: add a new config structure
      ARM: davinci: aintc: use the new irqchip config structure in dm* SoCs
      ARM: davinci: aintc: use the new config structure
      ARM: davinci: aintc: unify error handling
      ARM: davinci: aintc: request memory region before remapping it
      ARM: davinci: aintc: remove the timer-specific irq_set_handler()
      ARM: davinci: aintc: remove unnecessary includes
      irqchip: davinci-aintc: move the driver to drivers/irqchip
      ARM: davinci: cp-intc: remove cp_intc.h
      ARM: davinci: cp-intc: add a wrapper around cp_intc_init()
      irqchip: davinci-cp-intc: add a new config structure
      ARM: davinci: cp-intc: add the new config structures for da8xx SoCs
      ARM: davinci: cp-intc: use a common prefix for all symbols
      ARM: davinci: cp-intc: convert all hex numbers to lowercase
      ARM: davinci: cp-intc: use the new-style config structure
      ARM: davinci: cp-intc: request the memory region before remapping it
      ARM: davinci: cp-intc: improve coding style
      ARM: davinci: cp-intc: unify error handling
      ARM: davinci: cp-intc: use readl/writel_relaxed()
      ARM: davinci: cp-intc: drop GPL license boilerplate
      ARM: davinci: cp-intc: remove redundant comments
      irqchip: davinci-cp-intc: move the driver to drivers/irqchip
      ARM: davinci: remove intc related fields from davinci_soc_info

Grygorii Strashko (1):
      net: ethernet: ti: cpsw: deprecate cpsw-phy-sel driver

 arch/arm/Kconfig                                 |   2 +
 arch/arm/mach-davinci/Kconfig                    |  19 ++----
 arch/arm/mach-davinci/Makefile                   |   3 -
 arch/arm/mach-davinci/asp.h                      |   8 +--
 arch/arm/mach-davinci/board-da830-evm.c          |   5 +-
 arch/arm/mach-davinci/board-da850-evm.c          |   5 +-
 arch/arm/mach-davinci/board-dm355-evm.c          |   2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c      |   2 +-
 arch/arm/mach-davinci/board-dm365-evm.c          |   2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c         |   8 ++-
 arch/arm/mach-davinci/board-dm646x-evm.c         |   6 +-
 arch/arm/mach-davinci/board-mityomapl138.c       |   3 +-
 arch/arm/mach-davinci/board-neuros-osd2.c        |   2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c      |   3 +-
 arch/arm/mach-davinci/board-sffsdr.c             |   2 +-
 arch/arm/mach-davinci/common.c                   |   3 -
 arch/arm/mach-davinci/cp_intc.c                  | 215
--------------------------------------------------------------
 arch/arm/mach-davinci/cp_intc.h                  |  57 -----------------
 arch/arm/mach-davinci/da830.c                    | 128
+++++++------------------------------
 arch/arm/mach-davinci/da850.c                    | 154
+++++++++-----------------------------------
 arch/arm/mach-davinci/davinci.h                  |   4 ++
 arch/arm/mach-davinci/devices-da8xx.c            | 147
+++++++++++++++++++++---------------------
 arch/arm/mach-davinci/devices.c                  |  40 ++++++------
 arch/arm/mach-davinci/dm355.c                    |  78 +++++++++++++----------
 arch/arm/mach-davinci/dm365.c                    | 102
+++++++++++++++++-------------
 arch/arm/mach-davinci/dm644x.c                   |  68 ++++++++++++--------
 arch/arm/mach-davinci/dm646x.c                   |  82 ++++++++++++++----------
 arch/arm/mach-davinci/include/mach/common.h      |  14 ++--
 arch/arm/mach-davinci/include/mach/da8xx.h       |   2 +
 arch/arm/mach-davinci/include/mach/entry-macro.S |  39 ------------
 arch/arm/mach-davinci/irq.c                      | 117
----------------------------------
 arch/arm/mach-davinci/{include/mach => }/irqs.h  |   4 --
 arch/arm/mach-davinci/usb-da8xx.c                |   9 +--
 arch/arm/mach-davinci/usb.c                      |  15 +++--
 drivers/input/keyboard/davinci_keyscan.c         |   4 --
 drivers/irqchip/Kconfig                          |  10 +++
 drivers/irqchip/Makefile                         |   2 +
 drivers/irqchip/irq-davinci-aintc.c              | 163
+++++++++++++++++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-davinci-cp-intc.c            | 260
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ethernet/ti/Kconfig                  |   6 +-
 drivers/net/ethernet/ti/cpsw.h                   |   6 ++
 include/linux/irqchip/irq-davinci-aintc.h        |  27 ++++++++
 include/linux/irqchip/irq-davinci-cp-intc.h      |  25 ++++++++
 43 files changed, 889 insertions(+), 964 deletions(-)
