Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6FFC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC3A20661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbfCFPaT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 10:30:19 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36031 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbfCFPaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 10:30:19 -0500
Received: by mail-qt1-f193.google.com with SMTP id p25so13257238qtb.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 07:30:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=2iWqwxAzfzB07tvbxb7CfsHW7OVZS2V3CWESOQ+j7qc=;
        b=cxYN00o8EzJjB8Z6MTCYfk3OPxRNU6DB6g3iIQfxS7PxDpfR7c8T712ChrRk4iyakg
         si61IEoU0BCc2J8nR6pVpeGRGgoY0rGsGjLs4wQSJmjctySl+lGNSVEXqb6N82C3xlbO
         kXYWUX5WQuLGjOrQUF+tlNe83SHwTuASaCrOredhFz6zOQMJaCkrFoSMmWWh9rRBP2mn
         lvHppTEaEb+H4KxDShuTQw9TSZIjUk89RxyqwZget6pIVPwRbyJmpGBmfY7qExY+d+/E
         hDZj2NL55xwmF6aT+c+Yp4ON8ViH4krVgETXjTCQo7TiIkEg6ou+3MPZLw8fgWdJTjYQ
         x3cg==
X-Gm-Message-State: APjAAAXM5pgdSHseedPL5GK8RIcnZ9AnyNVdW2EzEg/X3890SHizi/RA
        BYndHUvd93SkIcliJsZ5r6/PdWE+K9Om6prULfE=
X-Google-Smtp-Source: APXvYqwBkH8yLGBHb+A/xQico8GquFlWwzuaobE5d2ZM1TQuimpQNlPbxoyCAuVwf+k17ZqYP6C9xmdnpumU4QEMTyM=
X-Received: by 2002:a0c:81ee:: with SMTP id 43mr6555862qve.180.1551886217822;
 Wed, 06 Mar 2019 07:30:17 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a37Nz0bWJx+Ly4Ttk-pZQ3birJaN+SLsJHgYVe=5wX0Vw@mail.gmail.com>
 <CAK8P3a2sgn3Ai8m_yLX1kHdWrXT3aUFRS5Gzzy5V0dAqMpdGBw@mail.gmail.com>
 <CAK8P3a0k4AgROH3UBd6hCyF=9VbbY2kDMGN=KnuLZ7tQV2aSOQ@mail.gmail.com>
 <CAK8P3a2eH2W1Tmt5t7qtnPyhmhqKCtSOhQa-ugFvFW+NGbQOAQ@mail.gmail.com>
 <CAK8P3a3s3AQhq57UQ_07hGVfpipxhdihUKH5EdYHX2=yhrY=6w@mail.gmail.com> <CAK8P3a0XTa6kBKzzTM3H+Xu=RRSJ2R-oi5=aydVrF-AE5=wpSw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 6 Mar 2019 16:30:00 +0100
