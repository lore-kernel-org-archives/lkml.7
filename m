Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C40C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C6120661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbfCFPd0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 10:33:26 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35205 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCFPdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 10:33:25 -0500
Received: by mail-qt1-f194.google.com with SMTP id p48so13264251qtk.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 07:33:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jNgS4GweUTWbwlX711d3DV2T9oJa4Cgr5+H3Az90GwI=;
        b=rJ74eIxhcvJ17mFyvrmJN6MOyE4ij0wS+InDHnuyGLvzVhOHVgxKm+vgSCj5vtTh7z
         t5QjjTNjAnkXPIyl6Aj3wj8DIq3Tb9SY9jEbaF7Uq+QQrZMWiV4U8oT2ihN0F0bBxvef
         feGj9/6Y/w4ySlqUQh1JFAy/0r7DLiPu9rjEtnBaMhjujx28TQgdZjgpkT3VKKosMvYq
         aXQFRpB3o7PKrz3T13DwaxlgYo9MbFqO8qDP04SKiJTwSptsAkz2hsCvuwDzJWOFT+8h
         9Mm+SwOYmja2M8d4C50XiEdF1ac9dj+mXRfz68TznGUXRLTG4N0c6YKTDkAkikyUKbDp
         xFvQ==
X-Gm-Message-State: APjAAAXJo9NRlsSich1B5cS7LA9ZeyeK7jeZTTZR1Lxs44OS9mOlP+hT
        S9is9/eVZ5t1QCZqjmkfuUWdDVoFrzqynf+9hvw=
X-Google-Smtp-Source: APXvYqydKn7bt0ygFq3Sb2yCbh0T8EPthflh6lDn+hGP9FBvC0K0wyX540ZTdL1Quh/nApZbYG8stpMhzGqyoPnMDOg=
X-Received: by 2002:ac8:237b:: with SMTP id b56mr6123654qtb.343.1551886401712;
 Wed, 06 Mar 2019 07:33:21 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a1mnNrpf5moqi4x9BaTNpE9ZUgs-VBjXoG7=AxENwYtbQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1mnNrpf5moqi4x9BaTNpE9ZUgs-VBjXoG7=AxENwYtbQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 6 Mar 2019 16:33:04 +0100
Message-ID: <CAK8P3a08Rxm_52q2xPvszukYGzbSEA0WypHjxCi9hXvLXNd41g@mail.gmail.com>
Subject: [GIT PULL 2/6] ARM: SoC device tree updates for 5.1
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

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-dt

for you to fetch changes up to a3238924a820c1d7c977b632b769f3b5690cba09:

  ARM: dts: exynos: Fix max voltage for buck8 regulator on Odroid
XU3/XU4 (2019-03-01 15:10:30 +0100)

----------------------------------------------------------------
ARM: SoC device tree updates for 5.1

This is a smaller update than the past few times, but with just over
500 non-merge changesets still dwarfes the rest of the SoC tree.

Three new SoC platforms get added, each one a follow-up to an existing
product, and added here in combination with a reference platform:

 - Renesas RZ/A2M (R7S9210) 32-bit Cortex-A9 Real-time imaging processor
   https://www.renesas.com/eu/en/products/microcontrollers-microprocessors/rz/rza/rza2m.html

 - Renesas RZ/G2E (r8a774c0) 64-bit Cortex-A53 SoC "for
   Rich Graphics Applications".
   https://www.renesas.com/eu/en/products/microcontrollers-microprocessors/rz/rzg/rzg2e.html

 - NXP i.MX8QuadXPlus 64-bit Cortex-A35 SoC
   https://www.nxp.com/products/processors-and-microcontrollers/arm-based-processors-and-mcus/i.mx-applications-processors/i.mx-8-processors/i.mx-8x-family-arm-cortex-a35-3d-graphics-4k-video-dsp-error-correcting-code-on-ddr:i.MX8X

These are actual commercial products we now support with an in-kernel
device tree source file:

 - Bosch Guardian is a product made by Bosch Power
   Tools GmbH, based on the Texas Instruments AM335x chip

 - Winterland IceBoard is a Texas Instruments AM3874 based
   machine used in telescopes at the south pole and elsewhere, see commit
   d031773169df2 for some pointers:

 - Inspur on5263m5 is an x86 server platform with an Aspeed
   ast2500 baseboard management controller. This is for running on
   the BMC.

 - Zodiac Digital Tapping Unit, apparently a kind of ethernet
   switch used in airplanes.

 - Phicomm K3 is a WiFi router based on Broadcom bcm47094

 - Methode Electronics uDPU FTTdp distribution point unit

 - X96 Max, a generic TV box based on Amlogic G12a (S905X2)

 - NVIDIA Shield TV (Darcy) based on Tegra210

And then there are several new SBC, evaluation, development or modular
systems that we add:

 - Three new Rockchips rk3399 based boards:
    - FriendlyElec NanoPC-T4 and NanoPi M4
    - Radxa ROCK Pi 4

 - Five new i.MX6 family SoM modules and boards for industrial
   products:
    - Logic PD i.MX6QD SoM and evaluation baseboad
    - Y Soft IOTA Draco/Hydra/Ursa family boards based on i.MX6DL
    - Phytec phyCORE i.MX6 UltraLite SoM and evaluation module

 - MYIR Tech MYD-LPC4357 development based on the NXP lpc4357
   microcontroller

 - Chameleon96, an Intel/Altera Cyclone5 based FPGA development
   system in 96boards form factor

 - Arm Fixed Virtual Platforms(FVP) Base RevC, a purely
   virtual platform for corresponding to the latest "fast model"

 - Another Raspberry Pi variant: Model 3 A+, supported both
   in 32-bit and 64-bit mode.

 - Oxalis Evalkit V100 based on NXP Layerscape LS1012a,
   in 96Boards enterprise form factor

 - Elgin RV1108 R1 development board based on 32-bit Rockchips RV1108

For already supported boards and SoCs, we often add support for new
devices after merging the drivers. This time, the largest changes include
updates for

 - STMicroelectronics stm32mp1, which was now formally
   launched last week

 - Qualcomm Snapdragon 845, a high-end phone and low-end laptop chip

 - Action Semi S700

 - TI AM654x, their recently merged 64-bit SoC from the OMAP family

 - Various Amlogic Meson SoCs

 - Mediatek MT2712

 - NVIDIA Tegra186 and Tegra210

 - The ancient NXP lpc32xx family

 - Samsung s5pv210, used in some older mobile phones

Many other chips see smaller updates and bugfixes beyond that.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Abel Vesa (1):
      arm64: dts: imx8mq: Add RTC support

Adam Ford (1):
      ARM: dts: imx: Add support for Logic PD i.MX6QD EVM

Aisheng Dong (5):
      dt-bindings: arm: imx: add imx8qxp mek support
      arm64: dts: imx: add imx8qxp support
      arm64: dts: imx: add imx8qxp mek support
      dt-bindings: fsl: scu: add fallback compatible string for clock
      dt-bindings: fsl: scu: add imx8qm scu clock support

Akash Gajjar (4):
      arm64: dts: rockchip: add ROCK Pi 4 DTS support
      arm64: dts: rockchip: rockpro64 dts make regulator more readable
      arm64: dts: rockchip: rockpro64 dts remove unused lcd-reset pinmux
      arm64: dts: rockchip: rockpro64 dts add usb regulator

Alexander Shiyan (4):
      ARM: dts: imx: Change i.MX27 interrupt controller unit name
      ARM: dts: i.MX51: digi-connectcore: Move RTC from SOM to JSK
      ARM: dts: i.MX51: imx51-digi-connectcore: Enable ESDHC1
      ARM: dts: i.MX51: digi-connectcore-som: Add support for I2C bus recovery

