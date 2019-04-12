Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC4DC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5864C20869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfDLQ3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:29:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50629 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfDLQ2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:28:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id z11so12060840wmi.0;
        Fri, 12 Apr 2019 09:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gRcLxeyXZvImWtR8ZwiWsNAa2GeuTR6HPCLNOg8VDeg=;
        b=hdDHE9fjV/8oaowgtOxhXiUrmaQHEfx3baL3a34z77U1F0jVQAT1dWgLkm7NK/RBbH
         AQEvvETJw+VZK7xIPvmuZD8Ur1DIUucfkCqYFAs56EEd7iLcEhGFtyWcslByP97HwiZw
         USTC5YoSQY+Yx1NWkKKOfnz1IBgowVUo1RIY5R/8Ywd0bR77e30aC4B489qfGPg5oWYR
         k+Rk91a+LPGkux7TjjNYwlg9SfKRdyjN7Q6v6s6xsLWhF/fVppi+0lTKo27WEBKIwU8a
         X/EZUv5+7XsSg6Mr7kG5lwfLcT5mvZ2DEUiGO4U+6Vl6+HJwxmRQ/us9MCVQXgzzpYqf
         y+Eg==
X-Gm-Message-State: APjAAAUfdZ2K1wYdT9fHxz++aCUmFldMiifNYkuFygkk3pn6YUpuKsuB
        rpQGe79p7eoGarJWs0GyGIw=
X-Google-Smtp-Source: APXvYqzPtLxNxtJ0Leo5ZTEeRR2TH+CiLeMMjFiHGrVo9u80MAP5R067mdRj1LJ0IufQpNAP00vzSA==
X-Received: by 2002:a1c:a103:: with SMTP id k3mr11938827wme.8.1555086510231;
        Fri, 12 Apr 2019 09:28:30 -0700 (PDT)
Received: from localhost ([90.85.130.193])
        by smtp.gmail.com with ESMTPSA id c20sm76503189wre.28.2019.04.12.09.28.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 09:28:29 -0700 (PDT)
From:   Christina Quast <cquast@hanoverdisplays.com>
Cc:     Christina Quast <cquast@hanoverdisplays.com>,
        Benoit Cousson <bcousson@baylibre.com>,
        Mark Jackson <mpfj@newflow.co.uk>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/17] ARM: dts: am335x: pepper: Replaced register offsets with defines
Date:   Fri, 12 Apr 2019 18:26:21 +0200
Message-Id: <20190412162627.24518-12-cquast@hanoverdisplays.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190412162627.24518-1-cquast@hanoverdisplays.com>
References: <20190412162627.24518-1-cquast@hanoverdisplays.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The defines are taken from dt-bindings/pinctrl/am33xx.h

Signed-off-by: Christina Quast <cquast@hanoverdisplays.com>
---
 arch/arm/boot/dts/am335x-pepper.dts | 200 ++++++++++++++--------------
 1 file changed, 100 insertions(+), 100 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am335x-pepper.dts
index 6be79b8349ac..5c3e49f93ac4 100644
--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -93,14 +93,14 @@
 &am33xx_pinmux {
 	i2c0_pins: pinmux_i2c0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x988, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_sda.i2c0_sda */
-			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c0_scl.i2c0_scl */
+			AM33XX_PADCONF(AM335X_PIN_I2C0_SDA, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_I2C0_SCL, PIN_INPUT_PULLUP, MUX_MODE0)
 		>;
 	};
 	i2c1_pins: pinmux_i2c1 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x90C, PIN_INPUT_PULLUP | MUX_MODE3)	/* mii1_crs,i2c1_sda */
-			AM33XX_IOPAD(0x910, PIN_INPUT_PULLUP | MUX_MODE3)	/* mii1_rxerr,i2c1_scl */
+			AM33XX_PADCONF(AM335X_PIN_MII1_CRS, PIN_INPUT_PULLUP, MUX_MODE3)	/* mii1_crs,i2c1_sda */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RX_ER, PIN_INPUT_PULLUP, MUX_MODE3)	/* mii1_rxerr,i2c1_scl */
 		>;
 	};
 };
