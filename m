Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215DCC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A3C20869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfDLQ2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:28:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32792 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfDLQ2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:28:36 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so12775631wrp.0;
        Fri, 12 Apr 2019 09:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u5lIV0EtpkBjIcn0HDZaDQCO6JsFT44pAGa3afmGJm8=;
        b=grLxG0vopEBPcd9MKcAhMKo6Vm7hnYLWP+nZymBGLNF1pzOU4rx+uauVkt9LI3lp/O
         DLgjtS7VYCQSlRKTutZXMMwHxNOD1Xd59wGQy9YRv1a/mBGvOuur2EIgSF/1D40IyP6/
         z1TMc9eTFOnD2LRqJXvN4RVQMKIISHARsAxo2Jh0zOeCZOFY4wxJIrrlfVKUa22bAgrS
         FwLJAUepqcKlPbqg52yEGMLIEhJGQbcVQqymOFYspTha4AD2++kyG38xQSaVkDT+jw+3
         89qFTPjfI8UIt4dG70wlR8qHEW/RZEyYfjkxOr6SZ2DheQY+N4VHVzXHFjyiXIL11wZu
         Tmfw==
X-Gm-Message-State: APjAAAWa3AKD81brXNIv5ekGP84LLb5B3LjL10ukea3g34WkExQ5clVw
        U91E6orKDP4nrf+m4OkIKi4=
X-Google-Smtp-Source: APXvYqyBT0evByuQ59h3WKlez+PCZ4Ubu5gKwQVdApU5qpNKgro0UmeKrdtl/384YIPVPNS1T8J7nA==
X-Received: by 2002:adf:f10c:: with SMTP id r12mr18348897wro.216.1555086514083;
        Fri, 12 Apr 2019 09:28:34 -0700 (PDT)
Received: from localhost ([90.85.130.193])
        by smtp.gmail.com with ESMTPSA id n4sm42094900wrx.39.2019.04.12.09.28.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 09:28:33 -0700 (PDT)
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
Subject: [PATCH 14/17] ARM: dts: am335x: sbc-t335: Replaced register offsets with defines
Date:   Fri, 12 Apr 2019 18:26:24 +0200
Message-Id: <20190412162627.24518-15-cquast@hanoverdisplays.com>
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
 arch/arm/boot/dts/am335x-sbc-t335.dts | 152 ++++++++++----------------
 1 file changed, 56 insertions(+), 96 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-sbc-t335.dts b/arch/arm/boot/dts/am335x-sbc-t335.dts
index 917d7ccc9109..07c46a59f1d2 100644
--- a/arch/arm/boot/dts/am335x-sbc-t335.dts
+++ b/arch/arm/boot/dts/am335x-sbc-t335.dts
@@ -70,122 +70,82 @@
 	lcd_pins_default: lcd_pins_default {
 		pinctrl-single,pins = <
 			/* gpmc_ad8.lcd_data23 */
-			AM33XX_IOPAD(0x820, PIN_OUTPUT | MUX_MODE1)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD8, PIN_OUTPUT, MUX_MODE1)
 			/* gpmc_ad9.lcd_data22 */
-			AM33XX_IOPAD(0x824, PIN_OUTPUT | MUX_MODE1)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD9, PIN_OUTPUT, MUX_MODE1)
 			/* gpmc_ad10.lcd_data21 */
-			AM33XX_IOPAD(0x828, PIN_OUTPUT | MUX_MODE1)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD10, PIN_OUTPUT, MUX_MODE1)
 			/* gpmc_ad11.lcd_data20 */
-			AM33XX_IOPAD(0x82c, PIN_OUTPUT | MUX_MODE1)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD11, PIN_OUTPUT, MUX_MODE1)
 			/* gpmc_ad12.lcd_data19 */
-			AM33XX_IOPAD(0x830, PIN_OUTPUT | MUX_MODE1)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD12, PIN_OUTPUT, MUX_MODE1)
 			/* gpmc_ad13.lcd_data18 */
-			AM33XX_IOPAD(0x834, PIN_OUTPUT | MUX_MODE1)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD13, PIN_OUTPUT, MUX_MODE1)
 			/* gpmc_ad14.lcd_data17 */
-			AM33XX_IOPAD(0x838, PIN_OUTPUT | MUX_MODE1)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD14, PIN_OUTPUT, MUX_MODE1)
 			/* gpmc_ad15.lcd_data16 */
