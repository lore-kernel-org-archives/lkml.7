Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68718CA9ED2
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA36222C7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfKDBk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 20:40:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:55726 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728352AbfKDBk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 20:40:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 81A9CB1AC;
        Mon,  4 Nov 2019 01:40:26 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [RFC 3/7] arm64: dts: realtek: rtd1295: Add Mali node
Date:   Mon,  4 Nov 2019 02:39:28 +0100
Message-Id: <20191104013932.22505-4-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191104013932.22505-1-afaerber@suse.de>
References: <20191104013932.22505-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 arch/arm64/boot/dts/realtek/rtd1295.dtsi | 85 ++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/arm64/boot/dts/realtek/rtd1295.dtsi b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
index 93f0e1d97721..61aa4f47c70b 100644
--- a/arch/arm64/boot/dts/realtek/rtd1295.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
@@ -69,6 +69,91 @@
 			     <GIC_PPI 10
 			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>;
 	};
+
+	mali_opp_table: gpu-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@620000000 {
+			opp-hz = /bits/ 64 <620000000>;
+			opp-microvolt = <1100000>;
+		};
+
+		opp@600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <1100000>;
+		};
+
+		opp@580000000 {
+			opp-hz = /bits/ 64 <580000000>;
+			opp-microvolt = <1075000>;
+		};
+
+		opp@560000000 {
+			opp-hz = /bits/ 64 <560000000>;
+			opp-microvolt = <1075000>;
+		};
+
+		opp@540000000 {
+			opp-hz = /bits/ 64 <540000000>;
+			opp-microvolt = <1050000>;
+		};
+
+		opp@520000000 {
+			opp-hz = /bits/ 64 <520000000>;
+			opp-microvolt = <1025000>;
+		};
+
+		opp@500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <1000000>;
+		};
+
+		opp@460000000 {
+			opp-hz = /bits/ 64 <460000000>;
+			opp-microvolt = <1000000>;
+		};
+
+		opp@440000000 {
+			opp-hz = /bits/ 64 <440000000>;
+			opp-microvolt = <1000000>;
+		};
+
+		opp@400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <1000000>;
+		};
+
+		opp@380000000 {
+			opp-hz = /bits/ 64 <380000000>;
+			opp-microvolt = <975000>;
+		};
+
+		opp@340000000 {
+			opp-hz = /bits/ 64 <340000000>;
+			opp-microvolt = <975000>;
+		};
+
+		opp@300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <900000>;
+		};
+	};
+
+	soc {
+		mali: gpu@98050000 {
+			compatible = "realtek,rtd1295-mali", "arm,mali-t820";
+			reg = <0x98050000 0x10000>;
+			clocks = <&clkc RTD1295_CLK_EN_GPU>;
+			clock-names = "core";
+			resets = <&reset1 RTD1295_RSTN_GPU>;
+			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "job", "mmu", "gpu";
+			operating-points-v2 = <&mali_opp_table>;
+			#cooling-cells = <2>;
+		};
+	};
 };
 
 &arm_pmu {
-- 
2.16.4

