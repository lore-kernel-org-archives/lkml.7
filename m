Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9841DC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7502084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfDIQFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:05:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40864 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfDIQFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:05:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id z24so3996138wmi.5;
        Tue, 09 Apr 2019 09:05:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cgIKaDZ69665xMEDdrOV1ZGf50j8KQY0hSs1MZBZWY0=;
        b=el8umtLcSWe7XiRBuA75fvslfIQfGXjKw20nhlVQzPyM2cv/BwBFs8W6v5ibyhx2rd
         7/ddeSlhAd0iAD+rjVCgpg3l6xRCNdpiwwXX+xhLvMCg9Hi6OwyPmVMgo9Ed/WSOn0X1
         ZKv+NNy5k7EL7a5yHV7E4WIJg56RbJF5I0WIh1a1q5CZNOkXiVNFQHrH0sy9E6pZhGfg
         //keECkc56wL6u743JLQsDRuPpsX/Tzkay+YJ4ye8ACqbU/5Xn245i40s0+AtSngUM8f
         Qb/OrYXw4iG5BdlRmy64GefWFmQY0xyw9sjqUEBmXIe2LBSvFda7q6guxA1VVZ9l3I2f
         kw3g==
X-Gm-Message-State: APjAAAWPHlM4UPsIpBf8iF/hd5MI9hNjSVEizEEiZWM2YSgRurqBc+rl
        Rxr+nX+4JVGlnG/PDUNkRJw=
X-Google-Smtp-Source: APXvYqzA2mEafm1RIKd5JHvyQaP1y9h90kqes7AEQptJCqUwwt+Or9Ram+0xyIsFj3BvkQyDmEpgYQ==
X-Received: by 2002:a1c:39d7:: with SMTP id g206mr20561618wma.99.1554825940050;
        Tue, 09 Apr 2019 09:05:40 -0700 (PDT)
Received: from localhost ([90.85.130.193])
        by smtp.gmail.com with ESMTPSA id r16sm23992223wrx.37.2019.04.09.09.05.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 09:05:39 -0700 (PDT)
From:   Christina Quast <cquast@hanoverdisplays.com>
To:     tony@atomide.com
Cc:     Christina Quast <cquast@hanoverdisplays.com>,
        Benoit Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/15] ARM: dts: am335x: bonegreen-wireless: Replaced register offsets with defines
Date:   Tue,  9 Apr 2019 18:03:38 +0200
Message-Id: <20190409160346.25599-8-cquast@hanoverdisplays.com>
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
 .../boot/dts/am335x-bonegreen-wireless.dts    | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bonegreen-wireless.dts b/arch/arm/boot/dts/am335x-bonegreen-wireless.dts
index 57731f0daf10..7db86a9c836a 100644
--- a/arch/arm/boot/dts/am335x-bonegreen-wireless.dts
+++ b/arch/arm/boot/dts/am335x-bonegreen-wireless.dts
@@ -32,35 +32,35 @@
 &am33xx_pinmux {
 	bt_pins: pinmux_bt_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x878, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_ad12.gpio1_28 BT_EN */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_BEN1, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* gpmc_ad12.gpio1_28 BT_EN */
 		>;
 	};
 
 	mmc3_pins: pinmux_mmc3_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x830, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad12.mmc2_dat0 */
-			AM33XX_IOPAD(0x834, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad13.mmc2_dat1 */
-			AM33XX_IOPAD(0x838, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad14.mmc2_dat2 */
-			AM33XX_IOPAD(0x83c, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_ad15.mmc2_dat3 */
-			AM33XX_IOPAD(0x888, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_csn3.mmc2_cmd */
-			AM33XX_IOPAD(0x88c, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_clk.mmc2_clk */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD12, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad12.mmc2_dat0 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD13, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad13.mmc2_dat1 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD14, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad14.mmc2_dat2 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD15, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_ad15.mmc2_dat3 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN3, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_csn3.mmc2_cmd */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CLK, PIN_INPUT_PULLUP, MUX_MODE3)	/* gpmc_clk.mmc2_clk */
 		>;
 	};
 
 	uart3_pins: pinmux_uart3_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x934, PIN_INPUT_PULLUP | MUX_MODE1)	/* gmii1_rxd3.uart3_rxd */
-			AM33XX_IOPAD(0x938, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* gmii1_rxd2.uart3_txd */
-			AM33XX_IOPAD(0x948, PIN_INPUT | MUX_MODE3)		/* mdio_data.uart3_ctsn */
-			AM33XX_IOPAD(0x94c, PIN_OUTPUT_PULLDOWN | MUX_MODE3)	/* mdio_clk.uart3_rtsn */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD3, PIN_INPUT_PULLUP, MUX_MODE1)	/* gmii1_rxd3.uart3_rxd */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD2, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* gmii1_rxd2.uart3_txd */
+			AM33XX_PADCONF(AM335X_PIN_MDIO, PIN_INPUT, MUX_MODE3)		/* mdio_data.uart3_ctsn */
+			AM33XX_PADCONF(AM335X_PIN_MDC, PIN_OUTPUT_PULLDOWN, MUX_MODE3)	/* mdio_clk.uart3_rtsn */
 		>;
 	};
 
 	wl18xx_pins: pinmux_wl18xx_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x828, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad10.gpio0_26 WL_EN */
-			AM33XX_IOPAD(0x82C, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* gpmc_ad11.gpio0_27 WL_IRQ */
-			AM33XX_IOPAD(0x87C, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* gpmc_csn0.gpio1_29 LS_BUF_EN */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD10, PIN_OUTPUT_PULLDOWN, MUX_MODE7)	/* gpmc_ad10.gpio0_26 WL_EN */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD11, PIN_INPUT_PULLDOWN, MUX_MODE7)	/* gpmc_ad11.gpio0_27 WL_IRQ */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_CSN0, PIN_OUTPUT_PULLUP, MUX_MODE7)	/* gpmc_csn0.gpio1_29 LS_BUF_EN */
 		>;
 	};
 };
-- 
2.20.1

