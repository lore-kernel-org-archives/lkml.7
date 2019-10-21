Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27188CA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9E920873
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571670891;
	bh=20+irw0UPt3VHlL+Lz86BZVkn+H0HupSOrlw0ITzCmA=;
	h=From:To:Subject:Date:List-ID:From;
	b=noOt4tDNa5RUwe/e24eG+Lih93rwHCZGRiyX4wGg9V33XCl1KfuWZntcy0Pn0CIxn
	 LW46hF5HPuCTh6At/Lbe8NDFxUyyXN7QzuoTHbIjWPpiO0uk8gxfDeD760UiXKbEay
	 zC6khnx8hH7b2/7sUA+s4dClySVIka1c9vb7dZpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbfJUPOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 11:14:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727355AbfJUPOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:14:49 -0400
Received: from localhost.localdomain (unknown [194.230.155.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77F2E2084B;
        Mon, 21 Oct 2019 15:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571670888;
        bh=20+irw0UPt3VHlL+Lz86BZVkn+H0HupSOrlw0ITzCmA=;
        h=From:To:Subject:Date:From;
        b=GmS0kp9tMOpZB5ciq3a4LvFpKoQd/vpmOUPSVdh4WINPN9iFnuxrgZAThByj8Q3uR
         kMlb0QxcAaNCsUzb70KWLN5UAcgsN30SV/MgNAxFHzDCiCrffkAUfMAAqTdQDHC43x
         sMDatall2Z8txqTfJC5f+Siq0ePU/ruIifo8fTgI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: exynos: Rename children of SysRAM node to "sram"
Date:   Mon, 21 Oct 2019 17:14:40 +0200
Message-Id: <20191021151440.13505-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device node name should reflect generic class of a device so rename
the children of SysRAM node to "smp-sysram".  This will be also in sync
with upcoming DT schema.  No functional change.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos3250.dtsi               | 4 ++--
 arch/arm/boot/dts/exynos4210-universal_c210.dts | 6 +++---
 arch/arm/boot/dts/exynos4210.dtsi               | 4 ++--
 arch/arm/boot/dts/exynos4412.dtsi               | 4 ++--
 arch/arm/boot/dts/exynos5250.dtsi               | 4 ++--
 arch/arm/boot/dts/exynos54xx.dtsi               | 4 ++--
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index b016b0b68306..044e5da64a76 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -145,12 +145,12 @@
 			#size-cells = <1>;
 			ranges = <0 0x02020000 0x40000>;
 
-			smp-sysram@0 {
+			smp-sram@0 {
 				compatible = "samsung,exynos4210-sysram";
 				reg = <0x0 0x1000>;
 			};
 
-			smp-sysram@3f000 {
+			smp-sram@3f000 {
 				compatible = "samsung,exynos4210-sysram-ns";
 				reg = <0x3f000 0x1000>;
 			};
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index 09d3d54d09ff..a1bdf7830a87 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -590,16 +590,16 @@
 };
 
 &sysram {
-	smp-sysram@0 {
+	smp-sram@0 {
 		status = "disabled";
 	};
 
-	smp-sysram@5000 {
+	smp-sram@5000 {
 		compatible = "samsung,exynos4210-sysram";
 		reg = <0x5000 0x1000>;
 	};
 
-	smp-sysram@1f000 {
+	smp-sram@1f000 {
 		status = "disabled";
 	};
 };
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 554819ae1446..b4466232f0c1 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -79,12 +79,12 @@
 			#size-cells = <1>;
 			ranges = <0 0x02020000 0x20000>;
 
-			smp-sysram@0 {
+			smp-sram@0 {
 				compatible = "samsung,exynos4210-sysram";
 				reg = <0x0 0x1000>;
 			};
 
-			smp-sysram@1f000 {
+			smp-sram@1f000 {
 				compatible = "samsung,exynos4210-sysram-ns";
 				reg = <0x1f000 0x1000>;
 			};
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 5022aa574b26..48868947373e 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -195,12 +195,12 @@
 			#size-cells = <1>;
 			ranges = <0 0x02020000 0x40000>;
 
-			smp-sysram@0 {
+			smp-sram@0 {
 				compatible = "samsung,exynos4210-sysram";
 				reg = <0x0 0x1000>;
 			};
 
-			smp-sysram@2f000 {
+			smp-sram@2f000 {
 				compatible = "samsung,exynos4210-sysram-ns";
 				reg = <0x2f000 0x1000>;
 			};
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index e1f0215e3985..ec983283f573 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -171,12 +171,12 @@
 			#size-cells = <1>;
 			ranges = <0 0x02020000 0x30000>;
 
-			smp-sysram@0 {
+			smp-sram@0 {
 				compatible = "samsung,exynos4210-sysram";
 				reg = <0x0 0x1000>;
 			};
 
-			smp-sysram@2f000 {
+			smp-sram@2f000 {
 				compatible = "samsung,exynos4210-sysram-ns";
 				reg = <0x2f000 0x1000>;
 			};
diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
index f78dee801cd9..8aa5117e58ce 100644
--- a/arch/arm/boot/dts/exynos54xx.dtsi
+++ b/arch/arm/boot/dts/exynos54xx.dtsi
@@ -62,12 +62,12 @@
 			#size-cells = <1>;
 			ranges = <0 0x02020000 0x54000>;
 
-			smp-sysram@0 {
+			smp-sram@0 {
 				compatible = "samsung,exynos4210-sysram";
 				reg = <0x0 0x1000>;
 			};
 
-			smp-sysram@53000 {
+			smp-sram@53000 {
 				compatible = "samsung,exynos4210-sysram-ns";
 				reg = <0x53000 0x1000>;
 			};
-- 
2.17.1