Alexandre Belloni (3):
      arm64: dts: fsl: use a generic node name for m25p80 flashes
      arm64: dts: fsl: ls1046a: disable the flash controller by default
      arm64: dts: fsl: ls1046a: disable uarts by default

Alistair Strachan (1):
      arm64: dts: hikey: Revert "Enable HS200 mode on eMMC"

Amit Kucheria (2):
      arm64: dts: pms405: Export PMIC temperature to thermal framework
      arm64: dts: sdm845: wireup the thermal trip points to cpufreq

Andreas Kemnade (4):
      ARM: dts: gta04: add pinctrl settings for wkup domain
      ARM: dts: gta04: add ldo 3v3 regulator
      ARM: dts: gta04: add gps support
      ARM: dts: omap3-gta04: declare backlight in lcd node

Andrew Lunn (2):
      arch: arm: dts: Remove disabled marvell,dsa properties
      ARM: dts: vf610: Add ZII SSMB DTU board

Andrius Štikonas (1):
      arm64: dts: rockchip: enable mali power supply on rk3399-rockpro64

Andy Gross (3):
      Merge tag 'qcom-fixes-for-5.0-rc3' into arm64-for-5.1-2
      Merge branch 'arm64-for-5.1' into arm64-for-5.1-2
      arm64: dts: sdm845: Fixup dependency on RPMPD includes

Anson Huang (9):
      ARM: dts: imx7ulp: add HSRUN mode clocks
      ARM: dts: imx6sl: correct PWM ipg clock source
      arm64: dts: imx: add i.MX8QXP system controller RTC support
      dt-bindings: fsl: add imx7ulp system integration module binding
      ARM: dts: imx7ulp: add sim node
      ARM: dts: imx6qdl-sabresd: add regulator control for isl29023 sensor
      ARM: dts: imx6qdl-sabresd: add regulators control for mag3110 sensor
      ARM: dts: imx6qdl-sabresd: add regulators control for mma8451 sensor
      ARM: dts: imx6qdl-sabresd: remove reg_sensors' regulator-always-on

Arnd Bergmann (57):
      Merge tag 'stm32-dt-for-v4.21-1' of
git://git.kernel.org/.../atorgue/stm32 into arm/dt
      Merge tag 'nomadik-dts-v5.1' of
git://git.kernel.org/.../linusw/linux-nomadik into arm/dt
      Merge tag 'integrator-dts-v5.1' of
git://git.kernel.org/.../linusw/linux-integrator into arm/dt
      Merge tag 'renesas-arm64-dt-for-v5.1' of
git://git.kernel.org/.../horms/renesas into arm/dt
      Merge tag 'sunxi-dt-for-5.1' of
git://git.kernel.org/.../sunxi/linux into arm/dt
      Merge tag 'sunxi-dt64-for-5.1' of
git://git.kernel.org/.../sunxi/linux into arm/dt
      Merge tag 'aspeed-5.1-devicetree' of
git://git.kernel.org/.../joel/aspeed into arm/dt
      Merge tag 'vexpress-updates-5.1' of
git://git.kernel.org/.../sudeep.holla/linux into arm/dt
      Merge tag 'juno-updates-5.1' of
git://git.kernel.org/.../sudeep.holla/linux into arm/dt
      Merge tag 'omap-for-v5.1/soc-ti-81xx-signed' of
git://git.kernel.org/.../tmlind/linux-omap into arm/dt
      Merge tag 'omap-for-v5.1/dt-ti-81xx-signed' of
git://git.kernel.org/.../tmlind/linux-omap into arm/dt
      Merge tag 'omap-for-v5.1/dt-signed' of
git://git.kernel.org/.../tmlind/linux-omap into arm/dt
      Merge tag 'davinci-for-v5.1/dt' of
git://git.kernel.org/.../nsekhar/linux-davinci into arm/dt
      Merge tag 'am654-for-v5.1' of
git://git.kernel.org/.../kristo/linux into arm/dt
      Merge tag 'v5.1-rockchip-dts32-1' of
git://git.kernel.org/.../mmind/linux-rockchip into arm/dt
      Merge tag 'v5.1-rockchip-dts64-1' of
git://git.kernel.org/.../mmind/linux-rockchip into arm/dt
      Merge tag 'stm32-dt-for-v5.1-1' of
git://git.kernel.org/.../atorgue/stm32 into arm/dt
      Merge tag 'samsung-dt-5.1' of
git://git.kernel.org/.../krzk/linux into arm/dt
      Merge tag 'arm-soc/for-5.1/devicetree' of
https://github.com/Broadcom/stblinux into arm/dt
      Merge tag 'arm-soc/for-5.1/devicetree-arm64' of
https://github.com/Broadcom/stblinux into arm/dt
      Merge tag 'lpc32xx-dt-for-5.1' of
https://github.com/vzapolskiy/linux-lpc32xx into arm/dt
      Merge tag 'qcom-arm64-for-5.1' of
git://git.kernel.org/.../agross/linux into arm/dt
      Merge tag 'qcom-dts-for-5.1' of
git://git.kernel.org/.../agross/linux into arm/dt
      Merge tag 'hisi-arm64-dt-for-5.1v2' of
git://github.com/hisilicon/linux-hisi into arm/dt
      Merge tag 'socfpga_dts_for_v5.1' of
git://git.kernel.org/.../dinguyen/linux into arm/dt
      Merge tag 'sunxi-h3-h5-for-5.1' of
git://git.kernel.org/.../sunxi/linux into arm/dt
      Merge tag 'sunxi-dt64-for-5.1-2' of
git://git.kernel.org/.../sunxi/linux into arm/dt
      Merge tag 'sunxi-dt-for-5.1-2' of
git://git.kernel.org/.../sunxi/linux into arm/dt
      Merge tag 'renesas-arm64-dt2-for-v5.1' of
git://git.kernel.org/.../horms/renesas into arm/dt
      Merge tag 'renesas-arm-dt-for-v5.1' of
git://git.kernel.org/.../horms/renesas into arm/dt
      Merge tag 'tegra-for-5.1-dt-bindings' of
git://git.kernel.org/.../tegra/linux into arm/dt
      Merge tag 'tegra-for-5.1-arm-dt' of
git://git.kernel.org/.../tegra/linux into arm/dt
      Merge tag 'tegra-for-5.1-arm64-dt' of
git://git.kernel.org/.../tegra/linux into arm/dt
      Merge tag 'v5.0-next-dts32' of
git://git.kernel.org/.../matthias.bgg/linux into arm/dt
      Merge tag 'v5.0-next-dts64' of
git://git.kernel.org/.../matthias.bgg/linux into arm/dt
      Merge tag 'mvebu-dt64-5.1-1' of
git://git.infradead.org/linux-mvebu into arm/dt
      Merge tag 'mvebu-dt-5.1-1' of
git://git.infradead.org/linux-mvebu into arm/dt
      Merge tag 'amlogic-dt64' of
git://git.kernel.org/.../khilman/linux-amlogic into arm/dt
      Merge tag 'amlogic-dt' of
git://git.kernel.org/.../khilman/linux-amlogic into arm/dt
      Merge tag 'imx-bindings-5.1' of
git://git.kernel.org/.../shawnguo/linux into arm/dt
      Merge tag 'imx-dt-5.1' of
git://git.kernel.org/.../shawnguo/linux into arm/dt
      Merge tag 'imx-dt64-5.1' of
git://git.kernel.org/.../shawnguo/linux into arm/dt
      Merge tag 'zynqmp-dt-for-v5.1' of
https://github.com/Xilinx/linux-xlnx into arm/dt
      Merge tag 'zynq-dt-for-v5.1' of
