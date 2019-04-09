Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11164C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB3A2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfDIQFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:05:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34829 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfDIQFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:05:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id w1so21668986wrp.2;
        Tue, 09 Apr 2019 09:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uj8Sdmg8+UTy28BBPrHwV2HsARfYm8FnLLG1iVuqiek=;
        b=XW/qC/UrfPHO4Eo8wHqLfV98psyC8+NsJjgVwIt4vY/1ZDqA2UG0VRblYpKdFqGAvm
         fwwL7MFW+5jjHcwWxkXNuBoN2Bxt5vIfnl9TlqTTpZKJ/T+/Bg4cL2H70dWtHyBZ0qEg
         CB9fuRu/iyWI33Fp+urWA9cT5bxwsEVY2pF0k+H+esbOveD/GShgaDyV0Mo+HR8pqmQ/
         DHfTiRnhGRKRCOOBkcjv3PLJJf045dEEE/2KWK4cBP5FZdRu7RnQKbZQHmrGrbH7rtpP
         mpWhG9+4BM5JsDRDgZbgBQf3aK1Iy0/jJzhpGyMFHhhbfQtYIpcORqVE1Rdik6C8UJ/l
         Cw4Q==
X-Gm-Message-State: APjAAAVyGrNp+UW5GtlB9uLVWOH1hIhmrwbkU7pHD1AwmbsTWiA2vQou
        JrlVAsN4GDsYm6Bgen6Wz9LvAvl/Gl4fNg==
X-Google-Smtp-Source: APXvYqxI/5zH4kg/ZnZkHdytXc20cv8tp3c+s6NTMSsWypBP6oHobM+DRQRWVvVbDqhQVvW+FAB6DQ==
X-Received: by 2002:adf:82f0:: with SMTP id 103mr23831960wrc.260.1554825913810;
        Tue, 09 Apr 2019 09:05:13 -0700 (PDT)
Received: from localhost ([90.85.130.193])
        by smtp.gmail.com with ESMTPSA id a17sm12612692wmg.40.2019.04.09.09.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 09:05:13 -0700 (PDT)
From:   Christina Quast <cquast@hanoverdisplays.com>
To:     tony@atomide.com
Cc:     Christina Quast <cquast@hanoverdisplays.com>,
        Benoit Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/15] ARM: dts: am335x: baltos: Replaced register offsets with defines
Date:   Tue,  9 Apr 2019 18:03:36 +0200
Message-Id: <20190409160346.25599-6-cquast@hanoverdisplays.com>
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
 arch/arm/boot/dts/am335x-baltos.dtsi | 140 +++++++++++++--------------
 1 file changed, 70 insertions(+), 70 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-baltos.dtsi b/arch/arm/boot/dts/am335x-baltos.dtsi
index 8c6fc4161ad7..b572ad1f1377 100644
--- a/arch/arm/boot/dts/am335x-baltos.dtsi
+++ b/arch/arm/boot/dts/am335x-baltos.dtsi
@@ -53,130 +53,130 @@
 &am33xx_pinmux {
 	mmc2_pins: pinmux_mmc2_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x820, PIN_INPUT_PULLUP | MUX_MODE2)      /* gpmc_ad8.mmc1_dat0_mux0 */
-			AM33XX_IOPAD(0x824, PIN_INPUT_PULLUP | MUX_MODE2)      /* gpmc_ad9.mmc1_dat1_mux0 */
-			AM33XX_IOPAD(0x828, PIN_INPUT_PULLUP | MUX_MODE2)      /* gpmc_ad10.mmc1_dat2_mux0 */
-			AM33XX_IOPAD(0x82c, PIN_INPUT_PULLUP | MUX_MODE2)      /* gpmc_ad11.mmc1_dat3_mux0 */
-			AM33XX_IOPAD(0x880, PIN_INPUT_PULLUP | MUX_MODE2)      /* gpmc_csn1.mmc1_clk_mux0 */
-			AM33XX_IOPAD(0x884, PIN_INPUT_PULLUP | MUX_MODE2)      /* gpmc_csn2.mmc1_cmd_mux0 */
-			AM33XX_IOPAD(0x9e4, PIN_INPUT_PULLUP | MUX_MODE7)      /* emu0.gpio3[7] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD8, PIN_INPUT_PULLUP, MUX_MODE2)      /* gpmc_ad8.mmc1_dat0_mux0 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD9, PIN_INPUT_PULLUP, MUX_MODE2)      /* gpmc_ad9.mmc1_dat1_mux0 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD10, PIN_INPUT_PULLUP, MUX_MODE2)      /* gpmc_ad10.mmc1_dat2_mux0 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD11, PIN_INPUT_PULLUP, MUX_MODE2)      /* gpmc_ad11.mmc1_dat3_mux0 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN1, PIN_INPUT_PULLUP, MUX_MODE2)      /* gpmc_csn1.mmc1_clk_mux0 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN2, PIN_INPUT_PULLUP, MUX_MODE2)      /* gpmc_csn2.mmc1_cmd_mux0 */
+			AM33XX_PADCONF(AM335X_PIN_EMU0, PIN_INPUT_PULLUP, MUX_MODE7)      /* emu0.gpio3[7] */
 		>;
 	};
 
 	wl12xx_gpio: pinmux_wl12xx_gpio {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9e8, PIN_OUTPUT_PULLUP | MUX_MODE7)      /* emu1.gpio3[8] */
