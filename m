Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E41C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9152084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfDIQGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:06:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40010 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfDIQGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:06:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so21629846wre.7;
        Tue, 09 Apr 2019 09:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jim4fwUeef0a2GXISjpr63T5EfeQXBDwBI22xVHZSgg=;
        b=QO1MMJjM+N2cSU+NX0Xrxs0Q3jqIcPH0t52PQM5/E6RJVesCuw+h9qSko39enSORgc
         An6g6E/k1ImKPHDq0lvhFIpYVzgTZYpoYr2x5w0PYsTrgueAkDMF2f8qIMFsKSJsMlGq
         JjUNoixL2rpCQwdSYmYpvUBkc3pnAOjtHunOz4X+3AFbPf/atcIUJecH/JQfuSo8HA5g
         2NSVI7CDbTMn5lQxbslpYVTjxaJ32vgk9ohmrxzkRQcAa1aBZs5nqtunSqBc9HA8lrRw
         Un69LXtiWriO5q2DmhkTR7q7g8S8tfs971qamz4grSMIdFMbMlPouRYSemFC2Rl6qaKE
         4PoQ==
X-Gm-Message-State: APjAAAX1i4NsyGGocyOeVYZr8uC9Pom6VdjH1pqMFpqR7b/Kc2yX+YgY
        dx8BJa0Gsr/4Tzzqf4Tcn5Y=
X-Google-Smtp-Source: APXvYqxPey5e/GU7W7suXK8n7RkWz0q7qPHiSKhQ5YVfuCugjluKtIcD2U7WSlDiKSIN/Ov6RmbDnQ==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr25071166wru.266.1554825969196;
        Tue, 09 Apr 2019 09:06:09 -0700 (PDT)
Received: from localhost ([90.85.130.193])
        by smtp.gmail.com with ESMTPSA id z11sm13559735wmf.12.2019.04.09.09.06.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 09:06:08 -0700 (PDT)
From:   Christina Quast <cquast@hanoverdisplays.com>
To:     tony@atomide.com
Cc:     Christina Quast <cquast@hanoverdisplays.com>,
        Benoit Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/15] ARM: dts: am335x: cm-t335: Replaced register offsets with defines
Date:   Tue,  9 Apr 2019 18:03:43 +0200
Message-Id: <20190409160346.25599-13-cquast@hanoverdisplays.com>
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
 arch/arm/boot/dts/am335x-cm-t335.dts | 190 +++++++++++----------------
 1 file changed, 77 insertions(+), 113 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
