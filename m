Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E94C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B682222DE
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qixSZeDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfKSGvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 01:51:21 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14339 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbfKSGvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 01:51:18 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dd390e20002>; Mon, 18 Nov 2019 22:51:14 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 Nov 2019 22:51:17 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 Nov 2019 22:51:17 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Nov
 2019 06:51:16 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Nov
 2019 06:51:16 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 19 Nov 2019 06:51:16 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.175.254]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dd390e30000>; Mon, 18 Nov 2019 22:51:16 -0800
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
Subject: [PATCH v1 15/17] dt-bindings: tegra186-pmc: Add Tegra PMC clock bindings
Date:   Mon, 18 Nov 2019 22:50:32 -0800
Message-ID: <1574146234-3871-16-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574146234-3871-1-git-send-email-skomatineni@nvidia.com>
References: <1574146234-3871-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574146274; bh=G7T/VBzC6jgpoi4v7NU2+pO/USNPyUXRGIQX4N7GGMA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=qixSZeDVAGBlCTnUbZKAPWoRGF1e0Ng9EV35HOoonh+TKycDSEvfturUTFKu3kVzf
         ZNy5pWvEwfaI+XuxnSUy2LYTGIyWs1fgHELJsjUvY0gC3qIh5BkRDEEv9zDtpnxvGX
         ZWqhwV1yL9BLc0yqO8BTEIfFq+XyHdu0ZeflRbZ9oCwTL+ZS9jVV8GKiuT58JrsCr3
         jxeVsecAB3KiB9qI21/2zF/dH6RkeREoP11Bps5vkD3a2gv8vGMebyzHTkPR6sD+aI
         Gq4q/6ivDp1n9FNbsG/ll96pmadCp06KSydxLRwxEP7CwEQ3FIv/sSt697mdt1jUd6
         NiyABHLnyn9pA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document clock bindings for pmc clocks clk_out_1, clk_out_2 and clk_out_3.
These clocks are part of Tegra PMC block and pmc node is the provider for
these clocks.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 .../bindings/arm/tegra/nvidia,tegra186-pmc.txt     | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
index 2d89cdc39eb0..4576de92e4cc 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.txt
@@ -12,6 +12,10 @@ Required properties:
   - "aotag"
   - "scratch"
   - "misc" (Only for Tegra194)
+- #clock-cells : Should be 1 for Tegra30 and higher.
+  In clock consumers, this cell represents the PMC clock ID.
+  The assignments may be found in header file
+  <dt-bindings/soc/tegra-pmc.h>.
 
 Optional properties:
 - nvidia,invert-interrupt: If present, inverts the PMU interrupt signal.
@@ -130,3 +134,43 @@ Pinctrl client example:
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
+		compatible = "nvidia,tegra186-pmc";
+		reg = <0 0x0c360000 0 0x10000>,
+		      <0 0x0c370000 0 0x10000>,
+		      <0 0x0c380000 0 0x10000>,
+		      <0 0x0c390000 0 0x10000>;
+		reg-names = "pmc", "wake", "aotag", "scratch";
+		...
+		#clock-cells = <1>;
+		...
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