https://github.com/Xilinx/linux-xlnx into arm/dt
      Merge tag 'at91-5.1-dt' of git://git.kernel.org/.../at91/linux into arm/dt
      Merge tag 'uniphier-dt64-v5.1' of
git://git.kernel.org/.../masahiroy/linux-uniphier into arm/dt
      Merge tag 'omap-for-v5.1/dt-pt2-signed' of
git://git.kernel.org/.../tmlind/linux-omap into arm/dt
      Merge tag 'am654-for-v5.1-part2' of
git://git.kernel.org/.../kristo/linux into HEAD
      Merge tag 'qcom-arm64-for-5.1' of
git://git.kernel.org/.../agross/linux into arm/dt
      Merge tag 'qcom-dts-for-5.1-2' of
git://git.kernel.org/.../agross/linux into arm/dt
      Merge tag 'v5.1-rockchip-dts32-2' of
git://git.kernel.org/.../mmind/linux-rockchip into arm/dt
      Merge tag 'v5.1-rockchip-dts64-2' of
git://git.kernel.org/.../mmind/linux-rockchip into arm/dt
      Merge tag 'renesas-dt-bindings-for-v5.1' of
git://git.kernel.org/.../horms/renesas into arm/dt
      Merge tag 'samsung-dt-5.1-2' of
git://git.kernel.org/.../krzk/linux into arm/dt
      Merge tag 'actions-arm64-dt-for-v5.1' of
git://git.kernel.org/.../mani/linux-actions into arm/dt
      Merge tag 'omap-for-v5.1/dt-cpsw-phy' of
git://git.kernel.org/.../tmlind/linux-omap into arm/dt
      Merge tag 'mvebu-dt-5.1-2' of
git://git.infradead.org/linux-mvebu into arm/dt

BOUGH CHEN (1):
      ARM: dts: imx6ull: change to use new compatible
"fsl,imx6ull-usdhc" for usdhc

Baolin Wang (5):
      arm64: dts: sprd: Remove PMIC INTC irq trigger type
      arm64: dts: sprd: Add ADC calibration support
      arm64: dts: sprd: Add SC2731 charger device
      arm64: dts: sprd: Add SC27XX fuel gauge device
      arm64: dts: sprd: Remove wildcard compatible string

Bich HEMON (3):
      ARM: dts: stm32: change CAN RAM mapping on stm32mp157c
      ARM: dts: stm32: add can1 sleep pins muxing
      ARM: dts: stm32: add can1 sleep pins muxing on stm32mp157c-ev1 board

Biju Das (16):
      ARM: dts: iwg23s-sbc: Enable RTC
      ARM: dts: r8a7744: Fix sorting of vsp and msiof nodes
      ARM: dts: r8a7743: Remove generic compatible string from iic3
      ARM: dts: r8a7743: Remove aliases from SoC dtsi
      ARM: dts: r8a7743: Fix sorting of rwdt node
      arm64: dts: renesas: Add Si-Linux CAT874 board support
      arm64: dts: renesas: Add Si-Linux EK874 board support
      arm64: dts: renesas: r8a774c0-cat874: Add pincontrol support to scif2
      arm64: dts: renesas: r8a774c0-cat874: Add uSD support
      arm64: dts: renesas: cat875: Add ethernet support
      ARM: dts: r8a7744: Add DU support
      ARM: dts: r8a7744: Add LVDS support
      arm64: dts: renesas: r8a774c0: Add CMT device nodes
      arm64: dts: renesas: r8a774c0: Add TMU device nodes
      arm64: dts: renesas: r8a774c0-cat874: Add pciec0 support
      arm64: dts: renesas: cat875: Enable PCIe support

Bjorn Andersson (10):
      arm64: dts: qcom: sdm845: Increase address and size cells for soc
      arm64: dts: qcom: sdm845: Extend ranges and describe DMA space
      arm64: dts: qcom: sdm845: Fix lpasscc reg
      arm64: dts: qcom: qcs404: Specify pinctrl state for UART
      arm64: dts: qcom: qcs404: Define remaining UARTs
      arm64: dts: qcom: qcs404: Add QUP I2C and SPI nodes
      arm64: dts: qcom: qcs404: Add rpmcc node
      arm64: dts: qcom: msm8996: Disabled VFE SMMU
      arm64: dts: qcom: sdm845: Define IOMMU for sdhc 2
      arm64: dts: qcom: sdm845: Define iommus for USB controllers

Brian Masney (2):
      ARM: dts: qcom: msm8974: add gpio-ranges
      ARM: dts: qcom: msm8974-hammerhead: add USB OTG support

Can Guo (1):
      arm64: dts: qcom: sdm845: Add UFS nodes for sdm845-mtp

Carlo Caione (5):
      arm64: dts: imx8mq-evk: add missing MDIO / PHY nodes
      arm64: dts: imx8mq-evk: Add fsl,magic-packet property
      arm64: dts: imx8mq: Add QuadSPI controller
      arm64: dts: imx8mq-evk: Enable the QuadSPI controller
      arm64: dts: imx8mq: Add ARM PMU node

Cezary Gapinski (1):
      ARM: dts: stm32: add SPI support on STM32F429 SoC

Chen-Yu Tsai (28):
      ARM: dts: sun8i: r40: Add pinmux settings for UART3 on PG pingroup
      ARM: dts: sun8i: r40: Add pinmux setting for CLK_OUT_A
      ARM: dts: sun8i: r40: bananapi-m2-ultra: Fix WiFi regulator definitions
      ARM: dts: sun8i: r40: bananapi-m2-ultra: Add Bluetooth device node
      ARM: dts: sunxi: bananapi-m2-plus: Add Bluetooth device node
      ARM: dts: sunxi: h3/h5: Drop A31 fallback compatible for CSI controller
      ARM: dts: sun8i-a23-a33: Move NAND controller device node to
sort by address
      ARM: dts: sun8i-a33: Move display pipeline nodes to a23/a33 common dtsi
      ARM: dts: sun8i-a23: Add compatible strings to display pipeline
device nodes
      ARM: dts: sun8i-q8-common: Enable display pipeline with RGB LCD panel
      ARM: dts: sun8i-a23-q8: Set compatible string for LCD panel
      arm64: dts: allwinner: h6: Move GIC device node fix base address ordering
      ARM: dts: sun5i: Add backlight GPIO for reference design tablet
      ARM: dts: sun5i: q8-tablet: Move panel properties to correct node level
      ARM: dts: sun5i: q8-tablet: Add LCD Panel enable GPIO
      ARM: dts: sun5i: q8-tablet: Add LCD Panel power supply
      ARM: dts: sun5i: q8-tablet: Use bananapi,s070wv20-ct16 panel compatible
      arm64: dts: allwinner: a64: Enable PMIC power supplies on various boards
      arm64: dts: allwinner: h5: libretech-all-h3-cc: Mark eMMC HS-DDR
3.3V capable
      ARM: dts: sun9i: a80-optimus: Add node for AXP809's unused dc1sw regulator
      ARM: dts: sun9i: a80-optimus: Add GPIO pin-bank regulator supplies
      ARM: dts: sun9i: cubieboard4: Add GPIO pin-bank regulator supplies
      ARM: dts: sun9i: Add GMAC clock node
      ARM: dts: sun9i: Add A80 GMAC gigabit ethernet controller node
      ARM: dts: sun9i: Add A80 GMAC RGMII pinmux setting
      ARM: dts: sun9i: a80-optimus: Enable GMAC
      ARM: dts: sun9i: cubieboard4: Enable GMAC
      ARM: dts: sun8i: a83t: Enable PMIC power supplies on various boards

Chris Brandt (3):
      ARM: dts: r7s9210: Initial SoC device tree
      ARM: dts: r7s9210-rza2mevb: Add support for RZ/A2M EVB
      dt-bindings: arm: renesas: Document RZ/A2M EVB

