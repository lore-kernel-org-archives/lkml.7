Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D86C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C834217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569255299;
	bh=qXqV0J88N2dypvGBO7A/lZfZUOS9/+hk7Rbjthl+2/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WwjHyKpqjDZ3Ctrtf1+EZvPcSnSxZWu9mIywI3I3C9m9+iI4xH9xE53OHnqtRiDUT
	 1BvnrfEr1EM7sz3acKTXaZDf5ZUZQkrtSuhxaRAsdqSFY5T8ayRT72xcn7L3XU3/UP
	 Ki/6EPePkcmIQRhqGjgHzakWAcVZlgdK7xrna++4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438206AbfIWQO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:14:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395236AbfIWQO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:14:56 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48A7F20B7C;
        Mon, 23 Sep 2019 16:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569255295;
        bh=qXqV0J88N2dypvGBO7A/lZfZUOS9/+hk7Rbjthl+2/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HSgzdn01o5ejN576RO+vqEPDnxHhjrna19PWbCUd2zXNLjFC1QnsYCWkiYH8VT0rb
         2Grlxp+4Rad0kYSiRLsC6HLh7IpYUr+SPtegbvff5omkvf5pTvDqJ+8d1QPyxCEPfP
         dRqokgYw+O0yLG7WzUkTjBcF8HpkwBNkHVAtI/4U=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH v4 8/8] ARM: dts: exynos: Use defines for MCT interrupt GIC SPI/PPI specifier
Date:   Mon, 23 Sep 2019 18:14:11 +0200
Message-Id: <20190923161411.9236-8-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923161411.9236-1-krzk@kernel.org>
References: <20190923161411.9236-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace hard-coded number with appropriate define for GIC SPI or PPI
specifier in interrupt.  This makes code easier to read.  No expected
functionality change.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4210.dtsi |  8 ++++----
 arch/arm/boot/dts/exynos4412.dtsi |  4 ++--
 arch/arm/boot/dts/exynos5250.dtsi |  4 ++--
 arch/arm/boot/dts/exynos54xx.dtsi | 16 ++++++++--------
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 5fa33d43821e..aac3b7a20a37 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -111,12 +111,12 @@
 			reg = <0x10050000 0x800>;
 			clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MCT>;
 			clock-names = "fin_pll", "mct";
-			interrupts-extended = <&gic 0 57 IRQ_TYPE_LEVEL_HIGH>,
-					      <&gic 0 69 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&gic GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+					      <&gic GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
 					      <&combiner 12 6>,
 					      <&combiner 12 7>,
-					      <&gic 0 42 IRQ_TYPE_LEVEL_HIGH>,
-					      <&gic 0 48 IRQ_TYPE_LEVEL_HIGH>;
+					      <&gic GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+					      <&gic GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		watchdog: watchdog@10060000 {
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 9b5fb4e54d7c..96a5ef3a2864 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -248,11 +248,11 @@
 			reg = <0x10050000 0x800>;
 			clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MCT>;
 			clock-names = "fin_pll", "mct";
-			interrupts-extended = <&gic 0 57 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts-extended = <&gic GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
 					      <&combiner 12 5>,
 					      <&combiner 12 6>,
 					      <&combiner 12 7>,
-					      <&gic 1 12 IRQ_TYPE_LEVEL_HIGH>;
+					      <&gic GIC_PPI 12 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		watchdog: watchdog@10060000 {
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index a549eafd2c64..f01e3156191d 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -242,8 +242,8 @@
 					      <&combiner 23 4>,
 					      <&combiner 25 2>,
 					      <&combiner 25 3>,
-					      <&gic 0 120 IRQ_TYPE_LEVEL_HIGH>,
-					      <&gic 0 121 IRQ_TYPE_LEVEL_HIGH>;
+					      <&gic GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+					      <&gic GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		pinctrl_0: pinctrl@11400000 {
diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
index aca1b4831e38..06ae40a2f1e9 100644
--- a/arch/arm/boot/dts/exynos54xx.dtsi
+++ b/arch/arm/boot/dts/exynos54xx.dtsi
@@ -71,14 +71,14 @@
 					      <&combiner 23 4>,
 					      <&combiner 25 2>,
 					      <&combiner 25 3>,
-					      <&gic 0 120 IRQ_TYPE_LEVEL_HIGH>,
-					      <&gic 0 121 IRQ_TYPE_LEVEL_HIGH>,
-					      <&gic 0 122 IRQ_TYPE_LEVEL_HIGH>,
-					      <&gic 0 123 IRQ_TYPE_LEVEL_HIGH>,
-					      <&gic 0 128 IRQ_TYPE_LEVEL_HIGH>,
-					      <&gic 0 129 IRQ_TYPE_LEVEL_HIGH>,
-					      <&gic 0 130 IRQ_TYPE_LEVEL_HIGH>,
-					      <&gic 0 131 IRQ_TYPE_LEVEL_HIGH>;
+					      <&gic GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+					      <&gic GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+					      <&gic GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+					      <&gic GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+					      <&gic GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
+					      <&gic GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+					      <&gic GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+					      <&gic GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		watchdog: watchdog@101d0000 {
-- 
2.17.1

