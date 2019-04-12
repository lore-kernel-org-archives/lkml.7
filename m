Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23849C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE69D20869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfDLQ2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:28:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40843 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbfDLQ2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:28:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so12714039wre.7;
        Fri, 12 Apr 2019 09:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H5zbP6kFiOXqOwuyjKMePgiPdho1F3ZQcuDk8allqsY=;
        b=fuSkP9dEDKOi4WMWPPFs/6pYs5b58ubZb3ZAaNy+gYW8LBVlbkKnBo4ldJlxxHqGcX
         n7gmzTAbr6UkrrNM+Kd8D9tYrTrfzED458muqMum9gk0/xNIUSyw+ZpAZ7MXZirgGC91
         fRpZIL7r/pxYj31uOEuvUXPKU+ZQ4eJ+P2Jym7NLzAo+WiLjAXxua6FMweff/EN6oq56
         dKOg0fsAU5Fh+QioTiFRckle2vFAqbHM64pMkUn9b6MSNSIrn12e0nHxfHjcHeEx1QSg
         87ZaP3YO/0hGdplfOGCjSZkk37HHkcgmeAenHqTIx1wMxnEkWyWq+UrwN+/6mErqBN+G
         Tnbw==
X-Gm-Message-State: APjAAAWtKh2zOWbxcJXvaq6ChO+HpI+mxl6x3GtI9dexEi81OQVxRHeo
        xDeTOl3t6q46+ZMAYl5WeA0=
X-Google-Smtp-Source: APXvYqyDZpnox+af1/fD5Up3VLUj5OQ2tLD95EXulnLf55fGpCRY99uRw5o2sunZh7JLkPSJ5+7cuw==
X-Received: by 2002:adf:eb4d:: with SMTP id u13mr31995430wrn.240.1555086507688;
        Fri, 12 Apr 2019 09:28:27 -0700 (PDT)
Received: from localhost ([90.85.130.193])
        by smtp.gmail.com with ESMTPSA id j22sm124841919wrd.91.2019.04.12.09.28.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 09:28:27 -0700 (PDT)
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
Subject: [PATCH 09/17] ARM: dts: am335x: pcm-953: Replaced register offsets with defines
Date:   Fri, 12 Apr 2019 18:26:19 +0200
Message-Id: <20190412162627.24518-10-cquast@hanoverdisplays.com>
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
 arch/arm/boot/dts/am335x-pcm-953.dtsi | 74 +++++++++++++--------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-pcm-953.dtsi b/arch/arm/boot/dts/am335x-pcm-953.dtsi
index 1ec8e0d80191..baceaa7bb33b 100644
--- a/arch/arm/boot/dts/am335x-pcm-953.dtsi
+++ b/arch/arm/boot/dts/am335x-pcm-953.dtsi
@@ -79,15 +79,15 @@
 &am33xx_pinmux {
 	user_buttons_pins: pinmux_user_buttons {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9e4, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* emu0.gpio3_7 */
-			AM33XX_IOPAD(0x9e8, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* emu1.gpio3_8 */
+			AM33XX_PADCONF(AM335X_PIN_EMU0, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* emu0.gpio3_7 */
+			AM33XX_PADCONF(AM335X_PIN_EMU1, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* emu1.gpio3_8 */
 		>;
 	};
 
 	user_leds_pins: pinmux_user_leds {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x880, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_csn1.gpio1_30 */
-			AM33XX_IOPAD(0x884, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_csn2.gpio1_31 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN1, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* gpmc_csn1.gpio1_30 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN2, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* gpmc_csn2.gpio1_31 */
 		>;
 	};
 };
@@ -96,8 +96,8 @@
 &am33xx_pinmux {
 	dcan1_pins: pinmux_dcan1 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x980, PIN_OUTPUT_PULLUP | MUX_MODE2)	/* uart1_rxd.dcan1_tx_mux2 */
-			AM33XX_IOPAD(0x984, PIN_INPUT_PULLUP | MUX_MODE2)	/* uart1_txd.dcan1_rx_mux2 */
+			AM33XX_PADCONF(AM335X_PIN_UART1_RXD, PIN_OUTPUT_PULLUP, MUX_MODE2)	/* uart1_rxd.dcan1_tx_mux2 */
+			AM33XX_PADCONF(AM335X_PIN_UART1_TXD, PIN_INPUT_PULLUP, MUX_MODE2)	/* uart1_txd.dcan1_rx_mux2 */
 		>;
 	};
 };
@@ -112,18 +112,18 @@
 &am33xx_pinmux {
 	ethernet1_pins: pinmux_ethernet1 {
 		pinctrl-single,pins = <
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
 };
@@ -171,8 +171,8 @@
 
 	cb_gpio_pins: pinmux_cb_gpio {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x968, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* uart0_ctsn.gpio1_8 */
-			AM33XX_IOPAD(0x96c, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* uart0_rtsn.gpio1_9 */
+			AM33XX_PADCONF(AM335X_PIN_UART0_CTSN, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* uart0_ctsn.gpio1_8 */
+			AM33XX_PADCONF(AM335X_PIN_UART0_RTSN, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* uart0_rtsn.gpio1_9 */
 		>;
 	};
 };
@@ -181,13 +181,13 @@
 &am33xx_pinmux {
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x8f0, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat3.mmc0_dat3 */
-			AM33XX_IOPAD(0x8f4, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat2.mmc0_dat2 */
-			AM33XX_IOPAD(0x8f8, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat1.mmc0_dat1 */
-			AM33XX_IOPAD(0x8fc, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_dat0.mmc0_dat0 */
-			AM33XX_IOPAD(0x900, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_clk.mmc0_clk */
-			AM33XX_IOPAD(0x904, PIN_INPUT_PULLUP | MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
-			AM33XX_IOPAD(0x960, PIN_INPUT_PULLUP | MUX_MODE7)	/* spi0_cs1.mmc0_sdcd */
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT3, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT2, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT1, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT0, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_CLK, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_CMD, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_SPI0_CS1, PIN_INPUT_PULLUP, MUX_MODE7)	/* spi0_cs1.mmc0_sdcd */
 		>;
 	};
 };
@@ -205,31 +205,31 @@
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
-			AM33XX_IOPAD(0x980, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart1_rxd.uart1_rxd */
-			AM33XX_IOPAD(0x984, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_txd.uart1_txd */
-			AM33XX_IOPAD(0x978, PIN_INPUT | MUX_MODE0)		/* uart1_ctsn.uart1_ctsn */
-			AM33XX_IOPAD(0x97c, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart1_rtsn.uart1_rtsn */
+			AM33XX_PADCONF(AM335X_PIN_UART1_RXD, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART1_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART1_CTSN, PIN_INPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART1_RTSN, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
 		>;
 	};
 
 	uart2_pins: pinmux_uart2 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x92c, PIN_INPUT_PULLUP | MUX_MODE1)	/* mii1_tx_clk.uart2_rxd */
-			AM33XX_IOPAD(0x930, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_rx_clk.uart2_txd */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TX_CLK, PIN_INPUT_PULLUP, MUX_MODE1)	/* mii1_tx_clk.uart2_rxd */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RX_CLK, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* mii1_rx_clk.uart2_txd */
 		>;
 	};
 
 	uart3_pins: pinmux_uart3 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLUP | MUX_MODE1)	/* mii1_rxd3.uart3_rxd */
-			AM33XX_IOPAD(0x938, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_rxd2.uart3_txd */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLUP, MUX_MODE1)	/* mii1_rxd3.uart3_rxd */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD2, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* mii1_rxd2.uart3_txd */
 		>;
 	};
 };
-- 
2.20.1

