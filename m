Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2968C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 14:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D8B2085A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 14:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564237669;
	bh=cx+Jbyhf5yZekW1MxdTeEk8WHoyY1TG+dq0LGyTw3MY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=DmqvwQt+mJtU+h2Bw0b6NEuO/+ZK5vDPGY6mfqCc+FQXtqE8hXf6YuUyMr7w07t9s
	 J6UCMx0FEB9O+fVhJmVMNcjNnGZavvHOw8emarmY0/0yJdeH4RaeA3FMUlsQi4NDHp
	 qbhalWyW8a1Xa1TiqQknXq+2YqHyRy/5nRRy/8g8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbfG0O1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 10:27:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfG0O1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 10:27:47 -0400
Received: from localhost.localdomain (unknown [194.230.155.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26C122084C;
        Sat, 27 Jul 2019 14:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564237666;
        bh=cx+Jbyhf5yZekW1MxdTeEk8WHoyY1TG+dq0LGyTw3MY=;
        h=From:To:Cc:Subject:Date:From;
        b=oltjGzdA4YUsXZML7RTQY4BJ6RVH7UiHjZKs70rCudVBpxOh1bn17aShJWMo9oIEz
         tBT9PC5msGPN6FzW5nhBMbnzu/cjOmLfyvXGBUM2yyp+rXb4pLW6+aCUh+elDXFMoK
         /kX8AP3jQP2VS2Nk2mTbmQW4tr02Mhm+G3aglonY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/2] ARM: dts: rockchip: Cleanup style around assignment operator
Date:   Sat, 27 Jul 2019 16:27:35 +0200
Message-Id: <20190727142736.23188-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a space before and after assignment operator to have consistent
style.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/rk3036.dtsi                   |  2 +-
 arch/arm/boot/dts/rk3288-evb.dtsi               |  2 +-
 arch/arm/boot/dts/rk3288-tinker.dtsi            | 12 ++++++------
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 0290ea4edd32..c776321b2cc4 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -484,7 +484,7 @@
 		compatible = "rockchip,rockchip-spi";
 		reg = <0x20074000 0x1000>;
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
-		clocks =<&cru PCLK_SPI>, <&cru SCLK_SPI>;
+		clocks = <&cru PCLK_SPI>, <&cru SCLK_SPI>;
 		clock-names = "apb-pclk","spi_pclk";
 		dmas = <&pdma 8>, <&pdma 9>;
 		dma-names = "tx", "rx";
diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 820440715302..2afd686b2033 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -97,7 +97,7 @@
 	};
 
 	panel: panel {
-		compatible ="lg,lp079qx1-sp0v", "simple-panel";
+		compatible = "lg,lp079qx1-sp0v", "simple-panel";
 		backlight = <&backlight>;
 		enable-gpios = <&gpio7 RK_PA4 GPIO_ACTIVE_HIGH>;
 		pinctrl-0 = <&lcd_cs>;
diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
index 293576869546..81e4e953d4a4 100644
--- a/arch/arm/boot/dts/rk3288-tinker.dtsi
+++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
@@ -47,13 +47,13 @@
 		compatible = "gpio-leds";
 
 		act-led {
-			gpios=<&gpio1 RK_PD0 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger="mmc0";
+			gpios = <&gpio1 RK_PD0 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "mmc0";
 		};
 
 		heartbeat-led {
-			gpios=<&gpio1 RK_PD1 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger="heartbeat";
+			gpios = <&gpio1 RK_PD1 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
 		};
 
 		pwr-led {
@@ -443,7 +443,7 @@
 
 &saradc {
 	vref-supply = <&vcc18_ldo1>;
-	status ="okay";
+	status = "okay";
 };
 
 &sdmmc {
@@ -516,7 +516,7 @@
 };
 
 &usb_otg {
-	status= "okay";
+	status = "okay";
 };
 
 &vopb {
diff --git a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
index 1cadb522fd0d..e0183655e92c 100644
--- a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
@@ -86,7 +86,7 @@
 	};
 
 	panel: panel {
-		compatible ="innolux,n116bge", "simple-panel";
+		compatible = "innolux,n116bge", "simple-panel";
 		status = "okay";
 		power-supply = <&vcc33_lcd>;
 		backlight = <&backlight>;
-- 
2.17.1

