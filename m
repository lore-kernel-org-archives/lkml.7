Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5508EC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D5121734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfDIQGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:06:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34534 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbfDIQGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:06:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id p10so21671119wrq.1;
        Tue, 09 Apr 2019 09:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YqbYz11eiPG2RYBGn8hZFF+7d04QBcoiGw4sN+8+3EE=;
        b=J0n6Qgsdv9zSW7R2RacDrL8ori6l/kyUIY7blyzlEgr8yFL1q70le8/3II/GicmrXd
         +v6HVnd9Iq82asFGFhoBCHP+Ovw2YsQiBJHN+PU/lZM9JRLpQ8mxMc17j++suAfH886J
         eRjgQYchguTUf5QR43SqcIE3Zk+jXUR3WxUNLR/d8s2mZSBOA5yPzwbiNX7W7fiO3a/W
         i/o4t6VtdjWl9M5GoHkhfTTNmnFyHVkutkaKitDL6GyEkGWQkPr45xfsm+sW5xazJjf9
         TkLNzDhmVNUyL3xnrZtEHtsI1dQVWPctzHJmGiPC20p86mtZMVDiGjO07H/jAIvazpwd
         a5xA==
X-Gm-Message-State: APjAAAX4DedSLAcIvE00DUElTY5bceP3MIl4S0eOqM2P9P0QoNBYlWmu
        rUgsiny9drBj0AaCwxwPWTI=
X-Google-Smtp-Source: APXvYqxsQDLwe9DIMiCODIbHl04lLE6fZXua5Bp81GcmG4ysoSzmKlilTsjtyWAIS3fCSkvAYlDc/A==
X-Received: by 2002:a05:6000:1152:: with SMTP id d18mr22735155wrx.32.1554825972995;
        Tue, 09 Apr 2019 09:06:12 -0700 (PDT)
Received: from localhost ([90.85.130.193])
        by smtp.gmail.com with ESMTPSA id y127sm16174121wmg.29.2019.04.09.09.06.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 09:06:12 -0700 (PDT)
From:   Christina Quast <cquast@hanoverdisplays.com>
To:     tony@atomide.com
Cc:     Christina Quast <cquast@hanoverdisplays.com>,
        Benoit Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/15] ARM: dts: am335x: icev2: Replaced register offsets with defines
Date:   Tue,  9 Apr 2019 18:03:46 +0200
Message-Id: <20190409160346.25599-16-cquast@hanoverdisplays.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409160346.25599-1-cquast@hanoverdisplays.com>
References: <20190409160346.25599-1-cquast@hanoverdisplays.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The defines are taken from dt-bindings/pinctrl/am33xx.h

Signed-off-by: Christina Quast <cquast@hanoverdisplays.com>
---
 arch/arm/boot/dts/am335x-icev2.dts | 116 ++++++++++++++---------------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/am335x-icev2.dts
