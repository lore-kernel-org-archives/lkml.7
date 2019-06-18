Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87276C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 19:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C7D20863
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 19:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560884781;
	bh=LkRvvcttoJNDSKrNrdMMav77ZqbcaMUvQH3Jz5hTWcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pYoUpSviYe5U53qKIKTG5YGtW0dFyLyAuoZlYh19iru8HaEFc3nxg73bxnMwVp2sD
	 yOZDCMDE/r/Rt4hs13DLP8eC+aOB8WB9S0CoHdn+zaw6EmKeYD79tdgYRJkbEXCvw3
	 x2eXmFx747g/OOlZu197nYpw/4HPtiO9Vc4A7DJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbfFRTGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 15:06:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730196AbfFRTGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 15:06:19 -0400
Received: from localhost.localdomain (unknown [194.230.155.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 001EF20863;
        Tue, 18 Jun 2019 19:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560884778;
        bh=LkRvvcttoJNDSKrNrdMMav77ZqbcaMUvQH3Jz5hTWcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j1vVpE1EGeSmNFa3mwdOVVNIgWI7vFcXQyL4hgaC7+vyZzPqaI7ezBj5zsfqOzA6X
         b6RLRbGyb+uKjxOZbIE5f8knTPRBv3BJjXsn4ektLwdQ56d5gue7Xwt0nXz1kplSVq
         x5iYr6U4bPLJhxg4O+BE0WERjGXOYF/Z0ve/pB08=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Olof Johansson <olof@lixom.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Joseph Kogut <joseph.kogut@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RFT 06/10] arm64: dts: exynos: Add GPU/Mali T760 node to Exynos5433
Date:   Tue, 18 Jun 2019 21:05:30 +0200
Message-Id: <20190618190534.4951-7-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190618190534.4951-1-krzk@kernel.org>
References: <20190618190534.4951-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for GPU (Mali T760) to Exynos5433.  Missing element is the
cooling device.  Not tested on HW.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../dts/exynos/exynos5433-tm2-common.dtsi     |  5 ++
 arch/arm64/boot/dts/exynos/exynos5433.dtsi    | 51 +++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index d2de16645e10..6f90b0e62cba 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -350,6 +350,11 @@
 	pinctrl-0 = <&te_irq>;
 };
 
+&gpu {
+	mali-supply = <&buck6_reg>;
+	status = "okay";
+};
+
 &hdmi {
 	hpd-gpios = <&gpa3 0 GPIO_ACTIVE_HIGH>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index d29d13f4694f..a76f620f7f35 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -249,6 +249,57 @@
 		};
 	};
 
+	gpu: gpu@14ac0000 {
+		compatible = "samsung,exynos5433-mali", "arm,mali-t760";
+		reg = <0x14ac0000 0x5000>;
+		interrupts = <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "job", "mmu", "gpu";
+		clocks = <&cmu_g3d CLK_ACLK_G3D>;
+		clock-names = "core";
+		power-domains = <&pd_g3d>;
+		operating-points-v2 = <&gpu_opp_table>;
+		status = "disabled";
+
+		gpu_opp_table: opp_table {
+			compatible = "operating-points-v2";
+
+			opp-160000000 {
+				opp-hz = /bits/ 64 <160000000>;
+				opp-microvolt = <1000000>;
+			};
+			opp-267000000 {
+				opp-hz = /bits/ 64 <267000000>;
+				opp-microvolt = <1000000>;
+			};
+			opp-350000000 {
+				opp-hz = /bits/ 64 <350000000>;
+				opp-microvolt = <1025000>;
+			};
+			opp-420000000 {
+				opp-hz = /bits/ 64 <420000000>;
+				opp-microvolt = <1025000>;
+			};
+			opp-500000000 {
+				opp-hz = /bits/ 64 <500000000>;
+				opp-microvolt = <1075000>;
+			};
+			opp-550000000 {
+				opp-hz = /bits/ 64 <550000000>;
+				opp-microvolt = <1125000>;
+			};
+			opp-600000000 {
+				opp-hz = /bits/ 64 <600000000>;
+				opp-microvolt = <1150000>;
+			};
+			opp-700000000 {
+				opp-hz = /bits/ 64 <700000000>;
+				opp-microvolt = <1150000>;
+			};
+		};
+	};
+
 	psci {
 		compatible = "arm,psci";
 		method = "smc";
-- 
2.17.1

