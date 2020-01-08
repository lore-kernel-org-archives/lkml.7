Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB17C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 04:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72C22070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 04:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ScLBmCGD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgAHEZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 23:25:42 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10299 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbgAHEZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 23:25:36 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e15598f0000>; Tue, 07 Jan 2020 20:24:47 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 Jan 2020 20:25:35 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 Jan 2020 20:25:35 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jan
 2020 04:25:35 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 8 Jan 2020 04:25:34 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.162.131]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e1559bd0000>; Tue, 07 Jan 2020 20:25:34 -0800
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
Subject: [PATCH v7 09/21] dt-bindings: soc: tegra-pmc: Add id for Tegra PMC 32KHz blink clock
Date:   Tue, 7 Jan 2020 20:25:03 -0800
Message-ID: <1578457515-3477-10-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578457515-3477-1-git-send-email-skomatineni@nvidia.com>
References: <1578457515-3477-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578457487; bh=0VMICKAqgNgQe8Ssepe6nckrz5SXX+WqrF2PVrkxSIw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ScLBmCGDf9hGRru5nAPyTFh10TpH2Sgcu0bpL+yT23pBLRRmIVZpCar9g0Y1Jx7nJ
         TN7TBTs+GKi37e7/5qsoDGXM3fHdC4tS5NSzdBa1/wP4wX/3/VyLvOVUP5f+Dubr9U
         JqLH2lNR/lLx22BZTiy3duyyXjwslCIw8+NbEbZ61HTK3Kcd0fs1qcLbHw8AMPWiH8
         kkadNO+p4kRvtZ8kgZC6MQGCEMxSsMtS9/cgWDMVe4OOGkrklp7xbH0J6gfK4zdlr/
         CETvxK6OpALXH7HMoG5orHYAH1PkitLb6/uPULtXM9eHytzQLVdIkqon0pBMJKPgw0
         /UIZRjm4LfTcg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra PMC has blink functionality that allows 32KHz clock out to
blink pin of the Tegra.

This patch adds id for this blink clock to use for enabling or
disabling blink output through device tree.

Tested-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml | 2 ++
 include/dt-bindings/soc/tegra-pmc.h                                 | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
index 5b5c42a00264..f17bb353f65e 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
@@ -44,6 +44,8 @@ properties:
     const: 1
     description:
       Tegra PMC has clk_out_1, clk_out_2, and clk_out_3.
+      PMC also has blink control which allows 32Khz clock output to
+      Tegra blink pad.
       Consumer of PMC clock should specify the desired clock by having
       the clock ID in its "clocks" phandle cell with pmc clock provider.
       See include/dt-bindings/soc/tegra-pmc.h for the list of Tegra PMC
diff --git a/include/dt-bindings/soc/tegra-pmc.h b/include/dt-bindings/soc/tegra-pmc.h
index f7c866404456..a99a457471ee 100644
--- a/include/dt-bindings/soc/tegra-pmc.h
+++ b/include/dt-bindings/soc/tegra-pmc.h
@@ -9,7 +9,8 @@
 #define TEGRA_PMC_CLK_OUT_1		0
 #define TEGRA_PMC_CLK_OUT_2		1
 #define TEGRA_PMC_CLK_OUT_3		2
+#define TEGRA_PMC_CLK_BLINK		3
 
-#define TEGRA_PMC_CLK_MAX		3
+#define TEGRA_PMC_CLK_MAX		4
 
 #endif	/* _DT_BINDINGS_SOC_TEGRA_PMC_H */
-- 
2.7.4

