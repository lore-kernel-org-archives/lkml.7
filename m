Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C54C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA7C20B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568996704;
	bh=2l1I33Xe5hDz42o1/ZVvgVgbND3Hlh/p+Y+TYnwAq4s=;
	h=From:To:Subject:Date:List-ID:From;
	b=gKZpoS+VEdsdAdkl5IBYF/qxELhnWcMM5nHGyq0Ibsh5S7mrMf428bfzDoPbBnIAI
	 /Hgyy2ldRqGCb/tXV37ldxBX6UjwQnKZt6A/qtWqyYHIyZ8piquj7jowHnbaInb6DU
	 /9dAfd0yeiAygdGfjdKDeANIvW3ZTwn8v+8qrFHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392791AbfITQZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:25:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388479AbfITQZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:25:03 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 807A92086A;
        Fri, 20 Sep 2019 16:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568996701;
        bh=2l1I33Xe5hDz42o1/ZVvgVgbND3Hlh/p+Y+TYnwAq4s=;
        h=From:To:Subject:Date:From;
        b=KkqN5G+B13H0f1DxC21Q1GnYExFCi/itCMzpdYagApC/n9y4To3XoVVFhpK8kmKc+
         wX7n2c7FrZmy0i0Lt4Q424i0cX/DXG8yTJ/QPMoYvWkjfgHnbzC1JLRl7Jt4ET1nE9
         awdxdOLhY+71PiYKDUH01RXku/zvk+eI9Vra/Tf0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: exynos: Rename Multi Core Timer node to just timer
Date:   Fri, 20 Sep 2019 18:24:55 +0200
Message-Id: <20190920162456.7294-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
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

