Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DFFC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 04:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2308C2068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 04:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XOWt5pk/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfK0E7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 23:59:51 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11670 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbfK0E7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 23:59:47 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dde02bb0000>; Tue, 26 Nov 2019 20:59:39 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 26 Nov 2019 20:59:45 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 26 Nov 2019 20:59:45 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Nov
 2019 04:59:45 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 Nov 2019 04:59:45 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.169.149]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dde02c00000>; Tue, 26 Nov 2019 20:59:45 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>,
        <mperttunen@nvidia.com>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <tglx@linutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <allison@lohutok.net>, <pdeschrijver@nvidia.com>,
        <pgaikwad@nvidia.com>, <mturquette@baylibre.com>,
        <horms+renesas@verge.net.au>, <Jisheng.Zhang@synaptics.com>,
        <krzk@kernel.org>, <arnd@arndb.de>, <spujar@nvidia.com>,
        <josephl@nvidia.com>, <vidyas@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 09/11] dt-bindings: Add Tegra PMC clock configuration bindings
Date:   Tue, 26 Nov 2019 20:59:31 -0800
Message-ID: <1574830773-14892-10-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574830773-14892-1-git-send-email-skomatineni@nvidia.com>
References: <1574830773-14892-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574830779; bh=pVDXsadl/RAHudMsZfbkl+hewGmoPu/40zsMcBi9anY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=XOWt5pk/gFUZpUGT987HCcSnxV3MzLbxGz1ngtKbTt5thmd1/l4nbEZ0wdyldda7r
         /FBXN9iaW+cX2VNZ49Kppj2VtY0StXBO09JwlM9ASoZcUl+faQYKErDZ600mGEsAGI
         NnUBOk2sn12Si/jMGdrRxf5vERcNkLqkA30b4WCqgdjL+adO/qO01UCVinmgAlUK7A
         /FBlKdEnftpkNjxpv0liE4ebtMw7Z4gNcjL0pru4mDL6Eg8Sfj4wt7MOPaZc2BESzP
         oCxF507aCwlNK0Oz+9gsP7Uv5N8mWbWEAdn0KmvozCJoN9A6VP6tORDVECdLqcbgrr
         cT6NQx70Fv3RQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document clock bindings for pmc clocks clk_out_1, clk_out_2 and clk_out_3.
These clocks are part of Tegra PMC block and pmc node is the provider for
these clocks.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 45 +++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
index cb12f33a247f..7e0069b87bc2 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
@@ -21,6 +21,10 @@ Required properties:
 - clock-names : Must include the following entries:
   "pclk" (The Tegra clock of that name),
   "clk32k_in" (The 32KHz clock input to Tegra).
+- #clock-cells : Should be 1 for Tegra30 and higher.
+  In clock consumers, this cell represents the PMC clock ID.
+  The assignments may be found in header file
+  <dt-bindings/soc/tegra-pmc.h>.
 
 Optional properties:
 - nvidia,invert-interrupt : If present, inverts the PMU interrupt signal.
@@ -80,11 +84,12 @@ Optional nodes:
 Example:
 
 / SoC dts including file
-pmc@7000f400 {
+pmc: pmc@7000f400 {
 	compatible = "nvidia,tegra20-pmc";
 	reg = <0x7000e400 0x400>;
 	clocks = <&tegra_car 110>, <&clk32k_in>;
 	clock-names = "pclk", "clk32k_in";
+	#clock-cells = <1>;
 	nvidia,invert-interrupt;
 	nvidia,suspend-mode = <1>;
 	nvidia,cpu-pwr-good-time = <2000>;
@@ -171,6 +176,7 @@ Example:
 		reg = <0x0 0x7000e400 0x0 0x400>;
 		clocks = <&tegra_car TEGRA210_CLK_PCLK>, <&clk32k_in>;
 		clock-names = "pclk", "clk32k_in";
+		#clock-cells = <1>;
 
 		powergates {
 			pd_audio: aud {
@@ -260,6 +266,7 @@ Pad configuration state example:
 		reg = <0x0 0x7000e400 0x0 0x400>;
 		clocks = <&tegra_car TEGRA210_CLK_PCLK>, <&clk32k_in>;
 		clock-names = "pclk", "clk32k_in";
+		#clock-cells = <1>;
 
 		...
 
@@ -298,3 +305,39 @@ Pinctrl client example:
 		pinctrl-1 = <&hdmi_on>;
 		pinctrl-names = "hdmi-on", "hdmi-off";
 	};
+
+== Clock Control ==
+
+Tegra PMC has 3 clocks clk_1, clk_2 and clk_3. Each of these clocks has
+source selection and enable/disable gate.
+Parent/source for these clocks can be either of clk_m, clk_m_div2, clk_m_div4,
+or extern clock from Tegra CAR module.
+
+Clock configuration example:
+	pmc: pmc@7000e400 {
+		compatible = "nvidia,tegra210-pmc";
+		reg = <0x0 0x7000e400 0x0 0x400>;
+		clocks = <&tegra_car TEGRA210_CLK_PCLK>, <&clk32k_in>;
+		clock-names = "pclk", "clk32k_in";
+		#clock-cells = <1>;
+	};
+
+Clock consumer example:
+	host1x@50000000 {
+		...
+		vi@54080000 {
+		...
+		assigned-clocks = <&pmc TEGRA_PMC_CLK_OUT_3_MUX>;
+		assigned-clock-parents = <&tegra_car TEGRA210_CLK_EXTERN3>;
+		};
+		...
+	};
+	...
+	i2c@7000c500 {
+		cam_sensor {
+		...
+		clocks = <&pmc TEGRA_PMC_CLK_OUT_3>;
+		clock-names = "mclk";
+		...
+		};
+	};
-- 
2.7.4