index 2c724bb60417..3b0bb88dfc12 100644
--- a/arch/arm/boot/dts/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/am335x-cm-t335.dts
@@ -94,108 +94,85 @@
 
 	i2c0_pins: pinmux_i2c0_pins {
 		pinctrl-single,pins = <
-			/* i2c0_sda.i2c0_sda */
-			AM33XX_IOPAD(0x988, PIN_INPUT_PULLUP | MUX_MODE0)
-			/* i2c0_scl.i2c0_scl */
-			AM33XX_IOPAD(0x98c, PIN_INPUT_PULLUP | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_I2C0_SDA, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_I2C0_SCL, PIN_INPUT_PULLUP, MUX_MODE0)
 		>;
 	};
 
 	i2c1_pins: pinmux_i2c1_pins {
 		pinctrl-single,pins = <
 			/* uart0_ctsn.i2c1_sda */
-			AM33XX_IOPAD(0x968, PIN_INPUT_PULLUP | MUX_MODE2)
+			AM33XX_PADCONF(AM335X_PIN_UART0_CTSN, PIN_INPUT_PULLUP, MUX_MODE2)
 			/* uart0_rtsn.i2c1_scl */
-			AM33XX_IOPAD(0x96c, PIN_INPUT_PULLUP | MUX_MODE2)
+			AM33XX_PADCONF(AM335X_PIN_UART0_RTSN, PIN_INPUT_PULLUP, MUX_MODE2)
 		>;
 	};
 
 	gpio_led_pins: pinmux_gpio_led_pins {
 		pinctrl-single,pins = <
 			/* gpmc_csn3.gpio2_0 */
-			AM33XX_IOPAD(0x888, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN3, PIN_OUTPUT, MUX_MODE7)
 		>;
 	};
 
 	nandflash_pins: pinmux_nandflash_pins {
 		pinctrl-single,pins = <
-			/* gpmc_ad0.gpmc_ad0 */
-			AM33XX_IOPAD(0x800, PIN_INPUT_PULLUP | MUX_MODE0)
-			/* gpmc_ad1.gpmc_ad1 */
-			AM33XX_IOPAD(0x804, PIN_INPUT_PULLUP | MUX_MODE0)
-			/* gpmc_ad2.gpmc_ad2 */
-			AM33XX_IOPAD(0x808, PIN_INPUT_PULLUP | MUX_MODE0)
-			/* gpmc_ad3.gpmc_ad3 */
-			AM33XX_IOPAD(0x80c, PIN_INPUT_PULLUP | MUX_MODE0)
-			/* gpmc_ad4.gpmc_ad4 */
-			AM33XX_IOPAD(0x810, PIN_INPUT_PULLUP | MUX_MODE0)
-			/* gpmc_ad5.gpmc_ad5 */
-			AM33XX_IOPAD(0x814, PIN_INPUT_PULLUP | MUX_MODE0)
-			/* gpmc_ad6.gpmc_ad6 */
-			AM33XX_IOPAD(0x818, PIN_INPUT_PULLUP | MUX_MODE0)
-			/* gpmc_ad7.gpmc_ad7 */
-			AM33XX_IOPAD(0x81c, PIN_INPUT_PULLUP | MUX_MODE0)
-			/* gpmc_wait0.gpmc_wait0 */
-			AM33XX_IOPAD(0x870, PIN_INPUT_PULLUP | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD0, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD1, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD2, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD3, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD4, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD5, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD6, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD7, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WAIT0, PIN_INPUT_PULLUP, MUX_MODE0)
 			/* gpmc_wpn.gpio0_30 */
-			AM33XX_IOPAD(0x874, PIN_INPUT_PULLUP | MUX_MODE7)
-			/* gpmc_csn0.gpmc_csn0  */
-			AM33XX_IOPAD(0x87c, PIN_OUTPUT | MUX_MODE0)
-			/* gpmc_advn_ale.gpmc_advn_ale */
-			AM33XX_IOPAD(0x890, PIN_OUTPUT | MUX_MODE0)
-			/* gpmc_oen_ren.gpmc_oen_ren */
-			AM33XX_IOPAD(0x894, PIN_OUTPUT | MUX_MODE0)
-			/* gpmc_wen.gpmc_wen */
-			AM33XX_IOPAD(0x898, PIN_OUTPUT | MUX_MODE0)
-			/* gpmc_ben0_cle.gpmc_ben0_cle */
-			AM33XX_IOPAD(0x89c, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WPN, PIN_INPUT_PULLUP, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN0, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_ADVN_ALE, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_OEN_REN, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WEN, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_BEN0_CLE, PIN_OUTPUT, MUX_MODE0)
 		>;
 	};
 
 	uart0_pins: pinmux_uart0_pins {
 		pinctrl-single,pins = <
-			/* uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)
-			/* uart0_txd.uart0_txd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART0_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
 		>;
 	};
 
 	uart1_pins: pinmux_uart1_pins {
 		pinctrl-single,pins = <
-			/* uart1_ctsn.uart1_ctsn */
-			AM33XX_IOPAD(0x978, PIN_INPUT | MUX_MODE0)
-			/* uart1_rtsn.uart1_rtsn */
-			AM33XX_IOPAD(0x97C, PIN_OUTPUT_PULLDOWN | MUX_MODE0)
-			/* uart1_rxd.uart1_rxd */
-			AM33XX_IOPAD(0x980, PIN_INPUT_PULLUP | MUX_MODE0)
-			/* uart1_txd.uart1_txd */
-			AM33XX_IOPAD(0x984, PIN_OUTPUT_PULLDOWN | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART1_CTSN, PIN_INPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART1_RTSN, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART1_RXD, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART1_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
 		>;
 	};
 
 	dcan0_pins: pinmux_dcan0_pins {
 		pinctrl-single,pins = <
 			/* uart1_ctsn.dcan0_tx */
-			AM33XX_IOPAD(0x978, PIN_OUTPUT | MUX_MODE2)
+			AM33XX_PADCONF(AM335X_PIN_UART1_CTSN, PIN_OUTPUT, MUX_MODE2)
 			/* uart1_rtsn.dcan0_rx */
-			AM33XX_IOPAD(0x97C, PIN_INPUT | MUX_MODE2)
+			AM33XX_PADCONF(AM335X_PIN_UART1_RTSN, PIN_INPUT, MUX_MODE2)
 		>;
 	};
 
 	dcan1_pins: pinmux_dcan1_pins {
 		pinctrl-single,pins = <
 			/* uart1_rxd.dcan1_tx */
-			AM33XX_IOPAD(0x980, PIN_OUTPUT | MUX_MODE2)
+			AM33XX_PADCONF(AM335X_PIN_UART1_RXD, PIN_OUTPUT, MUX_MODE2)
 			/* uart1_txd.dcan1_rx */
-			AM33XX_IOPAD(0x984, PIN_INPUT | MUX_MODE2)
+			AM33XX_PADCONF(AM335X_PIN_UART1_TXD, PIN_INPUT, MUX_MODE2)
 		>;
 	};
 
 	ecap0_pins: pinmux_ecap0_pins {
 		pinctrl-single,pins = <
-			/* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out MODE0 */
-			AM33XX_IOPAD(0x964, 0x0)
+			AM33XX_PADCONF(AM335X_PIN_ECAP0_IN_PWM0_OUT, 0x0, MUX_MODE0)
 		>;
 	};
 
@@ -203,96 +180,83 @@
 		pinctrl-single,pins = <
 			/* Slave 1 */
 			/* mii1_tx_en.rgmii1_tctl */
-			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE2)
+			AM33XX_PADCONF(AM335X_PIN_MII1_TX_EN, PIN_OUTPUT_PULLDOWN, MUX_MODE2)
 			/* mii1_rxdv.rgmii1_rctl */