Chunfeng Yun (1):
      arm64: dts: Add USB3 related nodes for MT2712

Claudiu Beznea (2):
      ARM: dts: at91: at91-sama5d27_som1: add QSPI1 + SPI NOR memory nodes
      ARM: dts: at91: at91-sama5d27_som1_ek: enable qspi1 memory

Corentin Labbe (1):
      ARM: dts: sun8i-h3: nanopi-m1-plus: enable HDMI

Dan Haab (1):
      ARM: dts: BCM53573: Relicense Luxul files to the GPL 2.0+ / MIT

Daniel Baluta (1):
      arm64: dts: imx8qxp: Fix MU4_INT number

David Dai (1):
      arm64: dts: sdm845: Add interconnect provider DT nodes

David Hernandez Sanchez (2):
      ARM: dts: stm32: add thermal sensor support on STM32MP157c
      ARM: dts: stm32: Enable thermal sensor support on STM32MP157c-ed1

Dietmar Eggemann (2):
      arm: dts: vexpress-v2p-ca15_a7: Add cpu
dynamic-power-coefficient information
      arm64: dts: juno: Add cpu dynamic-power-coefficient information

Dinh Nguyen (1):
      ARM: dts: socfpga: update missing reset property peripherals

Douglas Anderson (3):
      arm64: dts: qcom: sdm845: Add qspi (quad SPI) node
      arm64: dts: sdm845: Add gpu clock controller node
      arm64: dts: sdm845: Add clocks and iommus to WCN3990 WLAN node

Enric Balletbo i Serra (1):
      ARM: dts: rockchip: add chosen node on veyron devices

Erin Lo (1):
      dt-bindings: arm: Add bindings for Mediatek MT8183 SoC Platform

Evan Green (5):
      arm64: dts: qcom: sdm845: Add SD node
      arm64: dts: qcom: sdm845: Add SD nodes for sdm845-mtp
      arm64: dts: qcom: sdm845: add UFS controller
      arm64: dts: qcom: sdm845: Add USB PHY lane two
      arm64: dts: qcom: sdm845: Add gpio-ranges to TLMM node

Ezequiel Garcia (2):
      arm64: dts: rockchip: Enable HDMI audio devices on rk3399-rock960
      arm64: dts: rockchip: Enable tsadc device on rock960

Fabio Estevam (3):
      ARM: dts: vf610-zii-cfu1: Run I2C0 at 400 kHz
      ARM: dts: vf610-zii-ssmb-spu3: Pass "no-sdio"/"no-sd" properties
      arm64: dts: imx8mq: Add ECSPI support

Fabrice Gasnier (3):
      ARM: dts: stm32: Add dmas to timer on stm32mp157c
      ARM: dts: stm32: don't use timers dmas on stm32mp157c-ed1
      ARM: dts: stm32: don't use timers dmas on stm32mp157c-ev1

Fabrizio Castro (29):
      arm64: dts: renesas: Initial device tree for r8a774c0
      arm64: dts: renesas: r8a774c0: Add SYS-DMAC controller nodes
      arm64: dts: renesas: r8a774c0: Add SCIF and HSCIF nodes
      arm64: dts: renesas: r8a774c0: Add INTC-EX device node
      arm64: dts: renesas: r8a774c0: Add PFC support
      arm64: dts: renesas: r8a774c0: Add GPIO device nodes
      arm64: dts: renesas: r8a774c0: Add Ethernet AVB node
      arm64: dts: renesas: r8a774c0: Add watchdog support
      arm64: dts: renesas: r8a774c0: Add secondary CA53 CPU core
      arm64: dts: renesas: r8a774c0: Add SDHI nodes
      arm64: dts: renesas: r8a774c0: Add I2C and IIC-DVFS support
      arm64: dts: renesas: r8a774c0: Add IPMMU device nodes
      arm64: dts: renesas: r8a774c0: Add CAN nodes
      arm64: dts: renesas: r8a774c0: Add thermal support
      arm64: dts: renesas: r8a774c0: Add MSIOF nodes
      arm64: dts: renesas: r8a774c0: Add audio support
      arm64: dts: renesas: r8a774c0: Add PWM support
      arm64: dts: renesas: r8a774c0: Add display output support
      arm64: dts: renesas: r8a774c0: Add USB2.0 phy and host device nodes
      arm64: dts: renesas: r8a774c0: Add USB-DMAC and HSUSB device nodes
      arm64: dts: renesas: r8a774c0: Add USB3.0 device nodes
      arm64: dts: renesas: r8a774c0: Connect RZ/G2E SYS-DMAC to IPMMU
      arm64: dts: renesas: r8a774c0: Connect RZ/G2E AVB to IPMMU
      arm64: dts: renesas: r8a774c0: Connect RZ/G2E Audio-DMAC to IPMMU
      arm64: dts: renesas: r8a774c0: Add PCIe device node
      arm64: dts: renesas: r8a774c0: Add VIN and CSI-2 device nodes
      dt-bindings: arm: renesas: Add si-linux cat87[45] boards
      arm64: dts: renesas: r8a774a1: Fix hsusb reg size
      arm64: dts: renesas: r8a774c0: Add OPPs table for cpu devices

Faiz Abbas (2):
      arm64: dts: ti: k3-am654: Add Support for eMMC host controller
      arm64: dts: ti: k3-am654-base-board: Add eMMC Support

Felix Brack (1):
      ARM: dts: am33xx: Remove unnecessary properties

Florian Fainelli (2):
      Merge tag 'tags/bcm2835-dt-next-2019-02-01' into devicetree/next
      Merge tag 'tags/bcm2835-dt-64-next-2019-02-01' into devicetree-arm64/next

Geert Uytterhoeven (6):
      ARM: dts: stout: Convert to new LVDS DT bindings
      arm64: dts: renesas: r8a77990: Sort i2c nodes within soc node
      arm64: dts: renesas: r8a7796: salvator-xs: Convert to new LVDS DT bindings
      arm64: dts: renesas: r8a774c0: Enable DMA for SCIF2
      arm64: dts: renesas: r8a77990: Enable DMA for SCIF2
      dt-bindings: arm: renesas: Fix SoC mismatch for Stout

Govind Singh (2):
      arm64: dts: qcom: qcs404: Add WCN3990 WLAN module device node
      arm64: dts: sdm845: Add WCN3990 WLAN module device node

Graeme Smecher (4):
      ARM: ti81xx: Move I2C entries in omap_hwmod_81xx to maintain grouping
      ARM: ti81xx: Add hwmod boilerplate for all GPIO and SPI peripherals
      ARM: dts: ti81xx: Add dts boilerplate for all GPIO and SPI peripherals
      ARM: dts: Adds device tree file for McGill's IceBoard, based on TI AM3874

Gregory CLEMENT (2):
      arm64: dts: marvell: Remove unnecessary
#address-cells/#size-cells under flashes
      arch: arm: dts: kirkwood-rd88f6281: Remove disabled marvell,dsa reference

Grygorii Strashko (5):
      ARM: dts: dra7: switch to use phy-gmii-sel
      ARM: dts: dm814x: switch to use phy-gmii-sel
      ARM: dts: am4372: switch to use phy-gmii-sel
      ARM: dts: am335x: switch to use phy-gmii-sel
      dt-bindings: net: ti: deprecate cpsw-phy-sel bindings

Guido Günther (1):
      arm64: dts: imx8mq: Add pwm device nodes

Hao Dong (1):
      ARM: dts: BCM5301X: Add basic DT for Phicomm K3

Harald Geyer (3):
      arm64: dts: allwinner: a64: Add PMU node
      ARM: dts: sun4i-a10: Add PMU node
      arm64: dts: allwinner: a64: teres-i: enable power supplies