Message-ID: <CAK8P3a01nxwLHDztQ-K8bLi0tz0QkwmmJvp+Raquqp_ikRrG6A@mail.gmail.com>
Subject: [GIT PULL 1/6] ARM: SoC platform updates for 5.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f17b5f06cb92ef2250513a1e154c47b78df07d40:

  Linux 5.0-rc4 (2019-01-27 15:18:05 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-soc

for you to fetch changes up to 49b35cd5e7ddad04ae2fac614cd26f29c4851957:

  MAINTAINERS: Update Ampere email address (2019-02-22 23:57:56 +0100)

----------------------------------------------------------------
ARM: SoC platform updates for 5.1

The APM X-Gene platform is now maintained by folks from Ampere
computing that took over the product line a while ago, this gets
reflected in the MAINTAINERS file.

Cleanups continue on the older mach-davinci and mach-pxa platform,
to get them to be more like the modern ones. For pxa, we
now remove the Raumfeld platform code as it now works with
device tree based booting.

i.MX adds a couple new features for the i.MX7ULP SoC

Mediatek gains support for a new SoC: MT7629 is a new wireless
router platform, following MT7623.

Aside from those, there are the usual minor cleanups and bugfixes
across several platforms.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Anson Huang (2):
      ARM: imx: add i.MX7ULP cpuidle support
      ARM: imx: add i.MX7ULP SoC revision support

Arnd Bergmann (11):
      Merge tag 'pxa-for-5.1' of https://github.com/rjarzmik/linux
into arm/fixes
      Merge tag 'imx-maintainers-5.1' of
git://git.kernel.org/.../shawnguo/linux into arm/fixes
      Merge tag 'imx-soc-5.1' of
git://git.kernel.org/.../shawnguo/linux into arm/fixes
      Merge tag 'davinci-for-v5.1/soc-part2' of
git://git.kernel.org/.../nsekhar/linux-davinci into arm/fixes
      Merge tag 'amlogic-soc' of
git://git.kernel.org/.../khilman/linux-amlogic into arm/fixes
      Merge tag 'samsung-soc-5.1' of
git://git.kernel.org/.../krzk/linux into arm/fixes
      Merge tag 'mvebu-arm64-5.1-1' of
git://git.infradead.org/linux-mvebu into arm/fixes
      Merge tag 'v5.0-next-soc' of
git://git.kernel.org/.../matthias.bgg/linux into arm/fixes
      Merge tag 'tegra-for-5.1-arm-core' of
git://git.kernel.org/.../tegra/linux into arm/fixes
      Merge tag 'renesas-arm-soc-for-v5.1' of
git://git.kernel.org/.../horms/renesas into arm/fixes
      Merge tag 'lpc32xx-soc-for-5.1' of
https://github.com/vzapolskiy/linux-lpc32xx into arm/fixes

Bartosz Golaszewski (20):
      ARM: davinci: da850-evm: remove dead MTD code
      ARM: davinci: mityomapl138: don't read the MAC address from machine code
      ARM: davinci: dm365-evm: use device properties for at24 eeprom
      ARM: davinci: da830-evm: use device properties for at24 eeprom
      ARM: davinci: dm644x-evm: use device properties for at24 eeprom
      ARM: davinci: dm646x-evm: use device properties for at24 eeprom
      ARM: davinci: sffsdr: fix the at24 eeprom device name
      ARM: davinci: sffsdr: use device properties for at24 eeprom
      ARM: davinci: remove dead code related to MAC address reading
      ARM: davinci: mityomapl138: use nvmem notifiers
      ARM: davinci: mityomapl138: use device properties for at24 eeprom
      ARM: davinci: da850-evm: use GPIO hogs instead of the legacy API
      usb: ohci-da8xx: add a new line after local variables
      usb: ohci-da8xx: add a helper pointer to &pdev->dev
      ARM: davinci: omapl138-hawk: use gpio lookup entries for usb gpios
      ARM: davinci: da830-evm: use gpio lookup entries for usb gpios
      usb: ohci-da8xx: add vbus and overcurrent gpios
      ARM: davinci: omapl138-hawk: remove legacy usb helpers
      ARM: davinci: da830-evm: remove legacy usb helpers
      usb: ohci-da8xx: remove unused callbacks from platform data

Brajeswar Ghosh (1):
      arch/arm/mach-ep93xx: Remove duplicate header

Daniel Mack (1):
      ARM: pxa: remove raumfeld board files and defconfig

Dmitry Osipenko (3):
      ARM: tegra: Fix missed EMC registers latching on resume from LP1
on Tegra30+
      ARM: tegra: Fix DRAM refresh-interval clobbering on resume from
LP1 on Tegra30
      ARM: tegra: Restore memory arbitration on resume from LP1 on Tegra30+

Fabio Estevam (1):
      MAINTAINERS: imx: Change Fabio's email address

Gustavo A. R. Silva (1):
      ARM: s3c24xx: Fix boolean expressions in osiris_dvs_notify

Jerome Brunet (3):
      arm64: meson: remove COMMON_CLK_AMLOGIC selection
      ARM: meson: remove COMMON_CLK_AMLOGIC selection
      arm64: meson: enable g12a clock controller

Khuong Dinh (1):
      MAINTAINERS: Update Ampere email address

Lucas Stach (2):
      arm64: imx8mq: select GPCv2 irqchip driver
      arm64: imx8mq: select PM support

Marek Vasut (1):
      ARM: shmobile: Fix R-Car Gen2 regulator quirk

Markus Elfring (1):
      ARM: lpc32xx: Delete an error message for a failed memory
allocation in lpc32xx_pm_enter()

Ryder Lee (2):
      Revert "ARM: mediatek: add MT7623a smp bringup code"
      arm: mediatek: add MT7629 smp bring up code

Simon Horman (1):
      ARM: shmobile: Add missing dts files to MAINTAINERS

Stefan Agner (1):
      ARM: imx: don't build ssi-fiq if not required

Stuart Menefy (1):
      ARM: exynos: Fix timeout when booting secondary CPUs

Uwe Kleine-König (1):
      MAINTAINERS: add all files matching "imx" and "mxs" to the IMX entry

Vladimir Vid (1):
      MAINTAINERS: Add entry for uDPU board

Vladimir Zapolskiy (3):
      ARM: pxa: remove unused empty mach/pxa25x-udc.h file
      ARM: lpc32xx: remove platform data of ARM PL180 SD/MMC controller
      ARM: lpc32xx: remove platform data of ARM PL111 LCD controller

Weiyi Lu (1):
      dt-bindings: soc: fix typo of MT8173 power dt-bindings

zhong jiang (1):
      ARM: lpc32xx: Use kmemdup to replace duplicating its implementation

 MAINTAINERS                                        |   44 +--
 arch/arm/configs/pxa_defconfig                     |    4 -
 arch/arm/configs/raumfeld_defconfig                |  197 ------------
 arch/arm/mach-davinci/board-da830-evm.c            |   86 +-----
 arch/arm/mach-davinci/board-da850-evm.c            |   50 +--
 arch/arm/mach-davinci/board-dm365-evm.c            |   13 +-
 arch/arm/mach-davinci/board-dm644x-evm.c           |   13 +-
 arch/arm/mach-davinci/board-dm646x-evm.c           |   13 +-
 arch/arm/mach-davinci/board-mityomapl138.c         |   38 +--
 arch/arm/mach-davinci/board-omapl138-hawk.c        |   81 +----
 arch/arm/mach-davinci/board-sffsdr.c               |   13 +-
 arch/arm/mach-davinci/common.c                     |   15 -
 arch/arm/mach-ep93xx/ts72xx.c                      |    1 -
 arch/arm/mach-exynos/platsmp.c                     |    4 +-
 arch/arm/mach-imx/Makefile                         |    3 +-
 arch/arm/mach-imx/common.h                         |   10 +
 arch/arm/mach-imx/cpuidle-imx7ulp.c                |   60 ++++
 arch/arm/mach-imx/cpuidle.h                        |    5 +
 arch/arm/mach-imx/mach-imx7ulp.c                   |   46 +++
 arch/arm/mach-imx/pm-imx7ulp.c                     |   49 ++-
 arch/arm/mach-lpc32xx/phy3250.c                    |   84 ------
 arch/arm/mach-lpc32xx/pm.c                         |   13 +-
 arch/arm/mach-mediatek/Kconfig                     |    4 +
 arch/arm/mach-mediatek/mediatek.c                  |    3 +-
 arch/arm/mach-mediatek/platsmp.c                   |    2 +-
 arch/arm/mach-meson/Kconfig                        |    1 -
 arch/arm/mach-pxa/Kconfig                          |   18 --
 arch/arm/mach-pxa/Makefile                         |    3 -
 arch/arm/mach-pxa/include/mach/pxa25x-udc.h        |    0
 arch/arm/mach-pxa/raumfeld.c                       | 1187
------------------------------------------------------------------------
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c            |    8 +-
 arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c |    5 +
 arch/arm/mach-tegra/iomap.h                        |    9 +
 arch/arm/mach-tegra/sleep-tegra20.S                |    2 -
 arch/arm/mach-tegra/sleep-tegra30.S                |   25 +-
 arch/arm64/Kconfig.platforms                       |    9 +-
 drivers/usb/host/ohci-da8xx.c                      |  118 ++++----
 include/dt-bindings/power/mt8173-power.h           |    6 +-
 include/linux/davinci_emac.h                       |    1 -
 include/linux/platform_data/usb-davinci.h          |   14 -
 40 files changed, 389 insertions(+), 1868 deletions(-)
 delete mode 100644 arch/arm/configs/raumfeld_defconfig
 create mode 100644 arch/arm/mach-imx/cpuidle-imx7ulp.c
 delete mode 100644 arch/arm/mach-pxa/include/mach/pxa25x-udc.h
 delete mode 100644 arch/arm/mach-pxa/raumfeld.c
