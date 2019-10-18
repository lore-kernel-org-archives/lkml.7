Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EF4CA9EAB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFAD20872
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437127AbfJRQY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:24:26 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:44613 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395015AbfJRQY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:24:26 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MF35K-1iEtKs2TzE-00FPZj; Fri, 18 Oct 2019 18:24:02 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hubert Feurstein <hubert.feurstein@contec.at>,
        Lukasz Majewski <lukma@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Alexander Clouter <alex@digriz.org.uk>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 0/6] ARM: platform cleanup
Date:   Fri, 18 Oct 2019 18:23:35 +0200
Message-Id: <20191018162352.1283488-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pwjVgFC5TjKAp7cp6Lgy64vAycWP1S0XmL7dk93RJ9zvculJrgH
 rqMdTKxbQnryZXqiP2ynJByYBuPfWZKpr8SGhFRFSeU4r7/+N+U0BLjtCLqYEGtE3STdOat
 JwLn7H7+ecHTzPUE/vUPQ+cCqSDv3zBcG91KfepqBfV1jV25ttvttXgIpDIOR07OGNsERDl
 TZUkLmJPGHRqM8wrVM10Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qm+suhRpTbQ=:XtRN7qg3xIxI0QA5cssIb+
 DvUyxstGvqWb7XdmFmNy0y78vbgvP/8eIoHCC6Hqa94U4xknc0DQ7Sl89mKruIGQjA0R3aJSU
 OMtAmRRT5zLqHZ/ueCXTUqM6ldFt3RZ1SEUAWpJ7pwgMTW8vb2T9B6B2dNnXykOif73Cdko+x
 D+rOq0s9w97XpUok4WtNTgPVX3dLQOQuMrqOQfEBVzF1+N0iwgNUh9+QDLZeNp3nf9RvMd6ZZ
 NzsGe4XbCyqrYU+1bKwa/lmNor2MLxOaAdRrkIugkgpJ9oKekO+GsydXf7ak17pNTWcZ4HD/U
 9h5GO9LMrHjBVQVtrRzZZtfXULbL7tJ8Sb+3Q+vB+Nf65uxMR9mzKX727oP5nU/kMvTJftfEe
 SnhbTrTEuqwE8lb9Js384mh9z67mNmG59mrNiWDzRhHgSokU+FN01C38j7CwSu/jd1ZpUtPaK
 zRIls1leiJcicoRiqdPIXEmAujpHnUAYFuJZaSvjHM/ZcmpE6Nnc6/lTBI+EdoprjFAovZJNu
 0C+HlndkPhse9wR8eUjEqi3nQGfJJp6EyiPbJ/c9Yh2CJRodm9HKdpXETwCWVyKVoUOB56sQ2
 WO64613EhaD7cZYY7c9Ycojy35cPD/vfX5JKu2s+vgHWdO0CgKzDqj308NPxlYhDf2t84aTxF
 H2Y+EpTbviJ2rXlbmoODpxi8LUFBnpic8ZI+rADFlHg5TLiu26yAAla9s6Qc0Qd2iI1EttdBA
 eA0Q+WTDLzFKSxn5xEhPq9i2VLw17LGT6SdJ2vX8ZqrFT3/NO+xOprh/XzUg0zn2UCSR70KAu
 zPwzsPl2q2aN2DDASOeTtZzrpstqgV1XS+ZImNzX28lWxGCQV4aV6l6icq12WULXZMjiLIIFA
 0Ztov1cvIS3joM3U8N7g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some patches that didn't fit in any of the other series:

- Moving dove into multiplatform completes that conversion,
  this was missing as of a few years ago

- On ep93xx, the irqchip and clk drivers need to use the
  common frameworks, this one adapts the irqchip one