Heiko Schocher (1):
      ARM: dts: am335x-shc.dts: Switch to SPDX identifier

Heiko Stuebner (4):
      ARM: dts: rockchip: move rk3036 i2s sound-dail-cells into soc dtsi
      ARM: dts: rockchip: fix cif1_pdn pin on rk3188-bqedison2qc
      ARM: dts: rockchip: add focaltech touchscreen to rk3188-bqedison2qc
      arm64: dts: rockchip: move rk3328 #sound-dai-cells to the soc dtsi

Honghui Zhang (1):
      arm64: dts: add pcie nodes for MT2712

Hou Zhiqiang (2):
      ARM: dts: ls1021a: add num-viewport property for PCIe DT nodes
      arm64: dts: layerscape: add num-viewport property for PCIe DT nodes

Ioana Ciocoi Radulescu (2):
      arm64: dts: lx2160a: Add fsl-mc node
      arm64: dts: lx2160a: Add dma-ranges property

Jagan Teki (1):
      arm64: dts: allwinner: a64: Add A64 CSI controller

Jakob Wuhrer (1):
      arm64: dts: qcom: Correct "gpiio" typo in msm8996-pins

Jan Kiszka (2):
      arm64: dts: zcu100-revC: Give wifi some time after power-on
      arm64: dts: hikey: Give wifi some time after power-on

Jean-Philippe Brucker (1):
      arm64: dts: fast models: Add DTS fo Base RevC FVP

Jeffrey Hugo (3):
      arm64: dts: qcom: msm8998-mtp: Increase load on l21 for sdcard
      arm64: dts: qcom: msm8998: Enumerate i2c controllers
      arm64: dts: qcom: msm8998: Add USB-related nodes

Jernej Skrabec (2):
      dt-bindings: sram: sunxi: Add compatible for the H6 SRAM C1
      arm64: dts: allwinner: h6: Add support for the SRAM C1 section

Jerome Brunet (10):
      arm64: dts: meson-axg: add spdifin
      arm64: dts: meson-axg: s400: add spdif-dir codec
      arm64: dts: meson-axg: s400: add spdifin to the sound card
      arm64: dts: meson: s400: enable sdr104 on sdio
      arm64: dts: meson: s400: fix emmc maximum rate
      arm64: dts: meson-axg: add efuse device
      arm64: dts: meson: fix g12a buses
      arm64: dts: meson: axg: add clk measure support
      arm64: dts: meson: g12a: add clk measure support
      arm64: dts: meson: g12a: add peripheral clock controller

Jeykumar Sankaran (1):
      arm64: dts: qcom: sdm845: Add dpu to sdm845 dts file

Joel Stanley (1):
      ARM: dts: aspeed-palmetto: Add i2c OCC hwmon node

Johan Jonker (2):
      ARM: dts: rockchip: add HCLK_HDMI to rk3066 vio power-domain
      ARM: dts: rockchip: remove cap-mmc-highspeed from
rk3188-bqedison2qc mmc1 node

John Stultz (1):
      arm64: dts: hikey: Add DMA entries for Bluetooth UART

John Wang (1):
      ARM: dts: aspeed: Add Inspur on5263m5 BMC

Jonathan Bakker (1):
      ARM: dts: s5pv210: Add support for more devices present on Aries

Jonathan Marek (1):
      ARM: dts: qcom: msm8974-hammerhead: add WiFi support

Jonathan Neuschäfer (2):
      arm64: dts: allwinner: a64: Fix a typo
      ARM: dts: omap3-gta04a5: Replace LXR reference with a local one

Jorge Ramirez-Ortiz (1):
      arm64: dts: qcom: qcs404: sdcc1: enable HS400

Joseph Lo (11):
      arm64: tegra: Fix register range of apbmisc on Tegra210
      arm64: tegra: Fix IRQ type of PMIC on Smaug
      dt-bindings: clock: tegra124-dfll: add Tegra210 support
      dt-bindings: cpufreq: tegra124: remove vdd-cpu-supply from
required properties
      dt-bindings: cpufreq: tegra124: remove cpu_lp clock from
required properties
      arm64: tegra: Add DFLL clock on Tegra210
      arm64: tegra: Add CPU clocks on Tegra210
      arm64: tegra: Add pinmux for PWM-based DFLL support on P2597
      arm64: tegra: Enable DFLL clock on Jetson TX1
      arm64: tegra: Add CPU power rail regulator on Smaug
      arm64: tegra: Enable DFLL clock on Smaug

Jyri Sarha (1):
      arm64: dts: ti: am654: Add Main System Control Module node

Katsuhiro Suzuki (2):
      arm64: dts: rockchip: add rk3328 ACODEC node
      arm64: dts: rockchip: enable analog audio node for rock64

Kazuya Mizuguchi (1):
      arm64: dts: renesas: r8a77990: ebisu: Fix EthernetAVB phy mode to rgmii

Kevin Hilman (2):
      dt-bindings: arm: amlogic: add amediatech x96-max bindings
      arm64: dts: meson: add g12a x96 max board

Krzysztof Kozlowski (3):
      ARM: dts: s5pv210: Fix onenand's unit address format warning
      ARM: dts: s3c2416: Fix xti node's missing reg property warning
      ARM: dts: exynos: Enable ADC on Odroid HC1

Kunihiko Hayashi (1):
      arm64: dts: uniphier: Add PCIe host controller and PHY nodes

Kuninori Morimoto (6):
      arm64: dts: renesas: ulcb: use audio-graph-card
      arm64: dts: renesas: ulcb: add HDMI sound support
      arm64: dts: renesas: ulcb-kf: add pcm3168 sound codec
      arm64: dts: renesas: r8a7795: remove BUSIF0 settings from rcar_sound,ssi
      arm64: dts: renesas: r8a7796: remove BUSIF0 settings from rcar_sound,ssi
      arm64: dts: renesas: r8a77990-ebisu: use simple-audio-card

Laurent Pinchart (2):
      arm64: dts: renesas: r8a77990: ebisu: Add backlight
      arm64: dts: renesas: r8a77995: draak: Set better backlight levels

Leonard Crestez (1):
      ARM: dts: imx6sx: Add DISPLAY power domain support

Linus Walleij (4):
      ARM: dts: Augment panel setting for Integrator/CP
      ARM: dts: nomadik: Augment NHK15 panel setting
      ARM: dts: msm8660: Mark two GSBI blocks "disabled"
      ARM: dts: msm8660: Fix up GIC IRQ flags

Loic Poulain (2):
      arm64: dts: apq8016-sbc: Increase load on l11 for SDCARD
      arm64: dts: qcom: pm8916: Add PON watchdog node

Lucas Stach (6):
      arm64: dts: imx8mq: move watchdog nodes to correct location
      arm64: dts: imx8mq: add GPC power domains
      arm64: dts: imx8mq: properly describe IRQ hierarchy
      arm64: dts: imx8mq: add USB nodes
      arm64: dts: imx8mq-evk: enable USB nodes for USB3 host
      arm64: dts: imx8mq: specify dma-ranges

Lukasz Majewski (1):
      ARM: dts: vf610-bk4: Provide support for reading ID code from MVB device

