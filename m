Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29F7C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C4620869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfDLQ2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:28:42 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33714 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfDLQ2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:28:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id z6so833735wmi.0;
        Fri, 12 Apr 2019 09:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DY3xDcDWOQFhPL2CCU2/OSsR57Unq8ytI6i47evo+gg=;
        b=epTGpF57IvKE8T0FdFQO3NjeazVWwZHtDcqDCSEwV6XrKFxo9/uPrJOc2wMLN/7FJA
         qaxPgynv+RGc9sjmG07aPnCNA1UBwnvOSZYfNuDHQg30p6xay0fG+SsITxUzkrSGhvk+
         7RzbGSu6/nPdUFvhZWMBSZh46+WRxIsXaQtNqItYBIYCVCZzDrW7cmfnbwZQscaQH5RI
         2QTIbxnxnZzFnZEbf04CXLYNPeFO6SA1Izu53pmHzM7AQDU0zU9G++1Bumb5tbTJ5oZE
         2PR2whxv0X7Jmtnxr1/CKvZDjtxeXje8jk3vmDJLEuJVEBVNGlRVu9QdfSRMnpaKweYH
         j0sw==
X-Gm-Message-State: APjAAAWzs2IPt7mezecyQfTUBKiLvDvXMItVuZ65g+B18H/jWOYUZ0HQ
        06COcR3uoDARde07EvcfT34=
X-Google-Smtp-Source: APXvYqwkj8YBPQaMdjXEuHoLbHatoLbEIfE4ch+6DXdj5e2YHhSSHoKnZVpLsgWt9g3wt9uHmdxtBg==
X-Received: by 2002:a1c:cf0b:: with SMTP id f11mr11566619wmg.26.1555086517932;
        Fri, 12 Apr 2019 09:28:37 -0700 (PDT)
Received: from localhost ([90.85.130.193])
        by smtp.gmail.com with ESMTPSA id z11sm9646281wmf.12.2019.04.12.09.28.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 09:28:37 -0700 (PDT)
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
Subject: [PATCH 17/17] ARM: dts: am335x: wega: Replaced register offsets with defines
Date:   Fri, 12 Apr 2019 18:26:27 +0200
Message-Id: <20190412162627.24518-18-cquast@hanoverdisplays.com>
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
 arch/arm/boot/dts/am335x-wega.dtsi | 68 +++++++++++++++---------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-wega.dtsi b/arch/arm/boot/dts/am335x-wega.dtsi
index 8ce541739b24..b7d28a20341f 100644
--- a/arch/arm/boot/dts/am335x-wega.dtsi
+++ b/arch/arm/boot/dts/am335x-wega.dtsi
@@ -32,11 +32,11 @@
 &am33xx_pinmux {
 	mcasp0_pins: pinmux_mcasp0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9AC, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* mcasp0_ahclkx.mcasp0_ahclkx */
-			AM33XX_IOPAD(0x990, PIN_INPUT_PULLDOWN | MUX_MODE0)  /* mcasp0_aclkx.mcasp0_aclkx */
-			AM33XX_IOPAD(0x994, PIN_INPUT_PULLDOWN | MUX_MODE0)  /* mcasp0_fsx.mcasp0_fsx */
-			AM33XX_IOPAD(0x998, PIN_INPUT_PULLDOWN | MUX_MODE0)  /* mcasp0_axr0.mcasp0_axr0 */
-			AM33XX_IOPAD(0x9A8, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* mcasp0_axr1.mcasp0_axr1 */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_AHCLKX, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_ACLKX, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_FSX, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_AXR0, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_AXR1, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
 		>;
 	};
 };
@@ -84,8 +84,8 @@
 &am33xx_pinmux {
 	dcan1_pins: pinmux_dcan1 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x968, PIN_OUTPUT_PULLUP | MUX_MODE2) /* uart0_ctsn.d_can1_tx */