+			AM33XX_PADCONF(AM335X_PIN_EMU1, PIN_OUTPUT_PULLUP, MUX_MODE7)      /* emu1.gpio3[8] */
 		>;
 	};
 
 	tps65910_pins: pinmux_tps65910_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x878, PIN_INPUT_PULLUP | MUX_MODE7)      /* gpmc_ben1.gpio1[28] */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_BEN1, PIN_INPUT_PULLUP, MUX_MODE7)      /* gpmc_ben1.gpio1[28] */
 		>;
 	};
 
 	i2c1_pins: pinmux_i2c1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x958, PIN_INPUT | MUX_MODE2)      /* spi0_d1.i2c1_sda_mux3 */
-			AM33XX_IOPAD(0x95c, PIN_INPUT | MUX_MODE2)      /* spi0_cs0.i2c1_scl_mux3 */
+			AM33XX_PADCONF(AM335X_PIN_SPI0_D1, PIN_INPUT, MUX_MODE2)      /* spi0_d1.i2c1_sda_mux3 */
+			AM33XX_PADCONF(AM335X_PIN_SPI0_CS0, PIN_INPUT, MUX_MODE2)      /* spi0_cs0.i2c1_scl_mux3 */
 		>;
 	};
 
 	uart0_pins: pinmux_uart0_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)		/* uart0_txd.uart0_txd */
+			AM33XX_PADCONF(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART0_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
 		>;
 	};
 
 	cpsw_default: cpsw_default {
 		pinctrl-single,pins = <
 			/* Slave 1 */
-			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE1)       /* mii1_crs.rmii1_crs_dv */
-			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE1)      /* mii1_tx_en.rmii1_txen */
-			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE1)      /* mii1_txd1.rmii1_txd1 */
-			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE1)      /* mii1_txd0.rmii1_txd0 */
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE1)      /* mii1_rxd1.rmii1_rxd1 */
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE1)      /* mii1_rxd0.rmii1_rxd0 */
-			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE0)      /* rmii1_ref_clk.rmii1_refclk */
+			AM33XX_PADCONF(AM335X_PIN_MII1_CRS, PIN_INPUT_PULLDOWN, MUX_MODE1)       /* mii1_crs.rmii1_crs_dv */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TX_EN, PIN_OUTPUT_PULLDOWN, MUX_MODE1)      /* mii1_tx_en.rmii1_txen */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD1, PIN_OUTPUT_PULLDOWN, MUX_MODE1)      /* mii1_txd1.rmii1_txd1 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD0, PIN_OUTPUT_PULLDOWN, MUX_MODE1)      /* mii1_txd0.rmii1_txd0 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLDOWN, MUX_MODE1)      /* mii1_rxd1.rmii1_rxd1 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLDOWN, MUX_MODE1)      /* mii1_rxd0.rmii1_rxd0 */
+			AM33XX_PADCONF(AM335X_PIN_RMII1_REF_CLK, PIN_INPUT_PULLDOWN, MUX_MODE0)      /* rmii1_ref_clk.rmii1_refclk */
 
 
 			/* Slave 2 */
