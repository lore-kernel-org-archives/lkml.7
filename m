Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E505EC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB761218AF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfDLQ2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:28:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44661 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfDLQ2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:28:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id y7so12691091wrn.11;
        Fri, 12 Apr 2019 09:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Div0UcDT5pjkpGEcQMN6iz7N5zQCDWamiD+t9R9sf9I=;
        b=LOVKk5BPUj1Kz39FkH4xmidf55NA774bljplKzJcJw6ZcU51bLudG16rzPg+0hrWEU
         TctQLuoBW+Z19+kG8q8rf4s7v18pFeHnUwYPX3VD2IPosoqojeNYfWa/SNdeNM6nJ9A8
         Tsw3DecnW8luX7JF2A6Iretl4t7R+ORqvGv4Pa/IIZydTGJoLeBciuPIyaGY8XjzEKPm
         4PD7XAOEtEWusa6hXLWeq2qil72trVBvKH/e4552W5w9s6MVT5eZYFjkTeetDtjq9iLQ
         fRpeO8pG9yPeSsfkymWu1+1+khyXLVK2lPa4j4vpvX0z/5y28NEbCQFHeFz/SG+NGQxU
         D9Pw==
X-Gm-Message-State: APjAAAX40/9bonOtZNe7Ds/I0BPrSjZuXR9M7Dfanq9a9OrCrOxQQ4mT
        c0WK8fnlRhuTZxw4IEBWcRY=
X-Google-Smtp-Source: APXvYqwakY049fMljA7Thco0tmgABCLLzpwjGlGc2CmugGQz5U+ShxfX40rS8JKj3sVJF2QEnZXQBQ==
X-Received: by 2002:a5d:4907:: with SMTP id x7mr33457834wrq.133.1555086499594;
        Fri, 12 Apr 2019 09:28:19 -0700 (PDT)
Received: from localhost ([90.85.130.193])
        by smtp.gmail.com with ESMTPSA id w11sm118079060wre.15.2019.04.12.09.28.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 09:28:19 -0700 (PDT)
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
Subject: [PATCH 04/17] ARM: dts: am335x: moxa-uc-2101: Replaced register offsets with defines
Date:   Fri, 12 Apr 2019 18:26:14 +0200
Message-Id: <20190412162627.24518-5-cquast@hanoverdisplays.com>
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
 arch/arm/boot/dts/am335x-moxa-uc-2101.dts | 24 +++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-moxa-uc-2101.dts b/arch/arm/boot/dts/am335x-moxa-uc-2101.dts
index 48aee6de4cdb..5923b6e7e1cb 100644
--- a/arch/arm/boot/dts/am335x-moxa-uc-2101.dts
+++ b/arch/arm/boot/dts/am335x-moxa-uc-2101.dts
@@ -31,23 +31,23 @@
 	cpsw_default: cpsw_default {
 		pinctrl-single,pins = <
 			/* Slave 1 */
-			AM33XX_IOPAD(0x90c, PIN_INPUT_PULLDOWN | MUX_MODE1)	/* mii1_crs.rmii1_crs_dv */
-			AM33XX_IOPAD(0x910, PIN_INPUT_PULLUP | MUX_MODE1)	/* mii1_rxerr.rmii1_rxerr */
-			AM33XX_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txen.rmii1_txen */
-			AM33XX_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txd1.rmii1_txd1 */
-			AM33XX_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE1)	/* mii1_txd0.rmii1_txd0 */
-			AM33XX_IOPAD(0x93c, PIN_INPUT_PULLUP | MUX_MODE1)	/* mii1_rxd1.rmii1_rxd1 */
-			AM33XX_IOPAD(0x940, PIN_INPUT_PULLUP | MUX_MODE1)	/* mii1_rxd0.rmii1_rxd0 */
-			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* mii1_refclk.rmii1_refclk */
+			AM33XX_PADCONF(AM335X_PIN_MII1_CRS, PIN_INPUT_PULLDOWN, MUX_MODE1)	/* mii1_crs.rmii1_crs_dv */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RX_ER, PIN_INPUT_PULLUP, MUX_MODE1)	/* mii1_rxerr.rmii1_rxerr */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TX_EN, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* mii1_txen.rmii1_txen */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD1, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* mii1_txd1.rmii1_txd1 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_TXD0, PIN_OUTPUT_PULLDOWN, MUX_MODE1)	/* mii1_txd0.rmii1_txd0 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD1, PIN_INPUT_PULLUP, MUX_MODE1)	/* mii1_rxd1.rmii1_rxd1 */
+			AM33XX_PADCONF(AM335X_PIN_MII1_RXD0, PIN_INPUT_PULLUP, MUX_MODE1)	/* mii1_rxd0.rmii1_rxd0 */
+			AM33XX_PADCONF(AM335X_PIN_RMII1_REF_CLK, PIN_INPUT_PULLDOWN, MUX_MODE0)
 		>;
 	};
 
 	spi1_pins: pinmux_spi1 {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x964, PIN_INPUT_PULLUP | MUX_MODE4)	 /* ecap0_in_pwm0_out.spi1_sclk */
-			AM33XX_IOPAD(0x978, PIN_INPUT_PULLUP | MUX_MODE4)	 /* uart1_ctsn.spi1_cs0 */
-			AM33XX_IOPAD(0x968, PIN_INPUT_PULLUP | MUX_MODE4)	 /* uart0_ctsn.spi1_d0 */
-			AM33XX_IOPAD(0x96c, PIN_INPUT_PULLUP | MUX_MODE4)	 /* uart0_rtsn.spi1_d1 */
+			AM33XX_PADCONF(AM335X_PIN_ECAP0_IN_PWM0_OUT, PIN_INPUT_PULLUP, MUX_MODE4)	 /* ecap0_in_pwm0_out.spi1_sclk */
+			AM33XX_PADCONF(AM335X_PIN_UART1_CTSN, PIN_INPUT_PULLUP, MUX_MODE4)	 /* uart1_ctsn.spi1_cs0 */
+			AM33XX_PADCONF(AM335X_PIN_UART0_CTSN, PIN_INPUT_PULLUP, MUX_MODE4)	 /* uart0_ctsn.spi1_d0 */
+			AM33XX_PADCONF(AM335X_PIN_UART0_RTSN, PIN_INPUT_PULLUP, MUX_MODE4)	 /* uart0_rtsn.spi1_d1 */
 		>;
 	};
 };
-- 
2.20.1