Manivannan Sadhasivam (13):
      dt-bindings: vendor-prefixes: Add Novtech Vendor Prefix
      ARM: dts: Add support for 96Boards Chameleon96 board
      arm64: dts: mediatek: mt6797: Add pinctrl support
      arm64: dts: mediatek: x20: Add pinmux support for UART1
      dt-bindings: arm: fsl: Fix bindings for LS1012A and LS1021A based boards
      dt-bindings: vendor-prefixes: Add EBS-SYSTART GmbH Vendor Prefix
      dt-bindings: arm: fsl: Add devicetree binding for Oxalis
      arm64: dts: freescale: Add devicetree for Oxalis
      ARM: dts: Add devicetree compatibles for LS1021A based boards
      arm64: dts: rockchip: Add on-board WiFi/BT support for Rock960 boards
      arm64: dts: actions: Add interrupt properties to pinctrl node for S900
      arm64: dts: actions: Add Reset Controller support for S700 SoC
      arm64: dts: actions: Add Reset Controller support for S900 SoC

Manu Gautam (1):
      arm64: dts: qcom: sdm845: Fix pcs_misc region address for UNI PHY

Marc Gonzalez (1):
      arm64: dts: qcom: msm8998: Add rpmcc node

Marcin Niestroj (1):
      ARM: dts: am335x-chiliboard: Add stdout-path property

Marco Felsch (1):
      ARM: dts: imx6qdl-phytec-pfla02: add missing interrupt-controller property

Marek Szyprowski (7):
      ARM: dts: exynos: Fix conflicting fixed-regulator GPIO flags and
properties
      ARM: dts: exynos: Fix eMMC regulator properties on Odroid U3 boards
      ARM: dts: exynos: Fix pinctrl definition for eMMC RTSN line on
Odroid X2/U3
      ARM: dts: exynos: Add minimal clkout parameters to Exynos3250 PMU
      ARM: dts: exynos: Add stdout path property to Arndale board
      ARM: dts: exynos: Disable ARM PMU on Odroid XU3-lite
      ARM: dts: exynos: Fix max voltage for buck8 regulator on Odroid XU3/XU4

Marek Vasut (1):
      arm64: dts: renesas: r8a77990: ebisu: Fix backlight regulator numbering

Mark Walton (1):
      ARM: dts: aspeed: Add #interrupt-cells property to gpio controllers

Mark Yao (1):
      ARM: dts: rockchip: add rk3066 vop display nodes

Mark Zhang (6):
      arm64: tegra: Remove property gpio-keys,name
      dt-bindings: tegra: Add Shield TV device tree binding documentation
      arm64: tegra: Add support for NVIDIA Shield TV
      arm64: tegra: Add gpio-keys nodes for Darcy
      arm64: tegra: Add pinmux for Darcy board
      arm64: tegra: Add regulators for Tegra210 Darcy

Martin Blumenstingl (17):
      ARM: dts: meson6: add the APB2 bus
      ARM: dts: meson8: add the APB bus
      ARM: dts: meson8b: add the APB bus
      dt-bindings: gpu: mali-utgard: add Amlogic Meson8 and Meson8b compatible
      ARM: dts: meson8: add the Mali-450 MP6 GPU
      ARM: dts: meson8b: add the Mali-450 MP2 GPU
      ARM: dts: meson8b: fix the Ethernet data line signals in eth_rgmii_pins
      ARM: dts: meson: switch the clock controller to the HHI register area
      ARM: dts: meson8m2: use the Meson8m2 specific SAR ADC compatible
      ARM: dts: meson8: add the temperature calibration data for the SAR ADC
      ARM: dts: meson8b: add the temperature calibration data for the SAR ADC
      ARM: dts: meson8b: ec100: add iio-hwmon for the chip temperature
      ARM: dts: meson8b: odroidc1: add iio-hwmon for the chip temperature
      ARM: dts: meson8m2: mxiii-plus: add iio-hwmon for the chip temperature
      ARM: dts: meson8b: ec100: enable the Ethernet PHY interrupt
      ARM: dts: meson8b: ec100: improve the description of the regulators
      ARM: dts: meson8b: ec100: add the GPIO line names

Martyn Welch (3):
      dt-bindings: Add vendor prefix for Catalyst Semiconductor
      ARM: dts: imx6: Add support for Phytec phyBOARD i.MX6UL Segin
      ARM: dts: am335x: Add support for Bosch Guardian

Masahiro Yamada (1):
      arm64: dts: uniphier: sort labels in the same order as in dtsi

Mathieu Malaterre (1):
      ARM: dts: lpc32xx: Remove leading 0x and 0s from bindings notation

Matthias Brugger (1):
      arm64: dts: Add uart for mt6797 EVB

Maxime Jourdan (3):
      arm64: dts: meson-gx: Add canvas provider node to the vpu
      dt-bindings: meson: add specific simplefb bindings
      arm64: dts: meson-gx: add support for simplefb

Maxime Ripard (1):
      ARM: dts: sun7i: bananapi: Add GPIO banks regulators

Mikko Perttunen (2):
      arm64: tegra: Add nodes for TCU on Tegra194
      arm64: tegra: Mark TCU as primary serial port on Tegra194 P2888

Miquel Raynal (12):
      arm64: dts: marvell: add interrupt support to ap806 thermal node
      arm64: dts: marvell: add interrupt support to cp110 thermal node
      arm64: dts: marvell: armada-37xx: fix SATA node scope
      arm64: dts: marvell: armada-37xx: declare SATA clock
      arm64: dts: marvell: armada-37xx: fix USB2 memory region
      arm64: dts: marvell: armada-37xx: declare USB2 UTMI PHYs
      arm64: dts: marvell: armada-37xx: declare PCIe reset pin
      arm64: dts: marvell: armada-3720-espressobin: declare PCIe warm reset pin
      arm64: dts: marvell: armada-37xx: declare the COMPHY node
      arm64: dts: marvell: armada-3720-espressobin: declare PCIe PHY
      arm64: dts: marvell: armada-3720-espressobin: declare SATA PHY property
      arm64: dts: marvell: armada-37xx: link USB hosts with their PHYs

Niklas Cassel (2):
      arm64: dts: msm8916: remove bogus argument to the cpu clock
      ARM: dts: qcom: ipq4019: Fix MSI IRQ type

Niklas Söderlund (1):
      arm64: dts: renesas: enable HS400 on R-Car Gen3

Nipun Gupta (2):
      arm64: dts: ls1088: add smmu device node
      arm64: dts: ls1088: add missing dma-coherent property in fsl-mc

Otavio Salvador (7):
      ARM: dts: rockchip: Add missing dma-names SPI support for rv1108
      ARM: dts: rockchip: rv1108: Add spim0 and spim1 pinctrl groups
      dt-bindings: Add vendor prefix for elgin
      ARM: dts: rv1108: Add support for rv1108-elgin-r1 board
      ARM: dts: rockchip: Fix vcc5/6-supply representation on rv1108-elgin
      ARM: dts: rockchip: Use the correct regulator properties on rv1108-elgin
      ARM: dts: rockchip: Use the correct regulator properties on rv1108-evb

Parthiban Nallathambi (2):
      arm64: dts: actions: s700: Add I2C controller nodes
      arm64: dts: actions: s700-cubieboard7: Enable I2C0 and I2C1

Patrick Havelange (1):
      ARM: dts: ls1021a: Add memory controller

Patrick Venture (2):
      ARM: dts: aspeed: quanta-q71l: enable lpc_ctrl node
      ARM: dts: aspeed: quanta-q71l: enable uart1

Paul Kocialkowski (2):
      ARM: dts: sun4i: Add support for the C1 SRAM region with the
SRAM controller
      ARM: dts: sun4i-a10: Add Video Engine and reserved memory nodes

Paweł Chmiel (5):
      ARM: dts: s5pv210: Add node for exynos-rotator
      ARM: dts: s5pv210: Use correct fimd variant
      ARM: dts: s5pv210: Remove hardcoded bootargs on Galaxy S and Fascinate 4G
      ARM: dts: s5pv210: Add reserved memory for MFC on Aries
      ARM: dts: s5pv210: Add DMC nodes