-			AM33XX_IOPAD(0x840, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a0.rgmii2_tctl */
-			AM33XX_IOPAD(0x844, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a1.rgmii2_rctl */
-			AM33XX_IOPAD(0x848, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a2.rgmii2_td3 */
-			AM33XX_IOPAD(0x84c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a3.rgmii2_td2 */
-			AM33XX_IOPAD(0x850, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a4.rgmii2_td1 */
-			AM33XX_IOPAD(0x854, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a5.rgmii2_td0 */
-			AM33XX_IOPAD(0x858, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a6.rgmii2_tclk */
-			AM33XX_IOPAD(0x85c, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a7.rgmii2_rclk */
-			AM33XX_IOPAD(0x860, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a8.rgmii2_rd3 */
-			AM33XX_IOPAD(0x864, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a9.rgmii2_rd2 */
-			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a10.rgmii2_rd1 */
-			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a11.rgmii2_rd0 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A0, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a0.rgmii2_tctl */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A1, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a1.rgmii2_rctl */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A2, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a2.rgmii2_td3 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A3, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a3.rgmii2_td2 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A4, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a4.rgmii2_td1 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A5, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a5.rgmii2_td0 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A6, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a6.rgmii2_tclk */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A7, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a7.rgmii2_rclk */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A8, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a8.rgmii2_rd3 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A9, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a9.rgmii2_rd2 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A10, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a10.rgmii2_rd1 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A11, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* gpmc_a11.rgmii2_rd0 */
 		>;
 	};
 
 	cpsw_sleep: cpsw_sleep {
 		pinctrl-single,pins = <
 			/* Slave 1 reset value */
-			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x914, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x924, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x928, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_MII1_CRS, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_MII1_TX_EN, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD0, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_RMII1_REF_CLK, PIN_INPUT_PULLDOWN, MUX_MODE7)
 
 			/* Slave 2 reset value*/
-			AM33XX_IOPAD(0x840, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x844, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x848, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x84c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x850, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x854, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x858, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x85c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x860, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x864, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A0, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A2, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A3, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A4, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A5, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A6, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A7, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A8, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A9, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A10, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A11, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
 	davinci_mdio_default: davinci_mdio_default {
 		pinctrl-single,pins = <
 			/* MDIO */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
-			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+			AM33XX_PADCONF(AM335X_PIN_MDIO, PIN_INPUT_PULLUP | SLEWCTRL_FAST, MUX_MODE0)	/* mdio_data.mdio_data */
+			AM33XX_PADCONF(AM335X_PIN_MDC, PIN_OUTPUT_PULLUP, MUX_MODE0)			/* mdio_clk.mdio_clk */
 		>;
 	};
 
 	davinci_mdio_sleep: davinci_mdio_sleep {
 		pinctrl-single,pins = <
 			/* MDIO reset value */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x94c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_MDIO, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_MDC, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
 	nandflash_pins_s0: nandflash_pins_s0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
-			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
-			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
-			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
-			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
-			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
-			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
-			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
-			AM33XX_IOPAD(0x870, PIN_INPUT_PULLUP | MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
-			AM33XX_IOPAD(0x874, PIN_INPUT_PULLUP | MUX_MODE7)	/* gpmc_wpn.gpio0_30 */
-			AM33XX_IOPAD(0x87c, PIN_OUTPUT | MUX_MODE0)		/* gpmc_csn0.gpmc_csn0  */
-			AM33XX_IOPAD(0x890, PIN_OUTPUT | MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
-			AM33XX_IOPAD(0x894, PIN_OUTPUT | MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
-			AM33XX_IOPAD(0x898, PIN_OUTPUT | MUX_MODE0)		/* gpmc_wen.gpmc_wen */
-			AM33XX_IOPAD(0x89c, PIN_OUTPUT | MUX_MODE0)		/* gpmc_be0n_cle.gpmc_be0n_cle */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD0, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad0.gpmc_ad0 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD1, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad1.gpmc_ad1 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD2, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad2.gpmc_ad2 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD3, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad3.gpmc_ad3 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD4, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad4.gpmc_ad4 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD5, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad5.gpmc_ad5 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD6, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad6.gpmc_ad6 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD7, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_ad7.gpmc_ad7 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLUP, MUX_MODE0)	/* gpmc_wait0.gpmc_wait0 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WPN, PIN_INPUT_PULLUP, MUX_MODE7)	/* gpmc_wpn.gpio0_30 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN0, PIN_OUTPUT, MUX_MODE0)		/* gpmc_csn0.gpmc_csn0  */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_ADVN_ALE, PIN_OUTPUT, MUX_MODE0)		/* gpmc_advn_ale.gpmc_advn_ale */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_OEN_REN, PIN_OUTPUT, MUX_MODE0)		/* gpmc_oen_ren.gpmc_oen_ren */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WEN, PIN_OUTPUT, MUX_MODE0)		/* gpmc_wen.gpmc_wen */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_BEN0_CLE, PIN_OUTPUT, MUX_MODE0)		/* gpmc_be0n_cle.gpmc_be0n_cle */
 		>;
 	};
 };
-- 
2.20.1