index f2005ecca74f..51e1464b9c0e 100644
--- a/arch/arm/boot/dts/am335x-icev2.dts
+++ b/arch/arm/boot/dts/am335x-icev2.dts
@@ -157,111 +157,111 @@
 &am33xx_pinmux {
 	user_leds: user_leds {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x91c, PIN_OUTPUT | MUX_MODE7) /* (J18) gmii1_txd3.gpio0[16] */
-			AM33XX_IOPAD(0x920, PIN_OUTPUT | MUX_MODE7) /* (K15) gmii1_txd2.gpio0[17] */
-			AM33XX_IOPAD(0x9b0, PIN_OUTPUT | MUX_MODE7) /* (A15) xdma_event_intr0.gpio0[19] */
-			AM33XX_IOPAD(0x9b4, PIN_OUTPUT | MUX_MODE7) /* (D14) xdma_event_intr1.gpio0[20] */
-			AM33XX_IOPAD(0x880, PIN_OUTPUT | MUX_MODE7) /* (U9) gpmc_csn1.gpio1[30] */
-			AM33XX_IOPAD(0x92c, PIN_OUTPUT | MUX_MODE7) /* (K18) gmii1_txclk.gpio3[9] */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD3, PIN_OUTPUT, MUX_MODE7) /* (J18) gmii1_txd3.gpio0[16] */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD2, PIN_OUTPUT, MUX_MODE7) /* (K15) gmii1_txd2.gpio0[17] */
+			AM33XX_PADCONF(AM335X_PIN_XDMA_EVENT_INTR0, PIN_OUTPUT, MUX_MODE7) /* (A15) xdma_event_intr0.gpio0[19] */
+			AM33XX_PADCONF(AM335X_PIN_XDMA_EVENT_INTR1, PIN_OUTPUT, MUX_MODE7) /* (D14) xdma_event_intr1.gpio0[20] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN1, PIN_OUTPUT, MUX_MODE7) /* (U9) gpmc_csn1.gpio1[30] */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TX_CLK, PIN_OUTPUT, MUX_MODE7) /* (K18) gmii1_txclk.gpio3[9] */
 		>;
 	};
 
 	mmc0_pins_default: mmc0_pins_default {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0) /* (F17) mmc0_dat3.mmc0_dat3 */
-			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0) /* (F18) mmc0_dat2.mmc0_dat2 */
-			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0) /* (G15) mmc0_dat1.mmc0_dat1 */
-			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0) /* (G16) mmc0_dat0.mmc0_dat0 */
-			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0) /* (G17) mmc0_clk.mmc0_clk */
-			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0) /* (G18) mmc0_cmd.mmc0_cmd */
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT3, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT2, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT1, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT0, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_CLK, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_CMD, PIN_INPUT_PULLUP, MUX_MODE0)
 		>;
 	};
 
 	i2c0_pins_default: i2c0_pins_default {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x988, PIN_INPUT | MUX_MODE0) /* (C17) I2C0_SDA.I2C0_SDA */
-			AM33XX_IOPAD(0x98c, PIN_INPUT | MUX_MODE0) /* (C16) I2C0_SCL.I2C0_SCL */
+			AM33XX_PADCONF(AM335X_PIN_I2C0_SDA, PIN_INPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_I2C0_SCL, PIN_INPUT, MUX_MODE0)
 		>;
 	};
 
 	spi0_pins_default: spi0_pins_default {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x950, PIN_INPUT_PULLUP | MUX_MODE0) /* (A17) spi0_sclk.spi0_sclk */
-			AM33XX_IOPAD(0x954, PIN_INPUT_PULLUP | MUX_MODE0) /* (B17) spi0_d0.spi0_d0 */
-			AM33XX_IOPAD(0x958, PIN_INPUT_PULLUP | MUX_MODE0) /* (B16) spi0_d1.spi0_d1 */
-			AM33XX_IOPAD(0x95c, PIN_INPUT_PULLUP | MUX_MODE0) /* (A16) spi0_cs0.spi0_cs0 */
-			AM33XX_IOPAD(0x960, PIN_INPUT_PULLUP | MUX_MODE0) /* (C15) spi0_cs1.spi0_cs1 */
-			AM33XX_IOPAD(0x9a0, PIN_INPUT_PULLUP | MUX_MODE7) /* (B12) mcasp0_aclkr.gpio3[18] */
+			AM33XX_PADCONF(AM335X_PIN_SPI0_SCLK, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_SPI0_D0, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_SPI0_D1, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_SPI0_CS0, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_SPI0_CS1, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_ACLKR, PIN_INPUT_PULLUP, MUX_MODE7) /* (B12) mcasp0_aclkr.gpio3[18] */
 		>;
 	};
 
 	uart3_pins_default: uart3_pins_default {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLUP | MUX_MODE1) /* (L17) gmii1_rxd3.uart3_rxd */
