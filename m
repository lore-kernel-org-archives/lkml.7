Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E307EC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C5620716
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 20:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="p+NoUpLu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfLQUEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 15:04:13 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2751 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfLQUEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 15:04:13 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5df9349f0001>; Tue, 17 Dec 2019 12:03:43 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 17 Dec 2019 12:04:11 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 17 Dec 2019 12:04:11 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Dec
 2019 20:04:11 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 17 Dec 2019 20:04:11 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.174.101]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5df934ba0004>; Tue, 17 Dec 2019 12:04:11 -0800
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
Subject: [PATCH v4 01/19] dt-bindings: clock: tegra: Change CLK_M_DIV to OSC_DIV clocks
Date:   Tue, 17 Dec 2019 12:03:48 -0800
Message-ID: <1576613046-17159-2-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576613046-17159-1-git-send-email-skomatineni@nvidia.com>
References: <1576613046-17159-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576613023; bh=boB5dWrzB7K/fO5nQQLi9ejW3crjRKXkywFBAFroObw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=p+NoUpLuurXZjNxihmr9I7sy+Rv8KMAE1dCgUbjxr27LAYIkYsDFGzPDZznE1g1/k
         6uypX7eBY7kZXQq9fK3LxWxpwrBFVKrpHRos73u7LqrJGuH+7Jod4g4+UvstMFiVFy
         fWLWxrlTLe5VSQQhrj95AIyOW4SlBTwaYWy+q6z3mUUkSmTvhtONeJCv5vsaKaN10Z
         TZquUcgzkEH/CUGXQ+x+w6ykn5okCQfxjxySNHT+sC42ECi9+rBvceAbTI8R2Q7FFn
         C6u9weBUQePkkP7qXWdynS9mii/v60DG6rQC8KAF5qrPTOGRl1LByBBIpTdkgs9bm3
         FIZAR7JUntd2A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra has no CLK_M_DIV2 and CLK_M_DIV4 clocks and instead it has
OSC_DIV2 and OSC_DIV4 clocks from OSC pads.

This patch changes CLK_M_DIV2 and CLK_M_DIV4 clock ids to OSC_DIV2
and OSC_DIV4 clock ids for Tegra30 through Tegra210.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 include/dt-bindings/clock/tegra114-car.h        | 4 ++--
 include/dt-bindings/clock/tegra124-car-common.h | 4 ++--
 include/dt-bindings/clock/tegra210-car.h        | 4 ++--
 include/dt-bindings/clock/tegra30-car.h         | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/dt-bindings/clock/tegra114-car.h b/include/dt-bindings/clock/tegra114-car.h
index bb5c2c999c05..f4880959b094 100644
--- a/include/dt-bindings/clock/tegra114-car.h
+++ b/include/dt-bindings/clock/tegra114-car.h
@@ -226,8 +226,8 @@
 #define TEGRA114_CLK_FUSE_BURN 199
 #define TEGRA114_CLK_CLK_32K 200
 #define TEGRA114_CLK_CLK_M 201
-#define TEGRA114_CLK_CLK_M_DIV2 202
-#define TEGRA114_CLK_CLK_M_DIV4 203
+#define TEGRA114_CLK_OSC_DIV2 202
+#define TEGRA114_CLK_OSC_DIV4 203
 #define TEGRA114_CLK_PLL_REF 204
 #define TEGRA114_CLK_PLL_C 205
 #define TEGRA114_CLK_PLL_C_OUT1 206
diff --git a/include/dt-bindings/clock/tegra124-car-common.h b/include/dt-bindings/clock/tegra124-car-common.h
index 0c4f5be0a742..e7e601a88d3d 100644
--- a/include/dt-bindings/clock/tegra124-car-common.h
+++ b/include/dt-bindings/clock/tegra124-car-common.h
@@ -225,8 +225,8 @@
 #define TEGRA124_CLK_FUSE_BURN 199
 #define TEGRA124_CLK_CLK_32K 200
 #define TEGRA124_CLK_CLK_M 201
-#define TEGRA124_CLK_CLK_M_DIV2 202
-#define TEGRA124_CLK_CLK_M_DIV4 203
+#define TEGRA124_CLK_OSC_DIV2 202
+#define TEGRA124_CLK_OSC_DIV4 203
 #define TEGRA124_CLK_PLL_REF 204
 #define TEGRA124_CLK_PLL_C 205
 #define TEGRA124_CLK_PLL_C_OUT1 206
diff --git a/include/dt-bindings/clock/tegra210-car.h b/include/dt-bindings/clock/tegra210-car.h
index 44f60623f99b..6f65c14bf013 100644
--- a/include/dt-bindings/clock/tegra210-car.h
+++ b/include/dt-bindings/clock/tegra210-car.h
@@ -260,8 +260,8 @@
 #define TEGRA210_CLK_FUSE_BURN 231
 #define TEGRA210_CLK_CLK_32K 232
 #define TEGRA210_CLK_CLK_M 233
-#define TEGRA210_CLK_CLK_M_DIV2 234
-#define TEGRA210_CLK_CLK_M_DIV4 235
+#define TEGRA210_CLK_OSC_DIV2 234
+#define TEGRA210_CLK_OSC_DIV4 235
 #define TEGRA210_CLK_PLL_REF 236
 #define TEGRA210_CLK_PLL_C 237
 #define TEGRA210_CLK_PLL_C_OUT1 238
diff --git a/include/dt-bindings/clock/tegra30-car.h b/include/dt-bindings/clock/tegra30-car.h
index 3c90f1535551..907a8a04c280 100644
--- a/include/dt-bindings/clock/tegra30-car.h
+++ b/include/dt-bindings/clock/tegra30-car.h
@@ -194,8 +194,8 @@
 #define TEGRA30_CLK_TVO 169
 #define TEGRA30_CLK_CLK_32K 170
 #define TEGRA30_CLK_CLK_M 171
-#define TEGRA30_CLK_CLK_M_DIV2 172
-#define TEGRA30_CLK_CLK_M_DIV4 173
+#define TEGRA30_CLK_OSC_DIV2 172
+#define TEGRA30_CLK_OSC_DIV4 173
 #define TEGRA30_CLK_PLL_REF 174
 #define TEGRA30_CLK_PLL_C 175
 #define TEGRA30_CLK_PLL_C_OUT1 176
-- 
2.7.4

