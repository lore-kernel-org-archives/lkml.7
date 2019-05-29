Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F15C04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3BC20665
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 08:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfE2IZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 04:25:14 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49206 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725914AbfE2IZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 04:25:14 -0400
X-UUID: 49a926170b95400d8375011865a37b7b-20190529
X-UUID: 49a926170b95400d8375011865a37b7b-20190529
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <jamesjj.liao@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1050078162; Wed, 29 May 2019 16:25:07 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 29 May 2019 16:25:06 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 29 May 2019 16:25:06 +0800
From:   James Liao <jamesjj.liao@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        James Liao <jamesjj.liao@mediatek.com>
Subject: [PATCH] arm64: dts: mt8183: Enable CPU idle-states
Date:   Wed, 29 May 2019 16:25:03 +0800
Message-ID: <1559118303-31875-1-git-send-email-jamesjj.liao@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable mcdi-cpu and mcdi-cluster on MT8183 CPUs.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
This patch bases on v5.1-rc1 and [1], adds idle-states for MT8183 CPUs.

[1] https://patchwork.kernel.org/patch/10962375/

 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 08274bf..ef4b054 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -56,6 +56,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x000>;
 			enable-method = "psci";
+			cpu-idle-states = <&MCDI_CPU &MCDI_CLUSTER>;
 		};
 
 		cpu1: cpu@1 {
@@ -63,6 +64,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x001>;
 			enable-method = "psci";
+			cpu-idle-states = <&MCDI_CPU &MCDI_CLUSTER>;
 		};
 
 		cpu2: cpu@2 {
@@ -70,6 +72,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x002>;
 			enable-method = "psci";
+			cpu-idle-states = <&MCDI_CPU &MCDI_CLUSTER>;
 		};
 
 		cpu3: cpu@3 {
@@ -77,6 +80,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x003>;
 			enable-method = "psci";
+			cpu-idle-states = <&MCDI_CPU &MCDI_CLUSTER>;
 		};
 
 		cpu4: cpu@100 {
@@ -84,6 +88,7 @@
 			compatible = "arm,cortex-a73";
 			reg = <0x100>;
 			enable-method = "psci";
+			cpu-idle-states = <&MCDI_CPU &MCDI_CLUSTER>;
 		};
 
 		cpu5: cpu@101 {
@@ -91,6 +96,7 @@
 			compatible = "arm,cortex-a73";
 			reg = <0x101>;
 			enable-method = "psci";
+			cpu-idle-states = <&MCDI_CPU &MCDI_CLUSTER>;
 		};
 
 		cpu6: cpu@102 {
@@ -98,6 +104,7 @@
 			compatible = "arm,cortex-a73";
 			reg = <0x102>;
 			enable-method = "psci";
+			cpu-idle-states = <&MCDI_CPU &MCDI_CLUSTER>;
 		};
 
 		cpu7: cpu@103 {
@@ -105,6 +112,29 @@
 			compatible = "arm,cortex-a73";
 			reg = <0x103>;
 			enable-method = "psci";
+			cpu-idle-states = <&MCDI_CPU &MCDI_CLUSTER>;
+		};
+
+		idle-states {
+			entry-method = "arm,psci";
+
+			MCDI_CPU: mcdi-cpu {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x00010001>;
+				entry-latency-us = <200>;
+				exit-latency-us = <200>;
+				min-residency-us = <800>;
+			};
+
+			MCDI_CLUSTER: mcdi-cluster {
+				compatible = "arm,idle-state";
+				local-timer-stop;
+				arm,psci-suspend-param = <0x01010001>;
+				entry-latency-us = <250>;
+				exit-latency-us = <400>;
+				min-residency-us = <1300>;
+			};
 		};
 	};
 
-- 
1.9.1

