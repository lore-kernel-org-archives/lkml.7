Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9F2C4360D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 17:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CF320820
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 17:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569085333;
	bh=2l1I33Xe5hDz42o1/ZVvgVgbND3Hlh/p+Y+TYnwAq4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vTheCx/6ArnTISQTNSKYdoulvvvA3u6QefGDwHMjJwu59Kj+V0zjFmrs1VTPUmnLN
	 PaoBtFcRdtLV+9wiP9nqqwFFCdTcUlNju2eSy3tSmMq9jUqbBL46uqImd0YSjK77fH
	 Wnpx1EuTeNaot0gw5fwTUrhMJdERKoJDMGYwbN7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438264AbfIURCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 13:02:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438031AbfIURCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 13:02:08 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E12F5218AE;
        Sat, 21 Sep 2019 17:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569085327;
        bh=2l1I33Xe5hDz42o1/ZVvgVgbND3Hlh/p+Y+TYnwAq4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OnAAb+rJZUcNvlroMCU3IpKTPJJeSycaG/v1aT5Dawex2b1p/pmMDGXNtP4fv7P2e
         sqfDwawpccX4J/XIw5+nQUfc80ywEwq7da1Cb85K3adSFVo1Hgt3ZELh6X9nVR4iSR
         yWZcJt5XgYlXrXl+TEHjF5mOVU4QUH2DdPnx5BeY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH v3 2/8] ARM: dts: exynos: Rename Multi Core Timer node to "timer"
Date:   Sat, 21 Sep 2019 19:01:46 +0200
Message-Id: <20190921170152.5033-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190921170152.5033-1-krzk@kernel.org>
References: <20190921170152.5033-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device node name should reflect generic class of a device so rename
the Multi Core Timer node from "mct" to "timer".  This will be also in
sync with upcoming DT schema.  No functional change.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos3250.dtsi | 2 +-
 arch/arm/boot/dts/exynos4210.dtsi | 2 +-
 arch/arm/boot/dts/exynos4412.dtsi | 2 +-
 arch/arm/boot/dts/exynos5250.dtsi | 2 +-
 arch/arm/boot/dts/exynos5260.dtsi | 2 +-
 arch/arm/boot/dts/exynos54xx.dtsi | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 784818490376..d122fb52d3d4 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -265,7 +265,7 @@
 					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
-		mct@10050000 {
+		timer@10050000 {
 			compatible = "samsung,exynos4210-mct";
 			reg = <0x10050000 0x800>;
 			interrupts = <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index f220716239db..6d3f19562aab 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -106,7 +106,7 @@
 			arm,data-latency = <2 2 1>;
 		};
 
-		mct: mct@10050000 {
+		mct: timer@10050000 {
 			compatible = "samsung,exynos4210-mct";
 			reg = <0x10050000 0x800>;
 			interrupt-parent = <&mct_map>;
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index d20db2dfe8e2..8b6d5875c75d 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -243,7 +243,7 @@
 			clock-names = "aclk200", "aclk400_mcuisp";
 		};
 
-		mct@10050000 {
+		timer@10050000 {
 			compatible = "samsung,exynos4412-mct";
 			reg = <0x10050000 0x800>;
 			interrupt-parent = <&mct_map>;
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index fc966c10cf49..7a01349317a3 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -233,7 +233,7 @@
 			power-domains = <&pd_mau>;
 		};
 
-		mct@101c0000 {
+		timer@101c0000 {
 			compatible = "samsung,exynos4210-mct";
 			reg = <0x101C0000 0x800>;
 			interrupt-controller;
diff --git a/arch/arm/boot/dts/exynos5260.dtsi b/arch/arm/boot/dts/exynos5260.dtsi
index 3581b57fbbf7..b0811dbbb362 100644
--- a/arch/arm/boot/dts/exynos5260.dtsi
+++ b/arch/arm/boot/dts/exynos5260.dtsi
@@ -180,7 +180,7 @@
 			reg = <0x10000000 0x100>;
 		};
 
-		mct: mct@100b0000 {
+		mct: timer@100b0000 {
 			compatible = "samsung,exynos4210-mct";
 			reg = <0x100B0000 0x1000>;
 			clocks = <&fin_pll>, <&clock_peri PERI_CLK_MCT>;
diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
index 9c3b63b7cac6..247d23872384 100644
--- a/arch/arm/boot/dts/exynos54xx.dtsi
+++ b/arch/arm/boot/dts/exynos54xx.dtsi
@@ -64,7 +64,7 @@
 			};
 		};
 
-		mct: mct@101c0000 {
+		mct: timer@101c0000 {
 			compatible = "samsung,exynos4210-mct";
 			reg = <0x101c0000 0xb00>;
 			interrupt-parent = <&mct_map>;
-- 
2.17.1

