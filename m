Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19396C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 04:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A1C222D9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 04:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ccXExT9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgAHEZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 23:25:31 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10362 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgAHEZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 23:25:26 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1559a40000>; Tue, 07 Jan 2020 20:25:08 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 07 Jan 2020 20:25:25 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 07 Jan 2020 20:25:25 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jan
 2020 04:25:25 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 8 Jan 2020 04:25:25 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.162.131]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e1559b30001>; Tue, 07 Jan 2020 20:25:24 -0800
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
Subject: [PATCH v7 03/21] dt-bindings: clock: tegra: Add DT id for OSC clock
Date:   Tue, 7 Jan 2020 20:24:57 -0800
Message-ID: <1578457515-3477-4-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578457515-3477-1-git-send-email-skomatineni@nvidia.com>
References: <1578457515-3477-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578457508; bh=1NvJ4YURq3GMhbv3Ehpy1wVvFQ3o290gPEqmiMK1NGc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ccXExT9iWvYiQ7/2ZwxShUnJ7tYErUgzxE0PIJXBB5pAY+x8rrvvzV8s4JkYy+Lj1
         c6kwOrYy4WdsrAsamAy8Nkdi9RFJNQiXOlPUlogZR07T9zAyp72I8FAWolcZsdRn+5
         q/8Gfko39Yuj2ebTvhOnXwjBWwY24BR+jJYQpahWHaYicGHOuj9nnqrPGwuvMJh6YQ
         rUySuX4rJpa9GJ+xZmMvcvBQd55+GLYwrB3flhN/5PODcjhlEAb2EpKswIPQU0kl/f
         +YYHANLziuVcbuxd5Qhmlk2e0d6UP8j+sQf6vJ7teG+uEXwkcJfdPazmgnhU4fxt1g
         Mmz/qw1LUBD0g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OSC is one of the parent for Tegra clocks clk_out_1, clk_out_2, and
clk_out_3.

This patch adds DT id for OSC clock to allow parent configuration
through device tree.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 include/dt-bindings/clock/tegra114-car.h        | 2 +-
 include/dt-bindings/clock/tegra124-car-common.h | 2 +-
 include/dt-bindings/clock/tegra210-car.h        | 2 +-
 include/dt-bindings/clock/tegra30-car.h         | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/dt-bindings/clock/tegra114-car.h b/include/dt-bindings/clock/tegra114-car.h
index f4880959b094..e3927cabccad 100644
--- a/include/dt-bindings/clock/tegra114-car.h
+++ b/include/dt-bindings/clock/tegra114-car.h
@@ -274,7 +274,7 @@
 #define TEGRA114_CLK_CLK_OUT_2 246
 #define TEGRA114_CLK_CLK_OUT_3 247
 #define TEGRA114_CLK_BLINK 248
-/* 249 */
+#define TEGRA114_CLK_OSC 249
 /* 250 */
 /* 251 */
 #define TEGRA114_CLK_XUSB_HOST_SRC 252
diff --git a/include/dt-bindings/clock/tegra124-car-common.h b/include/dt-bindings/clock/tegra124-car-common.h
index e7e601a88d3d..45b2bada8ac0 100644
--- a/include/dt-bindings/clock/tegra124-car-common.h
+++ b/include/dt-bindings/clock/tegra124-car-common.h
@@ -273,7 +273,7 @@
 #define TEGRA124_CLK_CLK_OUT_2 246
 #define TEGRA124_CLK_CLK_OUT_3 247
 #define TEGRA124_CLK_BLINK 248
-/* 249 */
+#define TEGRA124_CLK_OSC 249
 /* 250 */
 /* 251 */
 #define TEGRA124_CLK_XUSB_HOST_SRC 252
diff --git a/include/dt-bindings/clock/tegra210-car.h b/include/dt-bindings/clock/tegra210-car.h
index 6f65c14bf013..383ee591ffa7 100644
--- a/include/dt-bindings/clock/tegra210-car.h
+++ b/include/dt-bindings/clock/tegra210-car.h
@@ -355,7 +355,7 @@
 #define TEGRA210_CLK_PLL_A_OUT_ADSP 323
 #define TEGRA210_CLK_PLL_A_OUT0_OUT_ADSP 324
 /* 325 */
-/* 326 */
+#define TEGRA210_CLK_OSC 326
 /* 327 */
 /* 328 */
 /* 329 */
diff --git a/include/dt-bindings/clock/tegra30-car.h b/include/dt-bindings/clock/tegra30-car.h
index 907a8a04c280..5d71f0c0a732 100644
--- a/include/dt-bindings/clock/tegra30-car.h
+++ b/include/dt-bindings/clock/tegra30-car.h
@@ -243,7 +243,7 @@
 #define TEGRA30_CLK_HCLK 217
 #define TEGRA30_CLK_PCLK 218
 /* 219 */
-/* 220 */
+#define TEGRA30_CLK_OSC 220
 /* 221 */
 /* 222 */
 /* 223 */
-- 
2.7.4

