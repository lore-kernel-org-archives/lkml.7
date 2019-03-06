Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF181C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852C820840
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbfCFPf2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 10:35:28 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46043 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCFPf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 10:35:27 -0500
Received: by mail-qt1-f193.google.com with SMTP id d18so13248334qtg.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 07:35:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C44dV1LLE+sDJe4B4ets0h5dOkzQfklkA1FAWBOmCl4=;
        b=VpE58r4cY8zNHusbPBf+jw5cR46aocZpB9nZkDi5JFvi7e5pd9W5yeiwzMtXhj1kRZ
         ujmBEpuBw/uDijkbO+aF8Bz5DEncMC7SfzHV1UuBTVwcH1FGmxrTdwhmPu4oUmGNzQkT
         CWpsjHW1FkR/B4fJreu4v7hnMt2ejOGNW39CHWdvphZnPGK+RcNgLKYgLkihVM79n7/S
         WAqh5kWJ/l1CEKCpFq2BC8vthWlUU+mAXz5iLo+pXQHgt8bXURJnl53Ew7Ef4c/McxlL
         B6976Op9VBlKc5FytEQXRSA2do9Mxf+I8BDQQbV2erh7nVrhEMmE/S36nbOHOH7RT1a+
         XEpA==
X-Gm-Message-State: APjAAAU9dJu7/oPKNkkImh8N5YlGVurg6KXlUtlQMpk755T0sR3zikVP
        gr8rY0WTgw3FH3GC5rCHBz/tTiwJXTMvnyWAzo0=
X-Google-Smtp-Source: APXvYqwfCzQHpZI3A387gdsSyqs3QMfsYLc+ALoM3as0DpWx5hI3enOa6iVtqIla1OYC8u8kuJ4CQZjB0XJimKMk9LY=
X-Received: by 2002:ac8:237b:: with SMTP id b56mr6131857qtb.343.1551886526215;
 Wed, 06 Mar 2019 07:35:26 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a1mnNrpf5moqi4x9BaTNpE9ZUgs-VBjXoG7=AxENwYtbQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1mnNrpf5moqi4x9BaTNpE9ZUgs-VBjXoG7=AxENwYtbQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 6 Mar 2019 16:35:07 +0100
Message-ID: <CAK8P3a1k3y0ZHLxGNBoynF+tpej9PVQUT7PgP1RLCuXWonKmHg@mail.gmail.com>
Subject: [GIT PULL 4/6] ARM: SoC defconfig updates for 5.1
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

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
tags/armsoc-defconfig

for you to fetch changes up to 31b0067e8d6d200f5c0a083ca7b3536022243a90:

  ARM: spear3xx_defconfig: Activate PL111 DRM driver (2019-03-01 15:09:21 +0100)

----------------------------------------------------------------
ARM: SoC defconfig updates for 5.1

We regenerated the defconfig files for samsung, shmobile, lpc18xx,
lpc32xx, omap2, and nhk8815.

Lots of additional drivers added on samsung and nhk8815,
as well as the new pl110 driver on all machines that have it.

The remaining changes are mostly to enable newly added drivers,
and in case of imx8mq together with the SoC getting merged.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Abel Vesa (1):
      arm64: defconfig: Add i.MX8MQ boot necessary configs

Aisheng Dong (1):
      arm64: defconfig: add imx8qxp support

Anson Huang (1):
      arm64: defconfig: add i.MX system controller RTC support

Ard Biesheuvel (1):
      ARM: multi_v7_defconfig: enable GCC plugin support and structleak plugin

Arnd Bergmann (11):
      Merge tag 'omap-for-v5.1/defconfig-signed' of
git://git.kernel.org/.../tmlind/linux-omap into arm/defconfig
      Merge tag 'imx-defconfig-5.1' of
git://git.kernel.org/.../shawnguo/linux into arm/defconfig
      Merge tag 'tegra-for-5.1-arm64-defconfig' of
git://git.kernel.org/.../tegra/linux into arm/defconfig
      Merge tag 'renesas-arm-defconfig-for-v5.1' of
git://git.kernel.org/.../horms/renesas into arm/defconfig
      Merge tag 'renesas-arm64-defconfig-for-v5.1' of
git://git.kernel.org/.../horms/renesas into arm/defconfig
      Merge tag 'sunxi-config64-for-5.1' of
git://git.kernel.org/.../sunxi/linux into arm/defconfig
      Merge branch 'socfpga_for_next_v5.1_defconfig' of
git://git.kernel.org/.../dinguyen/linux into arm/defconfig
      Merge tag 'lpc32xx-defconfig-for-5.1' of
https://github.com/vzapolskiy/linux-lpc32xx into arm/defconfig
      Merge tag 'arm-soc/for-5.1/defconfig' of
https://github.com/Broadcom/stblinux into arm/defconfig
      Merge tag 'samsung-defconfig-5.1' of