-			AM33XX_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE2)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RX_DV, PIN_INPUT_PULLDOWN, MUX_MODE2)
 			/* mii1_txd3.rgmii1_td3 */
-			AM33XX_IOPAD(0x91c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD3, PIN_OUTPUT_PULLDOWN, MUX_MODE2)
 			/* mii1_txd2.rgmii1_td2 */
-			AM33XX_IOPAD(0x920, PIN_OUTPUT_PULLDOWN | MUX_MODE2)
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD2, PIN_OUTPUT_PULLDOWN, MUX_MODE2)
 			/* mii1_txd1.rgmii1_td1 */
-			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE2)
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD1, PIN_OUTPUT_PULLDOWN, MUX_MODE2)
 			/* mii1_txd0.rgmii1_td0 */
-			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE2)
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD0, PIN_OUTPUT_PULLDOWN, MUX_MODE2)
 			/* mii1_txclk.rgmii1_tclk */
-			AM33XX_IOPAD(0x92c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)
+			AM33XX_PADCONF(AM335X_PIN_MII1_TX_CLK, PIN_OUTPUT_PULLDOWN, MUX_MODE2)
 			/* mii1_rxclk.rgmii1_rclk */
-			AM33XX_IOPAD(0x930, PIN_INPUT_PULLDOWN | MUX_MODE2)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RX_CLK, PIN_INPUT_PULLDOWN, MUX_MODE2)
 			/* mii1_rxd3.rgmii1_rd3 */
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLDOWN | MUX_MODE2)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLDOWN, MUX_MODE2)
 			/* mii1_rxd2.rgmii1_rd2 */