-			AM33XX_IOPAD(0x83c, PIN_OUTPUT | MUX_MODE1)
-			/* lcd_data0.lcd_data0 */
-			AM33XX_IOPAD(0x8a0, PIN_OUTPUT | MUX_MODE0)
-			/* lcd_data1.lcd_data1 */
-			AM33XX_IOPAD(0x8a4, PIN_OUTPUT | MUX_MODE0)
-			/* lcd_data2.lcd_data2 */
-			AM33XX_IOPAD(0x8a8, PIN_OUTPUT | MUX_MODE0)
-			/* lcd_data3.lcd_data3 */
-			AM33XX_IOPAD(0x8ac, PIN_OUTPUT | MUX_MODE0)
-			/* lcd_data4.lcd_data4 */
-			AM33XX_IOPAD(0x8b0, PIN_OUTPUT | MUX_MODE0)
-			/* lcd_data5.lcd_data5 */
-			AM33XX_IOPAD(0x8b4, PIN_OUTPUT | MUX_MODE0)
-			/* lcd_data6.lcd_data6 */
-			AM33XX_IOPAD(0x8b8, PIN_OUTPUT | MUX_MODE0)
-			/* lcd_data7.lcd_data7 */
-			AM33XX_IOPAD(0x8bc, PIN_OUTPUT | MUX_MODE0)
-			/* lcd_data8.lcd_data8 */
-			AM33XX_IOPAD(0x8c0, PIN_OUTPUT | MUX_MODE0)
-			/* lcd_data9.lcd_data9 */
-			AM33XX_IOPAD(0x8c4, PIN_OUTPUT | MUX_MODE0)
-			/* lcd_data10.lcd_data10 */
-			AM33XX_IOPAD(0x8c8, PIN_OUTPUT | MUX_MODE0)
-			/* lcd_data11.lcd_data11 */
-			AM33XX_IOPAD(0x8cc, PIN_OUTPUT | MUX_MODE0)
-			/* lcd_data12.lcd_data12 */
-			AM33XX_IOPAD(0x8d0, PIN_OUTPUT | MUX_MODE0)
-			/* lcd_data13.lcd_data13 */
-			AM33XX_IOPAD(0x8d4, PIN_OUTPUT | MUX_MODE0)
-			/* lcd_data14.lcd_data14 */
-			AM33XX_IOPAD(0x8d8, PIN_OUTPUT | MUX_MODE0)
-			/* lcd_data15.lcd_data15 */
-			AM33XX_IOPAD(0x8dc, PIN_OUTPUT | MUX_MODE0)
-			/* lcd_vsync.lcd_vsync */
-			AM33XX_IOPAD(0x8e0, PIN_OUTPUT | MUX_MODE0)
-			/* lcd_hsync.lcd_hsync */
-			AM33XX_IOPAD(0x8e4, PIN_OUTPUT | MUX_MODE0)
-			/* lcd_pclk.lcd_pclk */
-			AM33XX_IOPAD(0x8e8, PIN_OUTPUT | MUX_MODE0)
-			/* lcd_ac_bias_en.lcd_ac_bias_en */
-			AM33XX_IOPAD(0x8ec, PIN_OUTPUT | MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD15, PIN_OUTPUT, MUX_MODE1)
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
+			AM33XX_PADCONF(AM335X_PIN_LCD_VSYNC, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_HSYNC, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_PCLK, PIN_OUTPUT, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_LCD_AC_BIAS_EN, PIN_OUTPUT, MUX_MODE0)
 		>;
 	};
 
 	lcd_pins_sleep: lcd_pins_sleep {
 		pinctrl-single,pins = <
 			/* gpmc_ad8.lcd_data23 */
-			AM33XX_IOPAD(0x820, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD8, PIN_INPUT_PULLDOWN, MUX_MODE7)
 			/* gpmc_ad9.lcd_data22 */
-			AM33XX_IOPAD(0x824, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD9, PIN_INPUT_PULLDOWN, MUX_MODE7)
 			/* gpmc_ad10.lcd_data21 */
-			AM33XX_IOPAD(0x828, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD10, PIN_INPUT_PULLDOWN, MUX_MODE7)
 			/* gpmc_ad11.lcd_data20 */
-			AM33XX_IOPAD(0x82c, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD11, PIN_INPUT_PULLDOWN, MUX_MODE7)
 			/* gpmc_ad12.lcd_data19 */
-			AM33XX_IOPAD(0x830, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD12, PIN_INPUT_PULLDOWN, MUX_MODE7)
 			/* gpmc_ad13.lcd_data18 */
-			AM33XX_IOPAD(0x834, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD13, PIN_INPUT_PULLDOWN, MUX_MODE7)
 			/* gpmc_ad14.lcd_data17 */
-			AM33XX_IOPAD(0x838, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD14, PIN_INPUT_PULLDOWN, MUX_MODE7)
 			/* gpmc_ad15.lcd_data16 */
-			AM33XX_IOPAD(0x83c, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			/* lcd_data0.lcd_data0 */
-			AM33XX_IOPAD(0x8a0, PULL_DISABLE | MUX_MODE7)
-			/* lcd_data1.lcd_data1 */
-			AM33XX_IOPAD(0x8a4, PULL_DISABLE | MUX_MODE7)
-			/* lcd_data2.lcd_data2 */
-			AM33XX_IOPAD(0x8a8, PULL_DISABLE | MUX_MODE7)
-			/* lcd_data3.lcd_data3 */
-			AM33XX_IOPAD(0x8ac, PULL_DISABLE | MUX_MODE7)
-			/* lcd_data4.lcd_data4 */
-			AM33XX_IOPAD(0x8b0, PULL_DISABLE | MUX_MODE7)
-			/* lcd_data5.lcd_data5 */
-			AM33XX_IOPAD(0x8b4, PULL_DISABLE | MUX_MODE7)
-			/* lcd_data6.lcd_data6 */
-			AM33XX_IOPAD(0x8b8, PULL_DISABLE | MUX_MODE7)
-			/* lcd_data7.lcd_data7 */
-			AM33XX_IOPAD(0x8bc, PULL_DISABLE | MUX_MODE7)
-			/* lcd_data8.lcd_data8 */
-			AM33XX_IOPAD(0x8c0, PULL_DISABLE | MUX_MODE7)
-			/* lcd_data9.lcd_data9 */
-			AM33XX_IOPAD(0x8c4, PULL_DISABLE | MUX_MODE7)
-			/* lcd_data10.lcd_data10 */
-			AM33XX_IOPAD(0x8c8, PULL_DISABLE | MUX_MODE7)
-			/* lcd_data11.lcd_data11 */
-			AM33XX_IOPAD(0x8cc, PULL_DISABLE | MUX_MODE7)
-			/* lcd_data12.lcd_data12 */
-			AM33XX_IOPAD(0x8d0, PULL_DISABLE | MUX_MODE7)
-			/* lcd_data13.lcd_data13 */
-			AM33XX_IOPAD(0x8d4, PULL_DISABLE | MUX_MODE7)
-			/* lcd_data14.lcd_data14 */
-			AM33XX_IOPAD(0x8d8, PULL_DISABLE | MUX_MODE7)
-			/* lcd_data15.lcd_data15 */
-			AM33XX_IOPAD(0x8dc, PULL_DISABLE | MUX_MODE7)
-			/* lcd_vsync.lcd_vsync */
-			AM33XX_IOPAD(0x8e0, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			/* lcd_hsync.lcd_hsync */
-			AM33XX_IOPAD(0x8e4, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			/* lcd_pclk.lcd_pclk */
-			AM33XX_IOPAD(0x8e8, PIN_INPUT_PULLDOWN | MUX_MODE7)
-			/* lcd_ac_bias_en.lcd_ac_bias_en */
-			AM33XX_IOPAD(0x8ec, PIN_INPUT_PULLDOWN | MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_GPMC_AD15, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA0, PULL_DISABLE, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA1, PULL_DISABLE, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA2, PULL_DISABLE, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA3, PULL_DISABLE, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA4, PULL_DISABLE, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA5, PULL_DISABLE, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA6, PULL_DISABLE, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA7, PULL_DISABLE, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA8, PULL_DISABLE, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA9, PULL_DISABLE, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA10, PULL_DISABLE, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA11, PULL_DISABLE, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA12, PULL_DISABLE, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA13, PULL_DISABLE, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA14, PULL_DISABLE, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA15, PULL_DISABLE, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_LCD_VSYNC, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_LCD_HSYNC, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_LCD_PCLK, PIN_INPUT_PULLDOWN, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_LCD_AC_BIAS_EN, PIN_INPUT_PULLDOWN, MUX_MODE7)
 		>;
 	};
 };
-- 
2.20.1

