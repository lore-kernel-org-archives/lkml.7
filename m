Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D17AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A672075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 03:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfC1DDY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 23:03:24 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43269 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1DDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 23:03:23 -0400
Received: by mail-qt1-f193.google.com with SMTP id v32so21442162qtc.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 20:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=SPg5alf8D1Gdnse1F44M2MIHCSpOrYTxXm5N/Jj2u3I=;
        b=GgKN4RdbOcFmVGVzDCD0MNladNh7b/R07K3oe5HDOZgP8EU1D2knCM1sWjX102gr68
         6PbCrCnWu3JxEQsBfanNxW3PSTqpJLBqo9zB6uH0jy2qVn8lgxDvFrUnCpy7scMH9IRA
         fp5MK0N7ypZMhiLk2GBGya9VsIO8ctt8WN2NjrpajkYIn+AZ29diaagUkAeTQzFGIJ0F
         rRhbUi0zBJ1DYffjwtcSjZojMVlKO5jQ10DgGhyky6C1eFjowanQR0KyEShNwZb5TNnG
         UBiWOfVLJqE8zWbboiOkVa3CiLZyVng4cdcV/YxZKWLezkoVjjXTWT2s89R2magUDdb4
         j44Q==
X-Gm-Message-State: APjAAAWDjFHc/X0rzr/8x41CWFawUNxQDyEeVlwoMfN16qF+DQyEr/Hv
        DVidAQPwv/xXmo/Jt5VAVLa8gJiyxJV1XnQWmke+vXjF
X-Google-Smtp-Source: APXvYqwkDJVVigTvUP+6F+NDXg9uIBwQICbrxYPSbeNPTguzWN6+09VhrcZfHq2K6utFHnISKo98imOVaidbG9Qn/EU=
X-Received: by 2002:ac8:276b:: with SMTP id h40mr33883974qth.319.1553742201401;
 Wed, 27 Mar 2019 20:03:21 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 Mar 2019 11:03:04 +0800
Message-ID: <CAK8P3a1veuKq=3QNY-UrvpsK3RPCVNjf-uS+bwpyJzQfeXs-rA@mail.gmail.com>
Subject: [GIT PULL] ARM: SoC fixes for v5.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     arm-soc <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8c2ffd9174779014c3fe1f96d9dc3641d9175f00:

  Linux 5.1-rc2 (2019-03-24 14:02:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

for you to fetch changes up to 93958742192e7956d05989836ada9071f9ffe42e:

  arm64: tegra: Disable CQE Support for SDMMC4 on Tegra186 (2019-03-25
17:12:20 +0100)

----------------------------------------------------------------
ARM: SoC fixes for v5.1

A couple of minor fixes only for now

- Incorrect DMA channels on Renesas R-Car
- Broadcom bcm2835 error handling fixes
- Kconfig dependency fixes for bcm2835 and davinci
- CPU idle wakeup fix for i.MX6
- MMC regression on Tegra186
- Incorrect phy settings on one imx board

----------------------------------------------------------------
Arnd Bergmann (4):
      Merge tag 'renesas-fixes-for-v5.1' of
git://git.kernel.org/.../horms/renesas into arm/fixes
      Merge tag 'arm-soc/for-5.1/devicetree-fixes' of
https://github.com/Broadcom/stblinux into arm/fixes
      Merge tag 'arm-soc/for-5.1/soc-fixes' of
https://github.com/Broadcom/stblinux into arm/fixes
      Merge tag 'imx-fixes-5.1' of
git://git.kernel.org/.../shawnguo/linux into arm/fixes

Eric Anholt (3):
      soc: bcm: bcm2835-pm: Fix PM_IMAGE_PERI power domain support.
      soc: bcm: bcm2835-pm: Fix error paths of initialization.
      arm64: bcm2835: Add missing dependency on MFD_CORE.

Florian Fainelli (2):
      Merge tag 'tags/bcm2835-drivers-next-2019-03-12' into soc/fixes
      Merge tag 'tags/bcm2835-dt-next-2019-03-04' into devicetree/fixes

Geert Uytterhoeven (1):
      arm64: dts: renesas: r8a774c0: Fix SCIF5 DMA channels

Helen Koike (1):
      ARM: dts: bcm283x: Fix hdmi hpd gpio pull

Jonathan Hunter (1):
      arm64: tegra: Disable CQE Support for SDMMC4 on Tegra186

Kohji Okuno (1):
      ARM: imx6q: cpuidle: fix bug that CPU might not wake up at expected time

Linus Walleij (1):
      ARM: dts: nomadik: Fix polarity of SPI CS

Marco Felsch (1):
      ARM: dts: pfla02: increase phy reset duration

Masanari Iida (1):
      ARM: dts: imx6qdl: Fix typo in imx6qdl-icore-rqs.dtsi

Michal Vokáč (2):
      ARM: dts: imx6dl-yapp4: Use rgmii-id phy mode on the cpu port
      ARM: dts: imx6dl-yapp4: Use correct pseudo PHY address for the switch

Nishad Kamdar (1):
      ARM: dts: imx6ull: Use the correct style for SPDX License Identifier

Sekhar Nori (1):
      ARM: davinci: fix build failure with allnoconfig

Takeshi Kihara (1):
      arm64: dts: renesas: r8a77990: Fix SCIF5 DMA channels

Uwe Kleine-König (2):
      ARM: imx_v6_v7_defconfig: continue compiling the pwm driver
      ARM: imx_v4_v5_defconfig: enable PWM driver

Wen Yang (1):
      ARM: imx51: fix a leaked reference by adding missing of_node_put

 arch/arm/Kconfig                             |  1 +
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts     |  2 +-
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi   |  6 +++---
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi     |  4 ++--
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi |  1 +
 arch/arm/boot/dts/imx6ull-pinfunc-snvs.h     |  2 +-
 arch/arm/boot/dts/ste-nomadik-nhk15.dts      |  9 +++++----
 arch/arm/configs/imx_v4_v5_defconfig         |  3 +++
 arch/arm/configs/imx_v6_v7_defconfig         |  2 +-
 arch/arm/mach-imx/cpuidle-imx6q.c            | 27 ++++++++++-----------------
 arch/arm/mach-imx/mach-imx51.c               |  1 +
 arch/arm64/Kconfig.platforms                 |  1 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi     |  1 -
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi    |  7 +++----
 arch/arm64/boot/dts/renesas/r8a77990.dtsi    |  7 +++----
 drivers/soc/bcm/bcm2835-power.c              | 49
++++++++++++++++++++++++++++++++++++++++++-------
 16 files changed, 78 insertions(+), 45 deletions(-)