- the plat-orion and plat-versatile directories are no
  longer useful since the contents of the
  mach-{versatile,realview,integrator,vexpress} and
  mach-{orion5k,mv78xx0,dove} directories are rather
  small anyway and they can be classified as a single
  platform each.
  
  I have other patches to kill off the plat-samsung,
  plat-pxa and plat-omap directories, by moving the
  contents of those directories elsewhere. After that,
  we no longer need mach/*.h headers to be visible
  from plat-* directories.

     Arnd

Cc: Russell King <linux@armlinux.org.uk>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Hubert Feurstein <hubert.feurstein@contec.at>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: Alexander Clouter <alex@digriz.org.uk>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Arnd Bergmann (6):
  ARM: versatile: move integrator/realview/vexpress to versatile
  ARM: ep93xx: enable SPARSE_IRQ
  ARM: ep93xx: make mach/ep93xx-regs.h local
  ARM: dove: multiplatform support
  ARM: orion/mv78xx0/dove: move to a common directory
  ARM: orion: unify Makefile/Kconfig files

 MAINTAINERS                                   |   7 +-
 arch/arm/Kconfig                              |  42 +-
 arch/arm/Makefile                             |  12 +-
 arch/arm/configs/dove_defconfig               |   2 +
 arch/arm/mach-dove/Kconfig                    |  26 --
 arch/arm/mach-dove/Makefile                   |   6 -
 arch/arm/mach-dove/include/mach/uncompress.h  |  34 --
 arch/arm/mach-ep93xx/adssphere.c              |   1 +
 arch/arm/mach-ep93xx/crunch-bits.S            |   2 +-
 arch/arm/mach-ep93xx/edb93xx.c                |   8 +
 .../{include/mach => }/ep93xx-regs.h          |   4 -
 arch/arm/mach-ep93xx/gesbc9312.c              |   1 +
 arch/arm/mach-ep93xx/gpio-ep93xx.h            |   2 +-
 .../arm/mach-ep93xx/include/mach/uncompress.h |   1 -
 .../arm/mach-ep93xx/{include/mach => }/irqs.h |   7 -
 arch/arm/mach-ep93xx/micro9.c                 |   4 +
 arch/arm/mach-ep93xx/simone.c                 |   1 +
 arch/arm/mach-ep93xx/snappercl15.c            |   1 +
 arch/arm/mach-ep93xx/soc.h                    |   3 +-
 arch/arm/mach-ep93xx/ts72xx.c                 |   3 +-
 arch/arm/mach-ep93xx/vision_ep9307.c          |   1 +
 arch/arm/mach-integrator/Kconfig              | 161 --------
 arch/arm/mach-integrator/Makefile             |  11 -
 arch/arm/mach-mv78xx0/Kconfig                 |  34 --
 arch/arm/mach-mv78xx0/Makefile                |   7 -
 arch/arm/{mach-orion5x => mach-orion}/Kconfig |  74 +++-
 arch/arm/mach-orion/Makefile                  |  45 +++
 .../{mach-dove => mach-orion}/Makefile.boot   |   0
 .../include/plat => mach-orion}/addr-map.h    |   2 -
 .../board-d2net.c                             |   6 +-
 .../{mach-orion5x => mach-orion}/board-dt.c   |  10 +-
 .../{mach-orion5x => mach-orion}/board-mss2.c |   4 +-
 .../board-rd88f5182.c                         |   4 +-
 .../buffalo-wxl-setup.c                       |   6 +-
 arch/arm/{mach-dove => mach-orion}/cm-a510.c  |   4 +-
 arch/arm/{plat-orion => mach-orion}/common.c  |   4 +-
 .../include/plat => mach-orion}/common.h      |   2 -
 .../db78x00-bp-setup.c                        |   4 +-
 .../db88f5281-setup.c                         |   6 +-
 .../dns323-setup.c                            |   8 +-
 .../dove-bridge-regs.h}                       |   0
 .../common.c => mach-orion/dove-common.c}     |  13 +-
 .../common.h => mach-orion/dove-common.h}     |   2 -
 .../{mach-dove => mach-orion}/dove-db-setup.c |   4 +-
 .../irq.c => mach-orion/dove-irq.c}           |  12 +-
 .../irqs.h => mach-orion/dove-irqs.h}         |   0
 .../mpp.c => mach-orion/dove-mpp.c}           |   8 +-
 .../mpp.h => mach-orion/dove-mpp.h}           |   0
 .../pcie.c => mach-orion/dove-pcie.c}         |  12 +-
 .../{mach-dove/pm.h => mach-orion/dove-pm.h}  |   2 +-
 arch/arm/{mach-dove => mach-orion}/dove.h     |   2 +-
 arch/arm/{plat-orion => mach-orion}/gpio.c    |   4 +-
 arch/arm/{plat-orion => mach-orion}/irq.c     |   6 +-
 .../include/plat => mach-orion}/irq.h         |   2 -
 .../kurobox_pro-setup.c                       |   6 +-
 .../ls_hgl-setup.c                            |   6 +-
 arch/arm/{plat-orion => mach-orion}/mpp.c     |   6 +-
 .../include/plat => mach-orion}/mpp.h         |   2 -
 .../mv2120-setup.c                            |   4 +-
 .../mv78xx0-bridge-regs.h}                    |   0
 .../common.c => mach-orion/mv78xx0-common.c}  |  12 +-
 .../common.h => mach-orion/mv78xx0-common.h}  |   2 -
 .../irq.c => mach-orion/mv78xx0-irq.c}        |  10 +-
 .../irqs.h => mach-orion/mv78xx0-irqs.h}      |   0
 .../mpp.c => mach-orion/mv78xx0-mpp.c}        |   8 +-
 .../mpp.h => mach-orion/mv78xx0-mpp.h}        |   3 +-
 .../pcie.c => mach-orion/mv78xx0-pcie.c}      |   6 +-
 .../{mach-mv78xx0 => mach-orion}/mv78xx0.h    |   2 +-
 .../net2big-setup.c                           |   8 +-
 .../include/plat => mach-orion}/orion-gpio.h  |   2 -
 .../orion5x-bridge-regs.h}                    |   0
 .../common.h => mach-orion/orion5x-common.h}  |   0
 .../irq.c => mach-orion/orion5x-irq.c}        |  10 +-
 .../irqs.h => mach-orion/orion5x-irqs.h}      |   0
 .../mpp.c => mach-orion/orion5x-mpp.c}        |   8 +-
 .../mpp.h => mach-orion/orion5x-mpp.h}        |   0
 .../pci.c => mach-orion/orion5x-pci.c}        |   8 +-
 .../common.c => mach-orion/orion5x.c}         |  10 +-
 .../{mach-orion5x => mach-orion}/orion5x.h    |   2 +-
 arch/arm/{plat-orion => mach-orion}/pcie.c    |   6 +-
 .../include/plat => mach-orion}/pcie.h        |   2 -
 .../rd78x00-masa-setup.c                      |   4 +-
 .../rd88f5181l-fxo-setup.c                    |   6 +-
 .../rd88f5181l-ge-setup.c                     |   6 +-
 .../rd88f5182-setup.c                         |   6 +-
 .../rd88f6183ap-ge-setup.c                    |   4 +-
 .../terastation_pro2-setup.c                  |   4 +-
 arch/arm/{plat-orion => mach-orion}/time.c    |   4 +-
 .../include/plat => mach-orion}/time.h        |   2 -
 .../ts209-setup.c                             |   4 +-
 .../ts409-setup.c                             |   4 +-
 .../ts78xx-fpga.h                             |   0
 .../ts78xx-setup.c                            |   6 +-
 .../tsx09-common.c                            |   4 +-
 .../tsx09-common.h                            |   0
 .../wnr854t-setup.c                           |   6 +-
 .../wrt350n-v2-setup.c                        |   6 +-
 arch/arm/mach-orion5x/Makefile                |  26 --
 arch/arm/mach-realview/Kconfig                | 113 ------
 arch/arm/mach-realview/Makefile               |   8 -
 arch/arm/mach-versatile/Kconfig               | 360 ++++++++++++++++++
 arch/arm/mach-versatile/Makefile              |  34 +-
 .../Makefile.boot                             |   0
 .../{mach-integrator => mach-versatile}/cm.h  |   0
 .../common.h                                  |   0
 .../core.c                                    |   2 -
 .../{mach-vexpress => mach-versatile}/core.h  |   0
 .../{mach-vexpress => mach-versatile}/dcscb.c |   2 +-
 .../dcscb_setup.S                             |   2 -
 .../hardware.h                                |   0
 .../headsmp.S                                 |   2 -
 .../hotplug.c                                 |   2 +-
 .../impd1.c                                   |   2 -
 .../impd1.h                                   |   0
 .../integrator_ap.c                           |   2 -
 .../integrator_cp.c                           |   2 -
 .../{mach-integrator => mach-versatile}/lm.c  |   2 -
 .../{mach-integrator => mach-versatile}/lm.h  |   0
 .../platsmp-realview.c}                       |   2 +-
 .../platsmp-vexpress.c}                       |   5 +-
 .../platsmp.c                                 |   4 +-
 .../include/plat => mach-versatile}/platsmp.h |   2 -
 .../realview-dt.c                             |   0
 .../sched-clock.c                             |   4 +-
 .../plat => mach-versatile}/sched_clock.h     |   0
 .../{mach-vexpress => mach-versatile}/spc.c   |   0
 .../{mach-vexpress => mach-versatile}/spc.h   |   0
 .../tc2_pm.c                                  |   2 -
 .../v2m-mps2.c                                |   0
 .../{mach-vexpress => mach-versatile}/v2m.c   |   0
 arch/arm/mach-vexpress/Kconfig                |  84 ----
 arch/arm/mach-vexpress/Makefile               |  19 -
 arch/arm/plat-orion/Makefile                  |   9 -
 arch/arm/plat-versatile/Kconfig               |   7 -
 arch/arm/plat-versatile/Makefile              |   6 -
 135 files changed, 657 insertions(+), 862 deletions(-)
 delete mode 100644 arch/arm/mach-dove/Kconfig
 delete mode 100644 arch/arm/mach-dove/Makefile
 delete mode 100644 arch/arm/mach-dove/include/mach/uncompress.h
 rename arch/arm/mach-ep93xx/{include/mach => }/ep93xx-regs.h (94%)
 rename arch/arm/mach-ep93xx/{include/mach => }/irqs.h (94%)
 delete mode 100644 arch/arm/mach-integrator/Kconfig
 delete mode 100644 arch/arm/mach-integrator/Makefile
 delete mode 100644 arch/arm/mach-mv78xx0/Kconfig
 delete mode 100644 arch/arm/mach-mv78xx0/Makefile
 rename arch/arm/{mach-orion5x => mach-orion}/Kconfig (75%)
 create mode 100644 arch/arm/mach-orion/Makefile
 rename arch/arm/{mach-dove => mach-orion}/Makefile.boot (100%)
 rename arch/arm/{plat-orion/include/plat => mach-orion}/addr-map.h (96%)
 rename arch/arm/{mach-orion5x => mach-orion}/board-d2net.c (97%)
 rename arch/arm/{mach-orion5x => mach-orion}/board-dt.c (94%)
 rename arch/arm/{mach-orion5x => mach-orion}/board-mss2.c (97%)
 rename arch/arm/{mach-orion5x => mach-orion}/board-rd88f5182.c (97%)
 rename arch/arm/{mach-mv78xx0 => mach-orion}/buffalo-wxl-setup.c (97%)
 rename arch/arm/{mach-dove => mach-orion}/cm-a510.c (97%)
 rename arch/arm/{plat-orion => mach-orion}/common.c (99%)
 rename arch/arm/{plat-orion/include/plat => mach-orion}/common.h (98%)
 rename arch/arm/{mach-mv78xx0 => mach-orion}/db78x00-bp-setup.c (97%)
 rename arch/arm/{mach-orion5x => mach-orion}/db88f5281-setup.c (99%)
 rename arch/arm/{mach-orion5x => mach-orion}/dns323-setup.c (99%)
 rename arch/arm/{mach-dove/bridge-regs.h => mach-orion/dove-bridge-regs.h} (100%)
 rename arch/arm/{mach-dove/common.c => mach-orion/dove-common.c} (98%)
 rename arch/arm/{mach-dove/common.h => mach-orion/dove-common.h} (97%)
 rename arch/arm/{mach-dove => mach-orion}/dove-db-setup.c (97%)
 rename arch/arm/{mach-dove/irq.c => mach-orion/dove-irq.c} (92%)
 rename arch/arm/{mach-dove/irqs.h => mach-orion/dove-irqs.h} (100%)
 rename arch/arm/{mach-dove/mpp.c => mach-orion/dove-mpp.c} (97%)
 rename arch/arm/{mach-dove/mpp.h => mach-orion/dove-mpp.h} (100%)
 rename arch/arm/{mach-dove/pcie.c => mach-orion/dove-pcie.c} (97%)
 rename arch/arm/{mach-dove/pm.h => mach-orion/dove-pm.h} (99%)
 rename arch/arm/{mach-dove => mach-orion}/dove.h (99%)
 rename arch/arm/{plat-orion => mach-orion}/gpio.c (99%)
 rename arch/arm/{plat-orion => mach-orion}/irq.c (92%)
 rename arch/arm/{plat-orion/include/plat => mach-orion}/irq.h (88%)
 rename arch/arm/{mach-orion5x => mach-orion}/kurobox_pro-setup.c (99%)
 rename arch/arm/{mach-orion5x => mach-orion}/ls_hgl-setup.c (98%)
 rename arch/arm/{plat-orion => mach-orion}/mpp.c (95%)
 rename arch/arm/{plat-orion/include/plat => mach-orion}/mpp.h (95%)
 rename arch/arm/{mach-orion5x => mach-orion}/mv2120-setup.c (99%)
 rename arch/arm/{mach-mv78xx0/bridge-regs.h => mach-orion/mv78xx0-bridge-regs.h} (100%)
 rename arch/arm/{mach-mv78xx0/common.c => mach-orion/mv78xx0-common.c} (98%)
 rename arch/arm/{mach-mv78xx0/common.h => mach-orion/mv78xx0-common.h} (97%)
 rename arch/arm/{mach-mv78xx0/irq.c => mach-orion/mv78xx0-irq.c} (93%)
 rename arch/arm/{mach-mv78xx0/irqs.h => mach-orion/mv78xx0-irqs.h} (100%)
 rename arch/arm/{mach-mv78xx0/mpp.c => mach-orion/mv78xx0-mpp.c} (91%)
 rename arch/arm/{mach-mv78xx0/mpp.h => mach-orion/mv78xx0-mpp.h} (99%)
 rename arch/arm/{mach-mv78xx0/pcie.c => mach-orion/mv78xx0-pcie.c} (98%)
 rename arch/arm/{mach-mv78xx0 => mach-orion}/mv78xx0.h (99%)
 rename arch/arm/{mach-orion5x => mach-orion}/net2big-setup.c (99%)
 rename arch/arm/{plat-orion/include/plat => mach-orion}/orion-gpio.h (94%)
 rename arch/arm/{mach-orion5x/bridge-regs.h => mach-orion/orion5x-bridge-regs.h} (100%)
 rename arch/arm/{mach-orion5x/common.h => mach-orion/orion5x-common.h} (100%)
 rename arch/arm/{mach-orion5x/irq.c => mach-orion/orion5x-irq.c} (89%)
 rename arch/arm/{mach-orion5x/irqs.h => mach-orion/orion5x-irqs.h} (100%)
 rename arch/arm/{mach-orion5x/mpp.c => mach-orion/orion5x-mpp.c} (92%)
 rename arch/arm/{mach-orion5x/mpp.h => mach-orion/orion5x-mpp.h} (100%)
 rename arch/arm/{mach-orion5x/pci.c => mach-orion/orion5x-pci.c} (99%)
 rename arch/arm/{mach-orion5x/common.c => mach-orion/orion5x.c} (99%)
 rename arch/arm/{mach-orion5x => mach-orion}/orion5x.h (99%)
 rename arch/arm/{plat-orion => mach-orion}/pcie.c (98%)
 rename arch/arm/{plat-orion/include/plat => mach-orion}/pcie.h (96%)
 rename arch/arm/{mach-mv78xx0 => mach-orion}/rd78x00-masa-setup.c (96%)
 rename arch/arm/{mach-orion5x => mach-orion}/rd88f5181l-fxo-setup.c (98%)
 rename arch/arm/{mach-orion5x => mach-orion}/rd88f5181l-ge-setup.c (98%)
 rename arch/arm/{mach-orion5x => mach-orion}/rd88f5182-setup.c (98%)
 rename arch/arm/{mach-orion5x => mach-orion}/rd88f6183ap-ge-setup.c (97%)
 rename arch/arm/{mach-orion5x => mach-orion}/terastation_pro2-setup.c (99%)
 rename arch/arm/{plat-orion => mach-orion}/time.c (99%)
 rename arch/arm/{plat-orion/include/plat => mach-orion}/time.h (90%)
 rename arch/arm/{mach-orion5x => mach-orion}/ts209-setup.c (99%)
 rename arch/arm/{mach-orion5x => mach-orion}/ts409-setup.c (99%)
 rename arch/arm/{mach-orion5x => mach-orion}/ts78xx-fpga.h (100%)
 rename arch/arm/{mach-orion5x => mach-orion}/ts78xx-setup.c (99%)
 rename arch/arm/{mach-orion5x => mach-orion}/tsx09-common.c (97%)
 rename arch/arm/{mach-orion5x => mach-orion}/tsx09-common.h (100%)
 rename arch/arm/{mach-orion5x => mach-orion}/wnr854t-setup.c (98%)
 rename arch/arm/{mach-orion5x => mach-orion}/wrt350n-v2-setup.c (98%)
 delete mode 100644 arch/arm/mach-orion5x/Makefile
 delete mode 100644 arch/arm/mach-realview/Kconfig
 delete mode 100644 arch/arm/mach-realview/Makefile
 rename arch/arm/{mach-vexpress => mach-versatile}/Makefile.boot (100%)
 rename arch/arm/{mach-integrator => mach-versatile}/cm.h (100%)
 rename arch/arm/{mach-integrator => mach-versatile}/common.h (100%)
 rename arch/arm/{mach-integrator => mach-versatile}/core.c (97%)
 rename arch/arm/{mach-vexpress => mach-versatile}/core.h (100%)
 rename arch/arm/{mach-vexpress => mach-versatile}/dcscb.c (98%)
 rename arch/arm/{mach-vexpress => mach-versatile}/dcscb_setup.S (95%)
 rename arch/arm/{mach-integrator => mach-versatile}/hardware.h (100%)
 rename arch/arm/{plat-versatile => mach-versatile}/headsmp.S (94%)
 rename arch/arm/{plat-versatile => mach-versatile}/hotplug.c (98%)
 rename arch/arm/{mach-integrator => mach-versatile}/impd1.c (99%)
 rename arch/arm/{mach-integrator => mach-versatile}/impd1.h (100%)
 rename arch/arm/{mach-integrator => mach-versatile}/integrator_ap.c (98%)
 rename arch/arm/{mach-integrator => mach-versatile}/integrator_cp.c (98%)
 rename arch/arm/{mach-integrator => mach-versatile}/lm.c (97%)
 rename arch/arm/{mach-integrator => mach-versatile}/lm.h (100%)
 rename arch/arm/{mach-realview/platsmp-dt.c => mach-versatile/platsmp-realview.c} (98%)
 rename arch/arm/{mach-vexpress/platsmp.c => mach-versatile/platsmp-vexpress.c} (96%)
 rename arch/arm/{plat-versatile => mach-versatile}/platsmp.c (97%)
 rename arch/arm/{plat-versatile/include/plat => mach-versatile}/platsmp.h (87%)
 rename arch/arm/{mach-realview => mach-versatile}/realview-dt.c (100%)
 rename arch/arm/{plat-versatile => mach-versatile}/sched-clock.c (86%)
 rename arch/arm/{plat-versatile/include/plat => mach-versatile}/sched_clock.h (100%)
 rename arch/arm/{mach-vexpress => mach-versatile}/spc.c (100%)
 rename arch/arm/{mach-vexpress => mach-versatile}/spc.h (100%)
 rename arch/arm/{mach-vexpress => mach-versatile}/tc2_pm.c (99%)
 rename arch/arm/{mach-vexpress => mach-versatile}/v2m-mps2.c (100%)
 rename arch/arm/{mach-vexpress => mach-versatile}/v2m.c (100%)
 delete mode 100644 arch/arm/mach-vexpress/Kconfig
 delete mode 100644 arch/arm/mach-vexpress/Makefile
 delete mode 100644 arch/arm/plat-orion/Makefile
 delete mode 100644 arch/arm/plat-versatile/Kconfig
 delete mode 100644 arch/arm/plat-versatile/Makefile

-- 
2.20.0

