Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BFAC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 22:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89D920866
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 22:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JhUk1ESw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfLTW1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 17:27:45 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18937 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfLTW1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 17:27:24 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dfd4abc0000>; Fri, 20 Dec 2019 14:27:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 20 Dec 2019 14:27:19 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 20 Dec 2019 14:27:19 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Dec
 2019 22:27:19 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Dec
 2019 22:27:18 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 20 Dec 2019 22:27:18 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.169.197]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dfd4ac50005>; Fri, 20 Dec 2019 14:27:18 -0800
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
Subject: [PATCH v5 10/19] dt-bindings: clock: tegra: Remove pmc clock ids from clock dt-bindings
Date:   Fri, 20 Dec 2019 14:26:56 -0800
Message-ID: <1576880825-15010-11-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576880825-15010-1-git-send-email-skomatineni@nvidia.com>
References: <1576880825-15010-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576880829; bh=gzsvg9rSW4Lbi79+BaYx0H+ZOAiAzOlJ8PLy62cV+fE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=JhUk1ESwcdvVAB2M8/eZB6DvaH/yiAMJy0jxTADACuR07MXzCrA6YoU8tMQwgikNL
         h9Svdyglhdddlz0B/2TuaJ3ejrX0xbiSsdHN1zYSk9R8PukNsVBkuVfkh0GksPRt7+
         nDewDfogxdDk11FGLHzk8eooFr5wYjrkCB+mZPopJi6oj4E8i2z3EH+h+jsjiNWVNm
         qeLfD/GNJSvgsZ5v7/s0UOMKdZt7KILpoxllU8V7H4OP3D9IXdSlJOUsueLMUhsbLU
         LhfmGMVQVVI87iUoz1msbva40xPF8SdTYtaxkCjWquMzHunH+F9Bm5jmMgV3mfuFjg
         dn+eXbtVyXLCw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_out_1, clk_out_2, clk_out_3, blink are part of Tegra PMC block and
these clocks are moved to Tegra PMC driver with pmc as clock provider
and uses clock ids from dt-bindings/soc/tegra-pmc.h

So, this patch removes ids for these clocks from Tegra clock dt-bindings.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 include/dt-bindings/clock/tegra114-car.h        | 14 +++++++-------
 include/dt-bindings/clock/tegra124-car-common.h | 14 +++++++-------
 include/dt-bindings/clock/tegra20-car.h         |  2 +-
 include/dt-bindings/clock/tegra210-car.h        | 14 +++++++-------
 include/dt-bindings/clock/tegra30-car.h         | 14 +++++++-------
 5 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/include/dt-bindings/clock/tegra114-car.h b/include/dt-bindings/clock/tegra114-car.h
index f4880959b094..2818ba12e1f7 100644
--- a/include/dt-bindings/clock/tegra114-car.h
+++ b/include/dt-bindings/clock/tegra114-car.h
@@ -270,10 +270,10 @@
 #define TEGRA114_CLK_AUDIO3 242
 #define TEGRA114_CLK_AUDIO4 243
 #define TEGRA114_CLK_SPDIF 244
-#define TEGRA114_CLK_CLK_OUT_1 245
-#define TEGRA114_CLK_CLK_OUT_2 246
-#define TEGRA114_CLK_CLK_OUT_3 247
-#define TEGRA114_CLK_BLINK 248
+/* 245 */
+/* 246 */
+/* 247 */
+/* 248 */
 /* 249 */
 /* 250 */
 /* 251 */
@@ -333,9 +333,9 @@
 #define TEGRA114_CLK_AUDIO3_MUX 303
 #define TEGRA114_CLK_AUDIO4_MUX 304
 #define TEGRA114_CLK_SPDIF_MUX 305
-#define TEGRA114_CLK_CLK_OUT_1_MUX 306
-#define TEGRA114_CLK_CLK_OUT_2_MUX 307
-#define TEGRA114_CLK_CLK_OUT_3_MUX 308
+/* 306 */
+/* 307 */
+/* 308 */
 #define TEGRA114_CLK_DSIA_MUX 309
 #define TEGRA114_CLK_DSIB_MUX 310
 #define TEGRA114_CLK_XUSB_SS_DIV2 311
diff --git a/include/dt-bindings/clock/tegra124-car-common.h b/include/dt-bindings/clock/tegra124-car-common.h
index e7e601a88d3d..366bac3043f2 100644
--- a/include/dt-bindings/clock/tegra124-car-common.h
+++ b/include/dt-bindings/clock/tegra124-car-common.h
@@ -269,10 +269,10 @@
 #define TEGRA124_CLK_AUDIO3 242
 #define TEGRA124_CLK_AUDIO4 243
 #define TEGRA124_CLK_SPDIF 244
-#define TEGRA124_CLK_CLK_OUT_1 245
-#define TEGRA124_CLK_CLK_OUT_2 246
-#define TEGRA124_CLK_CLK_OUT_3 247
-#define TEGRA124_CLK_BLINK 248
+/* 245 */
+/* 246 */
+/* 247 */
+/* 248 */
 /* 249 */
 /* 250 */
 /* 251 */
