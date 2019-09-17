Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E740C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 07:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAFCF2196E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 07:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404459AbfIQHcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 03:32:32 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59286 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392639AbfIQHcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 03:32:32 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 74BF8200676;
        Tue, 17 Sep 2019 09:32:29 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 05C9A200672;
        Tue, 17 Sep 2019 09:32:25 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 830C2402E6;
        Tue, 17 Sep 2019 15:32:19 +0800 (SGT)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH] arm64: dts: lx2160a: Correct CPU core idle state name
Date:   Tue, 17 Sep 2019 15:33:56 +0800
Message-Id: <20190917073357.5895-1-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lx2160a support PW15 but not PW20, correct name to avoid confusing.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 36 +++++++++++++-------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 408e0ec..b032f38 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -33,7 +33,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster0_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cpu@1 {
@@ -49,7 +49,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster0_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cpu@100 {
@@ -65,7 +65,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster1_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cpu@101 {
@@ -81,7 +81,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster1_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cpu@200 {
@@ -97,7 +97,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster2_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cpu@201 {
@@ -113,7 +113,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster2_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cpu@300 {
@@ -129,7 +129,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster3_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cpu@301 {
@@ -145,7 +145,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster3_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cpu@400 {
@@ -161,7 +161,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster4_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cpu@401 {
@@ -177,7 +177,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster4_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cpu@500 {
@@ -193,7 +193,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster5_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cpu@501 {
@@ -209,7 +209,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster5_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cpu@600 {
@@ -225,7 +225,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster6_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cpu@601 {
@@ -241,7 +241,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster6_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cpu@700 {
@@ -257,7 +257,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster7_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cpu@701 {
@@ -273,7 +273,7 @@
 			i-cache-line-size = <64>;
 			i-cache-sets = <192>;
 			next-level-cache = <&cluster7_l2>;
-			cpu-idle-states = <&cpu_pw20>;
+			cpu-idle-states = <&cpu_pw15>;
 		};
 
 		cluster0_l2: l2-cache0 {
@@ -340,9 +340,9 @@
 			cache-level = <2>;
 		};
 
-		cpu_pw20: cpu-pw20 {
+		cpu_pw15: cpu-pw15 {
 			compatible = "arm,idle-state";
-			idle-state-name = "PW20";
+			idle-state-name = "PW15";
 			arm,psci-suspend-param = <0x0>;
 			entry-latency-us = <2000>;
 			exit-latency-us = <2000>;
-- 
2.7.4