-			AM33XX_IOPAD(0x938, PIN_INPUT_PULLDOWN | MUX_MODE2)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD2, PIN_INPUT_PULLDOWN, MUX_MODE2)
 			/* mii1_rxd1.rgmii1_rd1 */
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE2)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLDOWN, MUX_MODE2)
 			/* mii1_rxd0.rgmii1_rd0 */
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE2)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLDOWN, MUX_MODE2)
 		>;
 	};
 
 	cpsw_sleep: cpsw_sleep {
 		pinctrl-single,pins = <
 			/* Slave 1 reset value */
-			AM33XX_IOPAD(0x914, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x91c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x920, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x924, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x928, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x92c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x930, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x938, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_MII1_TX_EN, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RX_DV, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD3, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD2, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD0, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_MII1_TX_CLK, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RX_CLK, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD2, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 
 	davinci_mdio_default: davinci_mdio_default {
 		pinctrl-single,pins = <
-			/* mdio_data.mdio_data */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)
-			/* mdio_clk.mdio_clk */
-			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MDIO, PIN_INPUT_PULLUP | SLEWCTRL_FAST, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MDC, PIN_OUTPUT_PULLUP, MUX_MODE0)
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
 
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
-			/* mmc0_dat3.mmc0_dat3 */
-			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)
-			/* mmc0_dat2.mmc0_dat2 */
-			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)
-			/* mmc0_dat1.mmc0_dat1 */
-			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)
-			/* mmc0_dat0.mmc0_dat0 */
-			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)
-			/* mmc0_clk.mmc0_clk */
-			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)
-			/* mmc0_cmd.mmc0_cmd */
-			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT3, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT2, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT1, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT0, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_CLK, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_CMD, PIN_INPUT_PULLUP, MUX_MODE0)
 		>;
 	};
 
 	spi0_pins: pinmux_spi0_pins {
 		pinctrl-single,pins = <
-			/* spi0_sclk.spi0_sclk */
-			AM33XX_IOPAD(0x950, PIN_INPUT | MUX_MODE0)
-			/* spi0_d0.spi0_d0 */
-			AM33XX_IOPAD(0x954, PIN_OUTPUT_PULLUP | MUX_MODE0)
-			/* spi0_d1.spi0_d1 */
-			AM33XX_IOPAD(0x958, PIN_INPUT | MUX_MODE0)
-			/* spi0_cs0.spi0_cs0 */
-			AM33XX_IOPAD(0x95C, PIN_OUTPUT | MUX_MODE0)
-			/* spi0_cs1.spi0_cs1 */
-			AM33XX_IOPAD(0x960, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_SPI0_SCLK, PIN_INPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_SPI0_D0, PIN_OUTPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_SPI0_D1, PIN_INPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_SPI0_CS0, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_SPI0_CS1, PIN_OUTPUT, MUX_MODE0)
 		>;
 	};
 
@@ -300,7 +264,7 @@
 	bluetooth_pins: pinmux_bluetooth_pins {
 		pinctrl-single,pins = <
 			/* XDMA_EVENT_INTR0.gpio0_19 - bluetooth enable */
-			AM33XX_IOPAD(0x9b0, PIN_OUTPUT_PULLUP | MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_XDMA_EVENT_INTR0, PIN_OUTPUT_PULLUP, MUX_MODE7)
 		>;
 	};
 
@@ -308,13 +272,13 @@
 	mcasp1_pins: pinmux_mcasp1_pins {
 		pinctrl-single,pins = <
 			/* MII1_CRS.mcasp1_aclkx */
-			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE4)
+			AM33XX_PADCONF(AM335X_PIN_MII1_CRS, PIN_INPUT_PULLDOWN, MUX_MODE4)
 			/* MII1_RX_ER.mcasp1_fsx */
-			AM33XX_IOPAD(0x910, PIN_INPUT_PULLDOWN | MUX_MODE4)
+			AM33XX_PADCONF(AM335X_PIN_MII1_RX_ER, PIN_INPUT_PULLDOWN, MUX_MODE4)
 			/* MII1_COL.mcasp1_axr2 */
-			AM33XX_IOPAD(0x908, PIN_INPUT_PULLDOWN | MUX_MODE4)
+			AM33XX_PADCONF(AM335X_PIN_MII1_COL, PIN_INPUT_PULLDOWN, MUX_MODE4)
 			/* RMII1_REF_CLK.mcasp1_axr3 */
-			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE4)
+			AM33XX_PADCONF(AM335X_PIN_RMII1_REF_CLK, PIN_INPUT_PULLDOWN, MUX_MODE4)
 		>;
 	};
 
@@ -322,9 +286,9 @@
 	wifi_pins: pinmux_wifi_pins {
 		pinctrl-single,pins = <
 			/* EMU1.gpio3_8 - WiFi IRQ */
-			AM33XX_IOPAD(0x9e8, PIN_INPUT_PULLUP | MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_EMU1, PIN_INPUT_PULLUP, MUX_MODE7)
 			/* XDMA_EVENT_INTR1.gpio0_20 - WiFi enable */
-			AM33XX_IOPAD(0x9b4, PIN_OUTPUT | MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_XDMA_EVENT_INTR1, PIN_OUTPUT, MUX_MODE7)
 		>;
 	};
 };
-- 
2.20.1

