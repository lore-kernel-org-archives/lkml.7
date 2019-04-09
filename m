Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919FAC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610452084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfDIQEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:04:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39826 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfDIQEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:04:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so3968738wmk.4;
        Tue, 09 Apr 2019 09:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZJOgfdfE21IOstV9dI+gK3TYPRr79iJgsik7Y+jnLZo=;
        b=QTDkGpf3Rw6TA8xJq84mJglTKZyDRzQf/AQles768K437DQh+X3WJ3saDsJL+Sk6Rf
         NbJ9SdliCHN2I09CAAkkjVgqYxcFck51kCaf2+VydlmGzf3XsEscfPnV8DPbiW2lmVyY
         iPpb+/FZtppNlPVohrQDf3RckMX8QUq6+Bbwt1ojtblAHg1Gan45plDpKrfAFRiv2q6a
         LuAaId4KysjkwHNUoVS3SnkUOQcYUpgXHvNlpke+3Mn6XsQupYoGvaao66VuFAmPliOF
         4FPHHC3Mb3v9FCpJ+nm9673+qgLw0qUuufr3qubZFptAQosQpZXS+p7vP5VSi6UNfZHy
         fYBg==
X-Gm-Message-State: APjAAAX1FbtJBoyEf31QDlOPwnTQNa2kaFkLot3cx5Z55Ji0PGHbIjc2
        sV3F1qUnWXw6Ix2TOaaA2fw=
X-Google-Smtp-Source: APXvYqzpr4SsTaSG1sti0lBs7IvEgB7PB1138oiOira8mqEND4HMXPi9LACX6LGh63kf2qHFO7iiXw==
X-Received: by 2002:a1c:e0c6:: with SMTP id x189mr17817972wmg.4.1554825890840;
        Tue, 09 Apr 2019 09:04:50 -0700 (PDT)
Received: from localhost ([90.85.130.193])
        by smtp.gmail.com with ESMTPSA id d7sm16091014wmf.31.2019.04.09.09.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 09:04:50 -0700 (PDT)
From:   Christina Quast <cquast@hanoverdisplays.com>
To:     tony@atomide.com
Cc:     Christina Quast <cquast@hanoverdisplays.com>,
        Benoit Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/15] ARM: dts: am335x: baltos-ir3220: Replaced register offsets with defines
Date:   Tue,  9 Apr 2019 18:03:33 +0200
Message-Id: <20190409160346.25599-3-cquast@hanoverdisplays.com>
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
 arch/arm/boot/dts/am335x-baltos-ir3220.dts | 36 +++++++++++-----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-baltos-ir3220.dts b/arch/arm/boot/dts/am335x-baltos-ir3220.dts
index 1b215c425c57..e88d9f372f74 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir3220.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir3220.dts
@@ -23,35 +23,35 @@
 &am33xx_pinmux {
 	tca6416_pins: pinmux_tca6416_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x9b4, PIN_INPUT_PULLUP | MUX_MODE7)      /* xdma_event_intr1.gpio0[20] tca6416 stuff */
+			AM33XX_PADCONF(AM335X_PIN_XDMA_EVENT_INTR1, PIN_INPUT_PULLUP, MUX_MODE7)      /* xdma_event_intr1.gpio0[20] tca6416 stuff */
 		>;
 	};
 
 	uart1_pins: pinmux_uart1_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x980, PIN_INPUT | MUX_MODE0)      /* uart1_rxd */