@@ -332,9 +332,9 @@
 #define TEGRA124_CLK_AUDIO3_MUX 303
 #define TEGRA124_CLK_AUDIO4_MUX 304
 #define TEGRA124_CLK_SPDIF_MUX 305
-#define TEGRA124_CLK_CLK_OUT_1_MUX 306
-#define TEGRA124_CLK_CLK_OUT_2_MUX 307
-#define TEGRA124_CLK_CLK_OUT_3_MUX 308
+/* 306 */
+/* 307 */
+/* 308 */
 /* 309 */
 /* 310 */
 #define TEGRA124_CLK_SOR0_LVDS 311 /* deprecated */
diff --git a/include/dt-bindings/clock/tegra20-car.h b/include/dt-bindings/clock/tegra20-car.h
index b21a0eb32921..fe541f627965 100644
--- a/include/dt-bindings/clock/tegra20-car.h
+++ b/include/dt-bindings/clock/tegra20-car.h
@@ -131,7 +131,7 @@
 #define TEGRA20_CLK_CCLK 108
 #define TEGRA20_CLK_HCLK 109
 #define TEGRA20_CLK_PCLK 110
-#define TEGRA20_CLK_BLINK 111
+/* 111 */
 #define TEGRA20_CLK_PLL_A 112
 #define TEGRA20_CLK_PLL_A_OUT0 113
 #define TEGRA20_CLK_PLL_C 114
diff --git a/include/dt-bindings/clock/tegra210-car.h b/include/dt-bindings/clock/tegra210-car.h
index 6f65c14bf013..098a73d36c33 100644
--- a/include/dt-bindings/clock/tegra210-car.h
+++ b/include/dt-bindings/clock/tegra210-car.h
@@ -304,10 +304,10 @@
 #define TEGRA210_CLK_AUDIO3 274
 #define TEGRA210_CLK_AUDIO4 275
 #define TEGRA210_CLK_SPDIF 276
-#define TEGRA210_CLK_CLK_OUT_1 277
-#define TEGRA210_CLK_CLK_OUT_2 278
-#define TEGRA210_CLK_CLK_OUT_3 279
-#define TEGRA210_CLK_BLINK 280
+/* 277 */
+/* 278 */
+/* 279 */
+/* 280 */
 #define TEGRA210_CLK_SOR0_LVDS 281 /* deprecated */
 #define TEGRA210_CLK_SOR0_OUT 281
 #define TEGRA210_CLK_SOR1_OUT 282
@@ -386,9 +386,9 @@
 #define TEGRA210_CLK_AUDIO3_MUX 353
 #define TEGRA210_CLK_AUDIO4_MUX 354
 #define TEGRA210_CLK_SPDIF_MUX 355
-#define TEGRA210_CLK_CLK_OUT_1_MUX 356
-#define TEGRA210_CLK_CLK_OUT_2_MUX 357
-#define TEGRA210_CLK_CLK_OUT_3_MUX 358
+/* 356 */
+/* 357 */
+/* 358 */
 #define TEGRA210_CLK_DSIA_MUX 359
 #define TEGRA210_CLK_DSIB_MUX 360
 /* 361 */
diff --git a/include/dt-bindings/clock/tegra30-car.h b/include/dt-bindings/clock/tegra30-car.h
index 907a8a04c280..2a63a9c4de5c 100644
--- a/include/dt-bindings/clock/tegra30-car.h
+++ b/include/dt-bindings/clock/tegra30-car.h
@@ -230,11 +230,11 @@
 #define TEGRA30_CLK_AUDIO3 204
 #define TEGRA30_CLK_AUDIO4 205
 #define TEGRA30_CLK_SPDIF 206
-#define TEGRA30_CLK_CLK_OUT_1 207 /* (extern1) */
-#define TEGRA30_CLK_CLK_OUT_2 208 /* (extern2) */
-#define TEGRA30_CLK_CLK_OUT_3 209 /* (extern3) */
+/* 207 */
+/* 208 */
+/* 209 */
 #define TEGRA30_CLK_SCLK 210
-#define TEGRA30_CLK_BLINK 211
+/* 211 */
 #define TEGRA30_CLK_CCLK_G 212
 #define TEGRA30_CLK_CCLK_LP 213
 #define TEGRA30_CLK_TWD 214
@@ -260,9 +260,9 @@
 /* 297 */
 /* 298 */
 /* 299 */
-#define TEGRA30_CLK_CLK_OUT_1_MUX 300
-#define TEGRA30_CLK_CLK_OUT_2_MUX 301
-#define TEGRA30_CLK_CLK_OUT_3_MUX 302
+/* 300 */
+/* 301 */
+/* 302 */
 #define TEGRA30_CLK_AUDIO0_MUX 303
 #define TEGRA30_CLK_AUDIO1_MUX 304
 #define TEGRA30_CLK_AUDIO2_MUX 305
-- 
2.7.4

