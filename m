Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75692C282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451E0218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfDLQ3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:29:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40479 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfDLQ2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:28:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id z24so11816114wmi.5;
        Fri, 12 Apr 2019 09:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1XBvM29nm61DTJhk4YhM69lu7yRa7FIRz7gVcjNCqhw=;
        b=FqbT5XDjxz/CuCBkVh2rUQ7Pv330xL3i5IOggHsr1SmGtp5xpBaRZ2YinqSTL0Q6OQ
         YX2P0QTygXClbN55PBKrIenZEmAxA7PbjS7M1gz4WcEn//a6iqiG66S9snJEj5LGRwdy
         gzeLVjcvm34Mp8B13FTTemYciX4J+CrlWzpxZqYiUnMPAScMQTnIJv+6wl465abwXWMI
         L0Hd0puJioqCBq0L0mlsHghdPstPFlGmuxuiA0RAE+5vW3mx09IxwTc/BZuiQ9lPTgIv
         Cy5mhI6DQisedZpeMWcKIRoRxFesMQRCA3rLmeTMYWPeJAdLT5N03tQOI4YV/CoXmyCN
         E+PA==
X-Gm-Message-State: APjAAAXL7KiDvAebxGComLoxQeCBGkMlzIhu2tVMTqzrR5Zm+TAHZdkz
        xFDtTOGBmKeuvPAmbiJZwek=
X-Google-Smtp-Source: APXvYqwNj6IK4UlfAFESY0U4c3UwE2c76isT9vqzHQcmzgMDCLCwPVKEqXUoECxdkEpPM4eCbqoz5A==
X-Received: by 2002:a1c:a010:: with SMTP id j16mr11604536wme.40.1555086512812;
        Fri, 12 Apr 2019 09:28:32 -0700 (PDT)
Received: from localhost ([90.85.130.193])
        by smtp.gmail.com with ESMTPSA id v184sm16446629wma.6.2019.04.12.09.28.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 09:28:32 -0700 (PDT)
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
Subject: [PATCH 13/17] ARM: dts: am335x: sancloud-bbe: Replaced register offsets with defines
Date:   Fri, 12 Apr 2019 18:26:23 +0200
Message-Id: <20190412162627.24518-14-cquast@hanoverdisplays.com>
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
 arch/arm/boot/dts/am335x-sancloud-bbe.dts | 62 +++++++++++------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-sancloud-bbe.dts b/arch/arm/boot/dts/am335x-sancloud-bbe.dts
index 35527fdf56cc..7ed27b5c4756 100644
--- a/arch/arm/boot/dts/am335x-sancloud-bbe.dts
+++ b/arch/arm/boot/dts/am335x-sancloud-bbe.dts
@@ -23,70 +23,70 @@
 	cpsw_default: cpsw_default {
 		pinctrl-single,pins = <
 			/* Slave 1 */
-			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txen.rgmii1_tctl */
-			AM33XX_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxdv.rgmii1_rctl */
-			AM33XX_IOPAD(0x91c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd3.rgmii1_td3 */
-			AM33XX_IOPAD(0x920, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd2.rgmii1_td2 */
-			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_td1 */
-			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_td0 */
-			AM33XX_IOPAD(0x92c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txclk.rgmii1_tclk */
-			AM33XX_IOPAD(0x930, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxclk.rgmii1_rclk */
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd3.rgmii1_rd3 */
-			AM33XX_IOPAD(0x938, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd2.rgmii1_rd2 */
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd1.rgmii1_rd1 */
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd0.rgmii1_rd0 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TX_EN, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txen.rgmii1_tctl */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RX_DV, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* mii1_rxdv.rgmii1_rctl */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD3, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txd3.rgmii1_td3 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD2, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txd2.rgmii1_td2 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD1, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txd1.rgmii1_td1 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD0, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txd0.rgmii1_td0 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TX_CLK, PIN_OUTPUT_PULLDOWN, MUX_MODE2)	/* mii1_txclk.rgmii1_tclk */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RX_CLK, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* mii1_rxclk.rgmii1_rclk */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* mii1_rxd3.rgmii1_rd3 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD2, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* mii1_rxd2.rgmii1_rd2 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* mii1_rxd1.rgmii1_rd1 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLDOWN, MUX_MODE2)	/* mii1_rxd0.rgmii1_rd0 */
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
 			/* MDIO */
-			AM33XX_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
-			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
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
 
 	usb_hub_ctrl: usb_hub_ctrl {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x944, PIN_OUTPUT_PULLUP | MUX_MODE7)     /* rmii1_refclk.gpio0_29 */
+			AM33XX_PADCONF(AM335X_PIN_RMII1_REF_CLK, PIN_OUTPUT_PULLUP, MUX_MODE7)     /* rmii1_refclk.gpio0_29 */
 		>;
 	};
 
 	mpu6050_pins: pinmux_mpu6050_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x968, PIN_INPUT | MUX_MODE7)    /* uart0_ctsn.gpio1_8 */
+			AM33XX_PADCONF(AM335X_PIN_UART0_CTSN, PIN_INPUT, MUX_MODE7)    /* uart0_ctsn.gpio1_8 */
 		>;
 	};
 
 	lps3331ap_pins: pinmux_lps3331ap_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x868, PIN_INPUT | MUX_MODE7)     /* gpmc_a10.gpio1_26 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_A10, PIN_INPUT, MUX_MODE7)     /* gpmc_a10.gpio1_26 */
 		>;
 	};
 };
-- 
2.20.1