-			AM33XX_IOPAD(0x984, PIN_INPUT | MUX_MODE0)      /* uart1_txd */
-			AM33XX_IOPAD(0x978, PIN_INPUT_PULLDOWN | MUX_MODE0)      /* uart1_ctsn */
-			AM33XX_IOPAD(0x97c, PIN_OUTPUT_PULLDOWN | MUX_MODE0)      /* uart1_rtsn */
-			AM33XX_IOPAD(0x8e0, PIN_OUTPUT_PULLDOWN | MUX_MODE7)      /* lcd_vsync.gpio2[22] DTR */
-			AM33XX_IOPAD(0x8e4, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* lcd_hsync.gpio2[23] DSR */
-			AM33XX_IOPAD(0x8e8, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* lcd_pclk.gpio2[24] DCD */
-			AM33XX_IOPAD(0x8ec, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* lcd_ac_bias_en.gpio2[25] RI */
+			AM33XX_PADCONF(AM335X_PIN_UART1_RXD, PIN_INPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART1_TXD, PIN_INPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART1_CTSN, PIN_INPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_UART1_RTSN, PIN_OUTPUT_PULLDOWN, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_VSYNC, PIN_OUTPUT_PULLDOWN, MUX_MODE7)      /* lcd_vsync.gpio2[22] DTR */
+			AM33XX_PADCONF(AM335X_PIN_LCD_HSYNC, PIN_INPUT_PULLDOWN, MUX_MODE7)      /* lcd_hsync.gpio2[23] DSR */
+			AM33XX_PADCONF(AM335X_PIN_LCD_PCLK, PIN_INPUT_PULLDOWN, MUX_MODE7)      /* lcd_pclk.gpio2[24] DCD */
+			AM33XX_PADCONF(AM335X_PIN_LCD_AC_BIAS_EN, PIN_INPUT_PULLDOWN, MUX_MODE7)      /* lcd_ac_bias_en.gpio2[25] RI */
 		>;
 	};
 
 	uart2_pins: pinmux_uart2_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x950, PIN_INPUT | MUX_MODE1)      /* spi0_sclk.uart2_rxd_mux3 */
-			AM33XX_IOPAD(0x954, PIN_OUTPUT | MUX_MODE1)      /* spi0_d0.uart2_txd_mux3 */
-			AM33XX_IOPAD(0x988, PIN_INPUT_PULLDOWN | MUX_MODE2)      /* i2c0_sda.uart2_ctsn_mux0 */
-			AM33XX_IOPAD(0x98c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)      /* i2c0_scl.uart2_rtsn_mux0 */
-			AM33XX_IOPAD(0x830, PIN_OUTPUT_PULLDOWN | MUX_MODE7)      /* gpmc_ad12.gpio1[12] DTR */
-			AM33XX_IOPAD(0x834, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* gpmc_ad13.gpio1[13] DSR */
-			AM33XX_IOPAD(0x838, PIN_INPUT_PULLDOWN | MUX_MODE7)      /* gpmc_ad14.gpio1[14] DCD */
-			AM33XX_IOPAD(0x83c, PIN_INPUT_PULLDOWN | MUX_MODE7)     /* gpmc_ad15.gpio1[15] RI */
+			AM33XX_PADCONF(AM335X_PIN_SPI0_SCLK, PIN_INPUT, MUX_MODE1)      /* spi0_sclk.uart2_rxd_mux3 */
+			AM33XX_PADCONF(AM335X_PIN_SPI0_D0, PIN_OUTPUT, MUX_MODE1)      /* spi0_d0.uart2_txd_mux3 */
+			AM33XX_PADCONF(AM335X_PIN_I2C0_SDA, PIN_INPUT_PULLDOWN, MUX_MODE2)      /* i2c0_sda.uart2_ctsn_mux0 */
+			AM33XX_PADCONF(AM335X_PIN_I2C0_SCL, PIN_OUTPUT_PULLDOWN, MUX_MODE2)      /* i2c0_scl.uart2_rtsn_mux0 */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD12, PIN_OUTPUT_PULLDOWN, MUX_MODE7)      /* gpmc_ad12.gpio1[12] DTR */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD13, PIN_INPUT_PULLDOWN, MUX_MODE7)      /* gpmc_ad13.gpio1[13] DSR */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD14, PIN_INPUT_PULLDOWN, MUX_MODE7)      /* gpmc_ad14.gpio1[14] DCD */
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD15, PIN_INPUT_PULLDOWN, MUX_MODE7)     /* gpmc_ad15.gpio1[15] RI */
 
-			AM33XX_IOPAD(0x9a0, PIN_INPUT_PULLUP | MUX_MODE7)      /* mcasp0_aclkr.gpio3[18], INPUT_PULLDOWN | MODE7 */
+			AM33XX_PADCONF(AM335X_PIN_MCASP0_ACLKR, PIN_INPUT_PULLUP, MUX_MODE7)      /* mcasp0_aclkr.gpio3[18], INPUT_PULLDOWN | MODE7 */
 		>;
 	};
 };
-- 
2.20.1