-			AM33XX_IOPAD(0x938, PIN_OUTPUT_PULLUP | MUX_MODE1) /* (L16) gmii1_rxd2.uart3_txd */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLUP, MUX_MODE1) /* (L17) gmii1_rxd3.uart3_rxd */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD2, PIN_OUTPUT_PULLUP, MUX_MODE1) /* (L16) gmii1_rxd2.uart3_txd */
 		>;
 	};
 
 	cpsw_default: cpsw_default {
 		pinctrl-single,pins = <
 			/* Slave 1, RMII mode */
-			AM33XX_IOPAD(0x90c, (PIN_INPUT_PULLUP | MUX_MODE1))	/* mii1_crs.rmii1_crs_dv */
-			AM33XX_IOPAD(0x944, (PIN_INPUT_PULLUP | MUX_MODE0))	/* rmii1_refclk.rmii1_refclk */
-			AM33XX_IOPAD(0x940, (PIN_INPUT_PULLUP | MUX_MODE1))	/* mii1_rxd0.rmii1_rxd0 */
-			AM33XX_IOPAD(0x93c, (PIN_INPUT_PULLUP | MUX_MODE1))	/* mii1_rxd1.rmii1_rxd1 */
-			AM33XX_IOPAD(0x910, (PIN_INPUT_PULLUP | MUX_MODE1))	/* mii1_rxerr.rmii1_rxerr */
-			AM33XX_IOPAD(0x928, (PIN_OUTPUT_PULLDOWN | MUX_MODE1))	/* mii1_txd0.rmii1_txd0 */
-			AM33XX_IOPAD(0x924, (PIN_OUTPUT_PULLDOWN | MUX_MODE1))	/* mii1_txd1.rmii1_txd1 */
-			AM33XX_IOPAD(0x914, (PIN_OUTPUT_PULLDOWN | MUX_MODE1))	/* mii1_txen.rmii1_txen */
+			AM33XX_PADCONF(AM335X_PIN_MII1_CRS, PIN_INPUT_PULLUP, MUX_MODE1)	/* mii1_crs.rmii1_crs_dv */
+			AM33XX_PADCONF(AM335X_PIN_RMII1_REF_CLK, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLUP, MUX_MODE1)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLUP, MUX_MODE1)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RX_ER, PIN_INPUT_PULLUP, MUX_MODE1)	/* mii1_rxerr.rmii1_rxerr */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD0, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* mii1_txd0.rmii1_txd0 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD1, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* mii1_txd1.rmii1_txd1 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TX_EN, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* mii1_txen.rmii1_txen */
 			/* Slave 2, RMII mode */
