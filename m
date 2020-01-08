Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599E2C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 04:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C35020705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 04:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="K4BXBSu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgAHEZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 23:25:36 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10398 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgAHEZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 23:25:32 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1559aa0004>; Tue, 07 Jan 2020 20:25:14 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 Jan 2020 20:25:32 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 Jan 2020 20:25:32 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jan
 2020 04:25:31 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 8 Jan 2020 04:25:31 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.162.131]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e1559b90003>; Tue, 07 Jan 2020 20:25:31 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <gregkh@linuxfoundation.org>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <spujar@nvidia.com>, <josephl@nvidia.com>,
        <daniel.lezcano@linaro.org>, <mmaddireddy@nvidia.com>,
        <markz@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 07/21] dt-bindings: soc: tegra-pmc: Add Tegra PMC clock bindings
Date:   Tue, 7 Jan 2020 20:25:01 -0800
Message-ID: <1578457515-3477-8-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578457515-3477-1-git-send-email-skomatineni@nvidia.com>
References: <1578457515-3477-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578457514; bh=Z3ACX3vP5nNFEx8B7eX+Er9D7XJtGr/zcelaygn+3Bo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=K4BXBSu9MScA2PYYrIYzqBATVzLgxunoGmK6jTRnjrTgpmuZfc8ct269dqAvCJwlf
         +OsRAuc+g66pmrnhp1uJ2In5pMFTYE4bYoMkwPr9WQKkXRZa3hEwVRV89rA6ztyis1
         b/FH5fQtCgOqoRFO8MQeTMg7BDZ3/t12Hx+dYtSrDEB+icTWneOmkgQknfiQOtfnPz
         2OwpSRTdvBM7Zjbrxsts81R5J0t+dzflZ3cMJBI+7DoETYyVz/zRDAYqGIssroFqPC
         4R+q4qMMfUTcAkcAkEYzkK3b+dgz6VGvxpFRvfPJkVJeinwAm+DZoazu7O0FQ3KEvj
         +FINrRFDdSiAw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra PMC has 3 clocks clk_out_1, clk_out_2, and clk_out_3.

This patch documents PMC clock bindings and adds a header defining
Tegra PMC clock ids.

Tested-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 .../devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml | 12 ++++++++++++
 include/dt-bindings/soc/tegra-pmc.h                       | 15 +++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 include/dt-bindings/soc/tegra-pmc.h

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
index 3ff34b348141..5b5c42a00264 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
@@ -40,6 +40,15 @@ properties:
       Must contain an entry for each entry in clock-names.
       See ../clocks/clocks-bindings.txt for details.
 
+  '#clock-cells':
+    const: 1
+    description:
+      Tegra PMC has clk_out_1, clk_out_2, and clk_out_3.
+      Consumer of PMC clock should specify the desired clock by having
+      the clock ID in its "clocks" phandle cell with pmc clock provider.
+      See include/dt-bindings/soc/tegra-pmc.h for the list of Tegra PMC
+      clock IDs.
+
   '#interrupt-cells':
     const: 2
     description:
@@ -296,6 +305,7 @@ required:
   - reg
   - clock-names
   - clocks
+  - '#clock-cells'
 
 dependencies:
   "nvidia,suspend-mode": ["nvidia,core-pwr-off-time", "nvidia,cpu-pwr-off-time"]
@@ -307,12 +317,14 @@ examples:
 
     #include <dt-bindings/clock/tegra210-car.h>
     #include <dt-bindings/pinctrl/pinctrl-tegra-io-pad.h>
+    #include <dt-bindings/soc/tegra-pmc.h>
 
     tegra_pmc: pmc@7000e400 {
               compatible = "nvidia,tegra210-pmc";
               reg = <0x0 0x7000e400 0x0 0x400>;
               clocks = <&tegra_car TEGRA210_CLK_PCLK>, <&clk32k_in>;
               clock-names = "pclk", "clk32k_in";
+              #clock-cells = <1>;
 
               nvidia,invert-interrupt;
               nvidia,suspend-mode = <0>;
diff --git a/include/dt-bindings/soc/tegra-pmc.h b/include/dt-bindings/soc/tegra-pmc.h
new file mode 100644
index 000000000000..f7c866404456
--- /dev/null
+++ b/include/dt-bindings/soc/tegra-pmc.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2019-2020, NVIDIA CORPORATION.  All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_SOC_TEGRA_PMC_H
+#define _DT_BINDINGS_SOC_TEGRA_PMC_H
+
+#define TEGRA_PMC_CLK_OUT_1		0
+#define TEGRA_PMC_CLK_OUT_2		1
+#define TEGRA_PMC_CLK_OUT_3		2
+
+#define TEGRA_PMC_CLK_MAX		3
+
+#endif	/* _DT_BINDINGS_SOC_TEGRA_PMC_H */
-- 
2.7.4

