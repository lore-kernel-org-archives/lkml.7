Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998B6C7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 14:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725FC2085A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 14:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564237084;
	bh=jNHwtPY86cIyPUWN0driQ9jY6ypwTMDCkIMRU4xajzo=;
	h=From:To:Subject:Date:List-ID:From;
	b=WxQhn4LBmwurHZ+Gk8M+1I1Bk2I687efz996hdFChyE9amxVeVnX6ZhBEEYqtHk0j
	 muILM+Xg66pPmn5dzHM7gQRKpbDM7WfFrXHBzLhlf3UzcozgVrTS49K6TPwBRKfy3v
	 AwFo9gDSh+g4p1+Ka6wQC5At4U83DqaIK1Ey3X1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387747AbfG0OSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 10:18:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387419AbfG0OSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 10:18:02 -0400
Received: from localhost.localdomain (unknown [194.230.155.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1AC42075E;
        Sat, 27 Jul 2019 14:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564237081;
        bh=jNHwtPY86cIyPUWN0driQ9jY6ypwTMDCkIMRU4xajzo=;
        h=From:To:Subject:Date:From;
        b=LYLgcDKVAgLTzlkKV+i2E5fJV6nteMMW1xrU0+HtXVK25DVrUAQe1kcp1g7p2Ns6w
         Q3WIy6N+6z1nU4L6zNWM2QwYtE5zEsA0dQa46gETJC4OKD25aQyWy59eJH9auwHDQn
         BhBddoaxcHvI6MWVtDRUBLM4VseMO/IB+dMGi70Q=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: exynos: Use space after '=' in exynos4412-itop-scp-core
Date:   Sat, 27 Jul 2019 16:16:56 +0200
Message-Id: <20190727141656.10692-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace tab with space after assignment operator.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../arm/boot/dts/exynos4412-itop-scp-core.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
index 462a5409b1de..dfceb155b3a7 100644
--- a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
+++ b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
@@ -377,7 +377,7 @@
 			buck1_reg: BUCK1 {
 				regulator-name = "vdd_mif";
 				regulator-min-microvolt = <850000>;
-				regulator-max-microvolt	= <1100000>;
+				regulator-max-microvolt = <1100000>;
 				regulator-always-on;
 				regulator-boot-on;
 				op_mode = <1>; /* Normal Mode */
@@ -386,7 +386,7 @@
 			buck2_reg: BUCK2 {
 				regulator-name = "vdd_arm";
 				regulator-min-microvolt = <850000>;
-				regulator-max-microvolt	= <1456250>;
+				regulator-max-microvolt = <1456250>;
 				regulator-always-on;
 				regulator-boot-on;
 				op_mode = <1>; /* Normal Mode */
@@ -395,7 +395,7 @@
 			buck3_reg: BUCK3 {
 				regulator-name = "vdd_int";
 				regulator-min-microvolt = <875000>;
-				regulator-max-microvolt	= <1200000>;
+				regulator-max-microvolt = <1200000>;
 				regulator-always-on;
 				regulator-boot-on;
 				op_mode = <1>; /* Normal Mode */
@@ -404,7 +404,7 @@
 			buck4_reg: BUCK4 {
 				regulator-name = "vdd_g3d";
 				regulator-min-microvolt = <750000>;
-				regulator-max-microvolt	= <1500000>;
+				regulator-max-microvolt = <1500000>;
 				regulator-always-on;
 				regulator-boot-on;
 				op_mode = <1>; /* Normal Mode */
@@ -413,7 +413,7 @@
 			buck5_reg: BUCK5 {
 				regulator-name = "vdd_m12";
 				regulator-min-microvolt = <750000>;
-				regulator-max-microvolt	= <1500000>;
+				regulator-max-microvolt = <1500000>;
 				regulator-always-on;
 				regulator-boot-on;
 				op_mode = <1>; /* Normal Mode */
@@ -422,7 +422,7 @@
 			buck6_reg: BUCK6 {
 				regulator-name = "vdd12_5m";
 				regulator-min-microvolt = <750000>;
-				regulator-max-microvolt	= <1500000>;
+				regulator-max-microvolt = <1500000>;
 				regulator-always-on;
 				regulator-boot-on;
 				op_mode = <1>; /* Normal Mode */
@@ -431,7 +431,7 @@
 			buck7_reg: BUCK7 {
 				regulator-name = "pvdd_buck7";
 				regulator-min-microvolt = <750000>;
-				regulator-max-microvolt	= <2000000>;
+				regulator-max-microvolt = <2000000>;
 				regulator-boot-on;
 				regulator-always-on;
 				op_mode = <1>; /* Normal Mode */
@@ -440,7 +440,7 @@
 			buck8_reg: BUCK8 {
 				regulator-name = "pvdd_buck8";
 				regulator-min-microvolt = <750000>;
-				regulator-max-microvolt	= <1500000>;
+				regulator-max-microvolt = <1500000>;
 				regulator-boot-on;
 				regulator-always-on;
 				op_mode = <1>; /* Normal Mode */
@@ -449,7 +449,7 @@
 			buck9_reg: BUCK9 {
 				regulator-name = "vddf28_emmc";
 				regulator-min-microvolt = <750000>;
-				regulator-max-microvolt	= <3000000>;
+				regulator-max-microvolt = <3000000>;
 				op_mode = <1>; /* Normal Mode */
 			};
 		};
-- 
2.17.1