@@ -130,7 +130,7 @@
 &am33xx_pinmux {
 	accel_pins: pinmux_accel {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x898, PIN_INPUT | MUX_MODE7)   /* gpmc_wen.gpio2_4 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WEN, PIN_INPUT, MUX_MODE7)   /* gpmc_wen.gpio2_4 */
 		>;
 	};
 };
@@ -177,12 +177,12 @@
 &am33xx_pinmux {
 	audio_pins: pinmux_audio {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9ac, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_ahcklx.mcasp0_ahclkx */
-			AM33XX_IOPAD(0x994, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_fsx.mcasp0_fsx */
-			AM33XX_IOPAD(0x990, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_aclkx.mcasp0_aclkx */
-			AM33XX_IOPAD(0x998, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_axr0.mcasp0_axr0 */
-			AM33XX_IOPAD(0x9a8, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_axr1.mcasp0_axr1 */
-			AM33XX_IOPAD(0x840, PIN_OUTPUT | MUX_MODE7)	/* gpmc_a0.gpio1_16 */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_AHCLKX, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_FSX, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_ACLKX, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_AXR0, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_AXR1, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A0, PIN_OUTPUT, MUX_MODE7)	/* gpmc_a0.gpio1_16 */
 		>;
 	};
 };
@@ -228,36 +228,36 @@
 &am33xx_pinmux {
 	lcd_pins: pinmux_lcd {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8a0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data0.lcd_data0 */
-			AM33XX_IOPAD(0x8a4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data1.lcd_data1 */
-			AM33XX_IOPAD(0x8a8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data2.lcd_data2 */
-			AM33XX_IOPAD(0x8ac, PIN_OUTPUT | MUX_MODE0)	/* lcd_data3.lcd_data3 */
-			AM33XX_IOPAD(0x8b0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data4.lcd_data4 */
-			AM33XX_IOPAD(0x8b4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data5.lcd_data5 */
-			AM33XX_IOPAD(0x8b8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data6.lcd_data6 */
-			AM33XX_IOPAD(0x8bc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data7.lcd_data7 */
-			AM33XX_IOPAD(0x8c0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data8.lcd_data8 */
-			AM33XX_IOPAD(0x8c4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data9.lcd_data9 */
-			AM33XX_IOPAD(0x8c8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data10.lcd_data10 */
-			AM33XX_IOPAD(0x8cc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data11.lcd_data11 */
-			AM33XX_IOPAD(0x8d0, PIN_OUTPUT | MUX_MODE0)	/* lcd_data12.lcd_data12 */
-			AM33XX_IOPAD(0x8d4, PIN_OUTPUT | MUX_MODE0)	/* lcd_data13.lcd_data13 */
-			AM33XX_IOPAD(0x8d8, PIN_OUTPUT | MUX_MODE0)	/* lcd_data14.lcd_data14 */
-			AM33XX_IOPAD(0x8dc, PIN_OUTPUT | MUX_MODE0)	/* lcd_data15.lcd_data15 */
-			AM33XX_IOPAD(0x820, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad8.lcd_data16 */
-			AM33XX_IOPAD(0x824, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad9.lcd_data17 */
-			AM33XX_IOPAD(0x828, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad10.lcd_data18 */
-			AM33XX_IOPAD(0x82c, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad11.lcd_data19 */
-			AM33XX_IOPAD(0x830, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad12.lcd_data20 */
-			AM33XX_IOPAD(0x834, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad13.lcd_data21 */
-			AM33XX_IOPAD(0x838, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad14.lcd_data22 */
-			AM33XX_IOPAD(0x83c, PIN_OUTPUT | MUX_MODE1)	/* gpmc_ad15.lcd_data23 */
-			AM33XX_IOPAD(0x8e0, PIN_OUTPUT | MUX_MODE0)	/* lcd_vsync.lcd_vsync */
-			AM33XX_IOPAD(0x8e4, PIN_OUTPUT | MUX_MODE0)	/* lcd_hsync.lcd_hsync */
-			AM33XX_IOPAD(0x8e8, PIN_OUTPUT | MUX_MODE0)	/* lcd_pclk.lcd_pclk */
-			AM33XX_IOPAD(0x8ec, PIN_OUTPUT | MUX_MODE0)	/* lcd_ac_bias_en.lcd_ac_bias_en */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA0, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA1, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA2, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA3, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA4, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA5, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA6, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA7, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA8, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA9, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA10, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA11, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA12, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA13, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA14, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA15, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD8, PIN_OUTPUT, MUX_MODE1)	/* gpmc_ad8.lcd_data16 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD9, PIN_OUTPUT, MUX_MODE1)	/* gpmc_ad9.lcd_data17 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD10, PIN_OUTPUT, MUX_MODE1)	/* gpmc_ad10.lcd_data18 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD11, PIN_OUTPUT, MUX_MODE1)	/* gpmc_ad11.lcd_data19 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD12, PIN_OUTPUT, MUX_MODE1)	/* gpmc_ad12.lcd_data20 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD13, PIN_OUTPUT, MUX_MODE1)	/* gpmc_ad13.lcd_data21 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD14, PIN_OUTPUT, MUX_MODE1)	/* gpmc_ad14.lcd_data22 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD15, PIN_OUTPUT, MUX_MODE1)	/* gpmc_ad15.lcd_data23 */
+			AM33XX_PADCONF(AM335X_PIN_LCD_VSYNC, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_HSYNC, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_PCLK, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_AC_BIAS_EN, PIN_OUTPUT, MUX_MODE0)
 			/* Display Enable */
-			AM33XX_IOPAD(0x86c, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_a11.gpio1_27 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A11, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* gpmc_a11.gpio1_27 */
 		>;
 	};
 };
@@ -299,29 +299,29 @@
 &am33xx_pinmux {
 	ethernet_pins: pinmux_ethernet {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txen.rgmii1_tctl */
-			AM33XX_IOPAD(0x918, PIN_INPUT_PULLUP | MUX_MODE2)	/* mii1_rxdv.rgmii1_rctl */
-			AM33XX_IOPAD(0x91c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd3.rgmii1_td3 */
-			AM33XX_IOPAD(0x920, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd2.rgmii1_td2 */
-			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_td1 */
-			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_td0 */
-			AM33XX_IOPAD(0x92c, PIN_INPUT_PULLUP | MUX_MODE2)	/* mii1_txclk.rgmii1_tclk */
-			AM33XX_IOPAD(0x930, PIN_INPUT_PULLUP | MUX_MODE2)	/* mii1_rxclk.rgmii1_rclk */
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLUP | MUX_MODE2)	/* mii1_rxd3.rgmii1_rxd3 */
-			AM33XX_IOPAD(0x938, PIN_INPUT_PULLUP | MUX_MODE2)	/* mii1_rxd2.rgmii1_rxd2 */
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLUP | MUX_MODE2)	/* mii1_rxd1.rgmii1_rxd1 */
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLUP | MUX_MODE2)	/* mii1_rxd0.rgmii1_rxd0 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TX_EN, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txen.rgmii1_tctl */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RX_DV, PIN_INPUT_PULLUP, MUX_MODE2)	/* mii1_rxdv.rgmii1_rctl */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD3, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txd3.rgmii1_td3 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD2, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txd2.rgmii1_td2 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD1, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txd1.rgmii1_td1 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD0, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txd0.rgmii1_td0 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TX_CLK, PIN_INPUT_PULLUP, MUX_MODE2)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RX_CLK, PIN_INPUT_PULLUP, MUX_MODE2)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLUP, MUX_MODE2)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD2, PIN_INPUT_PULLUP, MUX_MODE2)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLUP, MUX_MODE2)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLUP, MUX_MODE2)
 			/* ethernet interrupt */
-			AM33XX_IOPAD(0x944, PIN_INPUT_PULLUP | MUX_MODE7)	/* rmii2_refclk.gpio0_29 */
+			AM33XX_PADCONF(AM335X_PIN_RMII1_REF_CLK, PIN_INPUT_PULLUP, MUX_MODE7)	/* rmii2_refclk.gpio0_29 */
 			/* ethernet PHY nReset */
-			AM33XX_IOPAD(0x908, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* mii1_col.gpio3_0 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_COL, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* mii1_col.gpio3_0 */
 		>;
 	};
 
 	mdio_pins: pinmux_mdio {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
-			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+			AM33XX_PADCONF(AM335X_PIN_MDIO, PIN_INPUT_PULLUP | SLEWCTRL_FAST, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MDC, PIN_OUTPUT_PULLUP, MUX_MODE0)
 		>;
 	};
 };
@@ -364,45 +364,45 @@
 &am33xx_pinmux {
 	sd_pins: pinmux_sd_card {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat0.mmc0_dat0 */
-			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat1.mmc0_dat1 */
-			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat2.mmc0_dat2 */
-			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat3.mmc0_dat3 */
-			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_clk.mmc0_clk */
-			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
-			AM33XX_IOPAD(0x960, PIN_INPUT | MUX_MODE7)		/* spi0_cs1.gpio0_6 */
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT3, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT2, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT1, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT0, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_CLK, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_CMD, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_SPI0_CS1, PIN_INPUT, MUX_MODE7)		/* spi0_cs1.gpio0_6 */
 		>;
 	};
 	emmc_pins: pinmux_emmc {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_csn1.mmc1_clk */
-			AM33XX_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2)	/* gpmc_csn2.mmc1_cmd */
-			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad0.mmc1_dat0 */
-			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad1.mmc1_dat1 */
-			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad2.mmc1_dat2 */
-			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad3.mmc1_dat3 */
-			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad4.mmc1_dat4 */
-			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad5.mmc1_dat5 */
-			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad6.mmc1_dat6 */
-			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE1)	/* gpmc_ad7.mmc1_dat7 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN1, PIN_INPUT_PULLUP, MUX_MODE2)	/* gpmc_csn1.mmc1_clk */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN2, PIN_INPUT_PULLUP, MUX_MODE2)	/* gpmc_csn2.mmc1_cmd */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD0, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad0.mmc1_dat0 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD1, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad1.mmc1_dat1 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD2, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad2.mmc1_dat2 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD3, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad3.mmc1_dat3 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD4, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad4.mmc1_dat4 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD5, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad5.mmc1_dat5 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD6, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad6.mmc1_dat6 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD7, PIN_INPUT_PULLUP, MUX_MODE1)	/* gpmc_ad7.mmc1_dat7 */
 			/* EMMC nReset */
-			AM33XX_IOPAD(0x874, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_wpn.gpio0_31 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WPN, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* gpmc_wpn.gpio0_31 */
 		>;
 	};
 	wireless_pins: pinmux_wireless {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x844, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a1.mmc2_dat0 */
-			AM33XX_IOPAD(0x848, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a2.mmc2_dat1 */
-			AM33XX_IOPAD(0x84c, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_a3.mmc2_dat2 */
-			AM33XX_IOPAD(0x878, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ben1.mmc2_dat3 */
-			AM33XX_IOPAD(0x888, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_csn3.mmc2_cmd */
-			AM33XX_IOPAD(0x88c, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_clk.mmc1_clk */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A1, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_a1.mmc2_dat0 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A2, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_a2.mmc2_dat1 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A3, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_a3.mmc2_dat2 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_BEN1, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ben1.mmc2_dat3 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN3, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_csn3.mmc2_cmd */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CLK, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_clk.mmc1_clk */
 			/* WLAN nReset */
-			AM33XX_IOPAD(0x860, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_a8.gpio1_24 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A8, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* gpmc_a8.gpio1_24 */
 			/* WLAN nPower down */
-			AM33XX_IOPAD(0x870, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_wait0.gpio0_30 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WAIT0, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* gpmc_wait0.gpio0_30 */
 			/* 32kHz Clock */
-			AM33XX_IOPAD(0x9b4, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* xdma_event_intr1.clkout2 */
+			AM33XX_PADCONF(AM335X_PIN_XDMA_EVENT_INTR1, PIN_OUTPUT_PULLDOWN, MUX_MODE3)	/* xdma_event_intr1.clkout2 */
 		>;
 	};
 };
@@ -498,10 +498,10 @@
 &am33xx_pinmux {
 	spi0_pins: pinmux_spi0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x950, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_sclk.spi0_sclk */
-			AM33XX_IOPAD(0x95C, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_cs0.spi0_cs0 */
-			AM33XX_IOPAD(0x954, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_d0.spi0_d0 */
-			AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP | MUX_MODE0) /* spi0_d1.spi0_d1 */
+			AM33XX_PADCONF(AM335X_PIN_SPI0_SCLK, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_SPI0_CS0, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_SPI0_D0, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_SPI0_D1, PIN_INPUT_PULLUP, MUX_MODE0)
 		>;
 	};
 };
@@ -539,16 +539,16 @@
 &am33xx_pinmux {
 	uart0_pins: pinmux_uart0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
+			AM33XX_PADCONF(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART0_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
 		>;
 	};
 	uart1_pins: pinmux_uart1 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x978, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_ctsn.uart1_ctsn */
-			AM33XX_IOPAD(0x97C, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_rtsn.uart1_rtsn */
-			AM33XX_IOPAD(0x980, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_rxd.uart1_rxd */
-			AM33XX_IOPAD(0x984, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_txd.uart1_txd */
+			AM33XX_PADCONF(AM335X_PIN_UART1_CTSN, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART1_RTSN, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART1_RXD, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART1_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
 		>;
 	};
 };
@@ -591,9 +591,9 @@
 	usb_pins: pinmux_usb {
 		pinctrl-single,pins = <
 			/* USB0 Over-Current (active low) */
-			AM33XX_IOPAD(0x864, PIN_INPUT | MUX_MODE7)	/* gpmc_a9.gpio1_25 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A9, PIN_INPUT, MUX_MODE7)	/* gpmc_a9.gpio1_25 */
 			/* USB1 Over-Current (active low) */
-			AM33XX_IOPAD(0x868, PIN_INPUT | MUX_MODE7)	/* gpmc_a10.gpio1_26 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A10, PIN_INPUT, MUX_MODE7)	/* gpmc_a10.gpio1_26 */
 		>;
 	};
 };
@@ -649,16 +649,16 @@
 &am33xx_pinmux {
 	user_leds_pins: pinmux_user_leds {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x850, PIN_OUTPUT | MUX_MODE7)	/* gpmc_a4.gpio1_20 */
-			AM33XX_IOPAD(0x854, PIN_OUTPUT | MUX_MODE7)	/* gpmc_a5.gpio1_21 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A4, PIN_OUTPUT, MUX_MODE7)	/* gpmc_a4.gpio1_20 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A5, PIN_OUTPUT, MUX_MODE7)	/* gpmc_a5.gpio1_21 */
 		>;
 	};
 
 	user_buttons_pins: pinmux_user_buttons {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x858, PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_a6.gpio1_22 */
-			AM33XX_IOPAD(0x85C, PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_a7.gpio1_21 */
-			AM33XX_IOPAD(0x964, PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_a8.gpio0_7 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A6, PIN_INPUT_PULLUP, MUX_MODE7)	/* gpmc_a6.gpio1_22 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A7, PIN_INPUT_PULLUP, MUX_MODE7)	/* gpmc_a7.gpio1_21 */
+			AM33XX_PADCONF(AM335X_PIN_ECAP0_IN_PWM0_OUT, PIN_INPUT_PULLUP, MUX_MODE7)	/* gpmc_a8.gpio0_7 */
 		>;
 	};
 };
-- 
2.20.1