Peter De Schrijver (1):
      dt-bindings: clock: tegra124-dfll: Update DFLL binding for PWM regulator

Peter Geis (1):
      arm64: dts: rockchip: fix rk3328-roc-cc gmac2io stability issues

Peter Ujfalusi (2):
      ARM: dts: da850-lcdk: Enable the analog mic input
      ARM: dts: omap4-sdp: Make ethernet working even if booted with
latest u-boot

Philipp Zabel (1):
      ARM: dts: pfla02: add ksz9031 clock skew values

Philippe Schenker (1):
      ARM: dts: Add stmpe-adc DT node to Toradex iMX6 modules

Rafał Miłecki (1):
      ARM: tegra: add "jedec,spi-nor" flash compatible binding

Rajendra Nayak (2):
      arm64: dts: msm8996: Add rpmpd device node
      arm64: dts: sdm845: Add rpmh powercontroller node

Ran Wang (2):
      arm64: dts: layerscape: Add incr-burst-type-adjustment property
to USB3 node
      ARM: dts: ls1021a: Add incr-burst-byte-adjustment property to USB3 node

Remi Pommarel (2):
      arm64: dts: armada-3720-espressobin: Configure RGMII and SMI pins
      arm64: dts: armada-3720-espressobin: Set mv88e6341 cpu port as RGMII-ID

Rob Herring (4):
      dt-bindings: arm: Convert Renesas board/soc bindings to json-schema
      dt-bindings: arm: Convert FSL board/soc bindings to json-schema
      ARM: dts: Kill off skeleton{64}.dtsi
      arm64: dts: Remove inconsistent use of 'arm,armv8' compatible string

Robert Marko (1):
      ARM: dts: ipq4019: Remove skeleton.dtsi

Robin Murphy (5):
      arm64: dts: rockchip: Add DT for NanoPi M4
      arm64: dts: rockchip: Refine nanopi4 differences
      arm64: dts: rockchip: Add NanoPC-T4 IR receiver
      arm64: dts: rockchip: 'Fix' nanopi4 uSD card detect
      arm64: dts: rockchip: Add nanopi4 bluetooth

Roger Quadros (3):
      arm64: dts: ti: k3-am65: Add MSMC RAM node
      arm64: dts: ti: k3-am6: add USB support
      arm64: dts: ti: k3-am654-base-board: enable USB1

Ryder Lee (3):
      dt-bindings: arm: mediatek: remove unused "mediatek, mt7623a"
      dt-bindings: arm: mediatek: add support for MT7622 BPI-R64 and MT7629 RFB
      dt-bindings: interrupt-controller: update bindings for MT7623

Sai Prakash Ranjan (1):
      arm64: dts: qcom: sdm845: Remove the duplicate header inclusion

Samuel Holland (1):
      arm64: dts: allwinner: a64: Enable A64 timer workaround

Saravanan Sekar (1):
      arm64: dts: actions: Add pinctrl node for Actions Semi S700

Sergei Shtylyov (1):
      arm64: dts: renesas: v3msk: specify EtherAVB PHY IRQ

Shawn Guo (1):
      arm64: dts: hi3798cv200: fix malformed SPDX license identifier

Shawn Lin (2):
      arm64: dts: rockchip: clean up the abuse of disable-wp
      ARM: dts: rockchip: clean up the abuse of disable-wp

Sibi Sankar (3):
      arm64: dts: qcom: sdm845: Add SCM DT node
      arm64: dts: qcom: sdm845: Add PDC Global reset driver node
      arm64: dts: qcom: sdm845: Add reserve-memory nodes

Simon Goldschmidt (1):
      ARM: dts: socfpga: update more missing reset properties

Simon Horman (2):
      arm64: dts: renesas: r8a77990: sort pciec0 node within soc node
      arm64: dts: renesas: r8a77990: ebisu: Enable HS400 of SDHI3

Soeren Moch (1):
      ARM: dts: imx6q-tbs2910: Switch to SPDX identifier

Sowjanya Komatineni (5):
      arm64: tegra: Add SDMMC auto-calibration settings
      arm64: tegra: Add CQE Support for SDMMC4
      arm64: tegra: Support 200 MHz for SDMMC on Tegra194
      arm64: tegra: Update compatible for Tegra210 I2C
      arm64: tegra: Update compatible for Tegra186 I2C

Stefan Agner (2):
      ARM: dts: imx6*-apalis/-colibri: mark I2C recovery GPIOs as open drain
      ARM: dts: colibri: use valid range configuration for weim

Stefan Wahren (12):
      dt-bindings: bcm: Add Raspberry Pi 3 A+
      ARM: dts: add Raspberry Pi 3 A+
      ARM: dts: bcm283x: Fix DTC warning for memory node
      ARM: dts: bcm2835-rpi: Drop unnecessary #address-cells/#size-cells
      ARM: dts: bcm2835: Fix labels for GPIO 0,1
      ARM: dts: bcm2837-rpi-3-b: Use consistent label for HDMI hotplug
      ARM: dts: bcm2837-rpi-3-b-plus: Clarify label for STATUS_LED
      ARM: dts: bcm283x: Add missing GPIO line names
      ARM: dts: bcm2835-rpi-zero-w: Drop unnecessary pinctrl
      ARM: dts: add Raspberry Pi 3 A+
      arm64: dts: broadcom: Add reference to RPi 3 A+
      ARM: dts: imx6ull: Fix i.MX6ULL/ULZ ocotp compatible

Sudeep Holla (7):
      ARM: dts: at91: replace gpio-key,wakeup with wakeup-source property
      ARM: dts: vexpress: use list instead of tuple for mmci interrupts
      ARM: dts: am437x: replace linux,wakeup with wakeup-source property
      arm64: dts: juno/fast models: using GIC macros instead of hardcoded values
      arm64: dts: models: use list instead of tuple for mmci interrupts
      arm64: dts: juno/fast models: sort couple of device nodes
      ARM: dts: zynq: replace gpio-key,wakeup with wakeup-source property

Sylwester Nawrocki (2):
      ARM: dts: exynos: Add support for secondary DAI to Odroid XU3
      ARM: dts: exynos: Add support for secondary DAI to Odroid XU4

Takeshi Kihara (1):
      arm64: dts: renesas: r8a77990: Add OPPs table for cpu devices

Taniya Das (3):
      arm64: dts: sdm845: Add cpufreq device node
      arm64: dts: sdm845: Add videocc node
      arm64: dts: sdm845: Add lpasscc node

Thierry Reding (6):
      arm64: tegra: Use GIC_SPI for PMIC interrupt on Smaug
      arm64: tegra: p2972: Sort nodes properly
      arm64: tegra: p2597: Sort nodes by unit-address
      arm64: tegra: p3310: Use TEGRA186_ prefix for GPIO names
      arm64: tegra: p2771-0000: Use TEGRA186_ prefix for GPIO names
      dt-bindings: firmware: tegra186-bpmp: Remove name property

Thor Thayer (1):
      arm64: dts: stratix10: Add Stratix10 SMMU support

Timo Alho (1):
      dt-bindings: firmware: Add bindings for Tegra210 BPMP

Tomeu Vizoso (1):
      arm64: dts: rockchip: Add devicetree for NanoPC-T4

Tony Lindgren (4):
      ARM: dts: Add wlcore wakeirq for omap3-evm
      ARM: dts: Configure wlcore wakeirq for pandaboard
      ARM: dts: omap4-droid4: Configure wlcore wakeirq
      Merge branch 'omap-for-v4.21/dt' into omap-for-v5.1/dt

Ulrich Hecht (2):
      ARM: dts: r8a7778: Add HSCIF0/1 support
      ARM: dts: r8a7779: Add HSCIF0/1 device nodes

