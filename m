Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEA9C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 02:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D1922525
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 02:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PMt+4B9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfLFCth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 21:49:37 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15987 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfLFCtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 21:49:10 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5de9c1940000>; Thu, 05 Dec 2019 18:48:52 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 05 Dec 2019 18:49:08 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 05 Dec 2019 18:49:08 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Dec
 2019 02:49:07 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 6 Dec 2019 02:49:07 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.163.171]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5de9c1a20000>; Thu, 05 Dec 2019 18:49:07 -0800
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
        <linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <alexios.zavras@intel.com>, <alsa-devel@alsa-project.org>
Subject: [PATCH v3 07/15] dt-bindings: clock: tegra: Remove pmc clock ids from clock dt-bindings
Date:   Thu, 5 Dec 2019 18:48:47 -0800
Message-ID: <1575600535-26877-8-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575600535-26877-1-git-send-email-skomatineni@nvidia.com>
References: <1575600535-26877-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575600532; bh=AoUfZIY+YXf8dsokt7kEH2A0DDWvPIIhSwfR2b7pRwI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=PMt+4B9mIZxzMa0VBHeuGsctDk7SkyMRGwHESkzdQMvb02IsUpMfGCfRqY5YUoOR0
         LJKK0/Lv1hx/zWXZNH8OQYQdMTL2kihWiO7K92N/gjaiSs47Hce9yU9MUgTwwFMDXc
         cbDScFHQi1wEC6a6Fehv3ZHUItHW6h9bfay0Zg+GsgASVy5atrhKYXZW+Vb0+Qos2p
         YFWmOjlWcLdpIZ6/11RailUL/qZ946A1PyebshPDigZ4CJ9GWtcQwWP3A2DY6JsUn3
         6FHi/29NObfKm/z3Y1zSeyaUccc41ICo90kPwLxdXpj1JTLnsqx9pMX9KafF/93FY9
         ZG6BYRu1YcyFw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_out_1, clk_out_2, clk_out_3, blink are part of Tegra PMC block and
these clocks are moved to Tegra PMC driver with pmc as clock provider
and uses clock ids from dt-bindings/soc/tegra-pmc.h

So, this patch removes ids for these clocks from Tegra clock dt-bindings.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 include/dt-bindings/clock/tegra114-car.h        | 14 +++++++-------
 include/dt-bindings/clock/tegra124-car-common.h | 14 +++++++-------
 include/dt-bindings/clock/tegra20-car.h         |  2 +-
 include/dt-bindings/clock/tegra210-car.h        | 14 +++++++-------
 include/dt-bindings/clock/tegra30-car.h         | 14 +++++++-------
 5 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/include/dt-bindings/clock/tegra114-car.h b/include/dt-bindings/clock/tegra114-car.h
index bb5c2c999c05..9175cd0571b5 100644
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
index 0c4f5be0a742..90a0c5e7eb5f 100644
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
index 44f60623f99b..a3d8d3e75728 100644
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
index 3c90f1535551..20ef2462d9e1 100644
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

