Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6B5C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D989024650
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfLQUEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:04:46 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15622 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbfLQUEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:04:25 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5df934be0000>; Tue, 17 Dec 2019 12:04:14 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 17 Dec 2019 12:04:23 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 17 Dec 2019 12:04:23 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Dec
 2019 20:04:23 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 17 Dec 2019 20:04:23 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.174.101]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5df934c60002>; Tue, 17 Dec 2019 12:04:23 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>,
        <mperttunen@nvidia.com>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <spujar@nvidia.com>, <josephl@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 17/19] ARM: tegra: Update sound node clocks in device tree
Date:   Tue, 17 Dec 2019 12:04:04 -0800
Message-ID: <1576613046-17159-18-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576613046-17159-1-git-send-email-skomatineni@nvidia.com>
References: <1576613046-17159-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_out_1, clk_out_2, and clk_out_3 are part of Tegra PMC block
and are moved from clock driver to pmc driver with pmc as clock
provider.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1576613055; bh=aZWp4sScdv8qprM+UpGS0w1DX7YelR50gFqoThf23X4=;
	h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
	 Content-Type;
	b=p9EmVtuTvJK6owqo0lmnZnAvftCWc6+7Mkp/Ks9y26tKN5c4jU+I+YEAaMWoHuzd+
	 7n0vS98WNMGomj19IUXoaH49IeTgPAlqOkU57IIiL2qEnX3sYNYpl/rCRUIs7vd33t
	 LSn8tQeu9Lz+Yfl8hvXcN3sdxRQOEPDYwzWG+tVy1FCnwouTHSfBhgado2Tx/9cWgi
	 HlSWkzjvodag7mAmZtLCl5P4J+oVEJnpYnjSZKNojqszn8u651ErvnVI/VbhZwQ0G5
	 Yg8kEr8YECPk2L4MXUe8J2YmKtNyZaADOkUhjyxqMjZ2bGrB9RDm5dKNFxkWuEeSpb
	 U3nMi7MNcvBmQ==

clk_out_1 is dedicated for audio mclk on Tegra30 through Tegra210.

This patch updates device tree sound node to use clk_out_1 from
pmc provider as mclk and uses assigned-clock properties to specify
clock parents for clk_out_1 and extern1.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm/boot/dts/tegra114-dalmore.dts      | 7 ++++++-
 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi | 7 ++++++-
 arch/arm/boot/dts/tegra124-apalis.dtsi      | 7 ++++++-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts   | 7 ++++++-
 arch/arm/boot/dts/tegra124-nyan.dtsi        | 7 ++++++-
 arch/arm/boot/dts/tegra124-venice2.dts      | 7 ++++++-
 arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi  | 7 ++++++-
 arch/arm/boot/dts/tegra30-apalis.dtsi       | 7 ++++++-
 arch/arm/boot/dts/tegra30-beaver.dts        | 7 ++++++-
 arch/arm/boot/dts/tegra30-cardhu.dtsi       | 7 ++++++-
 arch/arm/boot/dts/tegra30-colibri.dtsi      | 7 ++++++-
 11 files changed, 66 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index 97a5c3504bbe..c1914b590f5c 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -1296,7 +1296,12 @@
 
 		clocks = <&tegra_car TEGRA114_CLK_PLL_A>,
 			 <&tegra_car TEGRA114_CLK_PLL_A_OUT0>,
-			 <&tegra_car TEGRA114_CLK_EXTERN1>;
+			 <&pmc TEGRA_PMC_CLK_OUT_1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
+
+		assigned-clocks = <&tegra_car TEGRA114_CLK_EXTERN1>,
+				  <&pmc TEGRA_PMC_CLK_OUT_1>;
+		assigned-clock-parents = <&tegra_car TEGRA114_CLK_PLL_A_OUT0>,
+					 <&tegra_car TEGRA114_CLK_EXTERN1>;
 	};
 };
diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index 0462ed2dd8b8..ac6e3dda09a6 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
@@ -2009,8 +2009,13 @@
 		nvidia,audio-codec = <&sgtl5000>;
 		clocks = <&tegra_car TEGRA124_CLK_PLL_A>,
 			 <&tegra_car TEGRA124_CLK_PLL_A_OUT0>,
-			 <&tegra_car TEGRA124_CLK_EXTERN1>;
+			 <&pmc TEGRA_PMC_CLK_OUT_1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
+
+		assigned-clocks = <&tegra_car TEGRA124_CLK_EXTERN1>,
+				  <&pmc TEGRA_PMC_CLK_OUT_1>;
+		assigned-clock-parents = <&tegra_car TEGRA124_CLK_PLL_A_OUT0>,
+					 <&tegra_car TEGRA124_CLK_EXTERN1>;
 	};
 
 	thermal-zones {
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index d1e8593ef0d9..ab3dc9494528 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -2001,8 +2001,13 @@
 		nvidia,audio-codec = <&sgtl5000>;
 		clocks = <&tegra_car TEGRA124_CLK_PLL_A>,
 			 <&tegra_car TEGRA124_CLK_PLL_A_OUT0>,
-			 <&tegra_car TEGRA124_CLK_EXTERN1>;
+			 <&pmc TEGRA_PMC_CLK_OUT_1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
+
+		assigned-clocks = <&tegra_car TEGRA124_CLK_EXTERN1>,
+				  <&pmc TEGRA_PMC_CLK_OUT_1>;
+		assigned-clock-parents = <&tegra_car TEGRA124_CLK_PLL_A_OUT0>,
+					 <&tegra_car TEGRA124_CLK_EXTERN1>;
 	};
 
 	thermal-zones {
diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index d5fd642f8b77..5b69ac9d3fc3 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -2058,8 +2058,13 @@
 
 		clocks = <&tegra_car TEGRA124_CLK_PLL_A>,
 			 <&tegra_car TEGRA124_CLK_PLL_A_OUT0>,
-			 <&tegra_car TEGRA124_CLK_EXTERN1>;
+			 <&pmc TEGRA_PMC_CLK_OUT_1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
+
+		assigned-clocks = <&tegra_car TEGRA124_CLK_EXTERN1>,
+				  <&pmc TEGRA_PMC_CLK_OUT_1>;
+		assigned-clock-parents = <&tegra_car TEGRA124_CLK_PLL_A_OUT0>,
+					 <&tegra_car TEGRA124_CLK_EXTERN1>;
 	};
 
 	thermal-zones {
diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index 3b10f475037f..2bb7785311d6 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -788,9 +788,14 @@
 
 		clocks = <&tegra_car TEGRA124_CLK_PLL_A>,
 			 <&tegra_car TEGRA124_CLK_PLL_A_OUT0>,
-			 <&tegra_car TEGRA124_CLK_EXTERN1>;
+			 <&pmc TEGRA_PMC_CLK_OUT_1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 
+		assigned-clocks = <&tegra_car TEGRA124_CLK_EXTERN1>,
+				  <&pmc TEGRA_PMC_CLK_OUT_1>;
+		assigned-clock-parents = <&tegra_car TEGRA124_CLK_PLL_A_OUT0>,
+					 <&tegra_car TEGRA124_CLK_EXTERN1>;
+
 		nvidia,hp-det-gpios = <&gpio TEGRA_GPIO(I, 7) GPIO_ACTIVE_HIGH>;
 		nvidia,mic-det-gpios =
 				<&gpio TEGRA_GPIO(R, 7) GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index 7309393bfced..6b2e886b8fee 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -1266,8 +1266,13 @@
 
 		clocks = <&tegra_car TEGRA124_CLK_PLL_A>,
 			 <&tegra_car TEGRA124_CLK_PLL_A_OUT0>,
-			 <&tegra_car TEGRA124_CLK_EXTERN1>;
+			 <&pmc TEGRA_PMC_CLK_OUT_1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
+
+		assigned-clocks = <&tegra_car TEGRA124_CLK_EXTERN1>,
+				  <&pmc TEGRA_PMC_CLK_OUT_1>;
+		assigned-clock-parents = <&tegra_car TEGRA124_CLK_PLL_A_OUT0>,
+					 <&tegra_car TEGRA124_CLK_EXTERN1>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi b/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
index 8b7a827d604d..136a3db93e98 100644
--- a/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
@@ -1189,7 +1189,12 @@
 		nvidia,audio-codec = <&sgtl5000>;
 		clocks = <&tegra_car TEGRA30_CLK_PLL_A>,
 			 <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
-			 <&tegra_car TEGRA30_CLK_EXTERN1>;
+			 <&pmc TEGRA_PMC_CLK_OUT_1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
+
+		assigned-clocks = <&tegra_car TEGRA30_CLK_EXTERN1>,
+				  <&pmc TEGRA_PMC_CLK_OUT_1>;
+		assigned-clock-parents = <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
+					 <&tegra_car TEGRA30_CLK_EXTERN1>;
 	};
 };
diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index c18f6f61d764..e41c81cdfaf4 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -1171,7 +1171,12 @@
 		nvidia,audio-codec = <&sgtl5000>;
 		clocks = <&tegra_car TEGRA30_CLK_PLL_A>,
 			 <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
-			 <&tegra_car TEGRA30_CLK_EXTERN1>;
+			 <&pmc TEGRA_PMC_CLK_OUT_1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
+
+		assigned-clocks = <&tegra_car TEGRA30_CLK_EXTERN1>,
+				  <&pmc TEGRA_PMC_CLK_OUT_1>;
+		assigned-clock-parents = <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
+					 <&tegra_car TEGRA30_CLK_EXTERN1>;
 	};
 };
diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index a3b0f3555cd2..5df26b0055b4 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -2111,7 +2111,12 @@
 
 		clocks = <&tegra_car TEGRA30_CLK_PLL_A>,
 			 <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
-			 <&tegra_car TEGRA30_CLK_EXTERN1>;
+			 <&pmc TEGRA_PMC_CLK_OUT_1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
+
+		assigned-clocks = <&tegra_car TEGRA30_CLK_EXTERN1>,
+				  <&pmc TEGRA_PMC_CLK_OUT_1>;
+		assigned-clock-parents = <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
+					 <&tegra_car TEGRA30_CLK_EXTERN1>;
 	};
 };
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index 7ce61edd52f5..e01dfc8e2840 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -619,8 +619,13 @@
 
 		clocks = <&tegra_car TEGRA30_CLK_PLL_A>,
 			 <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
-			 <&tegra_car TEGRA30_CLK_EXTERN1>;
+			 <&pmc TEGRA_PMC_CLK_OUT_1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
+
+		assigned-clocks = <&tegra_car TEGRA30_CLK_EXTERN1>,
+				  <&pmc TEGRA_PMC_CLK_OUT_1>;
+		assigned-clock-parents = <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
+					 <&tegra_car TEGRA30_CLK_EXTERN1>;
 	};
 
 	gpio-keys {
diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 1f9198bb24ff..1eeeaa66f467 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -1030,8 +1030,13 @@
 		nvidia,audio-codec = <&sgtl5000>;
 		clocks = <&tegra_car TEGRA30_CLK_PLL_A>,
 			 <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
-			 <&tegra_car TEGRA30_CLK_EXTERN1>;
+			 <&pmc TEGRA_PMC_CLK_OUT_1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
+
+		assigned-clocks = <&tegra_car TEGRA30_CLK_EXTERN1>,
+				  <&pmc TEGRA_PMC_CLK_OUT_1>;
+		assigned-clock-parents = <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
+					 <&tegra_car TEGRA30_CLK_EXTERN1>;
 	};
 };
 
-- 
2.7.4