-			AM33XX_IOPAD(0x870, (PIN_INPUT_PULLUP | MUX_MODE3))	/* gpmc_wait0.rmii2_crs_dv */
-			AM33XX_IOPAD(0x908, (PIN_INPUT_PULLUP | MUX_MODE1))	/* mii1_col.rmii2_refclk */
-			AM33XX_IOPAD(0x86c, (PIN_INPUT_PULLUP | MUX_MODE3))	/* gpmc_a11.rmii2_rxd0 */
-			AM33XX_IOPAD(0x868, (PIN_INPUT_PULLUP | MUX_MODE3))	/* gpmc_a10.rmii2_rxd1 */
-			AM33XX_IOPAD(0x874, (PIN_INPUT_PULLUP | MUX_MODE3))	/* gpmc_wpn.rmii2_rxerr */
-			AM33XX_IOPAD(0x854, (PIN_OUTPUT_PULLDOWN | MUX_MODE3))	/* gpmc_a5.rmii2_txd0 */
-			AM33XX_IOPAD(0x850, (PIN_OUTPUT_PULLDOWN | MUX_MODE3))	/* gpmc_a4.rmii2_txd1 */
-			AM33XX_IOPAD(0x840, (PIN_OUTPUT_PULLDOWN | MUX_MODE3))	/* gpmc_a0.rmii2_txen */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_wait0.rmii2_crs_dv */
+			AM33XX_PADCONF(AM335X_PIN_MII1_COL, PIN_INPUT_PULLUP, MUX_MODE1)	/* mii1_col.rmii2_refclk */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A11, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_a11.rmii2_rxd0 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A10, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_a10.rmii2_rxd1 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WPN, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_wpn.rmii2_rxerr */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A5, PIN_OUTPUT_PULLDOWN, MUX_MODE3)	/* gpmc_a5.rmii2_txd0 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A4, PIN_OUTPUT_PULLDOWN, MUX_MODE3)	/* gpmc_a4.rmii2_txd1 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A0, PIN_OUTPUT_PULLDOWN, MUX_MODE3)	/* gpmc_a0.rmii2_txen */
 		>;
 	};
 
 	cpsw_sleep: cpsw_sleep {
 		pinctrl-single,pins = <
 			/* Slave 1 reset value */
-			AM33XX_IOPAD(0x90c, (PIN_INPUT_PULLDOWN | MUX_MODE7))
-			AM33XX_IOPAD(0x944, (PIN_INPUT_PULLDOWN | MUX_MODE7))
-			AM33XX_IOPAD(0x940, (PIN_INPUT_PULLDOWN | MUX_MODE7))
-			AM33XX_IOPAD(0x93c, (PIN_INPUT_PULLDOWN | MUX_MODE7))
-			AM33XX_IOPAD(0x910, (PIN_INPUT_PULLDOWN | MUX_MODE7))
-			AM33XX_IOPAD(0x928, (PIN_INPUT_PULLDOWN | MUX_MODE7))
-			AM33XX_IOPAD(0x924, (PIN_INPUT_PULLDOWN | MUX_MODE7))
-			AM33XX_IOPAD(0x914, (PIN_INPUT_PULLDOWN | MUX_MODE7))
+			AM33XX_PADCONF(AM335X_PIN_MII1_CRS, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_RMII1_REF_CLK, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RX_ER, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD0, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_MII1_TX_EN, PIN_INPUT_PULLDOWN, MUX_MODE7)
 
 			/* Slave 2 reset value */
-			AM33XX_IOPAD(0x870, (PIN_INPUT_PULLDOWN | MUX_MODE7))
-			AM33XX_IOPAD(0x908, (PIN_INPUT_PULLDOWN | MUX_MODE7))
-			AM33XX_IOPAD(0x86c, (PIN_INPUT_PULLDOWN | MUX_MODE7))
-			AM33XX_IOPAD(0x868, (PIN_INPUT_PULLDOWN | MUX_MODE7))
-			AM33XX_IOPAD(0x874, (PIN_INPUT_PULLDOWN | MUX_MODE7))
-			AM33XX_IOPAD(0x854, (PIN_INPUT_PULLDOWN | MUX_MODE7))
-			AM33XX_IOPAD(0x850, (PIN_INPUT_PULLDOWN | MUX_MODE7))
-			AM33XX_IOPAD(0x840, (PIN_INPUT_PULLDOWN | MUX_MODE7))
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_MII1_COL, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A11, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A10, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WPN, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A5, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A4, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A0, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
 	davinci_mdio_default: davinci_mdio_default {
 		pinctrl-single,pins = <
 			/* MDIO */
-			AM33XX_IOPAD(0x948, (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0))	/* mdio_data.mdio_data */
-			AM33XX_IOPAD(0x94c, (PIN_OUTPUT_PULLUP | MUX_MODE0))			/* mdio_clk.mdio_clk */
+			AM33XX_PADCONF(AM335X_PIN_MDIO, PIN_INPUT_PULLUP | SLEWCTRL_FAST, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MDC, PIN_OUTPUT_PULLUP, MUX_MODE0)
 		>;
 	};
 
 	davinci_mdio_sleep: davinci_mdio_sleep {
 		pinctrl-single,pins = <
 			/* MDIO reset value */
-			AM33XX_IOPAD(0x948, (PIN_INPUT_PULLDOWN | MUX_MODE7))
-			AM33XX_IOPAD(0x94c, (PIN_INPUT_PULLDOWN | MUX_MODE7))
+			AM33XX_PADCONF(AM335X_PIN_MDIO, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_MDC, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 };
-- 
2.20.1