Vignesh R (2):
      dt-bindings: input: ti-tsc-adc: Add new compatible for AM654 SoCs
      arm64: dts: ti: k3-am65-mcu: Add ADC nodes

Vijay Khemka (5):
      ARM: dts: aspeed: Add KCS support for LPC BMC
      ARM: dts: aspeed: tiogapass: Enable KCS
      ARM: dts: aspeed: tiogapass: Add sensors
      ARM: dts: aspeed: tiogapass: Add LPC devices
      ARM: dts: aspeed: tiogapass: Add uarts for SoL

Vincent Guittot (1):
      arm64: dts: hikey960: fix SDcard detection

Viresh Kumar (2):
      ARM64: dts: mediatek: Add all CPUs in cooling maps
      ARM: dts: mt7623: Add all CPUs in cooling maps

Vivek Gautam (1):
      arm64: dts: sdm845: Add node for arm,mmu-500

Vladimir Murzin (1):
      ARM: dts: mps2: use list instead of tuple for uart interrupts

Vladimir Vid (1):
      arm64: dts: marvell: Add device tree for uDPU board

Vladimir Zapolskiy (12):
      ARM: dts: lpc435x: remove address and size cells from
gpio-keys-polled nodes
      ARM: dts: Add DT for MYIR Tech MYD-LPC4357 Development Board
      ARM: dts: lpc32xx: add required clocks property to keypad device node
      ARM: dts: lpc32xx: reparent keypad controller to SIC1
      ARM: dts: lpc32xx: fix ARM PrimeCell LCD controller variant
      ARM: dts: lpc32xx: fix ARM PrimeCell LCD controller clocks property
      ARM: dts: lpc32xx: phy3250: fix SD card regulator voltage
      ARM: dts: lpc32xx: phy3250: remove regulators umbrella device node
      ARM: dts: lpc32xx: phy3250: setup LCD controller to panel interface
      ARM: dts: lpc32xx: phy3250: add unit address to memory device node
      ARM: dts: lpc32xx: ea3250: add unit address to memory device node
      ARM: dts: lpc32xx: ea3250: beautify gpio keys children nodes

Vokáč Michal (2):
      dt-bindings: arm: Add Y Soft IOTA Draco, Hydra and Ursa boards
      ARM: dts: imx: Add Y Soft IOTA Draco, Hydra and Ursa boards

Xiaoting Liu (1):
      ARM: dts: aspeed: stardragon4800: Add power supply

YT Shen (6):
      arm64: dts: add iommu/smi nodes for MT2712
      arm64: dts: add i2c nodes for MT2712
      arm64: dts: add spi nodes for MT2712
      arm64: dts: add pwm nodes for MT2712
      arm64: dts: add mmc nodes for MT2712
      arm64: dts: add nand nodes for MT2712

Yogesh Narayan Gaur (2):
      arm64: dts: lx2160a: add FlexSPI node property
      arm64: dts: lx2160a: update fspi node

(dirstat only)
   0.0% Documentation/devicetree/bindings/arm/bcm/
   0.1% Documentation/devicetree/bindings/arm/freescale/
   5.2% Documentation/devicetree/bindings/arm/
   0.5% Documentation/devicetree/bindings/clock/
   0.0% Documentation/devicetree/bindings/cpufreq/
   0.1% Documentation/devicetree/bindings/display/
   0.2% Documentation/devicetree/bindings/firmware/
   0.0% Documentation/devicetree/bindings/gpu/
   0.0% Documentation/devicetree/bindings/input/touchscreen/
   0.0% Documentation/devicetree/bindings/interrupt-controller/
   0.0% Documentation/devicetree/bindings/net/
   0.0% Documentation/devicetree/bindings/sram/
   0.0% Documentation/devicetree/bindings/
  34.1% arch/arm/boot/dts/
   0.4% arch/arm/mach-omap2/
   0.5% arch/arm64/boot/dts/actions/
   0.0% arch/arm64/boot/dts/al/
   0.4% arch/arm64/boot/dts/allwinner/
   0.2% arch/arm64/boot/dts/altera/
   0.9% arch/arm64/boot/dts/amlogic/
   0.1% arch/arm64/boot/dts/apm/
   3.4% arch/arm64/boot/dts/arm/
   0.0% arch/arm64/boot/dts/broadcom/northstar2/
   0.1% arch/arm64/boot/dts/broadcom/stingray/
   0.0% arch/arm64/boot/dts/broadcom/
   0.7% arch/arm64/boot/dts/cavium/
   0.1% arch/arm64/boot/dts/exynos/
   5.7% arch/arm64/boot/dts/freescale/
   1.6% arch/arm64/boot/dts/hisilicon/
   0.1% arch/arm64/boot/dts/lg/
   1.2% arch/arm64/boot/dts/marvell/
   3.0% arch/arm64/boot/dts/mediatek/
  11.3% arch/arm64/boot/dts/nvidia/
   8.4% arch/arm64/boot/dts/qcom/
   0.0% arch/arm64/boot/dts/realtek/
  11.9% arch/arm64/boot/dts/renesas/
   5.9% arch/arm64/boot/dts/rockchip/
   0.5% arch/arm64/boot/dts/socionext/
   0.5% arch/arm64/boot/dts/sprd/
   0.1% arch/arm64/boot/dts/synaptics/
   0.9% arch/arm64/boot/dts/ti/
   0.0% arch/arm64/boot/dts/xilinx/
   0.0% arch/arm64/boot/dts/zte/
   0.0% include/dt-bindings/clock/

 539 files changed, 21291 insertions(+), 2852 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/armadeus.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/bhf.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/compulab-boards.txt
 create mode 100644
Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-sim.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/fsl.txt
 create mode 100644 Documentation/devicetree/bindings/arm/fsl.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/i2se.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/olimex.txt
 create mode 100644 Documentation/devicetree/bindings/arm/renesas.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/shmobile.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/technologic.txt
 create mode 100644
Documentation/devicetree/bindings/display/amlogic,simple-framebuffer.txt
 create mode 100644
Documentation/devicetree/bindings/firmware/nvidia,tegra210-bpmp.txt
 create mode 100644 arch/arm/boot/dts/am335x-guardian.dts
 create mode 100644 arch/arm/boot/dts/am3874-iceboard.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-inspur-on5263m5.dts
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
 create mode 100644 arch/arm/boot/dts/bcm47094-phicomm-k3.dts
 create mode 100644 arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
 create mode 100644 arch/arm/boot/dts/imx6-logicpd-som.dtsi
 create mode 100644 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
 create mode 100644 arch/arm/boot/dts/imx6dl-yapp4-draco.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-yapp4-hydra.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-yapp4-ursa.dts
 create mode 100644 arch/arm/boot/dts/imx6q-logicpd.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-phytec-pcl063.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-phytec-peb-eval-01.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-full.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-phytec-phyboard-segin.dtsi
 create mode 100644 arch/arm/boot/dts/lpc4357-myd-lpc4357.dts
 create mode 100644 arch/arm/boot/dts/r7s9210-rza2mevb.dts
 create mode 100644 arch/arm/boot/dts/r7s9210.dtsi
 create mode 100644 arch/arm/boot/dts/rv1108-elgin-r1.dts
 delete mode 100644 arch/arm/boot/dts/skeleton.dtsi
 delete mode 100644 arch/arm/boot/dts/skeleton64.dtsi
 create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_chameleon96.dts
 create mode 100644 arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
 create mode 100644 arch/arm64/boot/dts/arm/fvp-base-revc.dts
 create mode 100644 arch/arm64/boot/dts/arm/rtsm_ve-motherboard-rs2.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra210-p2894-0050-a08.dts
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra210-p2894.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/cat875.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774c0-ek874.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774c0.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts
