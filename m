Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECBFC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7354221721
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565700483;
	bh=c4y5Qjts7N/VOT4uSlIxH2JaJhhOQU5E5yCW2mxeICI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WEJARwAwe9ivwNn27P4qpztl5BTlXltJJYzeijvubyAi/TyUOhN0Kq4CuG8hNSTX5
	 2KKJIg3elgiM4+zRzOoVp9gkM4b5VpPaPf6Lt3lHCWvExBLHLKADocggMhVmsQY1rd
	 4p+O6sdRfdUeZTHBajlZmhIsFAdoKRL+GdAW456o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfHMMsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 08:48:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728750AbfHMMr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 08:47:59 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE24120874;
        Tue, 13 Aug 2019 12:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565700478;
        bh=c4y5Qjts7N/VOT4uSlIxH2JaJhhOQU5E5yCW2mxeICI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g899SHTS40cT9TonvzLmegaNMtr1gvDv6Ng8Xf6URZY1rHXkzNnFxpqlDwrCX2c7k
         cGb563BVIBTipLzkO9UVJeEbf5qNV72TvH4sx+E74SpTFhTj+FxTWE8Cq+cL5LvplU
         6T1f1QekY51IkiSPTAFDlgz7Q5C+tcg/+uhwSSm0=
From:   Maxime Ripard <mripard@kernel.org>
To:     linux@roeck-us.net, wim@linux-watchdog.org
Cc:     linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 5/5] ARM: dts: sunxi: Add missing watchdog interrupts
Date:   Tue, 13 Aug 2019 14:47:44 +0200
Message-Id: <20190813124744.32614-5-mripard@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190813124744.32614-1-mripard@kernel.org>
References: <20190813124744.32614-1-mripard@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The watchdog has an interrupt on all our SoCs, but it wasn't always listed.
Add it to the devicetree where it's missing.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 1 +
 arch/arm/boot/dts/sun5i.dtsi     | 1 +
 arch/arm/boot/dts/sun6i-a31.dtsi | 1 +
 arch/arm/boot/dts/sun7i-a20.dtsi | 1 +
 arch/arm/boot/dts/sun8i-r40.dtsi | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 077d45c7db6f..eed9fcb46185 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -815,6 +815,7 @@
 		wdt: watchdog@1c20c90 {
 			compatible = "allwinner,sun4i-a10-wdt";
 			reg = <0x01c20c90 0x10>;
+			interrupts = <24>;
 		};
 
 		rtc: rtc@1c20d00 {
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 4e725afe7203..29a825f7afd1 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -600,6 +600,7 @@
 		wdt: watchdog@1c20c90 {
 			compatible = "allwinner,sun4i-a10-wdt";
 			reg = <0x01c20c90 0x10>;
+			interrupts = <24>;
 		};
 
 		ir0: ir@1c21800 {
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 916f99db6206..b32d2d7cad4e 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -744,6 +744,7 @@
 		wdt1: watchdog@1c20ca0 {
 			compatible = "allwinner,sun6i-a31-wdt";
 			reg = <0x01c20ca0 0x20>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		spdif: spdif@1c21000 {
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 9ad8e445b240..aeb682e757f2 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -1115,6 +1115,7 @@
 		wdt: watchdog@1c20c90 {
 			compatible = "allwinner,sun4i-a10-wdt";
 			reg = <0x01c20c90 0x10>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		rtc: rtc@1c20d00 {
diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 09e20768228c..f1be554b5894 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -404,6 +404,7 @@
 		wdt: watchdog@1c20c90 {
 			compatible = "allwinner,sun4i-a10-wdt";
 			reg = <0x01c20c90 0x10>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		uart0: serial@1c28000 {
-- 
2.21.0