-			AM33XX_IOPAD(0x96c, PIN_INPUT_PULLUP | MUX_MODE2) /* uart0_rtsn.d_can1_rx */
+			AM33XX_PADCONF(AM335X_PIN_UART0_CTSN, PIN_OUTPUT_PULLUP, MUX_MODE2) /* uart0_ctsn.d_can1_tx */
+			AM33XX_PADCONF(AM335X_PIN_UART0_RTSN, PIN_INPUT_PULLUP, MUX_MODE2) /* uart0_rtsn.d_can1_rx */
 		>;
 	};
 };
@@ -100,20 +100,20 @@
 &am33xx_pinmux {
 	ethernet1_pins: pinmux_ethernet1 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x840, PIN_OUTPUT | MUX_MODE1)		/* gpmc_a0.mii2_txen */
-			AM33XX_IOPAD(0x844, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a1.mii2_rxdv */
-			AM33XX_IOPAD(0x848, PIN_OUTPUT | MUX_MODE1)		/* gpmc_a2.mii2_txd3 */
-			AM33XX_IOPAD(0x84c, PIN_OUTPUT | MUX_MODE1)		/* gpmc_a3.mii2_txd2 */
-			AM33XX_IOPAD(0x850, PIN_OUTPUT | MUX_MODE1)		/* gpmc_a4.mii2_txd1 */
-			AM33XX_IOPAD(0x854, PIN_OUTPUT | MUX_MODE1)		/* gpmc_a5.mii2_txd0 */
-			AM33XX_IOPAD(0x858, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a6.mii2_txclk */
-			AM33XX_IOPAD(0x85c, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a7.mii2_rxclk */
-			AM33XX_IOPAD(0x860, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a8.mii2_rxd3 */
-			AM33XX_IOPAD(0x864, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a9.mii2_rxd2 */
-			AM33XX_IOPAD(0x868, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a10.mii2_rxd1 */
-			AM33XX_IOPAD(0x86c, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_a11.mii2_rxd0 */
-			AM33XX_IOPAD(0x874, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_wpn.mii2_rxerr */
-			AM33XX_IOPAD(0x878, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* gpmc_ben1.mii2_col */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A0, PIN_OUTPUT, MUX_MODE1)		/* gpmc_a0.mii2_txen */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A1, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* gpmc_a1.mii2_rxdv */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A2, PIN_OUTPUT, MUX_MODE1)		/* gpmc_a2.mii2_txd3 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A3, PIN_OUTPUT, MUX_MODE1)		/* gpmc_a3.mii2_txd2 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A4, PIN_OUTPUT, MUX_MODE1)		/* gpmc_a4.mii2_txd1 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A5, PIN_OUTPUT, MUX_MODE1)		/* gpmc_a5.mii2_txd0 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A6, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* gpmc_a6.mii2_txclk */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A7, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* gpmc_a7.mii2_rxclk */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A8, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* gpmc_a8.mii2_rxd3 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A9, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* gpmc_a9.mii2_rxd2 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A10, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* gpmc_a10.mii2_rxd1 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A11, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* gpmc_a11.mii2_rxd0 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_WPN, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* gpmc_wpn.mii2_rxerr */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_BEN1, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* gpmc_ben1.mii2_col */
 		>;
 	};
 };
@@ -141,13 +141,13 @@
 &am33xx_pinmux {
 	mmc1_pins: pinmux_mmc1 {
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
@@ -171,17 +171,17 @@
 &am33xx_pinmux {
 	uart0_pins: pinmux_uart0 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x970, PIN_INPUT_PULLUP | MUX_MODE0)    /* uart0_rxd.uart0_rxd */
-			AM33XX_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* uart0_txd.uart0_txd */
+			AM33XX_PADCONF(AM335X_PIN_UART0_RXD, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART0_TXD, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
 		>;
 	};
 
 	uart1_pins: pinmux_uart1_pins {
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
 };
-- 
2.20.1