git://git.kernel.org/.../krzk/linux into arm/defconfig
      ARM: pxa: remove CONFIG_SND_PXA2XX_AC97 in pxa_defconfig

Biju Das (2):
      ARM: shmobile: Enable NXP pcf85363 rtc in shmobile_defconfig
      ARM: multi_v7_defconfig: Enable NXP pcf85363 rtc

Carlo Caione (2):
      arm64: defconfig: Enable PFUZE100 regulator
      arm64: defconfig: Add IMX2+ watchdog

Dinh Nguyen (1):
      ARM: socfpga_defconfig: enable BLK_DEV_LOOP config option

Florian Fainelli (1):
      Merge tag 'tags/bcm2835-defconfig-next-2018-11-27' into defconfig/next

Geert Uytterhoeven (4):
      arm64: defconfig: Enable CONFIG_PHY_RCAR_GEN3_PCIE
      ARM: shmobile: defconfig: Refresh for v5.0-rc1
      ARM: shmobile: defconfig: Enable support for RZ/A2
      ARM: multi_v7_defconfig: Enable support for RZ/A2

Jagan Teki (2):
      arm64: defconfig: Enable I2C_GPIO
      arm64: defconfig: Enable SUN6I Camera sensor interface

Joseph Lo (1):
      arm64: defconfig: Enable MAX8973 regulator

Kuninori Morimoto (1):
      arm64: defconfig: select Kingfisher Sound related configs

Linus Walleij (11):
      ARM: defconfig: Update LPC18xx defconfig
      ARM: defconfig: Switch LPC18xx to use PL11x DRM driver
      ARM: defconfig: Update LPC32xx defconfig
      ARM: defconfig: Switch LPC32xx to use PL11x DRM driver
      ARM: defconfig: axm55xx: Drop PL11x graphics driver
      ARM: defconfig: Enable PL11x DRM driver on multi_v7
      arm64: defconfig: Switch to PL11x DRM driver
      ARM: defconfig: integrator: Switch to DRM
      ARM: nhk8815_defconfig: Update defconfig
      ARM: nhk8815_defconfig: Add new options
      ARM: spear3xx_defconfig: Activate PL111 DRM driver

Lukasz Luba (1):
      ARM: omap2plus_defconfig: remove PROVE_LOCKING from defconfig

Paweł Chmiel (3):
      ARM: s5pv210_defconfig: Run make savedefconfig
      ARM: s5pv210_defconfig: Enable more drivers present on Samsung Aries
      ARM: s5pv210_defconfig: Enable cpufreq

Simon Horman (1):
      arm64: defconfig: Enable R-Car thermal driver

Stefan Wahren (1):
      ARM: bcm2835_defconfig: Enable BCM2835 MMAL-based V4L2 camera driver

Thierry Reding (1):
      arm64: defconfig: Enable Tegra TCU

Tony Lindgren (2):
      ARM: omap2plus_defconfig: Update for dropped options
      ARM: omap2plus_defconfig: Update for moved options

Vladimir Zapolskiy (8):
      ARM: defconfig: lpc32xx: enable NFSv4 support
      ARM: defconfig: lpc32xx: enable build options for basic debugging
      ARM: defconfig: lpc32xx: enable panic on oops option
      ARM: defconfig: lpc32xx: enable serial console on HS UART
      ARM: defconfig: lpc32xx: enable generic SRAM driver
      ARM: defconfig: lpc32xx: disable superfluous GPIO controllers
      ARM: defconfig: lpc32xx: enable fixed voltage regulator support
      ARM: defconfig: lpc32xx: enable DRM simple panel driver

Yogesh Narayan Gaur (1):
      arm64: defconfig: enable NXP FlexSPI driver

 arch/arm/configs/axm55xx_defconfig    |  4 ----
 arch/arm/configs/bcm2835_defconfig    |  3 +++
 arch/arm/configs/integrator_defconfig |  9 +++++++--
 arch/arm/configs/lpc18xx_defconfig    | 31 +++++++++++++------------------
 arch/arm/configs/lpc32xx_defconfig    | 65
+++++++++++++++++++++++++++++++----------------------------------
 arch/arm/configs/multi_v7_defconfig   |  8 +++++++-
 arch/arm/configs/nhk8815_defconfig    | 41
+++++++++++++++++++++++++++--------------
 arch/arm/configs/omap2plus_defconfig  | 83
++++++++++++++++++++++++++++++++++++++---------------------------------------------
 arch/arm/configs/pxa_defconfig        |  1 -
 arch/arm/configs/s5pv210_defconfig    | 47
++++++++++++++++++++++++++++++++++++-----------
 arch/arm/configs/shmobile_defconfig   | 48
++++++++++++++++++++++++------------------------
 arch/arm/configs/socfpga_defconfig    | 25 +++++++++++--------------
 arch/arm/configs/spear3xx_defconfig   |  6 ++++--
 arch/arm64/configs/defconfig          | 32 +++++++++++++++++++++++++++++++-
 14 files changed, 232 insertions(+), 171 deletions(-)
